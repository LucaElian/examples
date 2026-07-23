using System;
using System.Data;
using System.Data.SqlClient;
using Entidades;

namespace Datos
{
    public class DaoHorario
    {
        private readonly AccesoDatos datos;
        private string consulta;

        public DaoHorario()
        {
            datos = new AccesoDatos();
        }


    //===============================// 
    //       LISTAR POR MEDICO       // 
    //===============================//

        public DataTable getHorariosPorMedico(int idMedico)
        {
            consulta = @"SELECT
                            IDHorario,
                            IDMedico_Horario AS IDMedico,
                            Dia,
                            HoraInicio,
                            HoraFin,
                            CONVERT(VARCHAR(5), HoraInicio, 108) AS HoraInicioTexto,
                            CONVERT(VARCHAR(5), HoraFin, 108) AS HoraFinTexto,
                            Estado,
                            CASE WHEN Estado = 1 THEN 'Activo' ELSE 'Inactivo' END AS EstadoTexto,
                            CASE WHEN Estado = 1 THEN 'badge-status active' ELSE 'badge-status inactive' END AS EstadoCSS
                        FROM Horarios
                        WHERE IDMedico_Horario = @IDMedico
                        ORDER BY
                            CASE Dia
                                WHEN 'Lunes' THEN 1
                                WHEN 'Martes' THEN 2 
                                WHEN 'Miercoles' THEN 3 
                                WHEN 'Jueves' THEN 4 
                                WHEN 'Viernes' THEN 5
                                WHEN 'Sabado' THEN 6 
                                WHEN 'Domingo' THEN 7
                            END,
                            HoraInicio ASC";

            SqlParameter[] parametros =
            {
                new SqlParameter("@IDMedico", idMedico)
            };

            return datos.ObtenerDatos(consulta, parametros);
        }


    //===============================// 
    //            AGREGAR            // 
    //===============================//

        public int agregarHorario(Horarios horario)
        {
            consulta = @"INSERT INTO Horarios
                        (
                            IDMedico_Horario,
                            Dia,
                            HoraInicio,
                            HoraFin
                        )
                        VALUES
                        (
                            @IDMedico,
                            @Dia,
                            @HoraInicio,
                            @HoraFin
                        )";

            SqlParameter[] parametros =
            {
                new SqlParameter("@IDMedico", horario.IDMedico),
                new SqlParameter("@Dia", horario.Dia),
                new SqlParameter("@HoraInicio", SqlDbType.Time) { Value = horario.HoraInicio },
                new SqlParameter("@HoraFin", SqlDbType.Time) { Value = horario.HoraFin }
            };

            return datos.EjecutarConsulta(consulta, parametros);
        }


    //===============================// 
    //          VALIDADORES          // 
    //===============================//

        public bool existeHorario(Horarios horario)
        {
            consulta = @"SELECT COUNT(*)
                        FROM Horarios
                        WHERE IDMedico_Horario = @IDMedico
                        AND Dia = @Dia
                        AND Estado = 1
                        AND @HoraInicio < HoraFin
                        AND @HoraFin > HoraInicio";

            SqlParameter[] parametros =
            {
                new SqlParameter("@IDMedico", horario.IDMedico),
                new SqlParameter("@Dia", horario.Dia),
                new SqlParameter("@HoraInicio", SqlDbType.Time) { Value = horario.HoraInicio },
                new SqlParameter("@HoraFin", SqlDbType.Time) { Value = horario.HoraFin }
            };

            int cantidad = Convert.ToInt32(datos.EjecutarEscalar(consulta, parametros));

            return cantidad > 0;
        }

        public bool existeHorarioActivoAlActivar(int idHorario)
        {
            consulta = @"SELECT COUNT(*)
                        FROM Horarios AS H
                        INNER JOIN Horarios AS H2
                            ON H.IDMedico_Horario = H2.IDMedico_Horario
                            AND H.Dia = H2.Dia
                            AND H.IDHorario <> H2.IDHorario
                        WHERE H.IDHorario = @IDHorario
                        AND H2.Estado = 1
                        AND H.HoraInicio < H2.HoraFin
                        AND H.HoraFin > H2.HoraInicio";

            SqlParameter[] parametros =
            {
                new SqlParameter("@IDHorario", idHorario)
            };

            int cantidad = Convert.ToInt32(datos.EjecutarEscalar(consulta, parametros));

            return cantidad > 0;
        }


    //===============================// 
    //      ACTIVAR / DESACTIVAR     // 
    //===============================//

        public int cambiarEstadoHorario(int idHorario, bool estado)
        {
            consulta = @"UPDATE Horarios
                        SET Estado = @Estado
                        WHERE IDHorario = @IDHorario";

            SqlParameter[] parametros =
            {
                new SqlParameter("@Estado", estado),
                new SqlParameter("@IDHorario", idHorario)
            };

            return datos.EjecutarConsulta(consulta, parametros);
        }


    //===============================// 
    //        ELIMINAR HORARIO       // 
    //===============================//

        public int eliminarHorario(int idHorario)
        {
            consulta = @"UPDATE Horarios
                        SET Estado = 0
                        WHERE IDHorario = @IDHorario";

            SqlParameter[] parametros =
            {
                new SqlParameter("@IDHorario", idHorario)
            };

            return datos.EjecutarConsulta(consulta, parametros);
        }
    }
}
