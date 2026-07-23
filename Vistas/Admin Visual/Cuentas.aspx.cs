using System;
using System.Data;
using System.Web.UI.WebControls;
using Negocio;

namespace Vistas
{
    public partial class Cuentas : PaginaAdmin
    {
        NegocioUsuario negocioU = new NegocioUsuario();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                CargarGrillaCuentas();
        }


    //===============================// 
    //       CARGAS INICIALES        //
    //===============================//

        private void CargarGrillaCuentas()
        {
            string campo = ddlCampoBusqueda.SelectedValue;
            string busqueda = txtFiltroCuenta.Text.Trim();

            DataTable tabla = negocioU.getTablaUsuarios(campo, busqueda);

            gvCuentas.DataSource = tabla;
            gvCuentas.DataBind();

            lblCantidadListado.Text = tabla.Rows.Count + " registros";
        }


    //===============================// 
    //       EVENTOS DE LISTADO      //
    //===============================//

        protected void lbtnBuscarCuenta_Click(object sender, EventArgs e)
        {
            gvCuentas.PageIndex = 0;
            CargarGrillaCuentas();
        }

        protected void btnMostrarTodos_Click(object sender, EventArgs e)
        {
            txtFiltroCuenta.Text = "";
            ddlCampoBusqueda.SelectedValue = "ID";
            gvCuentas.PageIndex = 0;

            CargarGrillaCuentas();
        }


    //===============================// 
    //      EVENTOS DE GRIDVIEW      //
    //===============================//

        protected void gvCuentas_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvCuentas.PageIndex = e.NewPageIndex;
            CargarGrillaCuentas();
        }
    }
}
