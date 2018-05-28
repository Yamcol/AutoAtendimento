<%@ Page Language="C#" AutoEventWireup="true" Async="true" CodeBehind="Default.aspx.cs" Inherits="AutoAtendimento.Default" %>
<%@ PreviousPageType VirtualPath="~/Inicial.aspx" %>

<!DOCTYPE html>

<html oncontextmenu="return false" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="Stylesheet" href="styles/TileSizes.css" />
    <link rel="Stylesheet" href="styles/TileSizesPais.css" />
    <link rel="Stylesheet" href="styles/WizardColor1.css" />
    <link rel="Stylesheet" href="styles/TreeList.Teste1.css" />
    <link rel="Stylesheet" href="styles/Tile.a2.css" />
    <link rel="Stylesheet" href="styles/Tile.a.css" />
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptBlock runat="server" ID="RadScriptBlock1">
            <script type="text/javascript">

                //flag proteina -> controla a impressão para a cozinha (só são impressas as proteinas e adicionais da treeList)

                //click proteina
                function OnClientTileClicking(sender, args) {
                    
                    $find("<%=RadWindowAdicionais.ClientID %>").show();
                    
                    var preco = args.get_tile().get_target();
                    var produto = args.get_tile().get_name();
                    var id_produto = args.get_tile().get_badgeData().value;

                    var item = "Add1:" + preco + ":" + produto + ":proteina:" + id_produto;

                    $find("<%=AjaxManager.ClientID%>").ajaxRequest(item);

                }
                    //click bebida
                function OnClientTileClicking1(titleList, args) {
                                        
                    var produto = args.get_tile().get_name();
                    if (produto.match(/ÁGUA/)) {
                        var preco = args.get_tile().get_target();
                        var id_produto = args.get_tile().get_badgeData().value;
                        var item = "Add1:" + preco + ":" + produto + ":x:" + id_produto;
                        $find("<%=AjaxManager.ClientID%>").ajaxRequest(item);
                    }
                    else if (produto.match(/REFRIGERANTE/)) {
                        var preco = args.get_tile().get_target();                        
                        var id_produto = args.get_tile().get_badgeData().value;
                        var item = "Add1:" + preco + ":" + produto + ":temSabor:" + id_produto;
                        $find("<%=AjaxManager.ClientID%>").ajaxRequest(item);
                        $find("<%=RadWindowBebidas.ClientID %>").show();
                    }
                    else if (produto == "SUCO LATA 335ML") {
                        var preco = args.get_tile().get_target();                        
                        var id_produto = args.get_tile().get_badgeData().value;
                        var item = "Add1:" + preco + ":" + produto + ":temSabor:" + id_produto;
                        $find("<%=AjaxManager.ClientID%>").ajaxRequest(item);
                        $find("<%=RadWindowBebidas1.ClientID %>").show();
                    }
                    else{ //quando for (produto == "SUCO NATURAL 300ML")
                        var preco = args.get_tile().get_target();                        
                        var id_produto = args.get_tile().get_badgeData().value;
                        var item = "Add1:" + preco + ":" + produto + ":temSabor:" + id_produto;
                        $find("<%=AjaxManager.ClientID%>").ajaxRequest(item);
                        $find("<%=RadWindowBebidas2.ClientID %>").show();
                    }
                }

                //click sobremesa
                function OnClientTileClicking2(titleList, args) {

                    $find("<%=RadWindowSobremesas.ClientID %>").show();

                    var preco = args.get_tile().get_target();
                    var produto = args.get_tile().get_name();
                    var id_produto = args.get_tile().get_badgeData().value;

                    var item = "Add1:" + preco + ":" + produto + ":temSabor:" + id_produto;

                    $find("<%=AjaxManager.ClientID%>").ajaxRequest(item);

                }             

                // click TileAdicionais
                function OnClientTileAdicionais(titleList, args) {

                    var preco = args.get_tile().get_target();
                    var produto = args.get_tile().get_name();
                    var id_produto = args.get_tile().get_badgeData().value;

                    var item = "Add2:" + preco + ":" + produto + ":proteina:" + id_produto;

                    $find("<%=AjaxManager.ClientID%>").ajaxRequest(item);
                }

                // click TileBebidas
                function OnClientTileBebidas(titleList, args) {

                    var preco = args.get_tile().get_target();
                    var produto = args.get_tile().get_name();
                    var id_sabor = args.get_tile().get_badgeData().value;                   

                    var item = "Add2:" + preco + ":" + produto + ":sabor:" + id_sabor;

                    $find("<%=AjaxManager.ClientID%>").ajaxRequest(item);      
                }                

                // click TileSobremesas
                function OnClientTileSobremesas(titleList, args) {

                    var preco = args.get_tile().get_target();
                    var produto = args.get_tile().get_name();
                    var id_sabor = args.get_tile().get_badgeData().value;

                    var item = "Add2:" + preco + ":" + produto + ":sabor:" + id_sabor;

                    $find("<%=AjaxManager.ClientID%>").ajaxRequest(item);                  
                }


                // confirma TileList adicional
                function windowConfirmacaoA(sender, args) {
                    $find("<%=RadWindowAdicionais.ClientID %>").close();
                }

                // confirma TileList bebida-Refri
                function windowConfirmacao(sender, args) {
                    $find("<%=RadWindowBebidas.ClientID %>").close();
                }

                // confirma TileList bebida-SucoLata
                function windowConfirmacao1(sender, args) {
                    $find("<%=RadWindowBebidas1.ClientID %>").close();
                }

                // confirma TileList bebida-SucoNatural
                function windowConfirmacao2(sender, args) {
                    $find("<%=RadWindowBebidas2.ClientID %>").close();
                }

                // confirma TileList sobremesa
                function windowConfirmacaoS(sender, args) {
                    $find("<%=RadWindowSobremesas.ClientID %>").close();
                }

                // define o botão de impressão
                function clientWizard(sender, args) {
                    var com = args.get_command();

                    switch (com) {
                        case 2: 

                            var item = "imprimir:"
                            $find("<%=AjaxManager.ClientID %>").ajaxRequest(item); 

                            //window.location.reload();

                            break;
                    }
                }

                function alertCallBack() { }

                // fecha window Pedidos
               function windowFecharPedidos(sender, args) {

                    $find("<%=RadWindowPedidos.ClientID %>").close();
                }
                
               function MostraPedidos() {
                    $find("<%=RadWindowPedidos.ClientID %>").show();
                }

            </script>
        </telerik:RadScriptBlock>

        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        <telerik:RadAjaxManager runat="server" ID="AjaxManager" OnAjaxRequest="AjaxManager_AjaxRequest">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="AjaxManager">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="lbProteina" />
                        <telerik:AjaxUpdatedControl ControlID="RadTreeList1" />
                        <telerik:AjaxUpdatedControl ControlID="lbTotal1" />
                        <telerik:AjaxUpdatedControl ControlID="lbMsg1" />
                        <telerik:AjaxUpdatedControl ControlID="lbMsg2" />
                        <telerik:AjaxUpdatedControl ControlID="RadWindowPedidos" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="RadTreeList1">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="lbTotal1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <div>
            <div runat="server" id="DivPrincipal" style="width: 70%; float: left; margin-top: 30px;">
                <telerik:RadWizard ID="RadWizard1" BackColor="Transparent" CssClass="RadWizard_A" Font-Size="18" runat="server" OnClientButtonClicking="clientWizard">
                    <Localization Next="Próximo" Previous="Anterior" Cancel="Cancelar" Finish="Finalizar" />
                    <WizardSteps>
                        <telerik:RadWizardStep ID="Proteina" Title="Proteína" Font-Size="12" runat="server" StepType="Start">
                            <telerik:RadTileList runat="server" CssClass="SizeTilesPais" TileRows="3" OnTileDataBound="RadTileList1_OnTileDataBound" ForeColor="#3a272f" SelectionMode="None" Skin="Glow" ID="RadTileList1" Height="500px" ScrollingMode="Auto" OnClientTileClicking="OnClientTileClicking" DataSourceID="sql1">
                                <DataBindings>
                                    <CommonTileBinding DataNameField="produto" DataBadgeValueField="id_produto" TileType="RadContentTemplateTile" DataTargetField="preco"  DataGroupNameField="subgrupo"/>
                                    <ContentTemplateTileBinding>
                                        <ContentTemplate>
                                            <telerik:RadBinaryImage runat="server" ID="RadBinaryImage1" DataValue='<%# DataBinder.Eval(Container.DataItem, "imagem_bin") == DBNull.Value? new System.Byte[0]: DataBinder.Eval(Container.DataItem, "imagem_bin") %>'
                                                AutoAdjustImageControlSize="false" Width="170px" Height="120px" AlternateText='<%#DataBinder.Eval(Container.DataItem, "produto") %>' />
                                            <div style="padding-left: 5px; margin-top: -5px">
                                                <telerik:RadLabel runat="server" ID="lbAdicional" Font-Size="12px" ForeColor="#3a272f" Text='<%#DataBinder.Eval(Container.DataItem, "produto")%>'></telerik:RadLabel>
                                            </div>
                                            <div style="padding-left: 5px; margin-top: -5px">
                                                <telerik:RadLabel runat="server" ID="RadLabel2" Font-Size="10px" ForeColor="#3a272f" Text='  <%#DataBinder.Eval(Container.DataItem, "preco", "{0:c}")%>'></telerik:RadLabel>
                                            </div>
                                        </ContentTemplate>
                                    </ContentTemplateTileBinding>                                    
                                </DataBindings>
                            </telerik:RadTileList>
                            <asp:SqlDataSource runat="server" ID="sql1" ConnectionString="<%$ ConnectionStrings: conexao %>" SelectCommand="select subgrupo.subgrupo,produtos.* from produtos JOIN subgrupo on subgrupo.id_subgrupo = produtos.id_subgrupo where produtos.id_grupo = 1 and produtos.disponivel_venda=1"></asp:SqlDataSource>                           
                        </telerik:RadWizardStep>

                        <telerik:RadWizardStep ID="Bebida" Font-Size="12" runat="server" StepType="Step" Title="Bebida">
                            <telerik:RadTileList runat="server" CssClass="SizeTilesPais" TileRows="3" ForeColor="Black" OnTileDataBound="RadTileList1_OnTileDataBound" Skin="Glow" SelectionMode="None" ID="RadTileList3" OnClientTileClicking="OnClientTileClicking1" ScrollingMode="Auto" Height="500px" DataSourceID="sql2">
                                <DataBindings>
                                    <CommonTileBinding DataNameField="produto" DataBadgeValueField="id_produto" TileType="RadContentTemplateTile" DataTargetField="preco" DataGroupNameField="subgrupo" />
                                    <ContentTemplateTileBinding>
                                        <ContentTemplate>
                                            <telerik:RadBinaryImage runat="server" ID="RadBinaryImage2" DataValue='<%# DataBinder.Eval(Container.DataItem, "imagem_bin") == DBNull.Value? new System.Byte[0]: DataBinder.Eval(Container.DataItem, "imagem_bin") %>'
                                                AutoAdjustImageControlSize="false" Width="170px" Height="120px" AlternateText='<%#DataBinder.Eval(Container.DataItem, "produto") %>' />
                                            <div style="padding-left: 5px">
                                                <telerik:RadLabel runat="server" ID="lbBebida" Font-Size="12px" ForeColor="#3a272f" Text='<%#DataBinder.Eval(Container.DataItem, "produto")%>'></telerik:RadLabel>
                                            </div>
                                        </ContentTemplate>
                                    </ContentTemplateTileBinding>
                                </DataBindings>
                            </telerik:RadTileList>
                            <asp:SqlDataSource runat="server" ID="sql2" ConnectionString="<%$ ConnectionStrings: conexao %>" SelectCommand="select subgrupo.subgrupo,produtos.* from produtos JOIN subgrupo on subgrupo.id_subgrupo = produtos.id_subgrupo where produtos.id_grupo = 2 and produtos.disponivel_venda=1"></asp:SqlDataSource>
                        </telerik:RadWizardStep>

                        <telerik:RadWizardStep ID="Sobremesa" Font-Size="12" runat="server" StepType="Step" CssClass="chartStep">
                            <telerik:RadTileList runat="server" CssClass="SizeTilesPais" TileRows="3" ForeColor="Black" OnTileDataBound="RadTileList1_OnTileDataBound" Skin="Glow" SelectionMode="None" OnClientTileClicking="OnClientTileClicking2" ID="RadTileList4" Height="500px" DataSourceID="sql3">
                                <DataBindings>
                                    <CommonTileBinding DataNameField="produto" DataBadgeValueField="id_produto" TileType="RadContentTemplateTile" DataTargetField="preco"  DataGroupNameField="subgrupo"/>
                                    <ContentTemplateTileBinding>
                                        <ContentTemplate>
                                            <telerik:RadBinaryImage runat="server" ID="RadBinaryImage3" DataValue='<%# DataBinder.Eval(Container.DataItem, "imagem_bin") == DBNull.Value? new System.Byte[0]: DataBinder.Eval(Container.DataItem, "imagem_bin") %>'
                                                AutoAdjustImageControlSize="false" Width="170px" Height="120px" AlternateText='<%#DataBinder.Eval(Container.DataItem, "produto") %>' />
                                            <div style="padding-left: 5px; margin-top: -5px">
                                                <telerik:RadLabel runat="server" ID="lbSobremesa" Font-Size="12px" ForeColor="#3a272f" Text='<%#DataBinder.Eval(Container.DataItem, "produto")%>'></telerik:RadLabel>
                                            </div>
                                            <div style="padding-left: 5px; margin-top: -5px">
                                                <telerik:RadLabel runat="server" ID="RadLabel2" Font-Size="10px" ForeColor="#3a272f" Text='  <%#DataBinder.Eval(Container.DataItem, "preco", "{0:c}")%>'></telerik:RadLabel>
                                            </div>
                                        </ContentTemplate>
                                    </ContentTemplateTileBinding>
                                </DataBindings>
                            </telerik:RadTileList>
                            <asp:SqlDataSource runat="server" ID="sql3" ConnectionString="<%$ ConnectionStrings: conexao %>" SelectCommand="select subgrupo.subgrupo,produtos.* from produtos JOIN subgrupo on subgrupo.id_subgrupo = produtos.id_subgrupo where produtos.id_grupo = 4 and produtos.disponivel_venda=1"></asp:SqlDataSource>
                        </telerik:RadWizardStep>

                        <telerik:RadWizardStep Font-Size="25" ID="Finalizar" runat="server" StepType="Finish" CssClass="chartStep">
                            <div style="margin-bottom: 482px">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 200px">
                                            <telerik:RadLabel runat="server" ID="lbNome" ForeColor="#3a272f" Text="Nome:"></telerik:RadLabel>
                                        </td>
                                        <td style="width: 400px">
                                            <telerik:RadTextBox runat="server" ID="txtNome" Width="100%"></telerik:RadTextBox>
                                            
                                        </td>
                                        <td>
                                            <telerik:RadLabel runat="server" ID="lbMsg1" ForeColor="red"></telerik:RadLabel>

                                        </td>
                                    </tr>
                                </table>                                
                                        
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 200px">
                                            <telerik:RadLabel runat="server" ID="lbTelefone" ForeColor="#3a272f" Text="Telefone:"></telerik:RadLabel>
                                        </td>
                                        <td style="width: 400px">
                                            <telerik:RadMaskedTextBox ID="txbTelefone1" runat="server" Mask="(##) #####-####"></telerik:RadMaskedTextBox>                                            
                                        </td>
                                        <td>
                                            <telerik:RadLabel runat="server" ID="lbMsg2" ForeColor="red"></telerik:RadLabel>

                                        </td>
                                    </tr>
                                </table>                                 
                            </div>                             
                        </telerik:RadWizardStep>
                    </WizardSteps>
                </telerik:RadWizard>

                <telerik:RadToolTip RenderMode="Lightweight" runat="server" ID="RadToolTip3" HideEvent="FromCode" Position="Center"
                    Animation="Slide" ShowEvent="FromCode" Modal="true" Title="Adicionais" Width="900px" Height="500px" RenderInPageRoot="true">
                    <telerik:RadLabel runat="server" ID="lbPrincipal" Skin="BlackMetroTouch" Text="ADICIONAIS PARA:"></telerik:RadLabel>
                    <telerik:RadLabel runat="server" ID="lbProteina" Skin="BlackMetroTouch"></telerik:RadLabel>
                    <telerik:RadLabel runat="server" ID="lbId" Visible="false"></telerik:RadLabel>
                </telerik:RadToolTip>

                <telerik:RadWindow RenderMode="Lightweight" Title="Adicionais" Modal="true" ID="RadWindowAdicionais" MinWidth="510px" MinHeight="600px" runat="server" Behaviors="None">
                    <ContentTemplate>
                        <telerik:RadTileList CssClass="CustomSizeTiles" runat="server" Skin="Glow" ID="RadTileList2" OnClientTileClicking="OnClientTileAdicionais" Height="400px"
                            DataSourceID="sql" ScrollingMode="Auto" Width="100%">
                            <DataBindings>
                                <CommonTileBinding DataNameField="produto" DataBadgeValueField="id_produto" TileType="RadContentTemplateTile" DataTargetField="preco" />
                                <ContentTemplateTileBinding>
                                    <ContentTemplate>
                                        <telerik:RadBinaryImage runat="server" ID="RadBinaryImage1" DataValue='<%# DataBinder.Eval(Container.DataItem, "imagem_bin") == DBNull.Value? new System.Byte[0]: DataBinder.Eval(Container.DataItem, "imagem_bin") %>'
                                            AutoAdjustImageControlSize="false" Width="150px" Height="105px" AlternateText='<%#DataBinder.Eval(Container.DataItem, "produto") %>' />
                                        <div style="padding-left: 5px; margin-top: -5px">
                                            <telerik:RadLabel runat="server" ID="lbAdicional" Font-Size="10px" ForeColor="White" Text='<%#DataBinder.Eval(Container.DataItem, "produto")%>'></telerik:RadLabel>
                                        </div>
                                        <div style="padding-left: 5px; margin-top: -5px">
                                            <telerik:RadLabel runat="server" ID="RadLabel2" Font-Size="10px" ForeColor="White" Text='  <%#DataBinder.Eval(Container.DataItem, "preco", "{0:c}")%>'></telerik:RadLabel>
                                        </div>
                                    </ContentTemplate>
                                </ContentTemplateTileBinding>
                            </DataBindings>
                        </telerik:RadTileList>
                        <table width="100%">
                            <tr>
                                <td>
                                    <telerik:RadButton runat="server" ID="btnOk" Text="Confimar" Width="120px" BackColor="WhiteSmoke" AutoPostBack="false" OnClientClicking="windowConfirmacaoA" Height="65px">
                                        <Icon PrimaryIconCssClass="rbOk" />
                                    </telerik:RadButton>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </telerik:RadWindow>
                <asp:SqlDataSource runat="server" ID="sql" ConnectionString="<%$ ConnectionStrings: conexao %>" SelectCommand="select * from produtos where id_grupo = 3 and produtos.disponivel_venda=1"></asp:SqlDataSource>

                <telerik:RadWindow RenderMode="Lightweight" Title="Bebidas" Modal="true" ID="RadWindowBebidas" MinWidth="510px" MinHeight="600px" runat="server" Behaviors="None">
                    <ContentTemplate>
                        <telerik:RadTileList runat="server" CssClass="CustomSizeTiles" Skin="Glow" ID="RadTileListBebida" Height="400px" OnClientTileClicking="OnClientTileBebidas"
                            DataSourceID="SqlBebidaSabor" ScrollingMode="None" Width="100%"> 
                            <DataBindings>
                                    <CommonTileBinding DataNameField="sabor" DataBadgeValueField="id_sabor" TileType="RadContentTemplateTile" DataTargetField="preco" />
                                    <ContentTemplateTileBinding>
                                        <ContentTemplate>
                                            <telerik:RadBinaryImage runat="server" ID="RadBinaryImageBebida" DataValue='<%# DataBinder.Eval(Container.DataItem, "imagem_bin") == DBNull.Value? new System.Byte[0]: DataBinder.Eval(Container.DataItem, "imagem_bin") %>'
                                                AutoAdjustImageControlSize="false" Width="150px" Height="105px" AlternateText='<%#DataBinder.Eval(Container.DataItem, "sabor") %>' />
                                            <div style="padding-left: 5px; margin-top: -5px">
                                                <telerik:RadLabel runat="server" ID="lbBebida" Font-Size="12px" ForeColor="White" Text='<%#DataBinder.Eval(Container.DataItem, "sabor")%>'></telerik:RadLabel>
                                            </div>
                                            <div style="padding-left: 5px; margin-top: -5px">
                                                <telerik:RadLabel runat="server" ID="RadLabelBebida" Font-Size="10px" ForeColor="White" Text='  <%#DataBinder.Eval(Container.DataItem, "preco", "{0:c}")%>'></telerik:RadLabel>
                                            </div>
                                        </ContentTemplate>
                                    </ContentTemplateTileBinding>
                                </DataBindings>
                        </telerik:RadTileList>
                        <table width="100%">
                            <tr>
                                <td>
                                    <telerik:RadButton runat="server" ID="RadButton2" Text="Confimar" Width="120px" BackColor="WhiteSmoke" AutoPostBack="false" OnClientClicking="windowConfirmacao" Height="65px">
                                        <Icon PrimaryIconCssClass="rbOk" />
                                    </telerik:RadButton>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </telerik:RadWindow>
                 <asp:SqlDataSource runat="server" ID="SqlBebidaSabor" ConnectionString="<%$ ConnectionStrings: conexao %>" SelectCommand="select * from Sabores where id_subgrupo = 1"></asp:SqlDataSource>

                <telerik:RadWindow RenderMode="Lightweight" Title="Bebidas" Modal="true" ID="RadWindowBebidas1" MinWidth="510px" MinHeight="600px" runat="server" Behaviors="None">
                    <ContentTemplate>
                        <telerik:RadTileList runat="server" CssClass="CustomSizeTiles" Skin="Glow" ID="RadTileList5" Height="400px" OnClientTileClicking="OnClientTileBebidas"
                            DataSourceID="SqlBebidaSabor1" ScrollingMode="None" Width="100%"> 
                            <DataBindings>
                                    <CommonTileBinding DataNameField="sabor" DataBadgeValueField="id_sabor" TileType="RadContentTemplateTile" DataTargetField="preco" />
                                    <ContentTemplateTileBinding>
                                        <ContentTemplate>
                                            <telerik:RadBinaryImage runat="server" ID="RadBinaryImageBebida1" DataValue='<%# DataBinder.Eval(Container.DataItem, "imagem_bin") == DBNull.Value? new System.Byte[0]: DataBinder.Eval(Container.DataItem, "imagem_bin") %>'
                                                AutoAdjustImageControlSize="false" Width="150px" Height="105px" AlternateText='<%#DataBinder.Eval(Container.DataItem, "sabor") %>' />
                                            <div style="padding-left: 5px; margin-top: -5px">
                                                <telerik:RadLabel runat="server" ID="lbBebida1" Font-Size="12px" ForeColor="White" Text='<%#DataBinder.Eval(Container.DataItem, "sabor")%>'></telerik:RadLabel>
                                            </div>
                                            <div style="padding-left: 5px; margin-top: -5px">
                                                <telerik:RadLabel runat="server" ID="RadLabelBebida1" Font-Size="10px" ForeColor="White" Text='  <%#DataBinder.Eval(Container.DataItem, "preco", "{0:c}")%>'></telerik:RadLabel>
                                            </div>
                                        </ContentTemplate>
                                    </ContentTemplateTileBinding>
                                </DataBindings>
                        </telerik:RadTileList>
                        <table width="100%">
                            <tr>
                                <td>
                                    <telerik:RadButton runat="server" ID="RadButton6" Text="Confimar" Width="120px" BackColor="WhiteSmoke" AutoPostBack="false" OnClientClicking="windowConfirmacao1" Height="65px">
                                        <Icon PrimaryIconCssClass="rbOk" />
                                    </telerik:RadButton>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </telerik:RadWindow>
                 <asp:SqlDataSource runat="server" ID="SqlBebidaSabor1" ConnectionString="<%$ ConnectionStrings: conexao %>" SelectCommand="select * from Sabores where id_subgrupo = 2"></asp:SqlDataSource>

                <telerik:RadWindow RenderMode="Lightweight" Title="Bebidas" Modal="true" ID="RadWindowBebidas2" MinWidth="510px" MinHeight="600px" runat="server" Behaviors="None">
                    <ContentTemplate>
                        <telerik:RadTileList runat="server" CssClass="CustomSizeTiles" DataBadgeValueField="id_sabor" Skin="Glow" ID="RadTileList6" Height="400px" OnClientTileClicking="OnClientTileBebidas"
                            DataSourceID="SqlBebidaSabor2" ScrollingMode="None" Width="100%"> 
                            <DataBindings>
                                    <CommonTileBinding DataNameField="sabor" TileType="RadContentTemplateTile" DataTargetField="preco" />
                                    <ContentTemplateTileBinding>
                                        <ContentTemplate>
                                            <telerik:RadBinaryImage runat="server" ID="RadBinaryImageBebida2" DataValue='<%# DataBinder.Eval(Container.DataItem, "imagem_bin") == DBNull.Value? new System.Byte[0]: DataBinder.Eval(Container.DataItem, "imagem_bin") %>'
                                                AutoAdjustImageControlSize="false" Width="150px" Height="105px" AlternateText='<%#DataBinder.Eval(Container.DataItem, "sabor") %>' />
                                            <div style="padding-left: 5px; margin-top: -5px">
                                                <telerik:RadLabel runat="server" ID="lbBebida2" Font-Size="12px" ForeColor="White" Text='<%#DataBinder.Eval(Container.DataItem, "sabor")%>'></telerik:RadLabel>
                                            </div>
                                            <div style="padding-left: 5px; margin-top: -5px">
                                                <telerik:RadLabel runat="server" ID="RadLabelBebida2" Font-Size="10px" ForeColor="White" Text='  <%#DataBinder.Eval(Container.DataItem, "preco", "{0:c}")%>'></telerik:RadLabel>
                                            </div>
                                        </ContentTemplate>
                                    </ContentTemplateTileBinding>
                                </DataBindings>
                        </telerik:RadTileList>
                        <table width="100%">
                            <tr>
                                <td>
                                    <telerik:RadButton runat="server" ID="RadButton8" Text="Confimar" Width="120px" BackColor="WhiteSmoke" AutoPostBack="false" OnClientClicking="windowConfirmacao2" Height="65px">
                                        <Icon PrimaryIconCssClass="rbOk" />
                                    </telerik:RadButton>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </telerik:RadWindow>
                 <asp:SqlDataSource runat="server" ID="SqlBebidaSabor2" ConnectionString="<%$ ConnectionStrings: conexao %>" SelectCommand="select * from Sabores where id_subgrupo = 10"></asp:SqlDataSource>

                <telerik:RadWindow RenderMode="Lightweight" Title="Sobremesas" Modal="true" ID="RadWindowSobremesas" MinWidth="510px" MinHeight="600px" runat="server" Behaviors="None">
                    <ContentTemplate>
                        <telerik:RadTileList runat="server" CssClass="CustomSizeTiles" Skin="Glow" ID="RadTileListSobremesas" Height="400px" OnClientTileClicking="OnClientTileSobremesas"
                            DataSourceID="SqlSobremesas" ScrollingMode="None" Width="100%"> 
                            <DataBindings>
                                    <CommonTileBinding DataNameField="sabor" DataBadgeValueField="id_sabor" TileType="RadContentTemplateTile" DataTargetField="preco" />
                                    <ContentTemplateTileBinding>
                                        <ContentTemplate>
                                            <telerik:RadBinaryImage runat="server" ID="RadBinaryImageSobremesa" DataValue='<%# DataBinder.Eval(Container.DataItem, "imagem_bin") == DBNull.Value? new System.Byte[0]: DataBinder.Eval(Container.DataItem, "imagem_bin") %>'
                                                AutoAdjustImageControlSize="false" Width="150px" Height="105px" AlternateText='<%#DataBinder.Eval(Container.DataItem, "sabor") %>' />
                                            <div style="padding-left: 5px; margin-top: -5px">
                                                <telerik:RadLabel runat="server" ID="lbSobremesa" Font-Size="12px" ForeColor="White" Text='<%#DataBinder.Eval(Container.DataItem, "sabor")%>'></telerik:RadLabel>
                                            </div>
                                            <div style="padding-left: 5px; margin-top: -5px">
                                                <telerik:RadLabel runat="server" ID="RadLabelSobremesa" Font-Size="10px" ForeColor="White" Text='  <%#DataBinder.Eval(Container.DataItem, "preco", "{0:c}")%>'></telerik:RadLabel>
                                            </div>
                                        </ContentTemplate>
                                    </ContentTemplateTileBinding>
                                </DataBindings>
                        </telerik:RadTileList>
                        <table width="100%">
                            <tr>
                                <td>
                                    <telerik:RadButton runat="server" ID="RadButton4" Text="Confimar" Width="120px" BackColor="WhiteSmoke" AutoPostBack="false" OnClientClicking="windowConfirmacaoS" Height="65px">
                                        <Icon PrimaryIconCssClass="rbOk" />
                                    </telerik:RadButton>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </telerik:RadWindow>
                 <asp:SqlDataSource runat="server" ID="SqlSobremesas" ConnectionString="<%$ ConnectionStrings: conexao %>" SelectCommand="select * from Sabores where id_subgrupo = 8"></asp:SqlDataSource>
               
                <telerik:RadWindow RenderMode="Lightweight" Title="Pedidos" VisibleStatusbar="false" Modal="true" ID="RadWindowPedidos" MinWidth="500px" MinHeight="600px" runat="server" Behaviors="None">
                    <ContentTemplate>

                        <telerik:RadGrid runat="server" ID="TabelaMostraPedidos" OnNeedDataSource="TabelaMostraPedidos_NeedDataSource" OnItemCreated="TabelaMostraPedidos_ItemCreated"></telerik:RadGrid>

                        <div style="padding-top: 5px; padding-bottom: 5px">                            
                            <telerik:RadButton runat="server" ID="RadButton1" Text="Fechar" Width="425px" BackColor="WhiteSmoke" AutoPostBack="false" OnClientClicking="windowFecharPedidos" Height="40px">
                                <Icon PrimaryIconCssClass="rbOk" />
                            </telerik:RadButton>
                        </div>
                        
                    </ContentTemplate>
                </telerik:RadWindow>            
            </div>

            <div>
                <img src="images/logo.png" alt="Sample Photo" height="200px" width="200px" style="padding-left:130px; padding-right: 4px; padding-top: 30px"/>
            </div>

            <div style="width: 29%; float: right; padding-left:2px; padding-right: 4px; padding-top: 15px">
                <telerik:RadTreeList runat="server" CssClass="RadTreeList_Teste1" ID="RadTreeList1" DataKeyNames="id" OnNeedDataSource="RadTreeList1_NeedDataSource" ParentDataKeyNames="id_proteina" OnSelectedIndexChanged="RadTreeList1_SelectedIndexChanged"
                    AutoGenerateColumns="false" ShowTreeLines="false" BorderColor="Transparent" BackColor="Transparent" GridLines="Horizontal" Height="415px" OnDeleteCommand="RadTreeList1_DeleteCommand">
                    <ClientSettings>
                        <Scrolling AllowScroll="true" UseStaticHeaders="true" SaveScrollPosition="true" />
                    </ClientSettings>
                    <Columns>
                        <telerik:TreeListBoundColumn DataField="id" UniqueName="id" Display="false"></telerik:TreeListBoundColumn>
                        <telerik:TreeListBoundColumn DataField="id_proteina" UniqueName="id_proteina" Display="false"></telerik:TreeListBoundColumn>
                        <telerik:TreeListBoundColumn DataField="id_pedido" UniqueName="id_proteina" Display="false"></telerik:TreeListBoundColumn>
                        <telerik:TreeListBoundColumn DataField="tipo" UniqueName="tipo" Display="false"></telerik:TreeListBoundColumn>
                        <telerik:TreeListBoundColumn DataField="parentesco" UniqueName="parentesco" Display="false"></telerik:TreeListBoundColumn>
                        <telerik:TreeListBoundColumn DataField="proteina" UniqueName="proteina" ItemStyle-Font-Size="8" HeaderText="Itens" HeaderStyle-Font-Bold="true" FooterText="Total">
                            <HeaderStyle HorizontalAlign="Center" />
                        </telerik:TreeListBoundColumn>
                        <telerik:TreeListBoundColumn DataField="preco" UniqueName="item_preco" ItemStyle-Font-Size="8" HeaderText="Valor" HeaderStyle-Font-Bold="true" DataFormatString="{0:n}" Aggregate="Sum" FooterAggregateFormatString="{0:n}">
                            <HeaderStyle HorizontalAlign="Center" Width="60px" />
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:TreeListBoundColumn>
                        <telerik:TreeListButtonColumn UniqueName="DeleteCommandColumn" ItemStyle-ForeColor="Red" HeaderStyle-Font-Size="20" Text="Delete" CommandName="Delete"
                            ButtonType="FontIconButton" HeaderStyle-Width="50px">
                        </telerik:TreeListButtonColumn>
                    </Columns>
                    <FooterItemStyle HorizontalAlign="Right" Font-Bold="true"/>    
                </telerik:RadTreeList> 

                <div style="text-align:center">
                    <asp:Label runat="server" ID="lbTotal1" CssClass="label" BackColor="#3a272f" ForeColor="#fbf4c7" Font-Size="24px" Font-Bold="true" Width="435px" Height="40px"></asp:Label>
                </div>

                <div style="text-align: center; padding-top: 20px">
                    <telerik:RadButton runat="server" BackColor="#3a272f" ForeColor="#fbf4c7" Text="Mostrar Pedidos" 
                            Height="100px" Width="435px" Font-Bold="true" Font-Size ="30px" AutoPostBack="false" OnClientClicked="MostraPedidos"></telerik:RadButton>
                </div>
            </div>

            <telerik:RadWindowManager ID="RadWindowManager1" runat="server" EnableShadow="true" ></telerik:RadWindowManager>

            <div style="float: right; padding-top:2px; padding-right:5px">
                <telerik:RadLabel runat="server" ID="RadLabel1" Font-Size="5" Text="Imagens meramente ilustrativas" ></telerik:RadLabel>
            </div>

        </div>
    </form>
</body>
</html>
