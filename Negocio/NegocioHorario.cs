using Datos;
using Entidades;
using System.Data;

namespace Negocio
{
    public class NegocioHorario
    {
        private readonly DaoHorario dao;

        public NegocioHorario() 
        {
            dao = new DaoHorario();
        }


    //===============================// 
    //       LISTAR POR MEDICO       // 
    //===============================//

        public DataTable getHorariosPorMedico(int idMedico)
        {
            return dao.getHorariosPorMedico(idMedico);
        }


    //===============================// 
    //            AGREGAR            // 
    //===============================//

        public bool agregarHorario(Horarios horario)
        {
            int filasAfectadas = dao.agregarHorario(horario);

            return filasAfectadas > 0;
        }


    //===============================// 
    //          VALIDADORES          // 
    //===============================//

        public bool existeHorario(Horarios horario)
        {
            return dao.existeHorario(horario);
        }


    //===============================// 
    //      ACTIVAR / DESACTIVAR     // 
    //===============================//

        public bool cambiarEstadoHorario(int idHorario, bool estado)
        {
            if (estado == true)
            {
                if (dao.existeHorarioActivoAlActivar(idHorario))
                    return false;
            }

            int filasAfectadas = dao.cambiarEstadoHorario(idHorario, estado);

            return filasAfectadas > 0;
        }


    //===============================// 
    //        ELIMINAR HORARIO       // 
    //===============================//

        public bool eliminarHorario(int idHorario)
        {
            int filasAfectadas = dao.eliminarHorario(idHorario);

            return filasAfectadas > 0;
        }
    }
}
