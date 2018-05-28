using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AutoAtendimento.Moldes.Views
{
    public class VProteinas
    {
        public int id { get; set; }
        public int id_proteina { get; set; }
        public int id_pedido { get; set; }
        public string proteina { get; set; }
        public String preco { get; set; }
        public String precoAUX { get; set; }
        public string imagem { get; set; }
        public string tipo { get; set; }
        public string parentesco { get; set; }
        public int qtde { get; set; }
        public int id_produto { get; set; }
        public int id_sabor { get; set; }
    }
}