using System;
using System.Data;
using System.Web.UI.WebControls;
using Negocio;

namespace Vistas
{
    public partial class Estadisticas : PaginaMedico
    {
        NegocioTurno negocioT = new NegocioTurno();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                CargarGrillaEstadisticas();
        }


    //===============================// 
    //       CARGAS INICIALES        //
    //===============================//

        private void CargarGrillaEstadisticas()
        {
            int idMedico = ObtenerIDMedicoLogueado();
            string campo = ddlCampoBusqueda.SelectedValue;
            string busqueda = txtFiltroEstadisticas.Text.Trim();

            DataTable tabla = negocioT.getEstadisticasPacientesMedico(idMedico, campo, busqueda);

            gvEstadisticas.DataSource = tabla;
            gvEstadisticas.DataBind();

            lblCantidadListado.Text = tabla.Rows.Count + " pacientes";
        }


    //===============================// 
    //       EVENTOS DE LISTADO      //
    //===============================//

        protected void lbtnBuscarEstadisticas_Click(object sender, EventArgs e)
        {
            gvEstadisticas.PageIndex = 0;
            CargarGrillaEstadisticas();
        }

        protected void btnMostrarTodos_Click(object sender, EventArgs e)
        {
            txtFiltroEstadisticas.Text = "";
            ddlCampoBusqueda.SelectedValue = "Paciente";
            gvEstadisticas.PageIndex = 0;

            CargarGrillaEstadisticas();
        }


    //===============================// 
    //      EVENTOS DE GRIDVIEW      //
    //===============================//

        protected void gvEstadisticas_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvEstadisticas.PageIndex = e.NewPageIndex;
            CargarGrillaEstadisticas();
        }


    //===============================// 
    //       METODOS AUXILIARES      //
    //===============================//

        private int ObtenerIDMedicoLogueado()
        {
            return IDMedicoLogueado;
        }
    }
}
