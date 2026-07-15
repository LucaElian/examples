using System;
using Negocio;

namespace Vistas
{
    public partial class Informes : System.Web.UI.Page
    {
        NegocioTurno negocioT = new NegocioTurno();
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                CargarInformes();
        }

        private void CargarInformes()
        {
            CargarReporte1();
            CargarReporte2();
        }

        private void CargarReporte1()
        {
            lblReporte1Cantidad.Text = negocioT.getDiaMayorDemandaJunio();
        }

        private void CargarReporte2()
        {
            lblReporte2Cantidad.Text = negocioT.getMedicoMayorTurnosJunio();
        }
    }
}