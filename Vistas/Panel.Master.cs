using System;
using System.Web.UI;

namespace Vistas
{
    public partial class Panel : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ConfigurarFecha();
                ConfigurarSidebar();
            }
        }

        private void ConfigurarFecha()
        {
            lblFechaMaster.Text = DateTime.Now.ToString("dd/MM/yyyy");
        }

        private void ConfigurarSidebar()
        {
            string rol = "";
            string nombreUsuario = "Usuario";

            if (Session["Rol"] != null)
                rol = Session["Rol"].ToString();

            if (Session["NombreCompleto"] != null)
                nombreUsuario = Session["NombreCompleto"].ToString();

            if (rol == "Administrador")
            {
                pnlMenuAdmin.Visible = true;
                pnlMenuMedico.Visible = false;
                lbtnIngresarTurno.Visible = true;

                lblRolUsuario.Text = "ADMINISTRADOR";
            }

            else if (rol == "Medico")
            {
                pnlMenuAdmin.Visible = false;
                pnlMenuMedico.Visible = true;
                lbtnIngresarTurno.Visible = false;

                lblRolUsuario.Text = "MEDICO";
            }

            else
            {
                pnlMenuAdmin.Visible = false;
                pnlMenuMedico.Visible = false;
                lbtnIngresarTurno.Visible = false;

                lblRolUsuario.Text = "SIN ROL";
            }

            lblNombreUsuario.Text = nombreUsuario;  
        }

        protected void lbtnInicioPanel_Click(object sender, EventArgs e)
        {
            string rol = "";

            if (Session["Rol"] != null)
                rol = Session["Rol"].ToString();
            else
                rol = lblRolUsuario.Text;

            if (rol == "Administrador")
                Response.Redirect("~/Admin Visual/InicioAdmin.aspx");
            else if (rol == "Medico")
                Response.Redirect("~/Medico Visual/InicioMedico.aspx");
            else
                Response.Redirect("~/Login.aspx");
        }

        protected void lbtnCerrarSesion_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();

            Response.Redirect("~/Login.aspx");
        }

        protected void lbtnIngresarTurno_Click(object sender, EventArgs e)
        {
            ucModalCrearTurno.Abrir();
        }
    }
}
