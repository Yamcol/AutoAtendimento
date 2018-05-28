using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace AutoAtendimento.Moldes
{
    public class Proteinas
    {
        [Key]
        public int id_proteina { get; set; }
        public string proteina { get; set; }
        public Decimal preco { get; set; }
        public string imagem { get; set; }
        public byte[] imagem_bin { get; set; }

    }
}