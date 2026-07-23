using Entidades;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace Datos
{
    public class DaoMedico
    {
        private readonly AccesoDatos datos;
        private string consulta;

        public DaoMedico()
        {
            datos = new AccesoDatos();
        }


    //===============================//
    //            LISTADO            // 
    //===============================//

        public DataTable getTablaMedicos(string campo, string busqueda)
        {
            consulta = @"SELECT
                            M.IDMedico AS ID,
                            M.Legajo AS Legajo,
                            M.DNI AS DNI,
                            M.Apellido AS Apellido,
                            M.Nombre AS Nombre,
                            E.NombreEspecialidad AS Especialidad,
                            M.Correo AS Correo,
                            M.Telefono AS Telefono,
                            M.Estado AS Estado,
                            CASE WHEN M.Estado = 1 THEN 'Activo' ELSE 'Inactivo' END AS EstadoTexto,
                            CASE WHEN M.Estado = 1 THEN 'badge-status active' ELSE 'badge-status inactive' END AS EstadoCSS
                        FROM Medicos AS M
                        INNER JOIN Especialidades AS E 
                            ON M.IDEspecialidad_Medico = E.IDEspecialidad
                        WHERE 1 = 1";

            List<SqlParameter> parametros = new List<SqlParameter>();

            if (!string.IsNullOrWhiteSpace(busqueda))
            {
                string columna = ObtenerFiltroBusqueda(campo);

                consulta += " AND " + columna + " LIKE @Busqueda";
                parametros.Add(new SqlParameter("@Busqueda", "%" + busqueda + "%"));
            }

            consulta += " ORDER BY M.IDMedico ASC";

            return datos.ObtenerDatos(consulta, parametros.ToArray());
        }


    //===============================//
    //         OBTENER POR ID        // 
    //===============================//

        public DataTable getMedicoPorID(int idMedico)
        {
            consulta = @"SELECT
                    M.IDMedico AS ID,
                    M.Legajo AS Legajo,
                    M.DNI AS DNI,
                    M.Apellido AS Apellido,
                    M.Nombre AS Nombre,
                    M.Sexo AS Sexo,
                    M.IDEspecialidad_Medico AS IDEspecialidad,
                    M.IDNacionalidad_Medico AS IDNacionalidad,
                    M.FechaNacimiento AS FechaNacimiento,
                    M.Direccion AS Direccion,
                    M.IDLocalidad_Medico AS IDLocalidad,
                    L.IDProvincia_Localidad AS IDProvincia,
                    M.Correo AS Correo,
                    M.Telefono AS Telefono,
                    M.Estado AS Estado
                FROM Medicos AS M
                INNER JOIN Localidades AS L
                    ON M.IDLocalidad_Medico = L.IDLocalidad
                WHERE M.IDMedico = @IDMedico";

            SqlParameter[] parametros =
            {
                new SqlParameter("@IDMedico", idMedico)
            };

            return datos.ObtenerDatos(consulta, parametros);
        }


    //===============================//
    //            AGREGAR            // 
    //===============================//

        public int agregarMedico(Entidades.Medicos medico)
        {
            consulta = @"BEGIN TRANSACTION
                        
                        BEGIN TRY
                        
                            INSERT INTO Medicos
                            (
                                Legajo,
                                DNI,
                                Apellido,
                                Nombre,
                                Sexo,
                                IDNacionalidad_Medico,
                                FechaNacimiento,
                                Direccion,
                                IDLocalidad_Medico,
                                IDEspecialidad_Medico,
                                Correo,
                                Telefono
                            )
                            VALUES
                            (
                                @Legajo,
                                @DNI,
                                @Apellido,
                                @Nombre,
                                @Sexo,
                                @IDNacionalidad,
                                @FechaNacimiento,
                                @Direccion,
                                @IDLocalidad,
                                @IDEspecialidad,
                                @Correo,
                                @Telefono
                            );
                            
                            DECLARE @IDMedicoGenerado INT;
                            SET @IDMedicoGenerado = SCOPE_IDENTITY();

                            INSERT INTO Usuarios
                            (
                                NombreCompleto,
                                Usuario,
                                Contrasenia,
                                Rol,
                                Estado,
                                IDMedico_Usuario
                            )
                            VALUES
                            (
                                @NombreCompleto,
                                @Usuario,
                                @Contrasenia,
                                'Medico',
                                1,
                                @IDMedicoGenerado
                            );

                            COMMIT TRANSACTION;

                        END TRY

                        BEGIN CATCH

                            ROLLBACK TRANSACTION;
                            THROW;

                        END CATCH";

            SqlParameter[] parametros =
            {
                new SqlParameter("@Legajo", medico.Legajo),
                new SqlParameter("@DNI", medico.DNI),
                new SqlParameter("@Apellido", medico.Apellido),
                new SqlParameter("@Nombre", medico.Nombre),
                new SqlParameter("@Sexo", medico.Sexo),
                new SqlParameter("@IDNacionalidad", medico.IDNacionalidad),
                new SqlParameter("@FechaNacimiento", medico.FechaNacimiento),
                new SqlParameter("@Direccion", medico.Direccion),
                new SqlParameter("@IDLocalidad", medico.IDLocalidad),
                new SqlParameter("@IDEspecialidad", medico.IDEspecialidad),
                new SqlParameter("@Correo", medico.Correo),
                new SqlParameter("@Telefono", medico.Telefono),

                new SqlParameter("@NombreCompleto", medico.Apellido + " " + medico.Nombre),
                new SqlParameter("@Usuario", medico.Legajo),
                new SqlParameter("@Contrasenia", medico.DNI)
            };

            return datos.EjecutarConsulta(consulta, parametros);
        }


    //===============================//
    //           MODIFICAR           // 
    //===============================//

        public int modificarMedico(Medicos medico)
        {
            consulta = @"UPDATE Medicos
                            SET Legajo = @Legajo,
                            DNI = @DNI,
                            Apellido = @Apellido,
                            Nombre = @Nombre,
                            Sexo = @Sexo,
                            IDNacionalidad_Medico = @IDNacionalidad,
                            FechaNacimiento = @FechaNacimiento,
                            Direccion = @Direccion,
                            IDLocalidad_Medico = @IDLocalidad,
                            IDEspecialidad_Medico = @IDEspecialidad,
                            Correo = @Correo,
                            Telefono = @Telefono
                        WHERE IDMedico = @IDMedico";

            SqlParameter[] parametros =
            {
                new SqlParameter("@Legajo", medico.Legajo),
                new SqlParameter("@DNI", medico.DNI),
                new SqlParameter("@Apellido", medico.Apellido),
                new SqlParameter("@Nombre", medico.Nombre),
                new SqlParameter("@Sexo", medico.Sexo),
                new SqlParameter("@IDNacionalidad", medico.IDNacionalidad),
                new SqlParameter("@FechaNacimiento", medico.FechaNacimiento),
                new SqlParameter("@Direccion", medico.Direccion),
                new SqlParameter("@IDLocalidad", medico.IDLocalidad),
                new SqlParameter("@IDEspecialidad", medico.IDEspecialidad),
                new SqlParameter("@Correo", medico.Correo),
                new SqlParameter("@Telefono", medico.Telefono),
                new SqlParameter("@IDMedico", medico.IDMedico)
            };

            return datos.EjecutarConsulta(consulta, parametros);
        }


    //===============================// 
    //      ACTIVAR / DESACTIVAR     // 
    //===============================//

        public int cambiarEstadoMedico(int idMedico, bool estado)
        {
            consulta = @"BEGIN TRANSACTION;
                        
                        BEGIN TRY
                            UPDATE Medicos
                            SET Estado = @Estado
                            WHERE IDMedico = @IDMedico;
    
                            UPDATE Usuarios
                            SET Estado = @Estado
                            WHERE IDMedico_Usuario = @IDMedico
                            AND Rol = 'Medico';

                            COMMIT TRANSACTION;
                        END TRY

                        BEGIN CATCH

                            ROLLBACK TRANSACTION;
                            THROW;

                        END CATCH";

            SqlParameter[] parametros =
            {
                new SqlParameter("@Estado", estado),
                new SqlParameter("@IDMedico", idMedico)
            };

            return datos.EjecutarConsulta(consulta, parametros);
        }

        
    //===============================// 
    //     INICIO ADMIN DASHBOARD    // 
    //===============================//

        public int getCantidadMedicosActivos()
        {
            consulta = @"SELECT COUNT(*)
                        FROM Medicos
                        WHERE Estado = 1";

            DataTable tabla = datos.ObtenerDatos(consulta);

            return Convert.ToInt32(tabla.Rows[0][0]);
        }


    //===============================// 
    //       DATOS PARA COMBOS       // 
    //===============================//

        public DataTable getMedicosActivosPorEspecialidad(int idEspecialidad)
        {
            consulta = @"SELECT
                            IDMedico,
                            Nombre + ' ' + Apellido + ' - ' + Legajo AS Medico
                        FROM Medicos
                        WHERE Estado = 1 
                        AND IDEspecialidad_Medico = @IDEspecialidad
                        ORDER BY Legajo ASC";

            SqlParameter[] parametros =
            {
                new SqlParameter("@IDEspecialidad", idEspecialidad)
            };

            return datos.ObtenerDatos(consulta, parametros);
        }


        //===============================// 
        //       VALIDAR REPETIDOS       // 
        //===============================//

        public bool existeLegajo(string legajo, int idMedico)
        {
            return existeDato("Legajo", legajo, idMedico);
        }

        public bool existeDNI(string dni, int idMedico)
        {
            return existeDato("DNI", dni, idMedico);
        }

        public bool existeCorreo(string correo, int idMedico)
        {
            return existeDato("Correo", correo, idMedico);
        }

        public bool existeTelefono(string telefono, int idMedico)
        {
            return existeDato("Telefono", telefono, idMedico);
        }


    //===============================// 
    //       METODOS AUXILIARES      // 
    //===============================//

        private bool existeDato(string columna, string valor, int idMedico)
        {
            consulta = @"SELECT COUNT(*)
                        FROM Medicos
                        WHERE " + columna + @" = @Valor
                        AND IDMedico <> @IDMedico";

            SqlParameter[] parametros =
            {
                new SqlParameter("@Valor", valor),
                new SqlParameter("@IDMedico", idMedico)
            };

            int cantidad = Convert.ToInt32(datos.EjecutarEscalar(consulta, parametros));

            return cantidad > 0;
        }


        private string ObtenerFiltroBusqueda(string campo)
        {
            switch (campo)
            {
                case "ID":
                    return "M.IDMedico";

                case "DNI":
                    return "M.DNI";

                case "Legajo":
                    return "M.Legajo";

                case "Nombre":
                    return "M.Nombre";

                case "Apellido":
                    return "M.Apellido";

                case "Especialidad":
                    return "E.NombreEspecialidad";

                default:
                    return "M.IDMedico";
            }
        }
    }
}
