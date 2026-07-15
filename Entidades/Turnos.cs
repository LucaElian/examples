using System;

namespace Entidades
{
    public class Turnos
    {
        public int IDTurno { get; set; }
        public int IDPaciente { get; set; }
        public int IDMedico { get; set; }
        public int IDUsuarioCreador { get; set; }
        public DateTime Fecha { get; set; }
        public TimeSpan Hora { get; set; }
        public string EstadoAsistencia { get; set; }
        public string Observacion { get; set; }
        public bool Estado { get; set; }
    }
}
