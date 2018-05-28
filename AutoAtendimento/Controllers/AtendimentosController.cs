using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Description;
using AutoAtendimento.Moldes;

namespace AutoAtendimento.Controllers
{
    public class AtendimentosController : ApiController
    {
        private BancoDados db = new BancoDados();

        // GET: api/Atendimentos
        public IQueryable<Atendimentos> GetAtendimentos()
        {
            return db.Atendimentos;
        }

        // GET: api/Atendimentos/5
        [ResponseType(typeof(Atendimentos))]
        public async Task<IHttpActionResult> GetAtendimentos(int id)
        {
            Atendimentos atendimentos = await db.Atendimentos.FindAsync(id);
            if (atendimentos == null)
            {
                return NotFound();
            }

            return Ok(atendimentos);
        }

        // PUT: api/Atendimentos/5
        [ResponseType(typeof(void))]
        public async Task<IHttpActionResult> PutAtendimentos(int id, Atendimentos atendimentos)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != atendimentos.id_venda)
            {
                return BadRequest();
            }

            db.Entry(atendimentos).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!AtendimentosExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST: api/Atendimentos
        [ResponseType(typeof(Atendimentos))]
        public async Task<IHttpActionResult> PostAtendimentos(Atendimentos atendimentos)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            try
            {
                db.Atendimentos.Add(atendimentos);
                await db.SaveChangesAsync();
            }
            catch( Exception erro)
            {

            }

            return CreatedAtRoute("DefaultApi", new { id = atendimentos.id_venda }, atendimentos);
        }

        // DELETE: api/Atendimentos/5
        [ResponseType(typeof(Atendimentos))]
        public async Task<IHttpActionResult> DeleteAtendimentos(int id)
        {
            Atendimentos atendimentos = await db.Atendimentos.FindAsync(id);
            if (atendimentos == null)
            {
                return NotFound();
            }

            db.Atendimentos.Remove(atendimentos);
            await db.SaveChangesAsync();

            return Ok(atendimentos);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool AtendimentosExists(int id)
        {
            return db.Atendimentos.Count(e => e.id_venda == id) > 0;
        }

        //Busca ultimo ticket do dia
        public int BuscarUltimoTicket(DateTime date)
        {
            var pedido = (from a in db.Atendimentos where a.data_venda == date orderby a.ticket descending select a);
            
            try
            {
                return pedido.First().ticket;
            }
            catch(Exception erro)
            {
                return 0;
            }

        }
    }
}