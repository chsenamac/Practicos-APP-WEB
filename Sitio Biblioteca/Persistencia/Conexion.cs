using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Persistencia
{
    //El modificador internal hace que la clase se comporte como
    //publica dentro de la biblioteca pero es privada fuera de ella
    internal class Conexion
    {
        //Otra forma de hacerlo es con una constante
        public const string STRCONEXION = "Data Source=.; Initial Catalog=Biblioteca; integrated Security=true";
    }
}

//Las constantes son elementos de clase, para poder usarlas necesito
//el nombre de la clase, como si fuera un atributo de 
//clase. (No necesito crear un objeto para poder usarlo)
//Todas las constantes son atributos de clase, pero no todos los atributos
//de clase son constantes. Implicitamente en la declaracion esta el static
//Toda constante debe ser inicializada al momento de la declaracion
//Despues no se puede cambiar su valor.
//El modificador (en este caso public) va a tener la visibilidad que tenga la
//clase.

//ES OTRO METODO DE HACERLO IGUAL DE VALIDO QUE HACERLO CON PROPIEDADES

//MODIFICADORES

//public es visible para toda la solucion (sistema)
//private es vivible solamente dentro de la clase
//protected es visible dentro de la clase y de las clases que heredan
//internal es visible solamente dentro del paquete pero privado para el resto del sistema