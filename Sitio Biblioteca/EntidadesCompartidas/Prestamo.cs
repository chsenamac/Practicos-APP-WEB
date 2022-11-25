using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EntidadesCompartidas
{
    class Prestamo
    {
        private int numero;
        private DateTime fecha;
        private DateTime vencimiento;
        private string nombreUsuario;
        private bool devuelto;

        //Atributo de asociacion
        private Publicacion pub;


        public Prestamo(int pNumero, DateTime pFecha, DateTime pVencimiento, string pNombreUsuario, bool pDevuelto, Publicacion pPub)
        {
            numero = pNumero;
            fecha = pFecha;
            vencimiento = pVencimiento;
            nombreUsuario = pNombreUsuario;
            devuelto = pDevuelto;
        }

        //La propiedad Numero no lleva codigo defensivo por que viene autogenerado
        //desde la BD
        public int Numero
        {
            get { return numero; }
            set { numero = value; }
        }

        public DateTime Fecha
        {
            get { return fecha; }
            set
            {
                if (value.Date > DateTime.Now.Date)
                {
                    throw new Exception("La fecha de prestamo no puede ser posterior al dia de hoy");
                }
            }
        }

        public DateTime Vencimmiento
        {
            get { return vencimiento; }
            set { value = vencimiento; }//La restriccion es parte de la logica de negocios
        }

        public string NombreUsuario
        {
            get { return nombreUsuario; }
            set
            {
                if (value.Trim() == "")
                {
                    throw new Exception("El nombre de usuario no puede estar vacio");
                }
                else if (value.Trim().Length > 20)
                {
                    throw new Exception("Elnombre de usuario no puede contener mas de 20 caracteres");
                }

                nombreUsuario = value;
            }
        }

        public bool Devuelto
        {
            get { return devuelto; }
            set { value = devuelto; }
        }

        public Publicacion Pub
        {
            get { return pub; }
            set
            {
                if (value == null)
                {
                    throw new Exception("Se necesita una publicacion para prestar");
                }
                else
                {
                    pub = value;
                }
            }
        }

        //Propiedad para mostrar en las GV
        public string TituloPub
        {
            get { return pub.Titulo; }
        }

        public override string ToString()
        {
            return "PRESTAMO: Numero: " + numero + " - Fecha: " + fecha.ToShortDateString()
                + " - Vencimiento: " + vencimiento.ToShortDateString() + " - usuario: "
                + nombreUsuario + (Devuelto ? " - Devuelta" : " - No devuelta")
                + " - Publicacion: " + pub.Titulo;
        }
    }
}
