using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace AutoAtendimento.Moldes
{
    public class Produtos
    {
        [Key]
        public int id_produto { get; set; }
    }
}