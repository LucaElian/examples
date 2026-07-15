using System;
using Entidades;
using Negocio;

namespace Vistas
{
    public partial class Login : System.Web.UI.Page
    {
        NegocioUsuario negocio = new NegocioUsuario();

        protected void Page_Load(object sender, EventArgs e)
        {}

        protected void btnIngresar_Click(object sender, EventArgs e)
        {
            lblMensaje.Visible = false;

            if(!Page.IsValid)
                return;

            Usuarios usuario = negocio.validarLogin(txtUser.Text, txtPassword.Text);

            if (usuario == null)
            {
                lblMensaje.Visible = true;
                return;
            }

            Session["IDUsuario"] = usuario.IDUsuario;
            Session["NombreUsuario"] = usuario.NombreUsuario;
            Session["Rol"] = usuario.Rol;
            Session["NombreCompleto"] = usuario.NombreCompleto;

            if (negocio.esAdministrador(usuario))
            {
                Response.Redirect("~/Admin Visual/InicioAdmin.aspx");
                return;
            }

            if (negocio.esMedico(usuario))
            {
                Session["IDMedico"] = usuario.IDMedicoUsuario;
                Response.Redirect("~/Medico Visual/InicioMedico.aspx");
                return;
            }
        }
    }
}