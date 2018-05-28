using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace AutoAtendimento.Moldes
{
    public class Atendimentos_itens
    {
        [Key, Column(Order = 0)]
        public int id_venda { get; set; }

        [Key, Column(Order = 1)]
        public String item { get; set; }

        [Key, Column(Order = 2)]
        public int ticket { get; set; }

        public Decimal valor { get; set; }

        public int qtde { get; set; }

        public int id_produto { get; set; }

        public int id_sabor { get; set; }

        public DateTime data_venda { get; set; }
    }
}