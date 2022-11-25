using System;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using System.Drawing;

using System.Data;
using System.Data.SqlClient;

public partial class ListarEmpdeEmpresa : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            lblError.Text = "";

            if (!IsPostBack)
            {
                SqlConnection cnx = new SqlConnection(Conexion.CNN);

                SqlDataAdapter da = new SqlDataAdapter("ListarEmpresas", cnx);
                DataSet ds = new DataSet();

                da.Fill(ds, "Empresas");

                if (ds.Tables["Empresas"].Rows.Count > 0)
                {
                    //cargamos las empresas en el DDL (DropDownList)
                    ddlEmpresa.DataSource = ds.Tables["Empresas"];

                    //determinamos que datos se muestra, y que dato asociado se muestra en la seleccion
                    ddlEmpresa.DataTextField = "Nombre";
                    ddlEmpresa.DataValueField = "Ruc";

                    ddlEmpresa.DataBind();

                    //insertamos el primer valor para que no quede nada relevante seleccionado por defecto
                    //por ejemplo: "Seleccione una opcion", pero podemos dejar un valor por defecto que nos sea util
                    //o le simplifique el trabajo al usuario
                    ddlEmpresa.Items.Insert(0, new ListItem("- Seleccione una empresa"));

                    //habilitamos el DDL por que en este caso, lo tenemos desahibilitado, esto es opcional
                    //puede estar habilitado por defecto, en este proyecto no lo esta.
                    ddlEmpresa.Enabled = true;
                }
                else
                {
                    throw new Exception("No hay empresas ingresadas en el sistema");
                }
            }
        }
        catch (Exception ex)
        {
            lblError.ForeColor = Color.Red;
            lblError.Text = ex.Message;
        }
    }

    protected void ddlEmpresa_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            SqlConnection cnx = new SqlConnection(Conexion.CNN);

            if (ddlEmpresa.SelectedIndex != 0)
            {
                //ddlEmpresa.SelectedValue devuelve el valor del RUC, por que asi lo seteamos en la propiedad DataValueField
                SqlDataAdapter da = new SqlDataAdapter("EmpleadosPorRuc " + ddlEmpresa.SelectedValue, cnx);

                DataSet ds = new DataSet();
                da.Fill(ds, "Empleados");

                if (ds.Tables["Empleados"].Rows.Count > 0)
                {
                    gvEmpleado.DataSource = ds.Tables["Empleados"];
                    gvEmpleado.DataBind();

                    Session["DataTableEmpleados"] = ds.Tables["Empleados"];
                }
                else
                {
                    //comentar las siguientes dos lineas para observar la diferencia
                    gvEmpleado.DataSource = null;
                    gvEmpleado.DataBind();

                    Session["DataTableEmpleados"] = null;

                    lblError.ForeColor = Color.Blue;
                    lblError.Text = "La empresa seleccionada no tiene empleados aun";
                }
            }
            else
            {
                gvEmpleado.DataSource = null;
                gvEmpleado.DataBind();

                throw new Exception("Seleccione una empresa");
            }
        }
        catch (Exception ex)
        {
            lblError.ForeColor = Color.Red;
            lblError.Text = ex.Message;
        }
    }

    protected void gvEmpleado_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            //cargamos el DataTable con los datos que habiamos subido previamente a la memoria Session
            DataTable dt = (DataTable)Session["DataTableEmpleados"];
            
            //los datos de cada registro estan en el mismo indice en la GridView y en el DataTable 
            //por que se cargan en el mismo orden
            DataRow fila = dt.Rows[gvEmpleado.SelectedIndex];

            lblError.ForeColor = Color.Blue;
            lblError.Text = "El empleado seleccionado tiene un sueldo de $U: " + fila["sueldo"] + ".";
        }
        catch (Exception ex)
        {
            lblError.ForeColor = Color.Red;
            lblError.Text = ex.Message;
        }
    }
}
