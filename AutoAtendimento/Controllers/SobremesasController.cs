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
    public class SobremesasController : ApiController
    {
        private BancoDados db = new BancoDados();

        // GET: api/Sobremesas
        public IQueryable<Sobremesas> GetSobremesas()
        {
            return db.Sobremesas;
        }

        // GET: api/Sobremesas/5
        [ResponseType(typeof(Sobremesas))]
        public async Task<IHttpActionResult> GetSobremesas(int id)
        {
            Sobremesas sobremesas = await db.Sobremesas.FindAsync(id);
            if (sobremesas == null)
            {
                return NotFound();
            }

            return Ok(sobremesas);
        }

        // PUT: api/Sobremesas/5
        [ResponseType(typeof(void))]
        public async Task<IHttpActionResult> PutSobremesas(int id, Sobremesas sobremesas)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != sobremesas.id_sobremesa)
            {
                return BadRequest();
            }

            db.Entry(sobremesas).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!SobremesasExists(id))
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

        // POST: api/Sobremesas
        [ResponseType(typeof(Sobremesas))]
        public async Task<IHttpActionResult> PostSobremesas(Sobremesas sobremesas)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Sobremesas.Add(sobremesas);
            await db.SaveChangesAsync();

            return CreatedAtRoute("DefaultApi", new { id = sobremesas.id_sobremesa }, sobremesas);
        }

        // DELETE: api/Sobremesas/5
        [ResponseType(typeof(Sobremesas))]
        public async Task<IHttpActionResult> DeleteSobremesas(int id)
        {
            Sobremesas sobremesas = await db.Sobremesas.FindAsync(id);
            if (sobremesas == null)
            {
                return NotFound();
            }

            db.Sobremesas.Remove(sobremesas);
            await db.SaveChangesAsync();

            return Ok(sobremesas);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool SobremesasExists(int id)
        {
            return db.Sobremesas.Count(e => e.id_sobremesa == id) > 0;
        }
    }
}