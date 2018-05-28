using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace AutoAtendimento.Moldes
{
    public class Bebidas
    {
        [Key]
        public int id { get; set; }
        public int id_bebida { get; set; }
        public string bebida { get; set; }
        public Decimal preco { get; set; }
        public string imagem { get; set; }
        public byte[] imagem_bin { get; set; }
    }
}