using AutoAtendimento.Controllers;
using AutoAtendimento.Moldes;
using AutoAtendimento.Moldes.Views;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Drawing.Printing;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace AutoAtendimento
{
    public partial class Default : System.Web.UI.Page
    {
        #region MyRegion
        HttpClient cliente;
        Atendimentos atendimentos;
        Atendimentos_itens atendimentos_itens;

        public Default()
        {
            if (cliente == null)
            {
                cliente = new HttpClient();
                cliente.BaseAddress = new Uri("http://localhost:49573/api/");
                cliente.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("applicattion/json"));
            }
        }

        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                Session["GridItens"] = null;
            }
        }

        protected void AjaxManager_AjaxRequest(object sender, Telerik.Web.UI.AjaxRequestEventArgs e)
        {
          
            var metodo = e.Argument.Split(':')[0];
            var item = new VProteinas();

            if (!metodo.Equals("imprimir"))
            {
                item.tipo = e.Argument.Split(':')[3];
                if (item.tipo.Equals("temSabor"))
                {
                    item.precoAUX = item.preco;
                    item.preco = null;
                }
                else
                {
                    item.preco = e.Argument.Split(':')[1];
                }

                item.proteina = e.Argument.Split(':')[2];
                item.id = IncluirItens.Count + 1;
                item.qtde = 1;
            }            

            switch (metodo)
            {
                case "Add1":
                    {            
                        lbProteina.Text = item.proteina;
                        lbId.Text = item.id.ToString();                        
                        item.id_produto = int.Parse(e.Argument.Split(':')[4]);
                        item.id_sabor = 10; //sabor UNICO
                        FinalizaAdicao(item);

                        break;
                    }

                case "Add2":
                    {
                        item.id_proteina = int.Parse(lbId.Text); 
                        
                        //verifica se é um adicional. Caso seja, colocao tipo como proteina, pega o id do produto adicional e o id_sabor é genérico(UNICO)
                        if (item.tipo.Equals("proteina"))
                        {                            
                            item.id_produto = int.Parse(e.Argument.Split(':')[4]);
                            item.id_sabor = 10; //sabor UNICO
                        }
                        //se não for adicional, então é um sabor comum que não possui ID_PRODUTO. Nesse caso, pegamos somente o id do sabor
                        else
                        {                           
                            item.id_sabor = int.Parse(e.Argument.Split(':')[4]);
                        }

                        FinalizaAdicao(item);

                        break;
                    }

                case "imprimir":

                    //Verifica se existe itens no atendimento
                    if (RadTreeList1.Items.Count > 0)
                    {
                        if (ValidaCampos() == true)
                        {                        
                            try
                            {
                                var doc = new PrintDocument();
                                doc.PrintPage += Doc_PrintPage;
                                Task.Run(() => doc.Print());
                            }
                            catch (Exception erro)
                            {
                                
                            }

                            FinalizarAtendimento();
                        }                        
                    }
                    else
                    {
                        //mostra mensagem de que não existem itens para atendimento
                        RadWindowManager1.RadAlert("Não existem itens para atendimento", 400, 180, "Atenção", "alertCallBack");
                    }

                    break;
            }
        }

        private void Doc_PrintPage(object sender, PrintPageEventArgs e)
        {
            //verifica se o ticket não é 0
            var ticket = BuscaTicket(DateTime.Today);
            if(ticket == 0)
            {
                ticket = 1;
            }

            //adiciona a informação de viagem na comanda da cozinha
            string titulo = "";
            if (Session["viagem"].ToString().Equals("true"))
            {
                titulo = "Pedido " + ticket + " (VIAGEM)";
            }
            else
            {
                titulo = "Pedido " + ticket;
            }

            //faz a impressão dos itens
            Graphics g = e.Graphics;
            using (Font font = new Font("Arial", 20))
            {
                //g.DrawString(titulo, font, Brushes.Black, 5, 20);

                var y = 60;
                int cont = 1;
                foreach (var item in RadTreeList1.Items)
                {
                    if (!item["tipo"].Text.Equals("proteina"))
                    {
                        continue;
                    }
                    else if (item.ParentItem == null)
                    {
                        //g.DrawString("Prato " + cont + ":", new Font("Arial", 12, FontStyle.Bold), Brushes.Black, 10, y);
                        y = y + 20;
                        cont++;
                    }

                    //g.DrawString(item["proteina"].Text, new Font("Arial", 12), Brushes.Black, 10, y);
                    y = y + 20;
                }
            }

            GeraMeusPedidos(titulo);

        }

        private void GeraMeusPedidos(String titulo)
        {
            //cria um item PEDIDO para apresentar no grid MEUS PEDIDOS, o objeto é guardado na lista IncluirPedidos
            var pedido = new VProteinas();
            pedido.proteina = titulo;
            var index = IncluirPedidos.Count;
            IncluirPedidos.Insert(index, pedido);

            //atribui os itens do IncluirItens ao IncluirPedidos
            for (int i = 0; i < IncluirItens.Count; i++)
            {
                IncluirPedidos.Add(IncluirItens[i]);
            }
        }

        //Finaliza a adição do atendimento na List IncluirItens e atualiza a treeList
        private void FinalizaAdicao(VProteinas item)
        {
            var index = IncluirItens.Count;
            IncluirItens.Insert(index, item);
            RadTreeList1.ExpandAllItems();
            RadTreeList1.Rebind();

            //soma e apresenta total na treeList
            SomaTotal();
        }

        protected Boolean ValidaCampos()
        {
            var valido = true;

            //verifica se o campo de nome está vazio ou não
            if (txtNome.Text.Equals(""))
            {
                lbMsg1.Text = "*";
                valido = false;
            }
            else
            {
                lbMsg1.Text = "";
            }            

            return valido;
        }

        protected List<VProteinas> IncluirItens
        {
            get
            {
                object itens = Session["GridItens"];
                if (itens == null)
                {
                    Session["GridItens"] = itens = new List<VProteinas>();
                }
                return (List<VProteinas>)itens;
            }
            set
            {
                Session["GridItens"] = value;
            }
        }

        protected List<VProteinas> IncluirPedidos
        {
            get
            {
                object itens = Session["pedidos"];
                if (itens == null)
                {
                    Session["pedidos"] = itens = new List<VProteinas>();
                }
                return (List<VProteinas>)itens;
            }
            set
            {
                Session["pedidos"] = value;
            }
        }

        //salva Atendimento no banco
        private async void FinalizarAtendimento()
        {                   
            //seta as informações no objeto Atendimentos
            atendimentos = new Atendimentos
            {                    
                ticket = BuscaTicket(DateTime.Today) + 1,
                valor = Decimal.Parse(lbTotal1.Text.Replace("TOTAL A PAGAR: ", "")),
                data_venda = DateTime.Today,
                digitacao = DateTime.Now,
                id_loja = 99,
                nome_cliente = txtNome.Text.ToUpper(),
                telefone = txbTelefone1.Text,
                viagem = bool.Parse(Session["viagem"].ToString())
            };

            //salva Atendimento no banco de dados e guarda o mesmo na variável
            atendimentos = await InsereAtendimento(atendimentos);

            //Cria um atendimentos_intes auxiliar para o cadastro de sabores no banco
            var atendimentos_itensAUX = new Atendimentos_itens();

            //contador do campo item
            var count = 1;

            //seta as informações no objeto Atendimentos_itens
            for (int i = 0; i < RadTreeList1.Items.Count; i++)
            {
                //se for um item que tenha sabor
                if (IncluirItens[i].tipo.Equals("temSabor"))
                {
                    atendimentos_itens = new Atendimentos_itens
                    {
                        id_venda = atendimentos.id_venda,
                        //item = (i + 1).ToString().PadLeft(4, '0'),
                        qtde = 1,
                        valor = Decimal.Parse(IncluirItens[i].precoAUX),
                        data_venda = DateTime.Today,
                        ticket = atendimentos.ticket,
                        id_produto = IncluirItens[i].id_produto,
                        id_sabor = IncluirItens[i].id_sabor
                    };

                    //guarda o item na variavel auxiliar
                    atendimentos_itensAUX = atendimentos_itens;
                }
                //se for um sabor
                else if (IncluirItens[i].tipo.Equals("sabor"))
                {
                    atendimentos_itensAUX.id_sabor = IncluirItens[i].id_sabor;
                    atendimentos_itensAUX.item = (count++).ToString().PadLeft(4, '0');

                    //insere os itens do atendimento
                    InsereAtendimentoItens(atendimentos_itensAUX);
                }
                //se for proteina, adicional ou agua
                else
                {
                    atendimentos_itens = new Atendimentos_itens
                    {
                        id_venda = atendimentos.id_venda,
                        item = (count++).ToString().PadLeft(4, '0'),
                        qtde = 1,
                        valor = Decimal.Parse(RadTreeList1.Items[i]["item_preco"].Text),
                        data_venda = DateTime.Today,
                        ticket = atendimentos.ticket,
                        id_produto = IncluirItens[i].id_produto,
                        id_sabor = IncluirItens[i].id_sabor
                    };

                    //insere os itens do atendimento
                    InsereAtendimentoItens(atendimentos_itens);
                }                          
            }

            //mostra mensagem que o pedido foi finalizado com sucesso
            //RadWindowManager1.RadAlert("Seu pedido foi finalizado com sucesso. Por favor, dirija-se ao caixa!!", 400, 180, "Atenção", "alertCallBack");
            RadWindowManager1.RadConfirm("Desja fazer mais algum pedido?", "alertCallBack", 400, 180, null, "Atenção");

            Response.Redirect("Inicial.aspx");            
        }

        protected void RadTreeList1_NeedDataSource(object sender, TreeListNeedDataSourceEventArgs e)
        {
            RadTreeList1.DataSource = IncluirItens;
        }

        protected void RadTreeList2_NeedDataSource(object sender, TreeListNeedDataSourceEventArgs e)
        {
            RadTreeList1.DataSource = IncluirPedidos;
        }

        protected void RadTreeList1_DeleteCommand(object sender, TreeListCommandEventArgs e)
        {
            TreeListDataItem item = (TreeListDataItem)e.Item;

            foreach (var child in item.ChildItems)
            {
                var index = IncluirItens.IndexOf(IncluirItens.Single(i => i.id == int.Parse(child["id"].Text) && i.id_proteina == int.Parse(child["id_proteina"].Text)));
                IncluirItens.RemoveAt(index);
            }

            IncluirItens.RemoveAt(item.DataItemIndex);

            //soma e apresenta total na treeList
            SomaTotal();

            RadTreeList1.Rebind();

            //btnOk.OnClientClicking = "windowConfirmacao";
        }

        private void SomaTotal()
        {
            //soma somente os itens 
            Decimal total = 0;
            for (int i = 0; i < IncluirItens.Count; i++)
            {
                if (!IncluirItens[i].tipo.Equals("temSabor"))
                {
                    total += Decimal.Parse(IncluirItens[i].preco);
                }
            }
            lbTotal1.Text = "TOTAL A PAGAR: " + string.Format("{0:n}", total);
        }

        protected void RadWizard1_NextButtonClick(object sender, WizardEventArgs e)
        {
            switch (e.NextStepIndex)
            {
                case 1:
                case 2:
                case 3:


                    try
                    {
                        var doc = new PrintDocument();
                        doc.PrintPage += Doc_PrintPage;
                        Task.Run(() => doc.Print());
                    }
                    catch (Exception erro)
                    {

                    }

                    break;

            }
        }

        protected void RadWizard1_ActiveStepChanged(object sender, EventArgs e)
        {
            //try
            //{
            //    var doc = new PrintDocument();
            //    doc.PrintPage += Doc_PrintPage;
            //    Task.Run(() => doc.Print());
            //}
            //catch (Exception erro)
            //{

            //}

        }

        //Coloca titulo nos grupos da TileList com base no nome do subgrupo
        protected void RadTileList1_OnTileDataBound(object sender, TileListEventArgs e)
        {
            string subgrupo = DataBinder.GetPropertyValue(e.Tile.DataItem, "subgrupo", null);            
            TileGroup currGroup = (sender as RadTileList).GetTileGroupByName(subgrupo);
            if (currGroup != null && currGroup.Title == string.Empty)
            {
                currGroup.Title = subgrupo;
            }
        }

        //busca o TICKET do ultimo Atendimento no banco
        public int BuscaTicket(DateTime date)
        {
            AtendimentosController ac = new AtendimentosController();
            return ac.BuscarUltimoTicket(date);
        }

        //insere um Atendimento no banco e retorna o objeto Atendimento inserido
        public async Task<Atendimentos> InsereAtendimento(Atendimentos atendimento)
        {
            //serializa o objeto e insere na tabela
            var serializaPedido = JsonConvert.SerializeObject(atendimento);
            var conteudo = new StringContent(serializaPedido, Encoding.UTF8, "application/json");
            var resultado = await cliente.PostAsync(cliente.BaseAddress + "Atendimentos", conteudo);

            //Desserializa o objeto adicionado na tabela e retorna o mesmo
            var re = resultado.Content.ReadAsStringAsync();
            atendimento = JsonConvert.DeserializeObject<Atendimentos>(re.Result);

            return atendimento;
        }

        //insere um ITEM DO PEDIDO no banco
        public void InsereAtendimentoItens(Atendimentos_itens atendimentos_itens)
        {
            var serializaPedido = JsonConvert.SerializeObject(atendimentos_itens);
            var conteudo = new StringContent(serializaPedido, Encoding.UTF8, "application/json");
            var resultado = cliente.PostAsync(cliente.BaseAddress + "Atendimentos_itens", conteudo);
        }

        //mostra o ultimo item escolhido pelo usuário na treeList
        protected void RadTreeList1_SelectedIndexChanged(object sender, EventArgs e)
        {
        }
        
        protected void TabelaMostraPedidos_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            // Cria tabela
            DataTable table = new DataTable();

            // Declara os objetos da tabela
            DataColumn column;
            DataRow row;
            DataView view;

            // Configura coluna Itens    
            column = new DataColumn();
            column.DataType = System.Type.GetType("System.String");
            column.ColumnName = "Itens";
            table.Columns.Add(column);

            // Configura coluna Valor
            column = new DataColumn();
            column.DataType = Type.GetType("System.String");
            column.ColumnName = "Valor";
            table.Columns.Add(column);

            Decimal total = 0;

            // Cria novas linhas na tabela    
            for (int i = 0; i < IncluirPedidos.Count; i++)
            {
                row = table.NewRow();
                
                //se o primeiro item da lista, ele será um cabeçalho "Pedido X"
                if (i == 0 && IncluirPedidos[i].proteina.Contains("Pedido")) 
                {                    
                    row["Itens"] = IncluirPedidos[i].proteina;
                    row["Valor"] = null;
                    table.Rows.Add(row);
                }
                //se não for o primeiro item da lista e for um cabeçalho pedido, escreve uma linha de TOTAL e depois adiciona o cabeçalho "PEDIDO X"
                else if (i > 0 && IncluirPedidos[i].proteina.Contains("Pedido"))  
                {
                    row["Itens"] = "Total";
                    row["Valor"] = total;
                    table.Rows.Add(row);
                    total = 0;

                    row = table.NewRow();
                    row["Itens"] = IncluirPedidos[i].proteina;
                    row["Valor"] = null;
                    table.Rows.Add(row);
                }
                //se for o último item da lista e o usuário desejar ver os pedidos, escreve o ultimo item do pedido e uma linha de total
                else if (i == IncluirPedidos.Count - 1)
                {
                    row["Itens"] = IncluirPedidos[i].proteina;
                    row["Valor"] = IncluirPedidos[i].preco;
                    total += Decimal.Parse(IncluirPedidos[i].preco);
                    table.Rows.Add(row);

                    row = table.NewRow();
                    row["Itens"] = "Total";
                    row["Valor"] = total;
                    table.Rows.Add(row);
                }
                //se for um item da lista que não seja cabeçalho e nem total, escreve a linha com nome, preço do produto e soma o preço ao valor total do pedido em questão
                else
                {
                    row["Itens"] = IncluirPedidos[i].proteina;
                    row["Valor"] = IncluirPedidos[i].preco;
                    total += Decimal.Parse(IncluirPedidos[i].preco);
                    table.Rows.Add(row);
                }                
            }

            // Cria uma visualização da tablea
            view = new DataView(table);

            // Assossia a View da tabela ao Grid
            TabelaMostraPedidos.DataSource = view;
        }

        private void MudaCorDasLinhas(object sender, DataGridItemEventArgs e)
        {
            for(int i=0; i < TabelaMostraPedidos.Items.Count; i++)
            {
                var celula = e.Item.Cells[i];
                if (celula.Text.Contains("Pedido"))
                {
                    celula.BackColor = Color.Black;
                }
            }                
        }

        protected void TabelaMostraPedidos_ItemCreated(object sender, GridItemEventArgs e)
        {
            //    for (int i = 0; i < TabelaMostraPedidos.Items.Count; i++)
            //    {
            //        var celula = e;
            //        if (celula.Text.Contains("Pedido"))
            //        {
            //            celula.BackColor = Color.Black;
            //        }
        }
    }
}
