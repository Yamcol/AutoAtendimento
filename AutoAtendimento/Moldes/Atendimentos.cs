using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace AutoAtendimento.Moldes
{
    public class Atendimentos
    {
        [Key]
        public int id_venda { get; set; }

        public int ticket { get; set; }

        public DateTime data_venda { get; set; }

        public Decimal valor { get; set; }

        public int id_loja { get; set; }

        public DateTime digitacao { get; set; }

        public string nome_cliente { get; set; }

        public string telefone { get; set; }

        public bool viagem { get; set; }
    }
}