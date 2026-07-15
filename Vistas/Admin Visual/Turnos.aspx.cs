using System;
using System.Data;
using System.Web.UI.WebControls;
using Vistas.Utilities;
using Entidades;
using Negocio;

namespace Vistas
{
    public partial class Turnos : System.Web.UI.Page
    {
        NegocioTurno negocioT = new NegocioTurno();
        NegocioExterno negocioE = new NegocioExterno();
        Tools util = new Tools();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarDDL();
                CargarGrillaTurnos();
            }
        }


    //===============================// 
    //       CARGAS INICIALES        //
    //===============================//

        private void CargarDDL()
        {
            util.CargarDDL(
                ddlPaciente,
                negocioT.getPacientes(),
                "Paciente",
                "IDPaciente",
                "Seleccione paciente"
            );

            util.CargarDDL(
                ddlEspecialidad,
                negocioE.getEspecialidades(),
                "NombreEspecialidad",
                "IDEspecialidad",
                "Seleccione especialidad"
            );

            util.LimpiarDDL(ddlMedico, "Seleccione médico");
            ddlMedico.Enabled = false;
        }


        private void CargarGrillaTurnos()
        {
            string campo = ddlCampoBusqueda.SelectedValue;
            string busqueda = txtFiltroTurno.Text.Trim();

            DataTable tabla = negocioT.getTablaTurnos(campo, busqueda);

            gvTurnos.DataSource = tabla;
            gvTurnos.DataBind();

            lblCantidadListado.Text = tabla.Rows.Count + " registros";
        }


    //===============================// 
    //       EVENTOS DE LISTADO      //
    //===============================//

        protected void lbtnBuscarTurno_Click(object sender, EventArgs e)
        {
            gvTurnos.PageIndex = 0;
            CargarGrillaTurnos();
        }

        protected void btnMostrarTodos_Click(object sender, EventArgs e)
        {
            txtFiltroTurno.Text = "";
            ddlCampoBusqueda.SelectedValue = "ID";
            gvTurnos.PageIndex = 0;

            CargarGrillaTurnos();
        }


    //===============================// 
    //      EVENTOS DE GRIDVIEW      //
    //===============================//

        protected void gvTurnos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvTurnos.PageIndex = e.NewPageIndex;
            CargarGrillaTurnos();
        }

        protected void gvTurnos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditarTurno")
            {
                string idTurno = e.CommandArgument.ToString();
                AbrirModalModificar(idTurno);
            }

            else if (e.CommandName == "CambiarEstadoTurno")
            {
                string[] datos = e.CommandArgument.ToString().Split('|');

                int idTurno = Convert.ToInt32(datos[0]);
                bool estadoActual = Convert.ToBoolean(datos[1]);

                bool nuevoEstado = !estadoActual;

                if (negocioT.cambiarEstadoTurno(idTurno, nuevoEstado))
                    CargarGrillaTurnos();
            }
        }


    //===============================// 
    //      EVENTOS DE DROPDOWN      //
    //===============================//

        protected void ddlEspecialidad_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlEspecialidad.SelectedValue == "")
            {
                util.LimpiarDDL(ddlMedico, "Seleccione médico");
                ddlMedico.Enabled = false;

                return;
            }
            
            int idEspecialidad = Convert.ToInt32(ddlEspecialidad.SelectedValue);

            util.CargarDDL(
                ddlMedico,
                negocioT.getMedicosPorEspecialidad(idEspecialidad),
                "Medico",
                "IDMedico",
                "Seleccione médico"
            );

            ddlMedico.Enabled = true;
        }

        protected void ddlMedico_SelectedIndexChanged(object sender, EventArgs e)
        {
            CargarHorariosDisponibles();
        }


    //===============================// 
    //       EVENTOS DE TEXTBOX      //
    //===============================//

        protected void txtFecha_TextChanged(object sender, EventArgs e)
        {
            CargarHorariosDisponibles();
        }


    //===============================// 
    //     FORMULARIO MODIFICAR      //
    //===============================//

        private void AbrirModalModificar(string idTurno)
        {
            LimpiarFormulario();

            int id = Convert.ToInt32(idTurno);

            DataTable tabla = negocioT.getTurnoPorID(id);

            if (tabla.Rows.Count == 0)
                return;

            DataRow fila = tabla.Rows[0];

            CargarTurnoFormulario(fila);

            lblTituloFormulario.Text = "Modificar turno";
            lblSubtituloFormulario.Text = "Actualice los datos del turno seleccionado";

            pnlModalFormulario.Visible = true;
        }

        protected void btnModificarTurno_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            Entidades.Turnos turno = ObtenerTurnoFormulario();

            if (negocioT.ModificarTurno(turno))
                CerrarModalTurno();
        }


    //===============================// 
    //        BOTONES CERRAR         //
    //===============================//

        protected void lbtnCerrarModal_Click(object sender, EventArgs e)
        {
            pnlModalFormulario.Visible = false;
        }

        protected void btnCancelarModal_Click(object sender, EventArgs e)
        {
            pnlModalFormulario.Visible = false;
        }


    //===============================// 
    //       METODOS AUXILIARES      //
    //===============================//

        private void LimpiarFormulario()
        {
            txtFecha.Text = "";
            txtObservacion.Text = "";

            ddlEstadoAsistencia.SelectedIndex = 0;
            ddlPaciente.SelectedIndex = 0;
            ddlEspecialidad.SelectedIndex = 0;

            util.LimpiarDDL(ddlMedico, "Seleccione médico");
            ddlMedico.Enabled = false;

            util.LimpiarDDL(ddlHoraTurno, "Seleccione horario"); 
            ddlHoraTurno.Enabled = false;

            hfIdTurno.Value = "";
        }

        private void CerrarModalTurno()
        {
            pnlModalFormulario.Visible = false;
            LimpiarFormulario();
            CargarGrillaTurnos();
        }

        private int ObtenerIDTurno()
        {
            if (string.IsNullOrWhiteSpace(hfIdTurno.Value))
                return 0;

            return Convert.ToInt32(hfIdTurno.Value);
        }


    //===============================// 
    //        CARGA DE HORAS         //
    //===============================//

        private void CargarHorariosDisponibles()
        {
            util.LimpiarDDL(ddlHoraTurno, "Seleccione horario");
            ddlHoraTurno.Enabled = false;

            if (ddlMedico.SelectedValue == "" || txtFecha.Text == "")
                return;

            int idMedico = Convert.ToInt32(ddlMedico.SelectedValue);
            DateTime fecha = Convert.ToDateTime(txtFecha.Text);
            int idTurnoActual = ObtenerIDTurno();

            DataTable horarios = negocioT.getHorariosDisponibles(idMedico, fecha, idTurnoActual);

            util.CargarDDL(
                ddlHoraTurno,
                horarios,
                "HoraTexto",
                "Hora",
                "Seleccione horario"
            );

            ddlHoraTurno.Enabled = true;
        }


    //===============================// 
    //        CARGA DE DATOS         //
    //===============================//

        private Entidades.Turnos ObtenerTurnoFormulario()
        {
            Entidades.Turnos turno = new Entidades.Turnos();

            turno.IDTurno = Convert.ToInt32(hfIdTurno.Value);
            turno.IDPaciente = Convert.ToInt32(ddlPaciente.SelectedValue);
            turno.IDMedico = Convert.ToInt32(ddlMedico.SelectedValue);
            turno.Fecha = Convert.ToDateTime(txtFecha.Text);
            turno.Hora = TimeSpan.Parse(ddlHoraTurno.SelectedValue);
            turno.EstadoAsistencia = ddlEstadoAsistencia.SelectedValue;
            turno.Observacion = txtObservacion.Text.Trim();

            return turno;
        }

        private void CargarTurnoFormulario(DataRow fila)
        {
            hfIdTurno.Value = fila["ID"].ToString();

            util.SeleccionarDDL(ddlPaciente, fila["IDPaciente"].ToString());
            util.SeleccionarDDL(ddlEspecialidad, fila["IDEspecialidad"].ToString());

            int idEspecialidad = Convert.ToInt32(fila["IDEspecialidad"]);

            util.CargarDDL(
                ddlMedico,
                negocioT.getMedicosPorEspecialidad(idEspecialidad),
                "Medico",
                "IDMedico",
                "Seleccione médico"
            );

            ddlMedico.Enabled = true;

            util.SeleccionarDDL(ddlMedico, fila["IDMedico"].ToString());
            util.SeleccionarDDL(ddlEstadoAsistencia, fila["EstadoAsistencia"].ToString());

            DateTime fecha = Convert.ToDateTime(fila["Fecha"]);
            txtFecha.Text = fecha.ToString("yyyy-MM-dd");

            CargarHorariosDisponibles();

            TimeSpan hora = (TimeSpan)fila["Hora"];
            util.SeleccionarDDL(ddlHoraTurno, hora.ToString(@"hh\:mm"));

            txtObservacion.Text = fila["Observacion"].ToString();
        }
    }
}