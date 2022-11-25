using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class Publicos
{
    private static string _cnn = "Data Source=.; Initial Catalog=Ventas; integrated Security=true";

    public static string StringConexion
    {
        get { return _cnn; }
    }

}