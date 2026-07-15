using System;
using System.Data;
using System.Web.UI.WebControls;
using Negocio;

namespace Vistas
{
    public partial class InicioMedico : System.Web.UI.Page
    {
        NegocioTurno negocioT = new NegocioTurno();
        private const int TurnosxPagina = 6;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ViewState["PaginaActual"] = 0;
                CargarTurnosPendientes();
            }
        }


    //===============================// 
    //       CARGAS INICIALES        //
    //===============================//

        private void CargarTurnosPendientes()
        {
            int idMedico = ObtenerIDMedicoLogueado();

            string campo = ddlCampoBusqueda.SelectedValue;
            string busqueda = txtBuscar.Text.Trim();

            DataTable tabla = negocioT.getTurnosPendientesMedico(idMedico, campo, busqueda);

            lblTotalTurnosHoy.Text = tabla.Rows.Count + " turnos";

            PagedDataSource paginador = new PagedDataSource();

            paginador.DataSource = tabla.DefaultView;
            paginador.AllowPaging = true;
            paginador.PageSize = TurnosxPagina;

            int paginaActual = ObtenerPaginaActual();

            if (paginaActual >= paginador.PageCount)
                paginaActual = 0;

            paginador.CurrentPageIndex = paginaActual;
            ViewState["PaginaActual"] = paginaActual;

            rptTurnosHoy.DataSource = paginador;
            rptTurnosHoy.DataBind();

            CargarPaginacion(paginador.PageCount, paginaActual);
        }


    //===============================// 
    //       EVENTOS DE LISTADO      //
    //===============================//

        protected void lbtnBuscarTurno_Click(object sender, EventArgs e)
        {
            pnlMensajeListado.Visible = false;

            ViewState["PaginaActual"] = 0;
            CargarTurnosPendientes();
        }

        protected void btnMostrarTodos_Click(object sender, EventArgs e)
        {
            txtBuscar.Text = "";
            ddlCampoBusqueda.SelectedValue = "Paciente";

            pnlMensajeListado.Visible = false;

            ViewState["PaginaActual"] = 0;
            CargarTurnosPendientes();
        }

        protected void rptTurnosHoy_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "RevisarTurno")
            {
                int idTurno = Convert.ToInt32(e.CommandArgument);

                AbrirModalRevision(idTurno);
            }
        }


    //===============================// 
    //       REVISION DE TURNO       //
    //===============================//

        private void AbrirModalRevision(int idTurno)
        {
            int idMedico = ObtenerIDMedicoLogueado();

            DataTable tabla = negocioT.getTurnoPendienteRevision(idTurno, idMedico);

            DataRow fila = tabla.Rows[0];

            hfIdTurnoRevision.Value = fila["IdTurno"].ToString();

            lblPacienteRevision.Text = fila["NombrePaciente"].ToString();
            lblDniRevision.Text = fila["DniPaciente"].ToString();
            lblFechaRevision.Text = fila["FechaTexto"].ToString();
            lblHorarioRevision.Text = fila["HoraInicio"].ToString() + " - " + fila["HoraFin"].ToString();

            ddlAsistenciaRevision.SelectedValue = "";
            txtObservacionRevision.Text = "";
            pnlObservacionRevision.Visible = false;

            pnlMensajeRevision.Visible = false;
            lblMensajeRevision.Text = "";

            pnlModalRevisarTurno.Visible = true;
        }

        protected void ddlAsistenciaRevision_SelectedIndexChanged(object sender, EventArgs e)
        {
            pnlObservacionRevision.Visible = ddlAsistenciaRevision.SelectedValue == "Presente";

            if (ddlAsistenciaRevision.SelectedValue == "Ausente")
                txtObservacionRevision.Text = "";
        }

        protected void btnGuardarRevision_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            int idTurno = Convert.ToInt32(hfIdTurnoRevision.Value);
            string asistencia = ddlAsistenciaRevision.SelectedValue;
            string observacion = "";

            if (asistencia == "Presente")
                observacion = txtObservacionRevision.Text.Trim();

            if (negocioT.revisarTurnoMedico(idTurno, asistencia, observacion))
            {
                pnlModalRevisarTurno.Visible = false;

                ViewState["PaginaActual"] = 0;
                CargarTurnosPendientes();

                MostrarMensajeListado("La revisión del turno se guardó correctamente.");
            }
            else
            {
                lblMensajeRevision.Text = "No se pudo guardar la revisión del turno.";
                pnlMensajeRevision.Visible = true;
            }
        }

        protected void btnCancelarRevision_Click(object sender, EventArgs e)
        {
            CerrarModalRevision();
        }

        protected void lbtnCerrarModalRevision_Click(object sender, EventArgs e)
        {
            CerrarModalRevision();
        }

        private void CerrarModalRevision()
        {
            hfIdTurnoRevision.Value = "";

            ddlAsistenciaRevision.SelectedValue = "";
            txtObservacionRevision.Text = "";

            pnlObservacionRevision.Visible = false;
            pnlMensajeRevision.Visible = false;
            pnlModalRevisarTurno.Visible = false;
        }


        //===============================// 
        //          PAGINACION           //
        //===============================//

        protected void lbtnPaginaAnterior_Click(object sender, EventArgs e)
        {
            int paginaActual = ObtenerPaginaActual();

            if (paginaActual > 0)
                ViewState["PaginaActual"] = paginaActual - 1;

            CargarTurnosPendientes();
        }

        protected void lbtnPaginaSiguiente_Click(object sender, EventArgs e)
        {
            int paginaActual = ObtenerPaginaActual();

            ViewState["PaginaActual"] = paginaActual + 1;

            CargarTurnosPendientes();
        }

        protected void rptPaginacion_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "CambiarPagina")
            {
                int numeroPagina = Convert.ToInt32(e.CommandArgument);

                ViewState["PaginaActual"] = numeroPagina - 1;

                CargarTurnosPendientes();
            }
        }

        private void CargarPaginacion(int cantidadPaginas, int paginaActual)
        {
            pnlPaginacionTurnos.Visible = cantidadPaginas > 1;

            if (cantidadPaginas <= 1)
                return;

            lbtnPaginaAnterior.Enabled = paginaActual > 0;
            lbtnPaginaSiguiente.Enabled = paginaActual < cantidadPaginas - 1;

            DataTable tablaPaginas = new DataTable();

            tablaPaginas.Columns.Add("NumeroPagina", typeof(int));
            tablaPaginas.Columns.Add("CssClass", typeof(string));

            for (int i = 0; i < cantidadPaginas; i++)
            {
                DataRow fila = tablaPaginas.NewRow();

                fila["NumeroPagina"] = i + 1;

                if (i == paginaActual)
                    fila["CssClass"] = "turnos-page active";
                else
                    fila["CssClass"] = "turnos-page";

                tablaPaginas.Rows.Add(fila);
            }

            rptPaginacion.DataSource = tablaPaginas;
            rptPaginacion.DataBind();
        }


        //===============================// 
        //       METODOS AUXILIARES      //
        //===============================//

        private int ObtenerPaginaActual()
        {
            if (ViewState["PaginaActual"] == null)
                return 0;

            return Convert.ToInt32(ViewState["PaginaActual"]);
        }

        private int ObtenerIDMedicoLogueado()
        {
            if (Session["IDMedico"] != null)
                return Convert.ToInt32(Session["IDMedico"]);

            return 0;
        }

        private void MostrarMensajeListado(string mensaje)
        {
            lblMensajeListado.Text = mensaje;
            pnlMensajeListado.Visible = true;
        }
    }
}