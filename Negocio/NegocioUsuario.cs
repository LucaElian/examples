using Datos;
using Entidades;
using System.Data;

namespace Negocio
{
    public class NegocioUsuario
    {
        private readonly DaoUsuario dao;

        public NegocioUsuario()
        {
            dao = new DaoUsuario();
        }


    //===============================//
    //             LOGIN             // 
    //===============================//

        public Usuarios validarLogin(string nombre, string contrasenia)
        {
            Usuarios usuario = new Usuarios();

            usuario.NombreUsuario = nombre;
            usuario.Contrasenia = contrasenia;

            return dao.validarLogin(usuario);
        }

        public bool esAdministrador(Usuarios usuario)
        {
            return usuario != null && usuario.Rol == "Administrador";
        }

        public bool esMedico(Usuarios usuario)
        {
            return usuario != null && usuario.Rol == "Medico";
        }


    //===============================//
    //            LISTADO            // 
    //===============================//

        public DataTable getTablaUsuarios(string campo, string busqueda)
        {
            return dao.getTablaUsuarios(campo, busqueda);
        }
    }
}