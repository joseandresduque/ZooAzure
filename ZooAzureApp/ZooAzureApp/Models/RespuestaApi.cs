using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ZooAzureApp
{
    public class RespuestaApi <T> where T : class
    {
        public int totalElementos { get; set; }
        public string error { get; set; }
        public string datos { get; set; }
        public int datosInt { get; set; }
        public List<T> data { get; set; }
    }
}