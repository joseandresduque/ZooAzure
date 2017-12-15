using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace ZooAzureApp
{
    public class EspeciesController : ApiController
    {
        // GET: api/Especies
        public RespuestaApi<Especies> Get()
        {
            RespuestaApi<Especies> resultado = new RespuestaApi<Especies>();
            List<Especies> data = new List<Especies>();
            try
            {
                Db.Conectar();
                if (Db.EstaLaConexionAbierta())
                {
                    data = Db.ListaEspecies();
                    resultado.error = "";
                }
            }
            catch (Exception)
            {
                resultado.error = "Error";
            }
            resultado.totalElementos = data.Count;
            resultado.data = data;
            Db.Desconectar();
            return resultado;
        }

        // GET: api/Especies/5
        public RespuestaApi<Especies> Get(long id)
        {
            RespuestaApi<Especies> resultado = new RespuestaApi<Especies>();
            List<Especies> data = new List<Especies>();
            try
            {
                Db.Conectar();
                if (Db.EstaLaConexionAbierta())
                {
                    data = Db.ListaEspeciesId(id);
                    resultado.error = "";
                }
            }
            catch (Exception)
            {
                resultado.error = "Error";
            }
            resultado.totalElementos = data.Count;
            resultado.data = data;
            Db.Desconectar();
            return resultado;
        }

        // POST: api/Especies
        [HttpPost]
        public RespuestaApi<Especies> Post([FromBody] Especies especie)
        {/*--http://bitacoraweb.info/como-cargar-dinamicamente-un-select-con-jquery-javascript/ */
            RespuestaApi<Especies> respuesta = new RespuestaApi<Especies>();
            respuesta.datos = especie.nombre;
            respuesta.error = "";
            int filasAfectadas = 0;
            try
            {
                Db.Conectar();
                if (Db.EstaLaConexionAbierta())
                {
                    filasAfectadas = Db.InsertarEspecie(especie);
                }
                respuesta.totalElementos = filasAfectadas;
                Db.Desconectar();
            }
            catch (Exception ex)
            {
                respuesta.totalElementos = 0;
                respuesta.error = "Error al insertar la especie " + ex.ToString();
            }
            return respuesta;
        }

        // PUT: api/Especies/5
        [HttpPut]
        public RespuestaApi<Especies> Put(long id, [FromBody] Especies especie)
        {
            RespuestaApi<Especies> respuesta = new RespuestaApi<Especies>();
            respuesta.datos = especie.nombre;
            respuesta.error = "";
            int filasAfectadas = 0;
            try {
                Db.Conectar();
                if (Db.EstaLaConexionAbierta()) {
                    filasAfectadas = Db.ActualizarEspecie(id, especie);
                }
                respuesta.totalElementos = filasAfectadas;
                Db.Desconectar();
            } catch (Exception ex) {
                respuesta.totalElementos = 0;
                respuesta.error = "Error al actualizar la especie " + ex.ToString();
            }
            return respuesta;
        }

        // DELETE: api/Especies/5
        [HttpDelete]
        public RespuestaApi<Especies> Delete(long id)
        {
            RespuestaApi<Especies> respuesta = new RespuestaApi<Especies>();
            respuesta.datos = "Borrado el id " + id.ToString();
            respuesta.error = "";
            int filasAfectadas = 0;
            try {
                Db.Conectar();
                if (Db.EstaLaConexionAbierta()) {
                    filasAfectadas = Db.EliminarEspecie(id);
                }
                respuesta.totalElementos = filasAfectadas;
                Db.Desconectar();
            } catch (Exception ex) {
                respuesta.totalElementos = 0;
                respuesta.error = "Error al eliminar la especie con id " + id.ToString() + " ERROR: " + ex.ToString();
            }
            return respuesta;
        }
    }
}
