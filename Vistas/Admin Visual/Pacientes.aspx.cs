using System;
using System.Data;
using System.Web.UI.WebControls;
using Vistas.Utilities;
using Entidades;
using Negocio;

namespace Vistas
{
    public partial class Pacientes : System.Web.UI.Page
    {
        NegocioPaciente negocioP = new NegocioPaciente();
        NegocioExterno negocioE = new NegocioExterno();
        Tools util = new Tools();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarDDL();
                CargarGrillaPacientes();
            }
        }

    //===============================// 
    //       CARGAS INICIALES        //
    //===============================//

        private void CargarDDL()
        {
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


        private void CargarGrillaPacientes()
        {
            string campo = ddlCampoBusqueda.SelectedValue;
            string busqueda = txtFiltroPaciente.Text.Trim();

            DataTable tabla = negocioP.getTablaPacientes(campo, busqueda);

            gvPacientes.DataSource = tabla;
            gvPacientes.DataBind();

            lblCantidadListado.Text = tabla.Rows.Count + " registros";
        }


    //===============================// 
    //       EVENTOS DE LISTADO      //
    //===============================//

        protected void lbtnBuscarPaciente_Click(object sender, EventArgs e)
        {
            gvPacientes.PageIndex = 0;
            CargarGrillaPacientes();
        }

        protected void btnMostrarTodos_Click(object sender, EventArgs e)
        {
            txtFiltroPaciente.Text = "";
            ddlCampoBusqueda.SelectedValue = "ID";
            gvPacientes.PageIndex = 0;

            CargarGrillaPacientes();
        }

    //===============================// 
    //      EVENTOS DE GRIDVIEW      //
    //===============================//

        protected void gvPacientes_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvPacientes.PageIndex = e.NewPageIndex;
            CargarGrillaPacientes();
        }

        protected void gvPacientes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditarPaciente")
            {
                string idPaciente = e.CommandArgument.ToString();
                AbrirModalModificar(idPaciente);
            }

            else if (e.CommandName == "CambiarEstadoPaciente")
            {
                string[] datos = e.CommandArgument.ToString().Split('|');

                int idPaciente = Convert.ToInt32(datos[0]);
                bool estadoActual = Convert.ToBoolean(datos[1]);

                bool nuevoEstado = !estadoActual;

                if (negocioP.cambiarEstadoPaciente(idPaciente, nuevoEstado))
                    CargarGrillaPacientes();
            }
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

    //===============================// 
    //      FORMULARIO AGREGAR       //
    //===============================//

        protected void btnAbrirModalAgregar_Click(object sender, EventArgs e)
        {
            LimpiarFormulario();
            hfIdPaciente.Value = "";

            lblTituloFormulario.Text = "Agregar paciente";
            lblSubtituloFormulario.Text = "Complete los datos del paciente";

            btnAgregarPaciente.Visible = true;
            btnModificarPaciente.Visible = false;

            pnlModalFormulario.Visible = true;
        }

        protected void btnAgregarPaciente_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            Entidades.Pacientes paciente = ObtenerPacienteFormulario();

            if (negocioP.AgregarPaciente(paciente))
                CerrarModalPaciente();
        }


    //===============================// 
    //     FORMULARIO MODIFICAR      //
    //===============================//

        private void AbrirModalModificar(string idPaciente)
        {
            LimpiarFormulario();

            int id = Convert.ToInt32(idPaciente);

            DataTable tabla = negocioP.getPacientePorID(id);

            if (tabla.Rows.Count == 0)
                return;

            DataRow fila = tabla.Rows[0];

            CargarPacienteFormulario(fila);

            lblTituloFormulario.Text = "Modificar paciente";
            lblSubtituloFormulario.Text = "Actualice los datos del paciente seleccionado";

            btnAgregarPaciente.Visible = false;
            btnModificarPaciente.Visible = true;

            pnlModalFormulario.Visible = true;
        }

        protected void btnModificarPaciente_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            Entidades.Pacientes paciente = ObtenerPacienteFormulario();
            paciente.IDPaciente = Convert.ToInt32(hfIdPaciente.Value);

            if (negocioP.ModificarPaciente(paciente))
                CerrarModalPaciente();
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
    //          VALIDADORES          //
    //===============================//

        protected void cvDniRepetido_ServerValidate(object source, ServerValidateEventArgs args)
        {
            ValidarDatoRepetido(args, negocioP.existeDNI);
        }

        protected void cvCorreoRepetido_ServerValidate(object source, ServerValidateEventArgs args)
        {
            ValidarDatoRepetido(args, negocioP.existeCorreo);
        }

        protected void cvTelefonoRepetido_ServerValidate(object source, ServerValidateEventArgs args)
        {
            ValidarDatoRepetido(args, negocioP.existeTelefono);
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


    //===============================// 
    //       METODOS AUXILIARES      //
    //===============================//

        private void LimpiarFormulario()
        {
            util.LimpiarControles(
                txtDni,
                txtNombre,
                txtApellido,
                txtFechaNacimiento,
                txtTelefono,
                txtCorreo,
                txtDireccion,
                ddlSexo,
                ddlNacionalidad,
                ddlProvincia
            );

            util.LimpiarDDL(ddlLocalidad, "Seleccione localidad");
            ddlLocalidad.Enabled = false;
        }

        private int ObtenerIDPaciente()
        {
            if (string.IsNullOrWhiteSpace(hfIdPaciente.Value))
                return 0;

            return Convert.ToInt32(hfIdPaciente.Value);
        }

        private void ValidarDatoRepetido(ServerValidateEventArgs args, Func<string, int, bool> existe)
        {
            int idPaciente = ObtenerIDPaciente();

            args.IsValid = !existe(args.Value.Trim(), idPaciente);
        }

        private void CerrarModalPaciente()
        {
            pnlModalFormulario.Visible = false;
            hfIdPaciente.Value = "";
            LimpiarFormulario();
            CargarGrillaPacientes();
        }


    //===============================// 
    //        CARGA DE DATOS         //
    //===============================//

        private Entidades.Pacientes ObtenerPacienteFormulario()
        {
            Entidades.Pacientes paciente = new Entidades.Pacientes();

            paciente.DNI = txtDni.Text.Trim();
            paciente.Nombre = txtNombre.Text.Trim();
            paciente.Apellido = txtApellido.Text.Trim();
            paciente.Sexo = Convert.ToChar(ddlSexo.SelectedValue);
            paciente.IDNacionalidad = Convert.ToInt32(ddlNacionalidad.SelectedValue);
            paciente.FechaNacimiento = Convert.ToDateTime(txtFechaNacimiento.Text);
            paciente.IDLocalidad = Convert.ToInt32(ddlLocalidad.SelectedValue);
            paciente.Telefono = txtTelefono.Text.Trim();
            paciente.Correo = txtCorreo.Text.Trim();
            paciente.Direccion = txtDireccion.Text.Trim();

            return paciente;
        }

        private void CargarPacienteFormulario(DataRow fila)
        {
            hfIdPaciente.Value = fila["ID"].ToString();

            txtDni.Text = fila["DNI"].ToString();
            txtNombre.Text = fila["Nombre"].ToString();
            txtApellido.Text = fila["Apellido"].ToString();
            txtTelefono.Text = fila["Telefono"].ToString();
            txtCorreo.Text = fila["Correo"].ToString();
            txtDireccion.Text = fila["Direccion"].ToString();

            DateTime fecha = Convert.ToDateTime(fila["FechaNacimiento"]);
            txtFechaNacimiento.Text = fecha.ToString("yyyy-MM-dd");

            util.SeleccionarDDL(ddlSexo, fila["Sexo"].ToString());
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