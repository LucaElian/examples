using System;
using Entidades;
using Negocio;
using System.Web.UI.WebControls;

namespace Vistas
{
    public partial class Login : System.Web.UI.Page
    {
        NegocioUsuario negocioU = new NegocioUsuario();

        protected void Page_Load(object sender, EventArgs e)
        {}


    //===============================//
    //    REESTABLECER CONTRASENIA   //
    //===============================//

        protected void lbtnAbrirModalRestablecerContrasenia_Click(object sender, EventArgs e)
        {
            LimpiarModal();
            pnlModalRestablecerContrasenia.Visible = true;
        }

        protected void lbtnCerrarModalRestablecer_Click(object sender, EventArgs e)
        {
            CerrarModal();
        }

        protected void btnCancelarRestablecer_Click(object sender, EventArgs e)
        {
            CerrarModal();
        }

        protected void btnRestablecerContrasenia_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            bool contraseniaActualizada = negocioU.restablecerContrasenia(txtUsuarioRecuperacion.Text, txtNuevaContrasenia.Text);

            if (contraseniaActualizada)
            {
                MostrarMensaje("La contraseña fue actualizada correctamente.", true);
                LimpiarCampos();
                return;
            }

            MostrarMensaje("No se pudo actualizar la contraseña.", false);
        }


    //===============================//
    //          VALIDADORES          //
    //===============================//

        protected void cvUsuarioRecuperacion_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (string.IsNullOrWhiteSpace(args.Value))
            {
                args.IsValid = true;
                return;
            }

            args.IsValid = negocioU.existeUsuarioActivo(args.Value);
        }


    //===============================//
    //             LOGIN             // 
    //===============================//

        protected void btnIngresar_Click(object sender, EventArgs e)
        {
            lblMensaje.Visible = false;

            if(!Page.IsValid)
                return;

            Usuarios usuario = negocioU.validarLogin(txtUser.Text, txtPassword.Text);

            if (usuario == null)
            {
                lblMensaje.Visible = true;
                return;
            }

            Session["IDUsuario"] = usuario.IDUsuario;
            Session["NombreUsuario"] = usuario.NombreUsuario;
            Session["Rol"] = usuario.Rol;
            Session["NombreCompleto"] = usuario.NombreCompleto;

            if (negocioU.esAdministrador(usuario))
            {
                Response.Redirect("~/Admin Visual/InicioAdmin.aspx");
                return;
            }

            if (negocioU.esMedico(usuario))
            {
                Session["IDMedico"] = usuario.IDMedicoUsuario;
                Response.Redirect("~/Medico Visual/InicioMedico.aspx");
                return;
            }
        }


    //===============================//
    //       METODOS AUXILIARES      //
    //===============================//

        private void CerrarModal()
        {
            pnlModalRestablecerContrasenia.Visible = false;
            LimpiarModal();
        }

        private void LimpiarModal()
        {
            LimpiarCampos();
            OcultarModal();
        }

        private void LimpiarCampos()
        {
            txtUsuarioRecuperacion.Text = "";
            txtNuevaContrasenia.Text = "";
            txtRepetirContrasenia.Text = "";
        }

        private void OcultarModal()
        {
            pnlMensajeRecuperacion.Visible = false;
            lblMensajeRecuperacion.Text = "";
        }

        private void MostrarMensaje(string mensaje, bool exito)
        {
            pnlMensajeRecuperacion.Visible = true;

            pnlMensajeRecuperacion.CssClass = exito ? "abml-message login-message-success" : "abml-message login-message-error";
            lblMensajeRecuperacion.Text = mensaje;
        }
    }
}
