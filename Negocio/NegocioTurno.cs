using Datos;
using Entidades;
using System;
using System.Data;

namespace Negocio
{
    public class NegocioTurno
    {
        private readonly DaoTurno dao;

        public NegocioTurno()
        {
            dao = new DaoTurno();
        }


    //===============================//
    //            LISTADO            // 
    //===============================//

        public DataTable getTablaTurnos(string campo, string busqueda)
        {
            return dao.getTablaTurnos(campo, busqueda);
        }


    //===============================//
    //         OBTENER POR ID        // 
    //===============================//

        public DataTable getTurnoPorID(int idTurno)
        {
            return dao.getTurnoPorID(idTurno);
        }


    //===============================//
    //            AGREGAR            // 
    //===============================//

        public bool AgregarTurno(Turnos turno)
        {
            int filasAfectadas = dao.agregarTurno(turno);

            return filasAfectadas > 0;
        }


    //===============================//
    //           MODIFICAR           // 
    //===============================//

        public bool ModificarTurno(Turnos turno)
        {
            int filasAfectadas = dao.modificarTurno(turno);

            return filasAfectadas > 0;
        }


    //===============================// 
    //      ACTIVAR / DESACTIVAR     // 
    //===============================//

        public bool cambiarEstadoTurno(int idTurno, bool estado)
        {
            int filasAfectadas = dao.cambiarEstadoTurno(idTurno, estado);

            return filasAfectadas > 0;
        }


    //===============================// 
    //    HISTORIAL MEDICO TURNOS    // 
    //===============================//

        public DataTable getHistorialMedico(int idMedico, string campo, string busqueda, string asistencia)
        {
            return dao.getHistorialMedico(idMedico, campo, busqueda, asistencia);
        }
        

    //===============================// 
    //   ESTADISTICAS MEDICO TURNOS  // 
    //===============================//

        public DataTable getEstadisticasPacientesMedico(int idMedico, string campo, string busqueda)
        {
            return dao.getEstadisticasPacientesMedico(idMedico, campo, busqueda);
        }


    //===============================// 
    //    TURNOS PENDIENTES MEDICO   // 
    //===============================//

        public DataTable getTurnosPendientesMedico(int idMedico, string campo, string busqueda)
        {
            return dao.getTurnosPendientesMedico(idMedico, campo, busqueda);
        }


    //===============================// 
    //       REVISION DE TURNO       // 
    //===============================//

        public DataTable getTurnoPendienteRevision(int idTurno, int idMedico)
        {
            return dao.getTurnoPendienteRevision(idTurno, idMedico);
        }

        public bool revisarTurnoMedico(int idTurno, string asistencia, string observacion)
        {
            int filasAfectadas = dao.revisarTurnoMedico(idTurno, asistencia, observacion);

            return filasAfectadas > 0;
        }


    //===============================// 
    //     INICIO ADMIN DASHBOARD    // 
    //===============================//

        public DataTable getTurnosPorEspecialidadMesActual()
        {
            return dao.getTurnosPorEspecialidadMesActual();
        }

        public int getCantidadTurnosPendientes()
        {
            return dao.getCantidadTurnosPendientes();
        }

        public int getCantidadTurnosHoy()
        {
            return dao.getCantidadTurnosHoy();
        }

        public DataTable getResumenAsistenciaMesActual()
        {
            return dao.getResumenAsistenciaMesActual();
        }


    //===============================// 
    //            INFORMES           // 
    //===============================//

        public string getDiaMayorDemandaJunio()
        {
            return dao.getDiaMayorDemandaJunio();
        }

        public string getMedicoMayorTurnosJunio()
        {
            return dao.getMedicoMayorTurnosJunio();
        }


    //===============================// 
    //       DATOS PARA COMBOS       // 
    //===============================//

        public DataTable getPacientes()
        {
            return dao.getPacientes();
        }

        public DataTable getMedicosPorEspecialidad(int idEspecialidad)
        {
            return dao.getMedicosPorEspecialidad(idEspecialidad);
        }

        public DataTable getHorariosDisponibles(int idMedico, DateTime fecha, int idTurnoActual)
        {
            return dao.getHorariosDisponibles(idMedico, fecha, idTurnoActual);
        }

    }
}
