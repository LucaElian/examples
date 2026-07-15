<%@ Page Title="Historial" Language="C#" MasterPageFile="~/Panel.Master" AutoEventWireup="true" CodeBehind="Historial.aspx.cs" Inherits="Vistas.Historial" %>

<asp:Content ID="ContentTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Historial
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="MainContent" runat="server">

    <asp:Panel ID="pnlHistorial" runat="server" CssClass="inicio-container abml-container">

        <asp:Panel ID="pnlListadoHistorial" runat="server" CssClass="panel-card abml-list-panel">

            <asp:Panel ID="pnlHeaderListado" runat="server" CssClass="panel-header compact">

                <asp:Panel ID="pnlTituloListado" runat="server">

                    <asp:Label
                        ID="lblTituloListado"
                        runat="server"
                        Text="Historial de turnos"
                        CssClass="panel-title">
                    </asp:Label>

                    <asp:Label
                        ID="lblSubtituloListado"
                        runat="server"
                        Text="Turnos pasados registrados como presentes o ausentes"
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
                        Text="0 registros"
                        CssClass="panel-total-number">
                    </asp:Label>

                </asp:Panel>

            </asp:Panel>


            <!-- BUSCADOR -->
            <asp:Panel ID="pnlBuscadorHistorial" runat="server" CssClass="abml-toolbar">

                <asp:Panel ID="pnlSearchHistorial" runat="server" CssClass="abml-search-area">

                    <asp:DropDownList
                        ID="ddlCampoBusqueda"
                        runat="server"
                        CssClass="form-control abml-search-select">
                        <asp:ListItem Text="ID Turno" Value="ID"></asp:ListItem>
                        <asp:ListItem Text="Paciente" Value="Paciente"></asp:ListItem>
                        <asp:ListItem Text="DNI" Value="DNI"></asp:ListItem>
                        <asp:ListItem Text="Fecha" Value="Fecha"></asp:ListItem>
                    </asp:DropDownList>

                    <asp:TextBox
                        ID="txtFiltroHistorial"
                        runat="server"
                        CssClass="form-control abml-search-input"
                        placeholder="Ingrese búsqueda">
                    </asp:TextBox>

                    <asp:LinkButton
                        ID="lbtnBuscarHistorial"
                        runat="server"
                        CssClass="abml-search-icon"
                        Text="<i class='bi bi-search'></i>"
                        CausesValidation="False"
                        OnClick="lbtnBuscarHistorial_Click"
                        ValidationGroup="GFiltro">
                    </asp:LinkButton>

                </asp:Panel>

                <asp:Panel ID="pnlAccionesFiltro" runat="server" CssClass="abml-toolbar-actions">

                    <asp:DropDownList
                        ID="ddlFiltroAsistencia"
                        runat="server"
                        CssClass="form-control abml-search-select"
                        AutoPostBack="True"
                        OnSelectedIndexChanged="ddlFiltroAsistencia_SelectedIndexChanged">

                        <asp:ListItem Text="Todas" Value=""></asp:ListItem>
                        <asp:ListItem Text="Presentes" Value="Presente"></asp:ListItem>
                        <asp:ListItem Text="Ausentes" Value="Ausente"></asp:ListItem>

                    </asp:DropDownList>

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
            <asp:Panel ID="pnlTablaHistorial" runat="server" CssClass="table-responsive abml-table-wrapper">

                <asp:GridView
                    ID="gvHistorial"
                    runat="server"
                    CssClass="table abml-table"
                    AutoGenerateColumns="False"
                    GridLines="None"
                    DataKeyNames="ID"
                    AllowPaging="True"
                    PageSize="15"
                    ShowHeaderWhenEmpty="True"
                    EmptyDataText="No hay turnos en el historial para mostrar."
                    OnPageIndexChanging="gvHistorial_PageIndexChanging">

                    <PagerSettings Mode="NumericFirstLast" FirstPageText="Primera" LastPageText="Última" />
                    <PagerStyle CssClass="abml-pager" />

                    <Columns>

                        <asp:BoundField DataField="ID" HeaderText="ID Turno" />
                        <asp:BoundField DataField="FechaTexto" HeaderText="Fecha" />
                        <asp:BoundField DataField="HoraTexto" HeaderText="Hora" />
                        <asp:BoundField DataField="Paciente" HeaderText="Paciente" />
                        <asp:BoundField DataField="DNI" HeaderText="DNI" />

                        <asp:TemplateField HeaderText="Asistencia">
                            <ItemTemplate>
                                <asp:Label
                                    ID="lblAsistencia"
                                    runat="server"
                                    Text='<%# Eval("AsistenciaTexto") %>'
                                    CssClass='<%# Eval("AsistenciaCSS") %>'>
                                </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="Observacion" HeaderText="Observación" />

                    </Columns>

                </asp:GridView>

            </asp:Panel>

        </asp:Panel>

    </asp:Panel>

</asp:Content>