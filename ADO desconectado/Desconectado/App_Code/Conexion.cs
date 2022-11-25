using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class Conexion
{
    public static string _cnn = "Data Source=.; Initial Catalog=Empresa; integrated Security=true";

    public static string CNN
    {
        get { return _cnn; }
    }
}