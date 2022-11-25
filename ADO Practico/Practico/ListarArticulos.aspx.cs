using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

using System.Data;
using System.Data.SqlClient;

using System.Drawing;

public partial class ListarArticulos : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DataSet ds = new DataSet();

        try
        {
            SqlConnection cnx = new SqlConnection(Publicos.StringConexion);
            SqlDataAdapter da = new SqlDataAdapter("ListoArticulo", cnx);

            da.Fill(ds, "Articulos");

            if (ds.Tables["Articulos"].Rows.Count > 0)
            {
                gvListado.DataSource = ds.Tables["Articulos"];
                gvListado.DataBind();
            }
            else
            {
                lblError.ForeColor = Color.Blue;
                lblError.Text = "No existen datos para mostrar";
            }

        }
        catch (Exception ex)
        {
            lblError.ForeColor = Color.Red;
            lblError.Text = ex.Message;
        }        
    }

}
