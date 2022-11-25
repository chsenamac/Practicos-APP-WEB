using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Conexion
/// </summary>
public class Conexion
{
    //Atributo de la clase que va a contener el string de conexion
    public static string _cnn = "Data Source=.; Initial Catalog=Universidad; integrated Security=true";

    //Propiedad de clase de solo lectura
    public static string Cnn
    {
        get { return _cnn; }
    }
}