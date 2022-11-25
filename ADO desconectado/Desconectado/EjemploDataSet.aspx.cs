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


public partial class EjemploDataSet : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // En este ejemplo dejamos todo habilitado, para ver los controles necesarios desde código
        lblError.Text = "";      

    }

    protected void btnCargar_Click(object sender, EventArgs e)
    {
        DataSet ds = new DataSet();
        SqlConnection cnx = new SqlConnection(Conexion.CNN);
        SqlDataAdapter da = new SqlDataAdapter("select cedula, nombre, edad from Empleados", cnx);

        try
        {
            da.Fill(ds, "Empleados");

            if (ds.Tables["Empleados"].Rows.Count > 0)
            {
                lblTitulo.Text = "Listado de empleados";
                gvEmpleado.DataSource = ds.Tables["Empleados"];
                gvEmpleado.DataBind();

                Session["DataSetEmpleados"] = ds;
            }
            else
            {
                gvEmpleado.DataSource = null;
                gvEmpleado.DataBind();

                Session["DataSetEmpleados"] = null;
            }
        }
        catch (Exception ex)
        {
            lblError.ForeColor = Color.Red;
            lblError.Text = ex.Message;
        }
        
    }

    protected void btnActualizar_Click(object sender, EventArgs e)
    {
        try
        {
            DataSet ds = (DataSet)Session["DataSetEmpleados"];

            if (ds != null)
            {
                //consultamos si algun registro de alguno de los DataTables del DataSet fue marcado como modificado
                if (!ds.HasChanges())
                {
                    throw new Exception("No se ha modificado ningun dato.");
                }
                else
                {
                    
                    SqlConnection cnx = new SqlConnection(Conexion.CNN);
                    //En este caso hay que tener cuidado con la sentencia SQL, debe ser identica a la que cargo de datos
                    //el DataSet inicial
                    SqlDataAdapter da = new SqlDataAdapter("select cedula, nombre, edad from Empleados", cnx);
                    

                    SqlCommandBuilder cb = new SqlCommandBuilder(da);

                    da.Update(ds, "Empleados");
                    ds.AcceptChanges();

                    lblTitulo.Text = "";

                    gvEmpleado.DataSource = null;
                    gvEmpleado.DataBind();

                    Session["DataSetEmpleados"] = null;
                    
                    lblError.ForeColor = Color.Green;
                    lblError.Text = "La base de datos ha sido actualizada!";
                }
            }
            else
            {
                throw new Exception("Para por actualizar la base de datos primero debe listar los empleados.");
            }
        }
        catch (Exception ex)
        {
            lblError.ForeColor = Color.Red;
            lblError.Text = ex.Message;
        }
    }

    protected void gvEmpleado_CommandRow(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            DataSet ds = (DataSet)Session["DataSetEmpleados"];
            DataTable dataT = ds.Tables["Empleados"];

            DataRow fila = dataT.Rows[Convert.ToInt32(e.CommandArgument)];

            if (e.CommandName == "Sumar")
            {
                fila["Edad"] = Convert.ToInt32(fila["edad"]) + 1;
            }
            else if (e.CommandName == "Restar")
            {
                fila["Edad"] = Convert.ToInt32(fila["edad"]) - 1;
            }

            gvEmpleado.DataSource = dataT;
            gvEmpleado.DataBind();
        }
        catch (Exception ex)
        {
            lblError.ForeColor = Color.Red;
            lblError.Text = ex.Message;
        }
    }
}
