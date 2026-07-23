using Entidades;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace Datos
{
    public class DaoUsuario
    {
        private readonly AccesoDatos datos;
        private string consulta;

        public DaoUsuario()
        {
            datos = new AccesoDatos();
        }


    //===============================//
    //             LOGIN             // 
    //===============================//

        public Usuarios validarLogin(Usuarios usuario)
        {
            consulta = @"SELECT
                            IDUsuario,
                            NombreCompleto,
                            Usuario,
                            Rol,
                            IDMedico_Usuario
                        FROM Usuarios
                        WHERE Usuario COLLATE Latin1_General_CS_AS = @Usuario
                        AND Contrasenia COLLATE Latin1_General_CS_AS = @Contrasenia
                        AND Estado = 1";

            SqlParameter[] parametros =
            {
                new SqlParameter("@Usuario", usuario.NombreUsuario),
                new SqlParameter("@Contrasenia", usuario.Contrasenia)
            };

            DataTable tabla = datos.ObtenerDatos(consulta, parametros);

            if (tabla.Rows.Count == 0)
                return null;

            return cargarUsuario(tabla.Rows[0]);
        }

        private Usuarios cargarUsuario(DataRow fila)
        {
            Usuarios usuario = new Usuarios();

            usuario.IDUsuario = Convert.ToInt32(fila["IDUsuario"]);
            usuario.NombreCompleto = fila["NombreCompleto"].ToString();
            usuario.NombreUsuario = fila["Usuario"].ToString();
            usuario.Rol = fila["Rol"].ToString();
            usuario.Estado = true;

            if (fila["IDMedico_Usuario"] != DBNull.Value)
                usuario.IDMedicoUsuario = (int?)Convert.ToInt32(fila["IDMedico_Usuario"]);
            else
                usuario.IDMedicoUsuario = null;

            return usuario;
        }


    //===============================//
    //    REESTABLECER CONTRASEÑA    //
    //===============================//

        public bool restablecerContrasenia(string nombreUsuario, string nuevaContrasenia)
        {
            consulta = @"UPDATE Usuarios
                        SET Contrasenia = @NuevaContrasenia
                        WHERE Usuario COLLATE Latin1_General_CS_AS = @Usuario
                            AND Estado = 1";

            SqlParameter[] parametros =
            {
                new SqlParameter("@Usuario", nombreUsuario),
                new SqlParameter("@NuevaContrasenia", nuevaContrasenia)
            };

            int filasAfectadas = datos.EjecutarConsulta(consulta, parametros);

            return filasAfectadas > 0;
        }

        public bool existeUsuarioActivo(string nombreUsuario)
        {
            consulta = @"SELECT COUNT(*)
                        FROM Usuarios
                        WHERE Usuario COLLATE Latin1_General_CS_AS = @Usuario
                            AND Estado = 1";

            SqlParameter[] parametros =
            {
                new SqlParameter("@Usuario", nombreUsuario)
            };

            int cantidad = Convert.ToInt32(datos.EjecutarEscalar(consulta, parametros));

            return cantidad > 0;
        }


    //===============================//
    //            LISTADO            // 
    //===============================//

        public DataTable getTablaUsuarios(string campo, string busqueda)
        {
            consulta = @"SELECT
                            U.IDUsuario AS ID,
                            U.NombreCompleto AS NombreCompleto,
                            ISNULL(CAST(U.IDMedico_Usuario AS VARCHAR(10)), '-') AS IDMedico,
                            U.Usuario AS Usuario,
                            U.Rol AS Rol,
                            U.Estado AS Estado,
                            CASE WHEN U.Estado = 1 THEN 'Activo' ELSE 'Inactivo' END AS EstadoTexto,
                            CASE WHEN U.Estado = 1 THEN 'badge-status active' ELSE 'badge-status inactive' END AS EstadoCSS
                        FROM Usuarios AS U
                        WHERE 1 = 1";

            List<SqlParameter> parametros = new List<SqlParameter>();

            if (!string.IsNullOrWhiteSpace(busqueda))
            {
                string columna = ObtenerFiltroBusqueda(campo);

                consulta += " AND " + columna + " LIKE @Busqueda";
                parametros.Add(new SqlParameter("@Busqueda", "%" + busqueda + "%"));
            }

            consulta += " ORDER BY U.IDUsuario ASC";

            return datos.ObtenerDatos(consulta, parametros.ToArray());
        }


    //===============================// 
    //       METODOS AUXILIARES      // 
    //===============================//

        private string ObtenerFiltroBusqueda(string campo)
        {
            switch (campo)
            {
                case "ID":
                    return "CAST(U.IDUsuario AS VARCHAR)";

                case "NombreCompleto":
                    return "U.NombreCompleto";

                case "IDMedico":
                    return "CAST(U.IDMedico_Usuario AS VARCHAR)";

                case "Usuario":
                    return "U.Usuario";

                case "Rol":
                    return "U.Rol";

                default:
                    return "CAST(U.IDUsuario AS VARCHAR)";
            }
        }
    }
}
