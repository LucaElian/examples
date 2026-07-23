using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Entidades;

namespace Datos
{
    public class DaoTurno
    {
        private readonly AccesoDatos datos;
        private string consulta;

        public DaoTurno()
        {
            datos = new AccesoDatos();
        }


    //===============================//
    //            LISTADO            // 
    //===============================//

        public DataTable getTablaTurnos(string campo, string busqueda)
        {
            consulta = @"SELECT
                            T.IDTurno AS ID,
                            P.Nombre + ' ' + P.Apellido + ' - ' + P.DNI AS Paciente,
                            M.Nombre + ' ' + M.Apellido + ' - ' + M.Legajo AS Medico,
                            CONVERT(VARCHAR(10), T.Fecha, 103) AS FechaTexto,
                            CONVERT(VARCHAR(5), T.Hora, 108) AS HoraTexto,
                            T.EstadoAsistencia AS Asistencia,
                            T.Estado AS Estado,
                            CASE WHEN T.Estado = 1 THEN 'Activo' ELSE 'Inactivo' END AS EstadoTexto,
                            CASE WHEN T.Estado = 1 THEN 'badge-status active' ELSE 'badge-status inactive' END AS EstadoCSS
                        FROM Turnos AS T
                        INNER JOIN Pacientes AS P
                            ON T.IDPaciente_Turno = P.IDPaciente
                        INNER JOIN Medicos AS M
                            ON T.IDMedico_Turno = M.IDMedico
                        WHERE 1 = 1";

            List<SqlParameter> parametros = new List<SqlParameter>();

            if (!string.IsNullOrWhiteSpace(busqueda))
            {
                string columna = ObtenerFiltroBusqueda(campo);

                consulta += " AND " + columna + " LIKE @Busqueda";
                parametros.Add(new SqlParameter("@Busqueda", "%" + busqueda + "%"));
            }

            consulta += " ORDER BY T.IDTurno ASC";

            return datos.ObtenerDatos(consulta, parametros.ToArray());
        }


    //===============================//
    //         OBTENER POR ID        // 
    //===============================//

        public DataTable getTurnoPorID(int idTurno)
        {
            consulta = @"SELECT
                            T.IDTurno AS ID,
                            T.IDPaciente_Turno AS IDPaciente,
                            T.IDMedico_Turno AS IDMedico,
                            M.IDEspecialidad_Medico AS IDEspecialidad,
                            T.Fecha AS Fecha,
                            T.Hora AS Hora,
                            T.EstadoAsistencia AS EstadoAsistencia,
                            T.Observacion AS Observacion
                        FROM Turnos AS T
                        INNER JOIN Medicos AS M
                            ON T.IDMedico_Turno = M.IDMedico
                        WHERE T.IDTurno = @IDTurno";

            SqlParameter[] parametros =
            {
                new SqlParameter("@IDTurno", idTurno)
            };

            return datos.ObtenerDatos(consulta, parametros);
        }


        //===============================//
        //            AGREGAR            // 
        //===============================//

            public int agregarTurno(Turnos turno)
            {
                consulta = @"INSERT INTO Turnos
                            (   
                                IDPaciente_Turno,
                                IDMedico_Turno,
                                IDUsuarioCreador_Turno,
                                Fecha,
                                Hora,
                                EstadoAsistencia,
                                Observacion,
                                Estado
                            )
                            VALUES
                            (
                                @IDPaciente,
                                @IDMedico,
                                @IDUsuarioCreador,
                                @Fecha,
                                @Hora,
                                @EstadoAsistencia,
                                @Observacion,
                                @Estado
                            )";

                SqlParameter[] parametros =
                {
                    new SqlParameter("@IDPaciente", turno.IDPaciente),
                    new SqlParameter("@IDMedico", turno.IDMedico),
                    new SqlParameter("@IDUsuarioCreador", turno.IDUsuarioCreador),
                    new SqlParameter("@Fecha", turno.Fecha),
                    new SqlParameter("@Hora", SqlDbType.Time) { Value = turno.Hora },
                    new SqlParameter("@EstadoAsistencia", turno.EstadoAsistencia),
                    new SqlParameter("@Observacion", string.IsNullOrWhiteSpace(turno.Observacion) ? (object)DBNull.Value : turno.Observacion),
                    new SqlParameter("@Estado", turno.Estado)
                };

                return datos.EjecutarConsulta(consulta, parametros);
            }


    //===============================//
    //           MODIFICAR           // 
    //===============================//

        public int modificarTurno(Turnos turno)
        {
            consulta = @"UPDATE Turnos
                            SET IDPaciente_Turno = @IDPaciente,
                                IDMedico_Turno = @IDMedico,
                                Fecha = @Fecha,
                                Hora = @Hora,
                                EstadoAsistencia = @EstadoAsistencia,
                                Observacion = @Observacion
                        WHERE IDTurno = @IDTurno";

            SqlParameter[] parametros =
            {
                new SqlParameter("@IDPaciente", turno.IDPaciente),
                new SqlParameter("@IDMedico", turno.IDMedico),
                new SqlParameter("@Fecha", turno.Fecha),
                new SqlParameter("@Hora", SqlDbType.Time) { Value = turno.Hora },
                new SqlParameter("@EstadoAsistencia", turno.EstadoAsistencia),
                new SqlParameter("@Observacion", string.IsNullOrWhiteSpace(turno.Observacion) ? (object)DBNull.Value : turno.Observacion),
                new SqlParameter("@IDTurno", turno.IDTurno)
            };

            return datos.EjecutarConsulta(consulta, parametros);
        }


    //===============================// 
    //      ACTIVAR / DESACTIVAR     // 
    //===============================//

        public int cambiarEstadoTurno(int idTurno, bool estado)
        {
            consulta = @"UPDATE Turnos
                            SET Estado = @Estado
                        WHERE IDTurno = @IDTurno";

            SqlParameter[] parametros =
            {
                new SqlParameter("@Estado", estado),
                new SqlParameter("@IDTurno", idTurno)
            };

            return datos.EjecutarConsulta(consulta, parametros);
        }


        //===============================// 
        //    HISTORIAL MEDICO TURNOS    // 
        //===============================//

        public DataTable getHistorialMedico(int idMedico, string campo, string busqueda, string asistencia)
        {
            consulta = @"SELECT
                            T.IDTurno AS ID,
                            CONVERT(VARCHAR(10), T.Fecha, 103) AS FechaTexto,
                            CONVERT(VARCHAR(5), T.Hora, 108) AS HoraTexto,
                            P.Nombre + ' ' + P.Apellido AS Paciente,
                            P.DNI AS DNI,
                            T.EstadoAsistencia AS AsistenciaTexto,
                            CASE 
                                WHEN T.EstadoAsistencia = 'Presente' THEN 'badge-status active'
                                WHEN T.EstadoAsistencia = 'Ausente' THEN 'badge-status inactive'
                                ELSE 'badge-status'
                            END AS AsistenciaCSS,
                            ISNULL(T.Observacion, '') AS Observacion
                        FROM Turnos AS T
                        INNER JOIN Pacientes AS P
                            ON T.IDPaciente_Turno = P.IDPaciente
                        WHERE T.IDMedico_Turno = @IDMedico
                        AND T.Estado = 1
                        AND T.EstadoAsistencia IN ('Presente', 'Ausente')";

            List<SqlParameter> parametros = new List<SqlParameter>();

            parametros.Add(new SqlParameter("@IDMedico", idMedico));

            if (!string.IsNullOrWhiteSpace(busqueda))
            {
                string columna = ObtenerFiltroHistorial(campo);

                consulta += " AND " + columna + " LIKE @Busqueda";
                parametros.Add(new SqlParameter("@Busqueda", "%" + busqueda + "%"));
            }

            if (!string.IsNullOrWhiteSpace(asistencia))
            {
                consulta += " AND T.EstadoAsistencia = @Asistencia";
                parametros.Add(new SqlParameter("@Asistencia", asistencia));
            }

            consulta += " ORDER BY T.Fecha DESC, T.Hora DESC";

            return datos.ObtenerDatos(consulta, parametros.ToArray());
        }


    //===============================// 
    //   ESTADISTICAS MEDICO TURNOS  // 
    //===============================//

        public DataTable getEstadisticasPacientesMedico(int idMedico, string campo, string busqueda)
        {
            consulta = @"SELECT
                            P.Nombre + ' ' + P.Apellido AS Paciente,
                            P.DNI AS DNI,

                            SUM(CASE WHEN T.EstadoAsistencia = 'Presente' THEN 1 ELSE 0 END) AS Presentes,
                            SUM(CASE WHEN T.EstadoAsistencia = 'Ausente' THEN 1 ELSE 0 END) AS Ausentes,
                            COUNT(*) AS Total,

                            CAST(
                                (SUM(CASE WHEN T.EstadoAsistencia = 'Presente' THEN 1 ELSE 0 END) * 100.0) / COUNT(*)
                                AS DECIMAL(5,2)
                            ) AS Presentismo,

                            CAST(
                                CAST(
                                    (SUM(CASE WHEN T.EstadoAsistencia = 'Presente' THEN 1 ELSE 0 END) * 100.0) / COUNT(*)
                                    AS DECIMAL(5,2)
                                ) AS VARCHAR
                            ) + '%' AS PresentismoTexto,

                            CONVERT(VARCHAR(10), MAX(T.Fecha), 103) AS UltimoTurnoTexto

                            FROM Turnos AS T
                            INNER JOIN Pacientes AS P
                                ON T.IDPaciente_Turno = P.IDPaciente

                            WHERE T.IDMedico_Turno = @IDMedico
                            AND T.Estado = 1
                            AND T.EstadoAsistencia IN ('Presente', 'Ausente')";

            List<SqlParameter> parametros = new List<SqlParameter>();

            parametros.Add(new SqlParameter("@IDMedico", idMedico));

            if (!string.IsNullOrWhiteSpace(busqueda))
            {
                string columna = ObtenerFiltroEstadisticas(campo);

                consulta += " AND " + columna + " LIKE @Busqueda";
                parametros.Add(new SqlParameter("@Busqueda", "%" + busqueda + "%"));
            }

            consulta += @" GROUP BY
                    P.IDPaciente,
                    P.Nombre,
                    P.Apellido,
                    P.DNI";

            consulta += " ORDER BY P.Apellido ASC, P.Nombre ASC, P.DNI ASC";

            return datos.ObtenerDatos(consulta, parametros.ToArray());
        }


    //===============================// 
    //    TURNOS PENDIENTES MEDICO   // 
    //===============================//

        public DataTable getTurnosPendientesMedico(int idMedico, string campo, string busqueda)
        {
            consulta = @"SELECT
                    ROW_NUMBER() OVER (ORDER BY T.Hora ASC) AS NumeroTurno,
                    T.IDTurno AS IdTurno,
                    CONVERT(VARCHAR(10), T.Fecha, 103) AS FechaTexto,
                    P.Nombre + ' ' + P.Apellido AS NombrePaciente,
                    P.DNI AS DniPaciente,
                    CONVERT(VARCHAR(5), T.Hora, 108) AS HoraInicio,
                    CONVERT(VARCHAR(5), DATEADD(HOUR, 1, T.Hora), 108) AS HoraFin,
                    U.NombreCompleto AS CreadorTurno
                FROM Turnos AS T
                INNER JOIN Pacientes AS P
                    ON T.IDPaciente_Turno = P.IDPaciente
                INNER JOIN Medicos AS M
                    ON T.IDMedico_Turno = M.IDMedico
                INNER JOIN Usuarios AS U
                    ON T.IDUsuarioCreador_Turno = U.IDUsuario
                WHERE T.IDMedico_Turno = @IDMedico
                AND T.Estado = 1
                AND T.EstadoAsistencia = 'Pendiente'
                AND T.Fecha <= CAST(GETDATE() AS DATE)";

            List<SqlParameter> parametros = new List<SqlParameter>();

            parametros.Add(new SqlParameter("@IDMedico", idMedico));

            if (!string.IsNullOrWhiteSpace(busqueda))
            {
                string columna = ObtenerFiltroTurnosPendientesMedico(campo);

                consulta += " AND " + columna + " LIKE @Busqueda";
                parametros.Add(new SqlParameter("@Busqueda", "%" + busqueda + "%"));
            }

            consulta += " ORDER BY T.Fecha ASC, T.Hora ASC";

            return datos.ObtenerDatos(consulta, parametros.ToArray());
        }


    //===============================// 
    //    OBTENER TURNO A REVISAR    // 
    //===============================//

        public DataTable getTurnoPendienteRevision(int idTurno, int idMedico)
        {
            consulta = @"SELECT
                            T.IDTurno AS IdTurno,
                            P.Nombre + ' ' + P.Apellido AS NombrePaciente,
                            P.DNI AS DniPaciente,
                            CONVERT(VARCHAR(10), T.Fecha, 103) AS FechaTexto,
                            CONVERT(VARCHAR(5), T.Hora, 108) AS HoraInicio,
                            CONVERT(VARCHAR(5), DATEADD(HOUR, 1, T.Hora), 108) AS HoraFin
                        FROM Turnos AS T
                        INNER JOIN Pacientes AS P
                            ON T.IDPaciente_Turno = P.IDPaciente
                        WHERE T.IDTurno = @IDTurno
                        AND T.IDMedico_Turno = @IDMedico
                        AND T.Estado = 1
                        AND T.EstadoAsistencia = 'Pendiente'
                        AND T.Fecha <= CAST(GETDATE() AS DATE)";

            SqlParameter[] parametros =
            {
                new SqlParameter("@IDTurno", idTurno),
                new SqlParameter("@IDMedico", idMedico)
            };

            return datos.ObtenerDatos(consulta, parametros);
        }


    //===============================// 
    //     REVISION TURNO MEDICO     // 
    //===============================//

        public int revisarTurnoMedico(int idTurno, string asistencia, string observacion)
        {
            consulta = @"UPDATE Turnos
                            SET EstadoAsistencia = @EstadoAsistencia,
                                Observacion = @Observacion
                        WHERE IDTurno = @IDTurno
                        AND Estado = 1
                        AND EstadoAsistencia = 'Pendiente'
                        AND Fecha <= CAST(GETDATE() AS DATE)";

            SqlParameter[] parametros =
            {
                new SqlParameter("@EstadoAsistencia", asistencia),
                new SqlParameter("@Observacion", string.IsNullOrWhiteSpace(observacion) ? (object)DBNull.Value : observacion),
                new SqlParameter("@IDTurno", idTurno)
            };

            return datos.EjecutarConsulta(consulta, parametros);
        }


        //===============================// 
        //     INICIO ADMIN DASHBOARD    // 
        //===============================//

        public DataTable getTurnosPorEspecialidadMesActual()
        {
            consulta = @"SELECT
                            E.NombreEspecialidad AS Especialidad,
                            COUNT(T.IDTurno) AS Cantidad,
                            CAST(COUNT(T.IDTurno) AS VARCHAR) + ' turnos' AS CantidadTexto,

                            CASE 
                                WHEN TotalTurnos.Total = 0 THEN 0
                                ELSE CAST((COUNT(T.IDTurno) * 100.0) / TotalTurnos.Total AS DECIMAL(5,2))
                            END AS Porcentaje,

                            CAST(
                                CASE 
                                    WHEN TotalTurnos.Total = 0 THEN 0
                                    ELSE CAST((COUNT(T.IDTurno) * 100.0) / TotalTurnos.Total AS DECIMAL(5,2))
                                END AS VARCHAR
                            ) + '%' AS PorcentajeTexto

                        FROM Especialidades AS E
                        LEFT JOIN Medicos AS M
                            ON E.IDEspecialidad = M.IDEspecialidad_Medico
                        LEFT JOIN Turnos AS T
                            ON M.IDMedico = T.IDMedico_Turno
                            AND T.Estado = 1
                            AND MONTH(T.Fecha) = MONTH(GETDATE())
                            AND YEAR(T.Fecha) = YEAR(GETDATE())
                        CROSS JOIN
                        (
                            SELECT COUNT(*) AS Total
                            FROM Turnos
                            WHERE Estado = 1
                            AND MONTH(Fecha) = MONTH(GETDATE())
                            AND YEAR(Fecha) = YEAR(GETDATE())
                        ) AS TotalTurnos

                        GROUP BY 
                            E.NombreEspecialidad,
                            TotalTurnos.Total

                        ORDER BY COUNT(T.IDTurno) DESC, E.NombreEspecialidad ASC";

            return datos.ObtenerDatos(consulta);
        }

        public int getCantidadTurnosPendientes()
        {
            consulta = @"SELECT COUNT(*)
                            FROM Turnos
                            WHERE Estado = 1
                            AND EstadoAsistencia = 'Pendiente'
                            AND Fecha <= CAST(GETDATE() AS DATE)";

            DataTable tabla = datos.ObtenerDatos(consulta);

            return Convert.ToInt32(tabla.Rows[0][0]);
        }

        public int getCantidadTurnosHoy()
        {
            consulta = @"SELECT COUNT(*)
                            FROM Turnos
                            WHERE Estado = 1
                            AND Fecha = CAST(GETDATE() AS DATE)";

            DataTable tabla = datos.ObtenerDatos(consulta);

            return Convert.ToInt32(tabla.Rows[0][0]);
        }

        public DataTable getResumenAsistenciaMesActual()
        {
            consulta = @"SELECT
                            ISNULL(SUM(CASE WHEN EstadoAsistencia = 'Presente' THEN 1 ELSE 0 END), 0) AS Presentes,
                            ISNULL(SUM(CASE WHEN EstadoAsistencia = 'Ausente' THEN 1 ELSE 0 END), 0) AS Ausentes,
                            ISNULL(SUM(CASE WHEN EstadoAsistencia = 'Pendiente' THEN 1 ELSE 0 END), 0) AS Pendientes
                        FROM Turnos
                        WHERE Estado = 1
                        AND MONTH(Fecha) = MONTH(GETDATE())
                        AND YEAR(Fecha) = YEAR(GETDATE())";

            return datos.ObtenerDatos(consulta);
        }



    //===============================// 
    //       DATOS PARA COMBOS       // 
    //===============================//

        public DataTable getHorariosDisponibles(int idMedico, DateTime fecha, int idTurnoActual)
        {
            DataTable tablaHorariosDisponibles = new DataTable();

            tablaHorariosDisponibles.Columns.Add("Hora", typeof(string));
            tablaHorariosDisponibles.Columns.Add("HoraTexto", typeof(string));

            string dia = ObtenerDia(fecha);

            consulta = @"SELECT
                            HoraInicio,
                            HoraFin
                        FROM Horarios
                        WHERE IDMedico_Horario = @IDMedico
                        AND Dia = @Dia
                        AND Estado = 1";

            SqlParameter[] parametrosHorarios =
            {
                new SqlParameter("@IDMedico", idMedico),
                new SqlParameter("@Dia", dia)
            };


            DataTable tablaHorariosMedicos = datos.ObtenerDatos(consulta, parametrosHorarios);

            consulta = @"SELECT
                            Hora
                        FROM Turnos
                        WHERE IDMedico_Turno = @IDMedico
                        AND Fecha = @Fecha
                        AND Estado = 1
                        AND IDTurno <> @IDTurnoActual";

            SqlParameter[] parametrosTurnos =
            {
                new SqlParameter("@IDMedico", idMedico),
                new SqlParameter("@Fecha", SqlDbType.Date) { Value = fecha.Date },
                new SqlParameter("@IDTurnoActual", idTurnoActual)
            };

            DataTable tablaTurnosOcupados = datos.ObtenerDatos(consulta, parametrosTurnos);

            TimeSpan duracionTurno = new TimeSpan(1, 0, 0);
            TimeSpan intervalo = new TimeSpan(0, 15, 0);

            foreach (DataRow filaHorario in tablaHorariosMedicos.Rows)
            {
                TimeSpan horaInicioAtencion = (TimeSpan)filaHorario["HoraInicio"];
                TimeSpan horaFinAtencion = (TimeSpan)filaHorario["HoraFin"];

                TimeSpan horaPosible = horaInicioAtencion;

                while (horaPosible.Add(duracionTurno) <= horaFinAtencion)
                {
                    bool disponible = true;

                    foreach (DataRow filaTurno in tablaTurnosOcupados.Rows)
                    {
                        TimeSpan horaTurnoExistente = (TimeSpan)filaTurno["Hora"];
                        TimeSpan finTurnoExistente = horaTurnoExistente.Add(duracionTurno);
                        TimeSpan finHoraPosible = horaPosible.Add(duracionTurno);

                        if (horaPosible < finTurnoExistente && finHoraPosible > horaTurnoExistente)
                        {
                            disponible = false;
                            break;
                        }
                    }

                    if (disponible)
                    {
                        DataRow filaNueva = tablaHorariosDisponibles.NewRow();

                        filaNueva["Hora"] = horaPosible.ToString(@"hh\:mm");
                        filaNueva["HoraTexto"] = horaPosible.ToString(@"hh\:mm");

                        tablaHorariosDisponibles.Rows.Add(filaNueva);
                    }

                    horaPosible = horaPosible.Add(intervalo);
                }
            }

            return tablaHorariosDisponibles;
        }


        //===============================// 
        //            INFORMES           // 
        //===============================//

        public string getDiaMayorDemandaJunio()
        {
            consulta = @"WITH ConteoDias AS
                (
                    SELECT
                        CASE (DATEDIFF(DAY, '19000101', Fecha) % 7)
                            WHEN 0 THEN 'Lunes'
                            WHEN 1 THEN 'Martes'
                            WHEN 2 THEN 'Miércoles'
                            WHEN 3 THEN 'Jueves'
                            WHEN 4 THEN 'Viernes'
                            WHEN 5 THEN 'Sábado'
                            WHEN 6 THEN 'Domingo'
                        END AS DiaSemana,

                        CASE (DATEDIFF(DAY, '19000101', Fecha) % 7)
                            WHEN 0 THEN 1
                            WHEN 1 THEN 2
                            WHEN 2 THEN 3
                            WHEN 3 THEN 4
                            WHEN 4 THEN 5
                            WHEN 5 THEN 6
                            WHEN 6 THEN 7
                        END AS OrdenDia,

                        COUNT(IDTurno) AS Cantidad
                    FROM Turnos
                    WHERE Estado = 1
                    AND MONTH(Fecha) = 7
                    AND YEAR(Fecha) = YEAR(GETDATE())
                    GROUP BY
                        CASE (DATEDIFF(DAY, '19000101', Fecha) % 7)
                            WHEN 0 THEN 'Lunes'
                            WHEN 1 THEN 'Martes'
                            WHEN 2 THEN 'Miércoles'
                            WHEN 3 THEN 'Jueves'
                            WHEN 4 THEN 'Viernes'
                            WHEN 5 THEN 'Sábado'
                            WHEN 6 THEN 'Domingo'
                        END,
                        CASE (DATEDIFF(DAY, '19000101', Fecha) % 7)
                            WHEN 0 THEN 1
                            WHEN 1 THEN 2
                            WHEN 2 THEN 3
                            WHEN 3 THEN 4
                            WHEN 4 THEN 5
                            WHEN 5 THEN 6
                            WHEN 6 THEN 7
                        END
                ),
                Maximo AS
                (
                    SELECT MAX(Cantidad) AS MayorCantidad
                    FROM ConteoDias
                )
                SELECT
                    C.DiaSemana,
                    C.Cantidad
                FROM ConteoDias AS C
                INNER JOIN Maximo AS M
                    ON C.Cantidad = M.MayorCantidad
                ORDER BY C.OrdenDia ASC";

            DataTable tabla = datos.ObtenerDatos(consulta);

            if (tabla.Rows.Count == 0)
                return "Sin turnos registrados";

            List<string> dias = new List<string>();

            foreach (DataRow fila in tabla.Rows)
            {
                dias.Add(fila["DiaSemana"].ToString());
            }

            int cantidad = Convert.ToInt32(tabla.Rows[0]["Cantidad"]);

            return string.Join(", ", dias) + " - " + cantidad + " turnos";
        }

        public string getMedicoMayorTurnosJunio()
        {
            consulta = @"WITH ConteoMedicos AS
                (
                    SELECT
                        M.Nombre + ' ' + M.Apellido AS Medico,
                        COUNT(T.IDTurno) AS Cantidad
                    FROM Turnos AS T
                    INNER JOIN Medicos AS M
                        ON T.IDMedico_Turno = M.IDMedico
                    WHERE T.Estado = 1
                    AND MONTH(T.Fecha) = 7
                    AND YEAR(T.Fecha) = YEAR(GETDATE())
                    GROUP BY
                        M.IDMedico,
                        M.Nombre,
                        M.Apellido
                ),
                Maximo AS
                (
                    SELECT MAX(Cantidad) AS MayorCantidad
                    FROM ConteoMedicos
                )
                SELECT
                    C.Medico,
                    C.Cantidad
                FROM ConteoMedicos AS C
                INNER JOIN Maximo AS M
                    ON C.Cantidad = M.MayorCantidad
                ORDER BY C.Medico ASC";

            DataTable tabla = datos.ObtenerDatos(consulta);

            if (tabla.Rows.Count == 0)
                return "Sin turnos registrados";

            List<string> medicos = new List<string>();

            foreach (DataRow fila in tabla.Rows)
            {
                medicos.Add(fila["Medico"].ToString());
            }

            int cantidad = Convert.ToInt32(tabla.Rows[0]["Cantidad"]);

            return string.Join(", ", medicos) + " - " + cantidad + " turnos";
        }


        //===============================// 
        //       METODOS AUXILIARES      // 
        //===============================//

        private string ObtenerFiltroBusqueda(string campo)
        {
            switch (campo)
            {
                case "ID":
                    return "CAST(T.IDTurno AS VARCHAR)";

                case "Paciente":
                    return "P.Nombre + ' ' + P.Apellido + ' ' + P.DNI";

                case "Medico":
                    return "M.Nombre + ' ' + M.Apellido + ' ' + M.Legajo";

                case "Asistencia":
                    return "T.EstadoAsistencia";

                case "Fecha":
                    return "CONVERT(VARCHAR(10), T.Fecha, 103)";

                default:
                    return "CAST(T.IDTurno AS VARCHAR)";
            }
        }

        private string ObtenerFiltroHistorial(string campo)
        {
            switch (campo)
            {
                case "ID":
                    return "CAST(T.IDTurno AS VARCHAR)";

                case "Paciente":
                    return "P.Nombre + ' ' + P.Apellido";

                case "DNI":
                    return "P.DNI";

                case "Fecha":
                    return "CONVERT(VARCHAR(10), T.Fecha, 103)";

                default:
                    return "CAST(T.IDTurno AS VARCHAR)";
            }
        }

        private string ObtenerFiltroEstadisticas(string campo)
        {
            switch (campo)
            {
                case "Paciente":
                    return "P.Nombre + ' ' + P.Apellido";

                case "DNI":
                    return "P.DNI";

                default:
                    return "P.Nombre + ' ' + P.Apellido";
            }
        }

        private string ObtenerFiltroTurnosPendientesMedico(string campo)
        {
            switch (campo)
            {
                case "Paciente":
                    return "P.Nombre + ' ' + P.Apellido";

                case "DNI":
                    return "P.DNI";

                case "Fecha":
                    return "CONVERT(VARCHAR(10), T.Fecha, 103)";

                case "Hora":
                    return "CONVERT(VARCHAR(5), T.Hora, 108)";

                default:
                    return "P.Nombre + ' ' + P.Apellido";
            }
        }

        private string ObtenerDia(DateTime fecha)
        {
            switch (fecha.DayOfWeek)
            {
                case DayOfWeek.Monday:
                    return "Lunes";

                case DayOfWeek.Tuesday:
                    return "Martes";

                case DayOfWeek.Wednesday:
                    return "Miercoles";

                case DayOfWeek.Thursday:
                    return "Jueves";

                case DayOfWeek.Friday:
                    return "Viernes";

                case DayOfWeek.Saturday:
                    return "Sabado";

                case DayOfWeek.Sunday:
                    return "Domingo";

                default:
                    return "";
            }
        }
    }
}
