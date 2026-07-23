using System.Data;
using Datos;
using Entidades;

namespace Negocio
{
    public class NegocioMedico
    {
        private readonly DaoMedico dao;

        public NegocioMedico()
        {
            dao = new DaoMedico();
        }


    //===============================//
    //            LISTADO            // 
    //===============================//

        public DataTable getTablaMedicos(string campo, string busqueda)
        {
            return dao.getTablaMedicos(campo, busqueda);
        }


    //===============================//
    //         OBTENER POR ID        // 
    //===============================//

        public DataTable getMedicoPorID(int idMedico)
        {
            return dao.getMedicoPorID(idMedico);
        }


    //===============================//
    //            AGREGAR            // 
    //===============================//

        public bool AgregarMedico(Entidades.Medicos medico)
        {
            int filasAfectadas = dao.agregarMedico(medico);

            return filasAfectadas > 0;
        }


    //===============================//
    //           MODIFICAR           // 
    //===============================//

        public bool ModificarMedico(Medicos medico)
        {
            int filasAfectadas = dao.modificarMedico(medico);

            return filasAfectadas > 0;
        }


    //===============================// 
    //      ACTIVAR / DESACTIVAR     // 
    //===============================//

        public bool cambiarEstadoMedico(int idMedico, bool estado)
        {
            int filasAfectadas = dao.cambiarEstadoMedico(idMedico, estado);

            return filasAfectadas > 0;
        }


        //===============================// 
        //     INICIO ADMIN DASHBOARD    // 
        //===============================//

        public int getCantidadMedicosActivos()
        {
            return dao.getCantidadMedicosActivos();
        }


        //===============================// 
        //       DATOS PARA COMBOS       // 
        //===============================//

        public DataTable getMedicosActivosPorEspecialidad(int idEspecialidad)
        {
            return dao.getMedicosActivosPorEspecialidad(idEspecialidad);
        }


        //===============================// 
        //       VALIDAR REPETIDOS       // 
        //===============================//

        public bool existeLegajo(string legajo, int idMedico)
        {
            return dao.existeLegajo(legajo.Trim(), idMedico);
        }

        public bool existeDNI(string dni, int idMedico)
        {
            return dao.existeDNI(dni.Trim(), idMedico);
        }

        public bool existeCorreo(string correo, int idMedico)
        {
            return dao.existeCorreo(correo.Trim(), idMedico);
        }

        public bool existeTelefono(string telefono, int idMedico)
        {
            return dao.existeTelefono(telefono.Trim(), idMedico);
        }
    }
}
