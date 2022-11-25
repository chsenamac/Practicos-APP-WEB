using System;
using System.Collections;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

using System.Drawing;

using System.Data;
using System.Data.SqlClient;

public partial class ABMArticulo : System.Web.UI.Page
{
    private void Limpieza()
    {
        txtCodigo.Text = "";
        txtCodigo.Enabled = true;
        txtCodigo.Focus();
        BtnBuscar.Enabled = true;

        BtnLimpiar.Enabled = false;

        txtNombre.Text = "";
        txtNombre.Enabled = false;
        txtPrecio.Text = "";
        txtPrecio.Enabled = false;

        BtnAlta.Enabled = false;
        BtnBaja.Enabled = false;
        BtnModificar.Enabled = false;
        lblError.Text = "";

    }

    private void Habilitar()
    {
        BtnBuscar.Enabled = false;
        txtCodigo.Enabled = false;
        BtnLimpiar.Enabled = true;
        txtNombre.Enabled = true;
        txtPrecio.Enabled = true;
        BtnAlta.Enabled = true;
        BtnBaja.Enabled = true;
        BtnModificar.Enabled = true;
        txtNombre.Focus();
    }

    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Limpieza();
        }
    }

    protected void BtnLimpiar_Click(object sender, EventArgs e)
    {
        Limpieza();
    }
    
    protected void BtnBuscar_Click(object sender, EventArgs e)
    {
        SqlConnection cnx = new SqlConnection(Publicos.StringConexion);

        try
        {
            if (txtCodigo.Text.Trim() == "")
            {
                throw new Exception("Debe ingresar un valor para el codigo de articulo");
            }

            Habilitar();

            SqlCommand cmd = new SqlCommand("BuscoArticulo", cnx);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@cod", txtCodigo.Text.Trim());

            cnx.Open();

            SqlDataReader lector = cmd.ExecuteReader();

            if (lector.HasRows)
            {
                lector.Read();
                txtNombre.Text = (string)lector["nomArt"];
                txtPrecio.Text = Convert.ToDouble(lector["PreArt"]).ToString();

                lector.Close();
            }
            else
            {
                lblError.Text = "No hay articulos registrados con este codigo: " + txtCodigo.Text;
            }
        }
        catch (Exception ex)
        {
            lblError.ForeColor = Color.Red;
            lblError.Text = ex.Message;
        }
    }

    protected void BtnAlta_Click(object sender, EventArgs e)
    {
        SqlConnection cnx = new SqlConnection(Publicos.StringConexion);

        SqlCommand comando = new SqlCommand("AltaArticulo", cnx);
        comando.CommandType = CommandType.StoredProcedure;

        comando.Parameters.AddWithValue("@cod", txtCodigo.Text.Trim());
        comando.Parameters.AddWithValue("@nom", txtNombre.Text.Trim());
        comando.Parameters.AddWithValue("@pre", txtPrecio.Text.Trim());

        SqlParameter retorno = new SqlParameter("@Retorno", SqlDbType.Int);
        retorno.Direction = ParameterDirection.ReturnValue;
        comando.Parameters.Add(retorno);

        try
        {
            cnx.Open();

            comando.ExecuteNonQuery();

            int res = Convert.ToInt32(retorno.Value);
            
            if (res == -1)
            {
                throw new Exception("El codigo: " + txtCodigo.Text + " esta duplicado, no se agregara el articulo");
            }
            else if (res == -2)
            {
                throw new Exception("Ocurrio un error inesperado, no se pudo agregar el articulo");
            }
            else
            {
                lblError.ForeColor = Color.Green;
                lblError.Text = "Alta con exito";
            }

            //Limpieza();
        }
        catch (Exception ex)
        {
            lblError.ForeColor = Color.Red;
            lblError.Text = ex.Message;
        }
        finally
        {
            cnx.Close();
        }
    }

    protected void BtnBaja_Click(object sender, EventArgs e)
    {
        SqlConnection cnx = new SqlConnection(Publicos.StringConexion);

        SqlCommand comando = new SqlCommand("BajaArticulo", cnx);
        comando.CommandType = CommandType.StoredProcedure;

        comando.Parameters.AddWithValue("@cod", txtCodigo.Text.Trim());

        SqlParameter retorno = new SqlParameter("@Retorno", SqlDbType.Int);
        retorno.Direction = ParameterDirection.ReturnValue;
        comando.Parameters.Add(retorno);

        try
        {
            cnx.Open();
            comando.ExecuteNonQuery();

            int res = (int)retorno.Value;
            if (res == -1)
            {
                throw new Exception("El codigo de articulo no se ha encontrado, nada que eliminar.");
            }
            else if (res == -2)
            {
                throw new Exception("Ocurrio un error  inesperado, no se ha eliminado el articulo");
            }
            else
            {
                lblError.ForeColor = Color.Green;
                lblError.Text = "Articulo eliminado con exito";
            }
        }
        catch (Exception ex)
        {
            lblError.ForeColor = Color.Red;
            lblError.Text = ex.Message;
        }
        finally
        {
            cnx.Close();
        }

    }

    protected void BtnModificar_Click(object sender, EventArgs e)
    {
        SqlConnection cnx= new SqlConnection(Publicos.StringConexion);

        SqlCommand comando = new SqlCommand("ModArticulo", cnx);
        comando.CommandType = CommandType.StoredProcedure;

        comando.Parameters.AddWithValue("@cod", txtCodigo.Text.Trim());
        comando.Parameters.AddWithValue("@nom", txtNombre.Text.Trim());
        comando.Parameters.AddWithValue("@pre", txtPrecio.Text.Trim());

        SqlParameter retorno = new SqlParameter("@Retorno", SqlDbType.Int);
        retorno.Direction = ParameterDirection.ReturnValue;
        comando.Parameters.Add(retorno);

        try
        {
            cnx.Open();
            comando.ExecuteNonQuery();

            int res = (int)retorno.Value;
            
            if (res == -2)
            {
                throw new Exception("Ocurrio un error inesperado, no se modifica el articulo");
            }
            else
            {
                lblError.ForeColor = Color.Green;
                lblError.Text = "El articulo se ha modificado correctamente.";
            }

        }
        catch (Exception ex)
        {
            lblError.ForeColor = Color.Red;
            lblError.Text = ex.Message;
        }
        finally
        {
            cnx.Close();
        }
    }
    
}
