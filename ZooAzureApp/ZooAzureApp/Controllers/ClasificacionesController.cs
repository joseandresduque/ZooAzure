using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace ZooAzureApp
{
    public class ClasificacionesController : ApiController
    {
        // GET: api/Clasificaciones
        public RespuestaApi<Clasificaciones> Get()
        {
            RespuestaApi<Clasificaciones> resultado = new RespuestaApi<Clasificaciones>();
            List<Clasificaciones> data = new List<Clasificaciones>();
            try
            {
                Db.Conectar();
                if (Db.EstaLaConexionAbierta())
                {
                    data = Db.ListaClasificaciones();
                    resultado.error = "";
                }
            }
            catch (Exception ex)
            {
                resultado.error = "Error " + ex.ToString();
            }
            resultado.totalElementos = data.Count;
            resultado.data = data;
            Db.Desconectar();
            return resultado;
        }

        // GET: api/Clasificaciones/5
        public RespuestaApi<Clasificaciones> Get(int id)
        {
            RespuestaApi<Clasificaciones> resultado = new RespuestaApi<Clasificaciones>();
            List<Clasificaciones> data = new List<Clasificaciones>();
            try
            {
                Db.Conectar();
                if (Db.EstaLaConexionAbierta())
                {
                    data = Db.ListaClasificacionesId(id);
                    resultado.error = "";
                }
            }
            catch (Exception ex)
            {
                resultado.error = "Error " + ex.ToString();
            }
            resultado.totalElementos = data.Count;
            resultado.data = data;
            Db.Desconectar();
            return resultado;
        }

        // POST: api/Clasificaciones
        [HttpPost]
        public IHttpActionResult Post([FromBody] Clasificaciones clasificacion)
        {
            RespuestaApi<Clasificaciones> respuesta = new RespuestaApi<Clasificaciones>();
            respuesta.datos = clasificacion.denominacion;
            int filaAfectadas = 0;
            try {
                Db.Conectar();
                if (Db.EstaLaConexionAbierta()) {
                    filaAfectadas = Db.InsertarClasificacion(clasificacion);
                }
                respuesta.totalElementos = filaAfectadas;
            } catch (Exception e) {
                respuesta.error = "Error al conectar con la base de datos " + e.ToString();
            }
            Db.Desconectar();
            return Ok(respuesta);
        }

        // PUT: api/Clasificaciones/5
        [HttpPut]
        public IHttpActionResult Put(int id,[FromBody] Clasificaciones clasificacion) {

            RespuestaApi<Clasificaciones> respuesta = new RespuestaApi<Clasificaciones>();
            respuesta.datos = clasificacion.denominacion;
            respuesta.error = "";
            int filasAfectadas = 0;
            try
            {
                Db.Conectar();
                if (Db.EstaLaConexionAbierta())
                {
                    filasAfectadas = Db.ActualizarClasificaciones(id, clasificacion);
                }
                respuesta.totalElementos = filasAfectadas;
                Db.Desconectar();
            }
            catch (Exception ex)
            {
                respuesta.totalElementos = 0;
                respuesta.error = "Error al actualizar la clasificación con id "+id.ToString() + " ERROR: " + ex.ToString();
            }
            return Ok(respuesta);
        }

        // DELETE: api/Clasificaciones/5
        [HttpDelete]
        public IHttpActionResult Delete(int id) 
        {
            RespuestaApi<Clasificaciones> respuesta = new RespuestaApi<Clasificaciones>();
            respuesta.datos = "Borrado el id " + id.ToString();
            respuesta.error = "";
            int filasAfectadas = 0;
            try {
                Db.Conectar();
                if (Db.EstaLaConexionAbierta()) {
                    filasAfectadas = Db.EliminarClasificacion(id);
                }
                respuesta.totalElementos = filasAfectadas;
                Db.Desconectar();
            } catch (Exception ex) {
                respuesta.totalElementos = 0;
                respuesta.error = "Error al eliminar la  clasificación con id " + id.ToString() + " ERROR: " + ex.ToString();
            }
            return Ok(respuesta);
        }
    }
}
