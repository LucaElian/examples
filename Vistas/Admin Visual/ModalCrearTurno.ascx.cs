using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using Vistas.Utilities;
using Negocio;

namespace Vistas
{
    public partial class ModalCrearTurno : System.Web.UI.UserControl
    {
        NegocioTurno negocioT = new NegocioTurno();
        NegocioPaciente negocioP = new NegocioPaciente();
        NegocioMedico negocioM = new NegocioMedico();
        NegocioExterno negocioE = new NegocioExterno();
        Tools util = new Tools();

        protected void Page_Load(object sender, EventArgs e)
        {
            txtFecha.Attributes["min"] = DateTime.Today.ToString("yyyy-MM-dd");

            if (!IsPostBack)
                CargarDDL();
        }


    //===============================// 
    //          ABRIR MODAL          //
    //===============================//

        public void Abrir()
        {
            CargarDDL();
            LimpiarFormulario();

            pnlModalCrearTurno.Visible = true;
        }


    //===============================// 
    //       CARGAS INICIALES        //
    //===============================//

        private void CargarDDL()
        {
            util.CargarDDL(
                ddlPaciente,
                negocioP.getPacientesActivos(),
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

            util.LimpiarDDL(ddlHoraTurno, "Seleccione horario");
            ddlHoraTurno.Enabled = false;
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

                util.LimpiarDDL(ddlHoraTurno, "Seleccione horario");
                ddlHoraTurno.Enabled = false;

                return;
            }

            int idEspecialidad = Convert.ToInt32(ddlEspecialidad.SelectedValue);

            util.CargarDDL(
                ddlMedico,
                negocioM.getMedicosActivosPorEspecialidad(idEspecialidad),
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
    //       EVENTOS DE TEXTBOX      //
    //===============================//

        protected void cvFechaTurno_ServerValidate(object source, ServerValidateEventArgs args)
        {
            DateTime fecha;

            if (!DateTime.TryParse(args.Value, out fecha))
            {
                args.IsValid = false;
                return;
            }

            if (fecha.Date < DateTime.Today)
            {
                args.IsValid = false;
                return;
            }

            args.IsValid = true;
        }


        //===============================// 
        //        EVENTOS DIRECTOS       //
        //===============================//

        protected void btnGuardarTurno_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            Entidades.Turnos turno = ObtenerTurnoFormulario();

            if (negocioT.AgregarTurno(turno))
            {
                LimpiarFormulario();
                
                string pagina = System.IO.Path.GetFileName(Request.Path);

                if (pagina == "InicioAdmin.aspx")
                {
                    Response.Redirect(Request.RawUrl);
                    return;
                }
            }
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            LimpiarFormulario();
        }


    //===============================// 
    //        BOTONES CERRAR         //
    //===============================//

        protected void btnCancelarModal_Click(object sender, EventArgs e)
        {
            pnlModalCrearTurno.Visible = false;
        }

        protected void lbtnCerrarModal_Click(object sender, EventArgs e)
        {
            pnlModalCrearTurno.Visible = false;
        }


    //===============================// 
    //       METODOS AUXILIARES      //
    //===============================//

        private void LimpiarFormulario()
        {
            txtFecha.Text = "";

            ddlPaciente.SelectedIndex = 0;
            ddlEspecialidad.SelectedIndex = 0;

            util.LimpiarDDL(ddlMedico, "Seleccione médico");
            ddlMedico.Enabled = false;

            util.LimpiarDDL(ddlHoraTurno, "Seleccione horario");
            ddlHoraTurno.Enabled = false;
        }

        private int ObtenerIDUsuarioCreador()
        {
            if (Session["IDUsuario"] != null)
                return Convert.ToInt32(Session["IDUsuario"]);

            Response.Redirect("~/Login.aspx", true);
            return 0;
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
            DateTime fecha;

            if (!DateTime.TryParse(txtFecha.Text, out fecha) || fecha.Date < DateTime.Today)
                return;

            DataTable horarios = negocioT.getHorariosDisponibles(idMedico, fecha, 0);

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

            turno.IDPaciente = Convert.ToInt32(ddlPaciente.SelectedValue);
            turno.IDMedico = Convert.ToInt32(ddlMedico.SelectedValue);
            turno.IDUsuarioCreador = ObtenerIDUsuarioCreador();
            turno.Fecha = Convert.ToDateTime(txtFecha.Text);
            turno.Hora = TimeSpan.Parse(ddlHoraTurno.SelectedValue);
            turno.EstadoAsistencia = "Pendiente";
            turno.Observacion = "";
            turno.Estado = true;

            return turno;
        }
    }
}
