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
    public class ProteinasController : ApiController
    {
        private BancoDados db = new BancoDados();

        // GET: api/Proteinas
        public IQueryable<Proteinas> GetProteinas()
        {
            return db.Proteinas;
        }

        // GET: api/Proteinas/5
        [ResponseType(typeof(Proteinas))]
        public async Task<IHttpActionResult> GetProteinas(int id)
        {
            Proteinas proteinas = await db.Proteinas.FindAsync(id);
            if (proteinas == null)
            {
                return NotFound();
            }

            return Ok(proteinas);
        }

        // PUT: api/Proteinas/5
        [ResponseType(typeof(void))]
        public async Task<IHttpActionResult> PutProteinas(int id, Proteinas proteinas)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != proteinas.id_proteina)
            {
                return BadRequest();
            }

            db.Entry(proteinas).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ProteinasExists(id))
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

        // POST: api/Proteinas
        [ResponseType(typeof(Proteinas))]
        public async Task<IHttpActionResult> PostProteinas(Proteinas proteinas)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Proteinas.Add(proteinas);
            await db.SaveChangesAsync();

            return CreatedAtRoute("DefaultApi", new { id = proteinas.id_proteina }, proteinas);
        }

        // DELETE: api/Proteinas/5
        [ResponseType(typeof(Proteinas))]
        public async Task<IHttpActionResult> DeleteProteinas(int id)
        {
            Proteinas proteinas = await db.Proteinas.FindAsync(id);
            if (proteinas == null)
            {
                return NotFound();
            }

            db.Proteinas.Remove(proteinas);
            await db.SaveChangesAsync();

            return Ok(proteinas);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool ProteinasExists(int id)
        {
            return db.Proteinas.Count(e => e.id_proteina == id) > 0;
        }
    }
}