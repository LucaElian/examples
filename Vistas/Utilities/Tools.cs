using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Vistas.Utilities
{
    public class Tools
    {
        public void CargarDDL(DropDownList ddl, DataTable tabla, string texto, string valor, string textoDefault)
        {
            ddl.DataSource = tabla;
            ddl.DataTextField = texto;
            ddl.DataValueField = valor;
            ddl.DataBind();

            ddl.Items.Insert(0, new ListItem($"--{textoDefault}--", ""));
        }

        public void LimpiarDDL(DropDownList ddl, string textoDefault)
        {
            ddl.Items.Clear();
            ddl.Items.Insert(0, new ListItem($"--{textoDefault}--", ""));
        }

        public void SeleccionarDDL(DropDownList ddl, string valor)
        {
            if (ddl.Items.FindByValue(valor) != null)
                ddl.SelectedValue = valor;
        }

        public void LimpiarControles(params Control[] controles)
        {
            foreach (Control control in controles)
            {
                if (control is TextBox txt)
                    txt.Text = "";
                else if (control is DropDownList ddl)
                    ddl.SelectedIndex = 0;
            }
        }

        public TimeSpan ObtenerHora(DropDownList ddlHora, DropDownList ddlMinuto)
        {
            return new TimeSpan(
                Convert.ToInt32(ddlHora.SelectedValue),
                Convert.ToInt32(ddlMinuto.SelectedValue),
                0
            );
        }
    }
}