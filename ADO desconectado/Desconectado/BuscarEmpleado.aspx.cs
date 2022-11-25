using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;

using System.Drawing;

public partial class BuscarEmpleado : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        lblError.Text = "";

        if (!IsPostBack)
            LimpiarFormulario();

    }

    protected void btnLimpiar_Click(object sender, EventArgs e)
    {
        LimpiarFormulario();
    }

    private void LimpiarFormulario()
    {
        txtCedula.Text = "";
        txtNombre.Text = "";
        txtEdad.Text = "";
        txtSueldo.Text = "";
        chkCasado.Checked = false;
        lblEmpresa.Text = "";

    }

    protected void btnBuscar_Click(object sender, EventArgs e)
    {
        try
        {
            int cedula;
            DataSet datos = new DataSet();

            try
            {
                cedula = Convert.ToInt32(txtCedula.Text.Trim());
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }

            SqlConnection conexion = new SqlConnection(Conexion.CNN);

            //Si concatenamos un parametro, debemos tener cuidado con el espacio despues del nombre del SP pues es
            //el que separa el nombre de este con el parametro ejemplo: "exec BuscarEmpleado " + cedula  es "exec BuscarEmpleado 31899838"
            SqlDataAdapter adaptador = new SqlDataAdapter("exec BuscarEmpleado " + cedula, conexion);

            #region Explicando SelectCommand
            /*
             * Debemos comentar la linea de codigo anterior SqlDataAdapter [adaptador = new SqlDataAdapter("exec BuscarEmpleado " + cedula, conexion);]
             * 
             * SqlCommand comando = new SqlCommand("BuscarEmpleado", conexion);
             * comando.CommandType = CommandType.StoredProcedure;
             *
             * comando.Parameters.AddWithValue("@Cedula", cedula);
             *
             * SqlDataAdapter adaptador = new SqlDataAdapter(comando);//ESTA ES UNA FORMA
             * 
             * SqlDataAdapter adaptador = new SqlDataAdapter();//ESTA ES OTRA FORMA
             * adaptador.SelectCommand = comando;
             * 
             */
            #endregion

            //Cargamos el dataset y le damos un nombre al objeto datatable
            //no tiene por que coincidir con la tabla de la BD, pero es una buena practica
            adaptador.Fill(datos, "Empleado");

            //Preguntamos si hay por lo menos un registro en el objeto datatable
            if (datos.Tables["Empleado"].Rows.Count > 0)
            {
                //Mostramos los datos del empleado
                //usamos la primera fila de la tabla empleado, que esta en el conjunto de tablas del dataset
                DataRow row = datos.Tables["Empleado"].Rows[0];

                //los datos mantienen el nombre que traen de la BD
                txtCedula.Text = row["cedula"].ToString();
                txtNombre.Text = row["nombre"].ToString();
                txtEdad.Text = row["edad"].ToString();
                txtSueldo.Text = row["sueldo"].ToString();
                chkCasado.Checked = Convert.ToBoolean(row["casado"]);

                //Buscamos la empresa en la cual trabaja (sin exec (execute) tambien lo toma y funciona)
                //usamos otro adaptador y cargamos los datos en la siguiente fila del dataset (lista dinamica)
                //el parametro en este caso lo sacamos de los datos que obtuvimos en la consulta anterior
                SqlDataAdapter otroAdaptador = new SqlDataAdapter("BuscarEmpresa " + row["TrabajaEn"].ToString(), conexion);

                //cargamos en el mismo dataset otro datatable (en la coleccion tables)
                otroAdaptador.Fill(datos, "Empresa");

                if (datos.Tables["Empresa"].Rows.Count > 0)
                {
                    lblEmpresa.Text = datos.Tables["Empresa"].Rows[0]["ruc"].ToString() + " - " + datos.Tables["Empresa"].Rows[0]["nombre"].ToString();
                }
                else
                {
                    throw new Exception("No existe la empresa.");
                }
            }
            else
            {
                LimpiarFormulario();
                throw new Exception("No existe el empleado.");
            }

            //LA CONEXION SE ABRE Y SE CIERRA AUTOMATICAMENTE
        }
        catch (Exception ex)
        {
            lblError.ForeColor = Color.Red;
            lblError.Text = ex.Message;
        }
    }
}