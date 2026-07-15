namespace Entidades
{
    public class Usuarios
    {
        public int IDUsuario { get; set; }
        public string NombreCompleto { get; set; }
        public string NombreUsuario { get; set; }
        public string Contrasenia { get; set; }
        public string Rol { get; set; }
        public bool Estado { get; set; }
        public int? IDMedicoUsuario { get; set; }

        public Usuarios() { }

        public Usuarios(int idUsuario, string nombreCompleto, string nombreUsuario, string contrasenia, string rol, bool estado, int? idMedicoUsuario)
        {
            IDUsuario = idUsuario;
            NombreCompleto = nombreCompleto;
            NombreUsuario = nombreUsuario;
            Contrasenia = contrasenia;
            Rol = rol;
            Estado = estado;
            IDMedicoUsuario = idMedicoUsuario;
        }
    }
}
