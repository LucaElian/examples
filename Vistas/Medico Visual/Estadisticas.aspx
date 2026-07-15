<%@ Page Title="Estadísticas" Language="C#" MasterPageFile="~/Panel.Master" AutoEventWireup="true" CodeBehind="Estadisticas.aspx.cs" Inherits="Vistas.Estadisticas" %>

<asp:Content ID="ContentTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Estadísticas
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="MainContent" runat="server">

    <asp:Panel ID="pnlEstadisticas" runat="server" CssClass="inicio-container abml-container">

        <asp:Panel ID="pnlListadoEstadisticas" runat="server" CssClass="panel-card abml-list-panel">

            <asp:Panel ID="pnlHeaderListado" runat="server" CssClass="panel-header compact">

                <asp:Panel ID="pnlTituloListado" runat="server">

                    <asp:Label
                        ID="lblTituloListado"
                        runat="server"
                        Text="Estadísticas por paciente"
                        CssClass="panel-title">
                    </asp:Label>

                    <asp:Label
                        ID="lblSubtituloListado"
                        runat="server"
                        Text="Cantidad de asistencias presentes y ausentes de los pacientes atendidos"
                        CssClass="panel-subtitle">
                    </asp:Label>

                </asp:Panel>

                <asp:Panel ID="pnlTotalListado" runat="server" CssClass="panel-total">

                    <asp:Label
                        ID="lblTotalListadoTexto"
                        runat="server"
                        Text="Total"
                        CssClass="panel-total-label">
                    </asp:Label>

                    <asp:Label
                        ID="lblCantidadListado"
                        runat="server"
                        Text="0 pacientes"
                        CssClass="panel-total-number">
                    </asp:Label>

                </asp:Panel>

            </asp:Panel>


            <!-- BUSCADOR -->
            <asp:Panel ID="pnlBuscadorEstadisticas" runat="server" CssClass="abml-toolbar">

                <asp:Panel ID="pnlSearchEstadisticas" runat="server" CssClass="abml-search-area">

                    <asp:DropDownList
                        ID="ddlCampoBusqueda"
                        runat="server"
                        CssClass="form-control abml-search-select">
                        <asp:ListItem Text="Paciente" Value="Paciente"></asp:ListItem>
                        <asp:ListItem Text="DNI" Value="DNI"></asp:ListItem>
                    </asp:DropDownList>

                    <asp:TextBox
                        ID="txtFiltroEstadisticas"
                        runat="server"
                        CssClass="form-control abml-search-input"
                        placeholder="Ingrese búsqueda">
                    </asp:TextBox>

                    <asp:LinkButton
                        ID="lbtnBuscarEstadisticas"
                        runat="server"
                        CssClass="abml-search-icon"
                        Text="<i class='bi bi-search'></i>"
                        CausesValidation="False"
                        OnClick="lbtnBuscarEstadisticas_Click"
                        ValidationGroup="GFiltro">
                    </asp:LinkButton>

                </asp:Panel>

                <asp:Panel ID="pnlAccionesFiltro" runat="server" CssClass="abml-toolbar-actions">

                    <asp:Button
                        ID="btnMostrarTodos"
                        runat="server"
                        Text="Todos"
                        CssClass="btn btn-panel-secondary"
                        CausesValidation="False"
                        OnClick="btnMostrarTodos_Click" />

                </asp:Panel>

            </asp:Panel>


            <asp:Panel ID="pnlMensajeListado" runat="server" CssClass="abml-list-message" Visible="False">
                <asp:Label ID="lblMensajeListado" runat="server" Text=""></asp:Label>
            </asp:Panel>


            <!-- TABLA -->
            <asp:Panel ID="pnlTablaEstadisticas" runat="server" CssClass="table-responsive abml-table-wrapper">

                <asp:GridView
                    ID="gvEstadisticas"
                    runat="server"
                    CssClass="table abml-table"
                    AutoGenerateColumns="False"
                    GridLines="None"
                    DataKeyNames="DNI"
                    AllowPaging="True"
                    PageSize="15"
                    ShowHeaderWhenEmpty="True"
                    EmptyDataText="No hay estadísticas para mostrar."
                    OnPageIndexChanging="gvEstadisticas_PageIndexChanging">

                    <PagerSettings Mode="NumericFirstLast" FirstPageText="Primera" LastPageText="Última" />
                    <PagerStyle CssClass="abml-pager" />

                    <Columns>

                        <asp:BoundField DataField="Paciente" HeaderText="Paciente" />
                        <asp:BoundField DataField="DNI" HeaderText="DNI" />
                        <asp:BoundField DataField="Presentes" HeaderText="Presentes" />
                        <asp:BoundField DataField="Ausentes" HeaderText="Ausentes" />
                        <asp:BoundField DataField="Total" HeaderText="Total" />
                        <asp:BoundField DataField="PresentismoTexto" HeaderText="Presentismo %" />
                        <asp:BoundField DataField="UltimoTurnoTexto" HeaderText="Último turno" />

                    </Columns>

                </asp:GridView>

            </asp:Panel>

        </asp:Panel>

    </asp:Panel>

</asp:Content>