using System;
using System.Web.UI;

namespace Vistas
{
    public abstract class PaginaProtegida : Page
    {
        protected abstract string RolRequerido { get; }

        protected virtual bool RequiereMedicoLogueado
        {
            get { return false; }
        }

        protected int IDMedicoLogueado
        {
            get { return Convert.ToInt32(Session["IDMedico"]); }
        }

        protected override void OnInit(EventArgs e)
        {
            ValidarAcceso();
            base.OnInit(e);
        }

        private void ValidarAcceso()
        {
            if (Session["IDUsuario"] == null || Session["Rol"] == null)
                Redirigir("~/Login.aspx");

            string rolActual = Session["Rol"].ToString();

            if (rolActual != RolRequerido)
                Redirigir(ObtenerPaginaInicio(rolActual));

            if (RequiereMedicoLogueado && Session["IDMedico"] == null)
                Redirigir("~/Login.aspx");
        }

        private string ObtenerPaginaInicio(string rol)
        {
            if (rol == "Administrador")
                return "~/Admin Visual/InicioAdmin.aspx";

            if (rol == "Medico")
                return "~/Medico Visual/InicioMedico.aspx";

            return "~/Login.aspx";
        }

        private void Redirigir(string url)
        {
            Response.Redirect(url, true);
        }
    }

    public abstract class PaginaAdmin : PaginaProtegida
    {
        protected override string RolRequerido
        {
            get { return "Administrador"; }
        }
    }

    public abstract class PaginaMedico : PaginaProtegida
    {
        protected override string RolRequerido
        {
            get { return "Medico"; }
        }

        protected override bool RequiereMedicoLogueado
        {
            get { return true; }
        }
    }
}
