using System;
using System.Data;
using Negocio;

namespace Vistas
{
    public partial class InicioAdmin : System.Web.UI.Page
    {
        NegocioTurno negocioT = new NegocioTurno();
        NegocioPaciente negocioP = new NegocioPaciente();
        NegocioMedico negocioM = new NegocioMedico();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                CargarInicioAdmin();
        }


    //===============================//
    //       CARGAS INICIALES        //
    //===============================//

        private void CargarInicioAdmin()
        {
            CargarTurnosPorEspecialidad();
            CargarTarjetasResumen();
            CargarResumenAsistencia();
        }

        private void CargarTurnosPorEspecialidad()
        {
            DataTable tabla = negocioT.getTurnosPorEspecialidadMesActual();

            rptEspecialidades.DataSource = tabla;
            rptEspecialidades.DataBind();

            int totalTurnos = 0;

            foreach(DataRow fila in tabla.Rows)
                totalTurnos += Convert.ToInt32(fila["Cantidad"]);

            lblTotalTurnoMes.Text = totalTurnos + " turnos";
        }

        private void CargarTarjetasResumen()
        {
            lblPacientesActivos.Text = negocioP.getCantidadPacientesActivos().ToString();
            lblMedicosActivos.Text = negocioM.getCantidadMedicosActivos().ToString();

            lblTurnosPendientes.Text = negocioT.getCantidadTurnosPendientes().ToString();
            lblTurnosHoy.Text = negocioT.getCantidadTurnosHoy().ToString();
        }

        private void CargarResumenAsistencia()
        {
            DataTable tabla = negocioT.getResumenAsistenciaMesActual();
            

            if(tabla.Rows.Count == 0)
            {
                lblPresentes.Text = "0";
                lblAusentes.Text = "0";
                lblPendientes.Text = "0";
                return;
            }

            DataRow fila = tabla.Rows[0];

            lblPresentes.Text = fila["Presentes"].ToString();
            lblAusentes.Text = fila["Ausentes"].ToString();
            lblPendientes.Text = fila["Pendientes"].ToString();
        }

    }
}