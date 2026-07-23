using System;
using System.Data;
using System.Web.UI.WebControls;
using Negocio;

namespace Vistas
{
    public partial class Historial : PaginaMedico
    {
        NegocioTurno negocioT = new NegocioTurno();

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
                CargarGrillaHistorial();
        }


    //===============================// 
    //       CARGAS INICIALES        //
    //===============================//

        private void CargarGrillaHistorial()
        {
            int idMedico = ObtenerIDMedicoLogueado();
            string campo = ddlCampoBusqueda.SelectedValue;
            string busqueda = txtFiltroHistorial.Text.Trim();
            string asistencia = ddlFiltroAsistencia.SelectedValue;

            DataTable tabla = negocioT.getHistorialMedico(idMedico, campo, busqueda, asistencia);

            gvHistorial.DataSource = tabla;
            gvHistorial.DataBind();

            lblCantidadListado.Text = tabla.Rows.Count + " registros";
        }


    //===============================// 
    //       EVENTOS DE LISTADO      //
    //===============================//

        protected void lbtnBuscarHistorial_Click(object sender, EventArgs e)
        {
            gvHistorial.PageIndex = 0;
            CargarGrillaHistorial();
        }

        protected void btnMostrarTodos_Click(object sender, EventArgs e)
        {
            txtFiltroHistorial.Text = "";
            ddlCampoBusqueda.SelectedValue = "ID";
            ddlFiltroAsistencia.SelectedValue = "";
            gvHistorial.PageIndex = 0;

            CargarGrillaHistorial();
        }


    //===============================// 
    //      EVENTOS DE GRIDVIEW      //
    //===============================//

        protected void gvHistorial_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvHistorial.PageIndex = e.NewPageIndex;
            CargarGrillaHistorial();
        }


    //===============================// 
    //      EVENTOS DE DROPDOWN      //
    //===============================//

        protected void ddlFiltroAsistencia_SelectedIndexChanged(object sender, EventArgs e)
        {
            gvHistorial.PageIndex = 0;
            CargarGrillaHistorial();
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
