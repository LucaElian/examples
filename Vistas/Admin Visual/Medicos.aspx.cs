using System;
using System.Data;
using System.Web.UI.WebControls;
using Vistas.Utilities;
using Entidades;
using Negocio;

namespace Vistas
{
    public partial class Medicos : PaginaAdmin
    {
        NegocioMedico negocioM = new NegocioMedico();
        NegocioExterno negocioE = new NegocioExterno();
        NegocioHorario negocioH = new NegocioHorario();
        Tools util = new Tools();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarDDL();
                CargarGrillaMedicos();
            }
        }


    //===============================// 
    //       CARGAS INICIALES        //
    //===============================//

        private void CargarDDL()
        {
            util.CargarDDL(
                ddlEspecialidad,
                negocioE.getEspecialidades(),
                "NombreEspecialidad",
                "IDEspecialidad",
                "Seleccione especialidad"
            );

            util.CargarDDL(
                ddlNacionalidad,
                negocioE.getNacionalidades(),
                "NombreNacionalidad",
                "IDNacionalidad",
                "Seleccione nacionalidad"
            );

            util.CargarDDL(
                ddlProvincia,
                negocioE.getProvincias(),
                "NombreProvincia",
                "IDProvincia",
                "Seleccione provincia"
            );

            util.LimpiarDDL(ddlLocalidad, "Seleccione localidad");
            ddlLocalidad.Enabled = false;
        }

        private void CargarGrillaMedicos()
        {
            string campo = ddlCampoBusqueda.SelectedValue;
            string busqueda = txtFiltroMedico.Text.Trim();

            DataTable tabla = negocioM.getTablaMedicos(campo, busqueda);

            gvMedicos.DataSource = tabla;
            gvMedicos.DataBind();

            lblCantidadListado.Text = tabla.Rows.Count + " registros";
        }

        private void CargarHorariosMedico(int idMedico)
        {
            DataTable tabla = negocioH.getHorariosPorMedico(idMedico);

            gvHorarios.DataSource = tabla;
            gvHorarios.DataBind();
        }


    //===============================// 
    //       EVENTOS DE LISTADO      //
    //===============================//

        protected void lbtnBuscarMedico_Click(object sender, EventArgs e)
        {
            gvMedicos.PageIndex = 0;
            CargarGrillaMedicos();
        }

        protected void btnMostrarTodos_Click(object sender, EventArgs e)
        {
            txtFiltroMedico.Text = "";
            ddlCampoBusqueda.SelectedValue = "ID";
            gvMedicos.PageIndex = 0;

            CargarGrillaMedicos();
        }


    //===============================// 
    //      EVENTOS DE GRIDVIEW      //
    //===============================//

        protected void gvMedicos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvMedicos.PageIndex = e.NewPageIndex;
            CargarGrillaMedicos();
        }

        protected void gvMedicos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditarMedico")
            {
                string idMedico = e.CommandArgument.ToString();
                AbrirModalModificar(idMedico);
            }

            else if (e.CommandName == "CambiarEstadoMedico")
            {
                string[] datos = e.CommandArgument.ToString().Split('|');

                int idMedico = Convert.ToInt32(datos[0]);
                bool estadoActual = Convert.ToBoolean(datos[1]);

                bool nuevoEstado = !estadoActual;

                if (negocioM.cambiarEstadoMedico(idMedico, nuevoEstado))
                    CargarGrillaMedicos();
            }

            else if (e.CommandName == "HorariosMedico")
            {
                int idMedico = Convert.ToInt32(e.CommandArgument);
                AbrirModalHorarios(idMedico);
            }
        }


        protected void gvHorarios_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "CambiarEstadoHorario")
            {
                string[] datos = e.CommandArgument.ToString().Split('|');

                int idHorario = Convert.ToInt32(datos[0]);
                bool estadoActual = Convert.ToBoolean(datos[1]);

                bool nuevoEstado = !estadoActual;

                if (!negocioH.cambiarEstadoHorario(idHorario, nuevoEstado))
                {
                    if (nuevoEstado)
                        lblMensajeHorario.Text = "No se puede activar el horario porque se superpone con otro horario activo.";

                    pnlMensajeHorario.Visible = true;
                }

                int idMedico = Convert.ToInt32(hfIdMedicoHorario.Value);
                CargarHorariosMedico(idMedico);
            }

            else if (e.CommandName == "EliminarHorario")
            {
                int idHorario = Convert.ToInt32(e.CommandArgument);

                if (negocioH.eliminarHorario(idHorario))
                {
                    int idMedico = Convert.ToInt32(hfIdMedicoHorario.Value);
                    CargarHorariosMedico(idMedico);
                }
            }
        }

        protected void gvHorarios_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvHorarios.PageIndex = e.NewPageIndex;

            int idMedico = Convert.ToInt32(hfIdMedicoHorario.Value);
            CargarHorariosMedico(idMedico);

            pnlModalHorarios.Visible = true;
        }


    //===============================// 
    //      EVENTOS DE DROPDOWN      //
    //===============================//

        protected void ddlProvincia_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlProvincia.SelectedValue == "")
            {
                util.LimpiarDDL(ddlLocalidad, "Seleccione localidad");
                ddlLocalidad.Enabled = false;
                return;
            }

            int idProvincia = Convert.ToInt32(ddlProvincia.SelectedValue);

            util.CargarDDL(
                ddlLocalidad,
                negocioE.getLocalidades(idProvincia),
                "NombreLocalidad",
                "IDLocalidad",
                "Seleccione localidad"
            );

            ddlLocalidad.Enabled = true;
        }


        protected void ddlHoraInicio_SelectedIndexChanged(object sender, EventArgs e)
        {
            CargarHorasFin();
        }

        protected void ddlHoraFin_SelectedIndexChanged(object sender, EventArgs e)
        {
            CargarMinutosFin();
        }


    //===============================// 
    //      FORMULARIO AGREGAR       //
    //===============================//

        protected void btnAbrirModalAgregar_Click(object sender, EventArgs e)
        {
            LimpiarFormulario();
            hfIdMedico.Value = "";

            lblTituloFormulario.Text = "Agregar médico";
            lblSubtituloFormulario.Text = "Complete los datos del médico";

            btnAgregarMedico.Visible = true;
            btnModificarMedico.Visible = false;

            pnlModalFormulario.Visible = true;
        }

        protected void btnAgregarMedico_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            Entidades.Medicos medico = ObtenerMedicoFormulario();

            if (negocioM.AgregarMedico(medico))
                CerrarModalMedico();
        }


    //===============================// 
    //     FORMULARIO MODIFICAR      //
    //===============================//

        private void AbrirModalModificar(string idMedico)
        {
            LimpiarFormulario();

            int id = Convert.ToInt32(idMedico);

            DataTable tabla = negocioM.getMedicoPorID(id);

            if (tabla.Rows.Count == 0)
                return;

            DataRow fila = tabla.Rows[0];

            CargarMedicoFormulario(fila);

            lblTituloFormulario.Text = "Modificar médico";
            lblSubtituloFormulario.Text = "Actualice los datos del médico seleccionado";

            btnAgregarMedico.Visible = false;
            btnModificarMedico.Visible = true;

            pnlModalFormulario.Visible = true;
        }

        protected void btnModificarMedico_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            Entidades.Medicos medico = ObtenerMedicoFormulario();
            medico.IDMedico = Convert.ToInt32(hfIdMedico.Value);

            if (negocioM.ModificarMedico(medico))
                CerrarModalMedico();
        }


    //===============================// 
    //      FORMULARIO HORARIO       //
    //===============================//

        private void AbrirModalHorarios(int idMedico)
        {
            LimpiarFormulario();

            hfIdMedicoHorario.Value = idMedico.ToString();

            DataTable tabla = negocioM.getMedicoPorID(idMedico);

            if (tabla.Rows.Count == 0)
                return;

            DataRow fila = tabla.Rows[0];

            lblTituloHorarios.Text = "Horarios de " + fila["Apellido"].ToString() + " " + fila["Nombre"].ToString();
            lblSubtituloHorarios.Text = "Agregue o quite horarios de atención";

            CargarHorariosMedico(idMedico);

            pnlModalHorarios.Visible = true;
        }

        protected void btnAgregarHorario_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            Entidades.Horarios horario = ObtenerHorarioFormulario();

            if (negocioH.agregarHorario(horario))
            {
                LimpiarFormulario();
                CargarHorariosMedico(horario.IDMedico);
            }
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

        protected void lbtnCerrarHorarios_Click(object sender, EventArgs e)
        {
            pnlModalHorarios.Visible = false;
        }


    //===============================// 
    //          VALIDADORES          //
    //===============================//

        protected void cvLegajoRepetido_ServerValidate(object source, ServerValidateEventArgs args)
        {
            ValidarDatoRepetido(args, negocioM.existeLegajo);
        }

        protected void cvDniRepetido_ServerValidate(object source, ServerValidateEventArgs args)
        {
            ValidarDatoRepetido(args, negocioM.existeDNI);
        }

        protected void cvCorreoRepetido_ServerValidate(object source, ServerValidateEventArgs args)
        {
            ValidarDatoRepetido(args, negocioM.existeCorreo);
        }

        protected void cvTelefonoRepetido_ServerValidate(object source, ServerValidateEventArgs args)
        {
            ValidarDatoRepetido(args, negocioM.existeTelefono);
        }

        protected void cvFechaNacimiento_ServerValidate(object source, ServerValidateEventArgs args)
        {
            DateTime fechaNacimiento;

            if (!DateTime.TryParse(args.Value, out fechaNacimiento))
            {
                args.IsValid = false;
                return;
            }

            if (fechaNacimiento > DateTime.Today)
            {
                args.IsValid = false;
                return;
            }

            args.IsValid = true;
        }

        protected void cvHorarioSuperpuesto_ServerValidate(object source, ServerValidateEventArgs args)
        {
            TimeSpan horaInicio = util.ObtenerHora(ddlHoraInicio, ddlMinutoInicio);
            TimeSpan horaFin = util.ObtenerHora(ddlHoraFin, ddlMinutoFin);

            Horarios horario = new Horarios();

            horario.IDMedico = Convert.ToInt32(hfIdMedicoHorario.Value);
            horario.Dia = ddlDiaHorario.SelectedValue;
            horario.HoraInicio = horaInicio;
            horario.HoraFin = horaFin;
            horario.Estado = true;

            args.IsValid = !negocioH.existeHorario(horario);
        }


    //===============================// 
    //       METODOS AUXILIARES      //
    //===============================//

        private void LimpiarFormulario()
        {
            util.LimpiarControles(
                txtLegajo,
                txtDni,
                txtNombre,
                txtApellido,
                txtFechaNacimiento,
                txtTelefono,
                txtCorreo,
                txtDireccion,
                ddlSexo,
                ddlEspecialidad,
                ddlNacionalidad,
                ddlProvincia,

                ddlDiaHorario,
                ddlHoraInicio,
                ddlMinutoInicio,
                ddlHoraFin,
                ddlMinutoFin
            );

            ddlHoraFin.Items.Clear();
            ddlHoraFin.Items.Add(new ListItem("HH", ""));
            ddlHoraFin.Enabled = false;

            ddlMinutoFin.Items.Clear();
            ddlMinutoFin.Items.Add(new ListItem("MM", ""));
            ddlMinutoFin.Enabled = false;

            util.LimpiarDDL(ddlLocalidad, "Seleccione localidad");
            ddlLocalidad.Enabled = false;
        }

        private int ObtenerIDMedico()
        {
            if (string.IsNullOrWhiteSpace(hfIdMedico.Value))
                return 0;

            return Convert.ToInt32(hfIdMedico.Value);
        }

        private void ValidarDatoRepetido(ServerValidateEventArgs args, Func<string, int, bool> existe)
        {
            int idMedico = ObtenerIDMedico();

            args.IsValid = !existe(args.Value.Trim(), idMedico);
        }

        private void CerrarModalMedico()
        {
            pnlModalFormulario.Visible = false;
            hfIdMedico.Value = "";
            LimpiarFormulario();
            CargarGrillaMedicos();
        }


    //===============================// 
    //         CARGA DE HORAS        //
    //===============================//

        private void CargarHorasFin()
        {
            ddlHoraFin.Items.Clear();
            ddlHoraFin.Items.Add(new ListItem("HH", ""));

            ddlMinutoFin.Items.Clear();
            ddlMinutoFin.Items.Add(new ListItem("MM", ""));

            ddlHoraFin.Enabled = false;
            ddlMinutoFin.Enabled = false;

            if (ddlHoraInicio.SelectedValue == "" || ddlMinutoInicio.SelectedValue == "")
                return;

            int horaInicio = Convert.ToInt32(ddlHoraInicio.SelectedValue);

            for (int h = horaInicio + 1; h <= 20; h++)
            {
                ddlHoraFin.Items.Add(
                    new ListItem(h.ToString("00"), h.ToString())
                );
            }

            ddlHoraFin.Enabled = true;
        }

        private void CargarMinutosFin()
        {
            ddlMinutoFin.Items.Clear();
            ddlMinutoFin.Items.Add(new ListItem("MM", ""));

            ddlMinutoFin.Enabled = false;

            if (ddlHoraFin.SelectedValue == "")
                return;

            ddlMinutoFin.Enabled = true;

            if (ddlHoraFin.SelectedValue == "20")
            {
                ddlMinutoFin.Items.Add(new ListItem("00", "0"));
                ddlMinutoFin.SelectedValue = "0";
                return;
            }

            ddlMinutoFin.Items.Add(new ListItem("00", "0"));
            ddlMinutoFin.Items.Add(new ListItem("15", "15"));
            ddlMinutoFin.Items.Add(new ListItem("30", "30"));
            ddlMinutoFin.Items.Add(new ListItem("45", "45"));
        }


    //===============================// 
    //        CARGA DE DATOS         //
    //===============================//

        private Entidades.Medicos ObtenerMedicoFormulario()
        {
            Entidades.Medicos medico = new Entidades.Medicos();

            medico.Legajo = txtLegajo.Text.Trim();
            medico.DNI = txtDni.Text.Trim();
            medico.Nombre = txtNombre.Text.Trim();
            medico.Apellido = txtApellido.Text.Trim();
            medico.Sexo = Convert.ToChar(ddlSexo.SelectedValue);
            medico.IDEspecialidad = Convert.ToInt32(ddlEspecialidad.SelectedValue);
            medico.IDNacionalidad = Convert.ToInt32(ddlNacionalidad.SelectedValue);
            medico.FechaNacimiento = Convert.ToDateTime(txtFechaNacimiento.Text);
            medico.IDLocalidad = Convert.ToInt32(ddlLocalidad.SelectedValue);
            medico.Telefono = txtTelefono.Text.Trim();
            medico.Correo = txtCorreo.Text.Trim();
            medico.Direccion = txtDireccion.Text.Trim();

            return medico;
        }

        private Entidades.Horarios ObtenerHorarioFormulario()
        {
            Entidades.Horarios horario = new Entidades.Horarios();

            horario.IDMedico = Convert.ToInt32(hfIdMedicoHorario.Value);
            horario.Dia = ddlDiaHorario.SelectedValue;
            horario.HoraInicio = util.ObtenerHora(ddlHoraInicio, ddlMinutoInicio);
            horario.HoraFin = util.ObtenerHora(ddlHoraFin, ddlMinutoFin);
            horario.Estado = true;

            return horario;
        }

        private void CargarMedicoFormulario(DataRow fila)
        {
            hfIdMedico.Value = fila["ID"].ToString();

            txtLegajo.Text = fila["Legajo"].ToString();
            txtDni.Text = fila["DNI"].ToString();
            txtNombre.Text = fila["Nombre"].ToString();
            txtApellido.Text = fila["Apellido"].ToString();
            txtTelefono.Text = fila["Telefono"].ToString();
            txtCorreo.Text = fila["Correo"].ToString();
            txtDireccion.Text = fila["Direccion"].ToString();

            DateTime fecha = Convert.ToDateTime(fila["FechaNacimiento"]);
            txtFechaNacimiento.Text = fecha.ToString("yyyy-MM-dd");

            util.SeleccionarDDL(ddlSexo, fila["Sexo"].ToString());
            util.SeleccionarDDL(ddlEspecialidad, fila["IDEspecialidad"].ToString());
            util.SeleccionarDDL(ddlNacionalidad, fila["IDNacionalidad"].ToString());
            util.SeleccionarDDL(ddlProvincia, fila["IDProvincia"].ToString());

            int idProvincia = Convert.ToInt32(fila["IDProvincia"]);

            util.CargarDDL(
                ddlLocalidad,
                negocioE.getLocalidades(idProvincia),
                "NombreLocalidad",
                "IDLocalidad",
                "Seleccione Localidad"
            );

            ddlLocalidad.Enabled = true;

            util.SeleccionarDDL(ddlLocalidad, fila["IDLocalidad"].ToString());
        }
    }
}
