using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Data.SqlClient;
using System.Data;

using EntidadesCompartidas;

namespace Persistencia
{
    public class PersistenciaDigital
    {
        public static void Agregar(Digital pDigital)
        {
            SqlConnection oConexion = new SqlConnection(Conexion.STRCONEXION);
            SqlCommand oComando = new SqlCommand("AgregarPublicacionDigital", oConexion);
            oComando.CommandType = CommandType.StoredProcedure;

            oComando.Parameters.AddWithValue("@Isbn", pDigital.ISBN);
            oComando.Parameters.AddWithValue("@Titulo", pDigital.Titulo);
            oComando.Parameters.AddWithValue("@Formato", pDigital.Formato);
            oComando.Parameters.AddWithValue("@Protegida", pDigital.Protegida);

            SqlParameter oRetorno = new SqlParameter("@Retorno", SqlDbType.Int);
            oRetorno.Direction = ParameterDirection.ReturnValue;
            oComando.Parameters.Add(oRetorno);

            try
            {
                oConexion.Open();
                oComando.ExecuteNonQuery();

                int resultado = (int)oComando.Parameters["@Retorno"].Value;

                if (resultado == -1)
                {
                    throw new Exception("Ya existe una publicacion con ese ISBN");
                }
                else if (resultado == -2)
                {
                    throw new Exception("Ocurrio un error inesperado");
                }

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally
            {
                oConexion.Close();
            }
        }
        public static void Modificar(Digital pDigital)
        {
            SqlConnection oConexion = new SqlConnection(Conexion.STRCONEXION);
            SqlCommand oComando = new SqlCommand("ModificarPublicacionDigital", oConexion);
            oComando.CommandType = CommandType.StoredProcedure;

            oComando.Parameters.AddWithValue("@Isbn", pDigital.ISBN);
            oComando.Parameters.AddWithValue("@Titulo", pDigital.Titulo);
            oComando.Parameters.AddWithValue("@Formato", pDigital.Formato);
            oComando.Parameters.AddWithValue("@Protegida", pDigital.Protegida);

            SqlParameter oRetorno = new SqlParameter("@Retorno", SqlDbType.Int);
            oRetorno.Direction = ParameterDirection.ReturnValue;
            oComando.Parameters.Add(oRetorno);

            try
            {
                oConexion.Open();
                oComando.ExecuteNonQuery();

                int resultado = (int)oComando.Parameters["@Retorno"].Value;

                if (resultado == -1)
                {
                    throw new Exception("No existe - no se modifica");
                }
                else if (resultado == -2)
                {
                    throw new Exception("Ocurrio un error inesperado");
                }

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally
            {
                oConexion.Close();
            }
        }
        public static void Eliminar(Digital pDigital)
        {
            SqlConnection oConexion = new SqlConnection(Conexion.STRCONEXION);
            SqlCommand oComando = new SqlCommand("EliminarPublicacion", oConexion);
            oComando.CommandType = CommandType.StoredProcedure;

            //Otra forma de crear el parametro de entrada
            //Le indico que la direccion es de entrada (ParameterDirection.Input)
            SqlParameter oIsbn = new SqlParameter("@Isbn", pDigital.ISBN);
            oIsbn.Direction = ParameterDirection.Input;

            SqlParameter oRetorno = new SqlParameter("@Retorno", SqlDbType.Int);
            oRetorno.Direction = ParameterDirection.ReturnValue;
            
            //Agrego manualmente los parametros a la coleccion de parametros
            oComando.Parameters.Add(oIsbn);
            oComando.Parameters.Add(oRetorno);

            //AddWithValue hace los 3 pasos 
            //(declararlo, determinar direccion y agregarlo a la coleccion) 

            try
            {
                oConexion.Open();
                
                //ExecuteNonQuery por que impactamos en la BD
                //pero no necesitamos que nos devuelva nada de una consulta
                //solamente devuelve el retorno
                oComando.ExecuteNonQuery();

                int resultado = (int)oComando.Parameters["@Retorno"].Value;

                if (resultado == -1)
                {
                    throw new Exception("No existe una publicacion con ese ISBN");
                }
                else if (resultado == -2)
                {
                    throw new Exception("Hay prestamos asociados - No se elimina");
                }
                else if (resultado == -3)
                {
                    throw new Exception("Ocurrio un error inesperado");
                }

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally
            {
                oConexion.Close();
            }
        }
        public static Digital Buscar(int pISBN)
        {
            string titulo, formato;
            bool protegida;

            Digital oDigital = null;
            SqlDataReader oReader;

            SqlConnection oConexion = new SqlConnection(Conexion.STRCONEXION);
            SqlCommand oComando = new SqlCommand("", oConexion);
            oComando.CommandType = CommandType.StoredProcedure;

            oComando.Parameters.AddWithValue("@Isbn", pISBN);

            try
            {
                oConexion.Open();
                //ExecuteReader() Se utiliza para hacer una consulta sobre la BD
                oReader = oComando.ExecuteReader();

                if (oReader.HasRows)
                {
                    if (oReader.Read())
                    {
                        titulo = (string)oReader["Titulo"];
                        formato = (string)oReader["Formato"];
                        protegida = Convert.ToBoolean(oReader["Protegida"]);

                        oDigital = new Digital(pISBN, titulo, formato, protegida);
                    }
                }
                oReader.Close();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally
            {
                oConexion.Close();
            }

            return oDigital;
        }
    }
}
 