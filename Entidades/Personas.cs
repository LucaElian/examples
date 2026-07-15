using System;

namespace Entidades
{
    public class Personas
    {
        public string DNI { get; set; }
        public string Apellido { get; set; }
        public string Nombre { get; set; }
        public char Sexo { get; set; }
        public int IDNacionalidad { get; set; }
        public DateTime FechaNacimiento { get; set; }
        public string Direccion { get; set; }
        public int IDLocalidad { get; set; }
        public string Correo { get; set; }
        public string Telefono { get; set; }
        public bool Estado { get; set; }

        public Personas() { }

        public Personas(string dni, string apellido, string nombre, char sexo, int idNacionalidad, DateTime fechaNacimiento, string direccion, int idLocalidad, string correo, string telefono, bool estado)
        {
            DNI = dni;
            Apellido = apellido;
            Nombre = nombre;
            Sexo = sexo;
            IDNacionalidad = idNacionalidad;
            FechaNacimiento = fechaNacimiento;
            Direccion = direccion;
            IDLocalidad = idLocalidad;
            Correo = correo;
            Telefono = telefono;
            Estado = estado;
        }
    }
}
