using Entidades;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace Datos
{
    public class DaoPaciente
    {
        private readonly AccesoDatos datos;
        private string consulta;

        public DaoPaciente()
        {
            datos = new AccesoDatos();
        }


    //===============================//
    //            LISTADO            // 
    //===============================//

        public DataTable getTablaPacientes(string campo, string busqueda)
        {
            consulta = @"SELECT
                            IDPaciente AS ID,
                            DNI,
                            Apellido,
                            Nombre,
                            Correo,
                            Telefono,
                            Estado,
                            CASE WHEN Estado = 1 THEN 'Activo' ELSE 'Inactivo' END AS EstadoTexto,
                            CASE WHEN Estado = 1 THEN 'badge-status active' ELSE 'badge-status inactive' END AS EstadoCSS
                        FROM Pacientes
                        WHERE 1 = 1";

            List<SqlParameter> parametros = new List<SqlParameter>();

            if (!string.IsNullOrWhiteSpace(busqueda))
            {
                string columna = ObtenerFiltroBusqueda(campo);

                consulta += " AND " + columna + " LIKE @Busqueda";
                parametros.Add(new SqlParameter("@Busqueda", "%" + busqueda + "%"));
            }

            consulta += " ORDER BY IDPaciente ASC";

            return datos.ObtenerDatos(consulta, parametros.ToArray());
        }


    //===============================//
    //         OBTENER POR ID        // 
    //===============================//

        public DataTable getPacientePorID(int idPaciente)
        {
            consulta = @"SELECT
                    P.IDPaciente AS ID,
                    P.DNI AS DNI,
                    P.Apellido AS Apellido,
                    P.Nombre AS Nombre,
                    P.Sexo AS Sexo,
                    P.IDNacionalidad_Paciente AS IDNacionalidad,
                    P.FechaNacimiento AS FechaNacimiento,
                    P.Direccion AS Direccion,
                    P.IDLocalidad_Paciente AS IDLocalidad,
                    L.IDProvincia_Localidad AS IDProvincia,
                    P.Correo AS Correo,
                    P.Telefono AS Telefono,
                    P.Estado AS Estado
                FROM Pacientes AS P
                INNER JOIN Localidades AS L
                    ON P.IDLocalidad_Paciente = L.IDLocalidad
                WHERE P.IDPaciente = @IDPaciente";

            SqlParameter[] parametros =
            {
                new SqlParameter("@IDPaciente", idPaciente)
            };

            return datos.ObtenerDatos(consulta, parametros);
        }


    //===============================//
    //            AGREGAR            // 
    //===============================//

        public int agregarPaciente(Entidades.Pacientes paciente)
        {
            consulta = @"INSERT INTO Pacientes
                        (
                            DNI,
                            Apellido,
                            Nombre,
                            Sexo,
                            IDNacionalidad_Paciente,
                            FechaNacimiento,
                            Direccion,
                            IDLocalidad_Paciente,
                            Correo,
                            Telefono
                        )
                        VALUES
                        (
                            @DNI,
                            @Apellido,
                            @Nombre,
                            @Sexo,
                            @IDNacionalidad,
                            @FechaNacimiento,
                            @Direccion,
                            @IDLocalidad,
                            @Correo,
                            @Telefono
                        )";

            SqlParameter[] parametros =
            {
            new SqlParameter("@DNI", paciente.DNI),
            new SqlParameter("@Apellido", paciente.Apellido),
            new SqlParameter("@Nombre", paciente.Nombre),
            new SqlParameter("@Sexo", paciente.Sexo),
            new SqlParameter("@IDNacionalidad", paciente.IDNacionalidad),
            new SqlParameter("@FechaNacimiento", paciente.FechaNacimiento),
            new SqlParameter("@Direccion", paciente.Direccion),
            new SqlParameter("@IDLocalidad", paciente.IDLocalidad),
            new SqlParameter("@Correo", paciente.Correo),
            new SqlParameter("@Telefono", paciente.Telefono)
            };

            return datos.EjecutarConsulta(consulta, parametros); 
        }


        //===============================//
        //           MODIFICAR           // 
        //===============================//

        public int modificarPaciente(Pacientes paciente)
        {
            consulta = @"UPDATE Pacientes
                            SET DNI = @DNI,
                            Apellido = @Apellido,
                            Nombre = @Nombre,
                            Sexo = @Sexo,
                            IDNacionalidad_Paciente = @IDNacionalidad,
                            FechaNacimiento = @FechaNacimiento,
                            Direccion = @Direccion,
                            IDLocalidad_Paciente = @IDLocalidad,
                            Correo = @Correo,
                            Telefono = @Telefono
                        WHERE IDPaciente = @IDPaciente";

            SqlParameter[] parametros =
            {
                new SqlParameter("@DNI", paciente.DNI),
                new SqlParameter("@Apellido", paciente.Apellido),
                new SqlParameter("@Nombre", paciente.Nombre),
                new SqlParameter("@Sexo", paciente.Sexo),
                new SqlParameter("@IDNacionalidad", paciente.IDNacionalidad),
                new SqlParameter("@FechaNacimiento", paciente.FechaNacimiento),
                new SqlParameter("@Direccion", paciente.Direccion),
                new SqlParameter("@IDLocalidad", paciente.IDLocalidad),
                new SqlParameter("@Correo", paciente.Correo),
                new SqlParameter("@Telefono", paciente.Telefono),
                new SqlParameter("@IDPaciente", paciente.IDPaciente)
            };

            return datos.EjecutarConsulta(consulta, parametros);
        }


    //===============================// 
    //      ACTIVAR / DESACTIVAR     // 
    //===============================//

        public int cambiarEstadoPaciente(int idPaciente, bool estado)
        {
            consulta = @"UPDATE Pacientes
                            SET Estado = @Estado
                        WHERE IDPaciente = @IDPaciente";

            SqlParameter[] parametros =
            {
                new SqlParameter("Estado", estado),
                new SqlParameter("IDPaciente", idPaciente)
            };

            return datos.EjecutarConsulta(consulta, parametros);
        }


    //===============================// 
    //     INICIO ADMIN DASHBOARD    // 
    //===============================//

        public int getCantidadPacientesActivos()
        {
            consulta = @"SELECT COUNT(*)
                        FROM Pacientes
                        WHERE Estado = 1";

            DataTable tabla = datos.ObtenerDatos(consulta);

            return Convert.ToInt32(tabla.Rows[0][0]);
        }


    //===============================// 
    //       DATOS PARA COMBOS       // 
    //===============================//

        public DataTable getPacientesActivos()
        {
            consulta = @"SELECT
                            IDPaciente,
                            Nombre + ' ' + Apellido + ' - ' + DNI AS Paciente
                        FROM Pacientes
                        WHERE Estado = 1
                        ORDER BY Apellido ASC, Nombre ASC";

            return datos.ObtenerDatos(consulta);
        }


    //===============================// 
    //       VALIDAR REPETIDOS       // 
    //===============================//

        public bool existeDNI(string dni, int idPaciente)
        {
            return existeDato("DNI", dni, idPaciente);
        }

        public bool existeCorreo(string correo, int idPaciente)
        {
            return existeDato("Correo", correo, idPaciente);
        }

        public bool existeTelefono(string telefono, int idPaciente)
        {
            return existeDato("Telefono", telefono, idPaciente);
        }

    //===============================// 
    //       METODOS AUXILIARES      // 
    //===============================//

        private bool existeDato(string columna, string valor, int idPaciente)
        {
            consulta = @"SELECT COUNT(*)
                        FROM Pacientes
                        WHERE " + columna + @" = @Valor
                        AND IDPaciente <> @IDPaciente";

            SqlParameter[] parametros =
            {
                new SqlParameter("@Valor", valor),
                new SqlParameter("@IDPaciente", idPaciente)
            };

            int cantidad = Convert.ToInt32(datos.EjecutarEscalar(consulta, parametros));

            return cantidad > 0;
        }

        private string ObtenerFiltroBusqueda(string campo)
        {
            switch (campo)
            {
                case "ID":
                    return "IDPaciente";

                case "DNI":
                    return "DNI";

                case "Nombre":
                    return "Nombre";

                case "Apellido":
                    return "Apellido";

                default:
                    return "IDPaciente";
            }
        }
    }
}
