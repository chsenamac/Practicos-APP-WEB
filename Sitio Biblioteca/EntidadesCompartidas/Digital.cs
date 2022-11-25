using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EntidadesCompartidas
{
    public class Digital : Publicacion
    {
        private string formato;
        private bool protegida;

        public Digital(int pISBN, string pTitulo, string pFormato, bool pProtegida)
            : base(pISBN, pTitulo)
        {
            formato = pFormato;
            protegida = pProtegida;
        }

        public string Formato
        {
            get { return formato; }
            set
            {
                if (value.Trim() == "")
                {
                    throw new Exception("El formato no puede estar vacio");
                }
                else if (value.Trim().Length > 3)
                {
                    throw new Exception("El formato no puede contener mas de 3 caracteres");
                }
                formato = value;
            }
        }

        public bool Protegida
        {
            get { return protegida; }
            set { protegida = value; }
        }

        //Propiedad para desplegar en un DDL
        public override string AMostrar
        {
            get
            {
                return Titulo + " - Digital";
            }
        }

        public override string ToString()
        {
            return "DIGITAL: " + base.ToString() + " Formato: " 
                + formato + (Protegida ? " Protegida" : " No protegida");
            //Operador ternario: este funciona como un if...else
            //puede tener todos los else if que queramos
            //la forma es (condicion booleana ? True : False)
            //en este caso es (Protegida ? " Protegida" : " No protegida")
            //Protegida = true then " Protegida"
            //Protegida = false then " No protegida"
        }
    }
}
