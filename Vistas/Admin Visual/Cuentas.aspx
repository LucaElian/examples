<%@ Page Title="Cuentas" Language="C#" MasterPageFile="~/Panel.Master" AutoEventWireup="true" CodeBehind="Cuentas.aspx.cs" Inherits="Vistas.Cuentas" %>

<asp:Content ID="ContentTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Cuentas
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="MainContent" runat="server">

    <asp:Panel ID="pnlCuentas" runat="server" CssClass="inicio-container abml-container">

        <!-- LISTADO -->
        <asp:Panel ID="pnlListadoCuentas" runat="server" CssClass="panel-card abml-list-panel">

            <asp:Panel ID="pnlHeaderListado" runat="server" CssClass="panel-header compact">

                <asp:Panel ID="pnlTituloListado" runat="server">

                    <asp:Label
                        ID="lblTituloListado"
                        runat="server"
                        Text="Cuentas"
                        CssClass="panel-title">
                    </asp:Label>

                    <asp:Label
                        ID="lblSubtituloListado"
                        runat="server"
                        Text="Se muestran hasta 8 cuentas por página"
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
            <asp:Panel ID="pnlBuscadorCuentas" runat="server" CssClass="abml-toolbar">

                <asp:Panel ID="pnlSearchCuenta" runat="server" CssClass="abml-search-area">

                    <asp:DropDownList
                        ID="ddlCampoBusqueda"
                        runat="server"
                        CssClass="form-control abml-search-select">
                        <asp:ListItem Text="ID" Value="ID"></asp:ListItem>
                        <asp:ListItem Text="Nombre completo" Value="NombreCompleto"></asp:ListItem>
                        <asp:ListItem Text="ID Médico" Value="IDMedico"></asp:ListItem>
                        <asp:ListItem Text="Usuario" Value="Usuario"></asp:ListItem>
                        <asp:ListItem Text="Rol" Value="Rol"></asp:ListItem>
                    </asp:DropDownList>

                    <asp:TextBox
                        ID="txtFiltroCuenta"
                        runat="server"
                        CssClass="form-control abml-search-input"
                        placeholder="Ingrese búsqueda">
                    </asp:TextBox>

                    <asp:LinkButton
                        ID="lbtnBuscarCuenta"
                        runat="server"
                        CssClass="abml-search-icon"
                        Text="<i class='bi bi-search'></i>"
                        CausesValidation="False"
                        OnClick="lbtnBuscarCuenta_Click"
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


            <!-- TABLA -->
            <asp:Panel ID="pnlTablaCuentas" runat="server" CssClass="table-responsive abml-table-wrapper">

                <asp:GridView
                    ID="gvCuentas"
                    runat="server"
                    CssClass="table abml-table"
                    AutoGenerateColumns="False"
                    GridLines="None"
                    DataKeyNames="ID"
                    AllowPaging="True"
                    PageSize="8"
                    ShowHeaderWhenEmpty="True"
                    EmptyDataText="No hay cuentas cargadas para mostrar."
                    OnPageIndexChanging="gvCuentas_PageIndexChanging">

                    <PagerSettings Mode="NumericFirstLast" FirstPageText="Primera" LastPageText="Última" />
                    <PagerStyle CssClass="abml-pager" />

                    <Columns>

                        <asp:BoundField DataField="ID" HeaderText="ID" />
                        <asp:BoundField DataField="NombreCompleto" HeaderText="Nombre completo" />
                        <asp:BoundField DataField="IDMedico" HeaderText="ID Médico" />
                        <asp:BoundField DataField="Usuario" HeaderText="Usuario" />
                        <asp:BoundField DataField="Rol" HeaderText="Rol" />

                        <asp:TemplateField HeaderText="Estado">
                            <ItemTemplate>
                                <asp:Label
                                    ID="lblEstado"
                                    runat="server"
                                    Text='<%# Eval("EstadoTexto") %>'
                                    CssClass='<%# Eval("EstadoCSS") %>'>
                                </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>

                </asp:GridView>

            </asp:Panel>

        </asp:Panel>

    </asp:Panel>

</asp:Content>