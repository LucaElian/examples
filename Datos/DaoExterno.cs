using System.Data;
using System.Data.SqlClient;

namespace Datos
{
    public class DaoExterno
    {
        private readonly AccesoDatos datos;
        private string consulta;

        public DaoExterno()
        {
            datos = new AccesoDatos();
        }

        public DataTable getProvincias()
        {
            consulta = @"SELECT
                            IDProvincia,
                            NombreProvincia
                        FROM Provincias
                        ORDER BY NombreProvincia ASC";

            return datos.ObtenerDatos(consulta);
        }

        public DataTable getLocalidades(int idProvincia)
        {
            consulta = @"SELECT
                            IDLocalidad,
                            NombreLocalidad
                        FROM Localidades
                        WHERE IDProvincia_Localidad = @IDProvincia
                        ORDER BY NombreLocalidad ASC";

            SqlParameter[] parametros =
            {
                new SqlParameter("@IDProvincia", idProvincia)
            };

            return datos.ObtenerDatos(consulta, parametros);
        }

        public DataTable getNacionalidades()
        {
            consulta = @"SELECT
                            IDNacionalidad,
                            NombreNacionalidad
                        FROM Nacionalidades
                        ORDER BY NombreNacionalidad ASC";

            return datos.ObtenerDatos(consulta);
        }

        public DataTable getEspecialidades()
        {
            consulta = @"SELECT
                            IDEspecialidad,
                            NombreEspecialidad
                        FROM Especialidades
                        ORDER BY NombreEspecialidad ASC";

            return datos.ObtenerDatos(consulta);
        }
    }
}
