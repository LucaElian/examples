using System.Data;
using Datos;
using Entidades;

namespace Negocio
{
    public class NegocioPaciente
    {
        private readonly DaoPaciente dao;
    
        public NegocioPaciente()
        {
            dao = new DaoPaciente();
        }


    //===============================//
    //            LISTADO            // 
    //===============================//

        public DataTable getTablaPacientes(string campo, string busqueda)
        {
            return dao.getTablaPacientes(campo, busqueda);
        }


    //===============================//
    //         OBTENER POR ID        // 
    //===============================//

        public DataTable getPacientePorID(int idPaciente)
        {
            return dao.getPacientePorID(idPaciente);
        }


    //===============================//
    //            AGREGAR            // 
    //===============================//

        public bool AgregarPaciente(Entidades.Pacientes paciente)
        {
            int filasAfectadas = dao.agregarPaciente(paciente);

            return filasAfectadas > 0;
        }


    //===============================//
    //           MODIFICAR           // 
    //===============================//

        public bool ModificarPaciente(Pacientes paciente)
        {
            int filasAfectadas = dao.modificarPaciente(paciente);

            return filasAfectadas > 0;
        }



    //===============================// 
    //      ACTIVAR / DESACTIVAR     // 
    //===============================//

        public bool cambiarEstadoPaciente(int idPaciente, bool estado)
        {
            int filasAfectadas = dao.cambiarEstadoPaciente(idPaciente, estado);

            return filasAfectadas > 0;
        }


    //===============================// 
    //     INICIO ADMIN DASHBOARD    // 
    //===============================//

        public int getCantidadPacientesActivos()
        {
            return dao.getCantidadPacientesActivos();
        }


    //===============================// 
    //       VALIDAR REPETIDOS       // 
    //===============================//

        public bool existeDNI(string dni, int idPaciente)
        {
            return dao.existeDNI(dni.Trim(), idPaciente);
        }

        public bool existeCorreo(string correo, int idPaciente)
        {
            return dao.existeCorreo(correo.Trim(), idPaciente);
        }

        public bool existeTelefono(string telefono, int idPaciente)
        {
            return dao.existeTelefono(telefono.Trim(), idPaciente);
        }
    }
}
