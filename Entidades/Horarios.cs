using System;

namespace Entidades
{
    public class Horarios
    {
        public int IDHorario { get; set; }
        public int IDMedico { get; set; }
        public string Dia { get; set; }
        public TimeSpan HoraInicio { get; set; }
        public TimeSpan HoraFin { get; set; }
        public bool Estado { get; set; }

        public Horarios() { }

        public Horarios(int idHorario, int idMedico, string dia, TimeSpan horaInicio, TimeSpan horaFin, bool estado)
        {
            IDHorario = idHorario;
            IDMedico = idMedico;
            Dia = dia;
            HoraInicio = horaInicio;
            HoraFin = horaFin;
            Estado = estado;
        }
    }
}
