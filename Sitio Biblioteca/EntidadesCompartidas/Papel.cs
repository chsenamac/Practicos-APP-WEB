using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EntidadesCompartidas
{
    public class Papel : Publicacion
    {
        private double peso;

        public Papel(int pISBN, string pTitulo, double pPeso)
            : base(pISBN, pTitulo)
        {
            peso = pPeso;
        }

        public double Peso
        {
            get { return peso; }
            set
            {
                if (value > 0)
                {
                    peso = value;
                }
                else
                {
                    throw new Exception("El peso debe ser mayor que cero");
                }
            }
        }

        //Propiedad para desplegar en DDL
        public override string AMostrar
        {
            get
            {
                return Titulo + " - Papel";
            }
        }

        public override string ToString()
        {
            return "PAPEL: " + base.ToString() + " Peso: " + peso;
        }
    }
}
