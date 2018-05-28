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
    public class BebidasController : ApiController
    {
        private BancoDados db = new BancoDados();

        // GET: api/Bebidas
        public IQueryable<Bebidas> GetBebidas()
        {
            return db.Bebidas;
        }

        // GET: api/Bebidas/5
        [ResponseType(typeof(Bebidas))]
        public async Task<IHttpActionResult> GetBebidas(int id)
        {
            Bebidas bebidas = await db.Bebidas.FindAsync(id);
            if (bebidas == null)
            {
                return NotFound();
            }

            return Ok(bebidas);
        }

        // PUT: api/Bebidas/5
        [ResponseType(typeof(void))]
        public async Task<IHttpActionResult> PutBebidas(int id, Bebidas bebidas)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != bebidas.id_bebida)
            {
                return BadRequest();
            }

            db.Entry(bebidas).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!BebidasExists(id))
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

        // POST: api/Bebidas
        [ResponseType(typeof(Bebidas))]
        public async Task<IHttpActionResult> PostBebidas(Bebidas bebidas)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Bebidas.Add(bebidas);
            await db.SaveChangesAsync();

            return CreatedAtRoute("DefaultApi", new { id = bebidas.id_bebida }, bebidas);
        }

        // DELETE: api/Bebidas/5
        [ResponseType(typeof(Bebidas))]
        public async Task<IHttpActionResult> DeleteBebidas(int id)
        {
            Bebidas bebidas = await db.Bebidas.FindAsync(id);
            if (bebidas == null)
            {
                return NotFound();
            }

            db.Bebidas.Remove(bebidas);
            await db.SaveChangesAsync();

            return Ok(bebidas);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool BebidasExists(int id)
        {
            return db.Bebidas.Count(e => e.id_bebida == id) > 0;
        }
    }
}