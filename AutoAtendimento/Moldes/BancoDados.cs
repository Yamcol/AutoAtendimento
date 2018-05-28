using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;

namespace AutoAtendimento.Moldes
{
    public class BancoDados : DbContext
    {
        public BancoDados() : base("name=conexao")
        {

        }

        public DbSet<Proteinas> Proteinas { get; set; }

        public DbSet<Adicionais> Adicionais { get; set; }

        public DbSet<Bebidas> Bebidas { get; set; }

        public DbSet<Sobremesas> Sobremesas { get; set; }

        public System.Data.Entity.DbSet<AutoAtendimento.Moldes.Atendimentos> Atendimentos { get; set; }

        public System.Data.Entity.DbSet<AutoAtendimento.Moldes.Atendimentos_itens> Atendimentos_itens { get; set; }

        public System.Data.Entity.DbSet<AutoAtendimento.Moldes.Produtos> Produtos { get; set; }
    }
}