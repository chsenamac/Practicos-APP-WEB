using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EntidadesCompartidas
{
    public abstract class Publicacion
    {
        private int isbn;
        private string titulo;

        public Publicacion(int pISBN, string pTitulo)
        {
            isbn = pISBN;
            titulo = pTitulo;
        }

        public int ISBN
        {
            get
            {
                return isbn;
            }
            set
            {
                if (value <= 0)
                {
                    throw new Exception("El código ISBN debe ser mayor a cero");
                }
                
                isbn = value;
            }
        }

        public string Titulo
        {
            get
            {
                return titulo;
            }
            set
            {
                if (value.Trim() == "")
                {
                    throw new Exception("El título no puede ser de más de 20 caractes de largo.");
                }

                titulo = value;
            }
        }

        //Propiedad para desplegar en un DDL (no es obligatorio tenerla)
        public virtual string AMostrar
        {
            get { return Titulo + " - Publicación"; }
        }

        public override string ToString()
        {
            return "Título: " + titulo + " ISBN: " + isbn;
        }
    }
}
