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
    public class AdicionaisController : ApiController
    {
        private BancoDados db = new BancoDados();

        // GET: api/Adicionais
        public IQueryable<Adicionais> GetAdicionais()
        {
            return db.Adicionais;
        }

        // GET: api/Adicionais/5
        [ResponseType(typeof(Adicionais))]
        public async Task<IHttpActionResult> GetAdicionais(int id)
        {
            Adicionais adicionais = await db.Adicionais.FindAsync(id);
            if (adicionais == null)
            {
                return NotFound();
            }

            return Ok(adicionais);
        }

        // PUT: api/Adicionais/5
        [ResponseType(typeof(void))]
        public async Task<IHttpActionResult> PutAdicionais(int id, Adicionais adicionais)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != adicionais.id_adicional)
            {
                return BadRequest();
            }

            db.Entry(adicionais).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!AdicionaisExists(id))
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

        // POST: api/Adicionais
        [ResponseType(typeof(Adicionais))]
        public async Task<IHttpActionResult> PostAdicionais(Adicionais adicionais)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Adicionais.Add(adicionais);
            await db.SaveChangesAsync();

            return CreatedAtRoute("DefaultApi", new { id = adicionais.id_adicional }, adicionais);
        }

        // DELETE: api/Adicionais/5
        [ResponseType(typeof(Adicionais))]
        public async Task<IHttpActionResult> DeleteAdicionais(int id)
        {
            Adicionais adicionais = await db.Adicionais.FindAsync(id);
            if (adicionais == null)
            {
                return NotFound();
            }

            db.Adicionais.Remove(adicionais);
            await db.SaveChangesAsync();

            return Ok(adicionais);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool AdicionaisExists(int id)
        {
            return db.Adicionais.Count(e => e.id_adicional == id) > 0;
        }
    }
}