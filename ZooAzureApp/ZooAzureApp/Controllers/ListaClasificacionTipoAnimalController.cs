using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace ZooAzureApp.Controllers
{
    public class ListaClasificacionTipoAnimalController : ApiController
    {
        // GET: api/ListaClasificacionTipoAnimal
        public RespuestaApi<ListaClasificacionTipoAnimal> Get()
        {
            RespuestaApi<ListaClasificacionTipoAnimal> resultado = new RespuestaApi<ListaClasificacionTipoAnimal>();
            List<ListaClasificacionTipoAnimal> data = new List<ListaClasificacionTipoAnimal>();
            try
            {
                Db.Conectar();
                if (Db.EstaLaConexionAbierta())
                {
                    data = Db.GetClasiTipoAnimal();
                    resultado.error = "";
                }
            }
            catch (Exception ex)
            {
                resultado.error = "Error: " + ex.ToString();
            }
            resultado.totalElementos = data.Count;
            resultado.data = data;
            Db.Desconectar();
            return resultado;
        }

        // GET: api/ListaClasificacionTipoAnimal/5
        public string Get(int id)
        {
            return "value";
        }

        // POST: api/ListaClasificacionTipoAnimal
        public void Post([FromBody]string value)
        {
        }

        // PUT: api/ListaClasificacionTipoAnimal/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/ListaClasificacionTipoAnimal/5
        public void Delete(int id)
        {
        }
    }
}
