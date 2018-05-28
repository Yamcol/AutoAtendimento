using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace AutoAtendimento.Moldes
{
    public class Sobremesas
    {
        [Key]
        public int id_sobremesa { get; set; }
        public string sobremesa { get; set; }
        public Decimal preco { get; set; }
        public string imagem { get; set; }
        public byte[] imagem_bin { get; set; }
    }
}