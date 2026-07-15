using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Datos
{
    public class AccesoDatos
    {
        private readonly string cadenaConexion;

        public AccesoDatos()
        {
            cadenaConexion = ConfigurationManager.ConnectionStrings["BDClinica"].ConnectionString;
        }

        private SqlConnection ObtenerConexion()
        {
            SqlConnection conexion = new SqlConnection(cadenaConexion);

            try
            {
                conexion.Open();
                return conexion;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al abrir la conexión con la base de datos.", ex);
            }
        }

        public DataTable ObtenerDatos(string consulta, SqlParameter[] parametros = null)
        {
            DataTable tabla = new DataTable();

            using (SqlConnection conexion = ObtenerConexion())
            using (SqlCommand comando = new SqlCommand(consulta, conexion))
            {
                if (parametros != null)
                    comando.Parameters.AddRange(parametros);

                using (SqlDataAdapter adapter = new SqlDataAdapter(comando))
                {
                    adapter.Fill(tabla);
                }
            }

            return tabla;
        }

        public int EjecutarConsulta(string consulta, SqlParameter[] parametros = null)
        {
            using (SqlConnection conexion = ObtenerConexion())
            using (SqlCommand comando = new SqlCommand(consulta, conexion))
            {
                if (parametros != null)
                    comando.Parameters.AddRange(parametros);

                return comando.ExecuteNonQuery();
            }
        }

        public object EjecutarEscalar(string consulta, SqlParameter[] parametros = null)
        {
            using (SqlConnection conexion = ObtenerConexion())
            using (SqlCommand comando = new SqlCommand(consulta, conexion))
            {
                if (parametros != null)
                    comando.Parameters.AddRange(parametros);

                return comando.ExecuteScalar();
            }
        }
    }
}