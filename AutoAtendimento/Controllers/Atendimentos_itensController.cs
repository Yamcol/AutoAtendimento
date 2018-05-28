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
    public class Atendimentos_itensController : ApiController
    {
        private BancoDados db = new BancoDados();

        // GET: api/Atendimentos_itens
        public IQueryable<Atendimentos_itens> GetAtendimentos_itens()
        {
            return db.Atendimentos_itens;
        }

        // GET: api/Atendimentos_itens/5
        [ResponseType(typeof(Atendimentos_itens))]
        public async Task<IHttpActionResult> GetAtendimentos_itens(int id)
        {
            Atendimentos_itens atendimentos_itens = await db.Atendimentos_itens.FindAsync(id);
            if (atendimentos_itens == null)
            {
                return NotFound();
            }

            return Ok(atendimentos_itens);
        }

        // PUT: api/Atendimentos_itens/5
        [ResponseType(typeof(void))]
        public async Task<IHttpActionResult> PutAtendimentos_itens(int id, Atendimentos_itens atendimentos_itens)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != atendimentos_itens.id_venda)
            {
                return BadRequest();
            }

            db.Entry(atendimentos_itens).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!Atendimentos_itensExists(id))
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

        // POST: api/Atendimentos_itens
        [ResponseType(typeof(Atendimentos_itens))]
        public async Task<IHttpActionResult> PostAtendimentos_itens(Atendimentos_itens atendimentos_itens)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Atendimentos_itens.Add(atendimentos_itens);

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (Atendimentos_itensExists(atendimentos_itens.id_venda))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = atendimentos_itens.id_venda }, atendimentos_itens);
        }

        // DELETE: api/Atendimentos_itens/5
        [ResponseType(typeof(Atendimentos_itens))]
        public async Task<IHttpActionResult> DeleteAtendimentos_itens(int id)
        {
            Atendimentos_itens atendimentos_itens = await db.Atendimentos_itens.FindAsync(id);
            if (atendimentos_itens == null)
            {
                return NotFound();
            }

            db.Atendimentos_itens.Remove(atendimentos_itens);
            await db.SaveChangesAsync();

            return Ok(atendimentos_itens);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool Atendimentos_itensExists(int id)
        {
            return db.Atendimentos_itens.Count(e => e.id_venda == id) > 0;
        }
    }
}