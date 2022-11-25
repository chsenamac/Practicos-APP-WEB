using System;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using System.Drawing;

using System.Data;
using System.Data.SqlClient;


public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblResultado.Text = "";

        if (!IsPostBack)
            LimpiarFormulario();

    }

    #region Operaciones auxiliares

    private void LimpiarFormulario()
    {
        txtNumero.Enabled = true;
        txtNumero.Text = "";
        txtNombre.Enabled = false;
        txtNombre.Text = "";
        txtCarga.Enabled = false;
        txtCarga.Text = "";

        lbAldeMat.Items.Clear();
        lbAlumnos.Items.Clear();
        lbMaterias.Items.Clear();

        btnBuscar.Enabled = true;
        btnAgregar.Enabled = false;
        btnModificar.Enabled = false;
        btnEliminar.Enabled = false;
        btnListarAl.Enabled = false;

    }

    private void HabilitarBotones(bool esAlta)
    {
        btnModificar.Enabled = !esAlta;
        btnEliminar.Enabled = !esAlta;
        btnListarAl.Enabled = !esAlta;
        btnParamOutPut.Enabled = !esAlta;
        btnAgregar.Enabled = esAlta;
        btnBuscar.Enabled = false;

        txtNumero.Enabled = false;
        txtNombre.Enabled = true;
        txtCarga.Enabled = true;

    }

    #endregion

    protected void btnLimpiar_Click(object sender, EventArgs e)
    {
        LimpiarFormulario();
    }

    protected void btnBuscar_Click(object sender, EventArgs e)
    {
        //Creamos un objeto de la clase sqlConnection, pasando por parametro el string de conexion
        SqlConnection conexion = new SqlConnection(Conexion.Cnn);

        try
        {
            // Controlamos que haya escrito algo en el textbox
            if (txtNumero.Text.Trim() == "")
                throw new Exception("Ingrese un valor para el numero");

            //Creamos un objeto de la clase SqlCommand,
            //pasando como parametros el nombre del PA y la conexion existente
            SqlCommand comando = new SqlCommand("BuscarMateria", conexion);

            //Indicamos el tipo de comando (por defecto es una sentencia SQL)
            comando.CommandType = CommandType.StoredProcedure;

            //Agregamos a la coleccion de parametros (mismon ombre de que en el PA de la base de datos)
            comando.Parameters.AddWithValue("@id", txtNumero.Text);

            //Abrimos la conexion
            conexion.Open();

            //Definimos el contendor de datos
            SqlDataReader lector = comando.ExecuteReader();

            //Consultamos si tien algo para leer
            if (lector.HasRows)
            {
                HabilitarBotones(false);

                lector.Read();

                //En el indice 0 (cero) se encuentra idMateria
                txtNombre.Text = lector[1].ToString(); //(string)lector[1];
                txtCarga.Text = lector[2].ToString();

                //Cerramos el flujo de datos
                lector.Close();
            }
            else
            {
                HabilitarBotones(true);
                lblResultado.Text = "No hay  materia registrada con ese ID";
            }
        }
        catch (Exception ex)
        {
            lblResultado.ForeColor = Color.Red;
            lblResultado.Text = ex.Message;
        }
        finally
        {
            //Siempre cerramos la conexion 
            conexion.Close();
        }
    }

    protected void btnAgregar_Click(object sender, EventArgs e)
    {
        SqlConnection conexion = new SqlConnection(Conexion.Cnn);

        SqlCommand comando = new SqlCommand("Agregar", conexion);
        comando.CommandType = CommandType.StoredProcedure;

        //AddWithvalue solo se puede usar con parametros de entrada
        comando.Parameters.AddWithValue("@IdMateria", txtNumero.Text.Trim());
        comando.Parameters.AddWithValue("@Nombre", txtNombre.Text.Trim());
        comando.Parameters.AddWithValue("@carga", txtCarga.Text.Trim());

        //Como no es un parametro de entrada debemos agregarlo de otra forma
        SqlParameter retorno = new SqlParameter("@Retorno", SqlDbType.Int);
        retorno.Direction = ParameterDirection.ReturnValue;
        comando.Parameters.Add(retorno);

        try
        {
            conexion.Open();

            //En este caso necesitamos un contenedor
            comando.ExecuteNonQuery();

            int resultado = Convert.ToInt32(retorno.Value); //(int)retorno.value
            if (resultado == -1)
            {
                throw new Exception("Id de materia duplicado - no se agrega");
            }
            else if (resultado == -2)
            {
                throw new Exception("Ocurrio un error inesperado");
            }
            else
            {
                lblResultado.ForeColor = Color.Green;
                lblResultado.Text = "Alta con exito";
            }
            
            LimpiarFormulario();
        }
        catch (Exception ex)
        {
            lblResultado.ForeColor = Color.Red;
            lblResultado.Text = ex.Message;
        }
        finally
        {
            conexion.Close();
        }
    }

    protected void btnModificar_Click(object sender, EventArgs e)
    {
        SqlConnection conexion = new SqlConnection(Conexion.Cnn);

        SqlCommand comando = new SqlCommand("Modificar", conexion);
        comando.CommandType = CommandType.StoredProcedure;

        comando.Parameters.AddWithValue("@IdMateria", txtNumero.Text.Trim());
        comando.Parameters.AddWithValue("@Nombre", txtNombre.Text.Trim());
        comando.Parameters.AddWithValue("@carga", txtCarga.Text.Trim());

        SqlParameter retorno = new SqlParameter("@Retorno", SqlDbType.Int);
        retorno.Direction = ParameterDirection.ReturnValue;
        comando.Parameters.Add(retorno);

        try
        {
            conexion.Open();
            comando.ExecuteNonQuery();

            int resultado = (int)retorno.Value;
            if (resultado == -1)
            {
                throw new Exception("Id de materia duplicado - no se modifica");
            }
            else if (resultado == -2)
            {
                throw new Exception("Ocurrio un error inesperado");
            }
            else
            {
                lblResultado.ForeColor = Color.Green;
                lblResultado.Text = "Modificacion realizada con exito";
            }
            
            LimpiarFormulario();
        }
        catch (Exception ex)
        {
            lblResultado.ForeColor = Color.Red;
            lblResultado.Text = ex.Message;
        }
        finally
        {
            conexion.Close();
        }
    }

    protected void btnEliminar_Click(object sender, EventArgs e)
    {
        SqlConnection conexion = new SqlConnection(Conexion.Cnn);

        SqlCommand comando = new SqlCommand("Eliminar", conexion);
        comando.CommandType = CommandType.StoredProcedure;

        comando.Parameters.AddWithValue("@IdMateria", txtNumero.Text.Trim());

        SqlParameter retorno = new SqlParameter("@Retorno", SqlDbType.Int);
        retorno.Direction = ParameterDirection.ReturnValue;
        comando.Parameters.Add(retorno);

        try
        {
            conexion.Open();
            comando.ExecuteNonQuery();

            int resultado = (int)retorno.Value;
            if (resultado == -1)
            {
                throw new Exception("Id de materia no encontrado - no se eliminara");
            }
            else if (resultado == -2)
            {
                throw new Exception("Materia con alumnos - no se eliminara");
            }
            else if (resultado == -3)
            {
                throw new Exception("Ocurrio un error inesperado");
            }
            else
            {
                lblResultado.ForeColor = Color.Green;
                lblResultado.Text = "Eliminado con exito";
            }
            
            LimpiarFormulario();
        }
        catch (Exception ex)
        {
            lblResultado.ForeColor = Color.Red;
            lblResultado.Text = ex.Message;
        }
        finally
        {
            conexion.Close();
        }
    }

    protected void btnListarAl_Click(object sender, EventArgs e)
    {
        lbAldeMat.Items.Clear();

        SqlConnection conexion = new SqlConnection(Conexion.Cnn);

        SqlCommand comando = new SqlCommand("InscriptosAmateria", conexion);
        comando.CommandType = CommandType.StoredProcedure;

        comando.Parameters.AddWithValue("@Id", txtNumero.Text);

        try
        {
            conexion.Open();

            SqlDataReader reader = comando.ExecuteReader();

            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    lbAldeMat.Items.Add(reader["ci"].ToString() + " - " + reader["nombre"].ToString() + " - " + reader["direccion"].ToString());
                }
            }
            else
            {
                lblResultado.ForeColor = Color.Blue;
                lblResultado.Text = "No hay alumnos registrados en esta materia";
            }

            reader.Close(); //Cerramos el lector SqlDataReader (reader)
        }
        catch (Exception ex)
        {
            lblResultado.ForeColor = Color.Red;
            lblResultado.Text = ex.Message;
        }
        finally
        {
            conexion.Close();
        }
    }


    protected void btnParamOut_Click(object sender, EventArgs e)
    {
        SqlConnection conexion = new SqlConnection(Conexion.Cnn);

        SqlCommand comando = new SqlCommand("Salida", conexion);
        comando.CommandType = CommandType.StoredProcedure;

        comando.Parameters.AddWithValue("@Id", txtNumero.Text);

        //Parametro de salida, mismo nombre que en SP (debemos indicar el tipo de datos)
        SqlParameter salida = new SqlParameter("@cant", SqlDbType.Int);
        salida.Direction = ParameterDirection.Output;

        comando.Parameters.Add(salida);

        try
        {
            conexion.Open();
            comando.ExecuteNonQuery();

            lblResultado.ForeColor = Color.Black;
            lblResultado.Text = "Cantidad de alumnos inscriptos a esta materia: " + salida.Value;
        }
        catch (Exception ex)
        {
            lblResultado.ForeColor = Color.Red;
            lblResultado.Text = ex.Message;
        }
        finally
        {
            conexion.Close();
        }
    }

    protected void btnlistarMaterias_Click(object sender, EventArgs e)
    {
        LimpiarFormulario();

        SqlConnection conexion = new SqlConnection(Conexion.Cnn);
        SqlCommand comando = new SqlCommand("select * from materias", conexion);

        try
        {
            conexion.Open();
            SqlDataReader reader = comando.ExecuteReader();

            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    lbMaterias.Items.Add(reader["idmateria"].ToString() + " - " + reader["nombre"].ToString() + " - " + reader["cargahoraria"].ToString());
                }
            }
            else
            {
                lblResultado.ForeColor = Color.Blue;
                lblResultado.Text = "No hay materias registradas en el sistema";
            }

            reader.Close();
        }
        catch (Exception ex)
        {
            lblResultado.ForeColor = Color.Red;
            lblResultado.Text = ex.Message;
        }
        finally
        {
            conexion.Close();
        }
    }

    protected void btnListarAlumnos_Click(object sender, EventArgs e)
    {
        LimpiarFormulario();

        SqlConnection conexion = new SqlConnection(Conexion.Cnn);
        SqlCommand comando = new SqlCommand("select * from alumnos", conexion);

        try
        {
            conexion.Open();
            SqlDataReader reader = comando.ExecuteReader();

            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    lbAlumnos.Items.Add(reader["ci"].ToString() + " - " + reader["nombre"].ToString() + " - " + reader["direccion"].ToString());
                }
            }
            else
            {
                lblResultado.ForeColor = Color.Blue;
                lblResultado.Text = "No hay alumnos registrados en el sistema";
            }

            reader.Close();
        }
        catch (Exception ex)
        {
            lblResultado.ForeColor = Color.Red;
            lblResultado.Text = ex.Message;
        }
        finally
        {
            conexion.Close();
        }
    }

}
