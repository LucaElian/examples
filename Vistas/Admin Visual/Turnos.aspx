<%@ Page Title="Turnos" Language="C#" MasterPageFile="~/Panel.Master" AutoEventWireup="true" CodeBehind="Turnos.aspx.cs" Inherits="Vistas.Turnos" %>

<asp:Content ID="ContentTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Turnos
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="MainContent" runat="server">

    <asp:Panel ID="pnlTurnos" runat="server" CssClass="inicio-container abml-container">

        <!-- LISTADO -->
        <asp:Panel ID="pnlListadoTurnos" runat="server" CssClass="panel-card abml-list-panel">

            <asp:Panel ID="pnlHeaderListado" runat="server" CssClass="panel-header compact">

                <asp:Panel ID="pnlTituloListado" runat="server">

                    <asp:Label
                        ID="lblTituloListado"
                        runat="server"
                        Text="Turnos"
                        CssClass="panel-title">
                    </asp:Label>

                    <asp:Label
                        ID="lblSubtituloListado"
                        runat="server"
                        Text="Se muestran hasta 8 turnos por página"
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
            <asp:Panel ID="pnlBuscadorTurnos" runat="server" CssClass="abml-toolbar">

                <asp:Panel ID="pnlSearchTurno" runat="server" CssClass="abml-search-area">

                    <asp:DropDownList
                        ID="ddlCampoBusqueda"
                        runat="server"
                        CssClass="form-control abml-search-select">
                        <asp:ListItem Text="ID" Value="ID"></asp:ListItem>
                        <asp:ListItem Text="Paciente" Value="Paciente"></asp:ListItem>
                        <asp:ListItem Text="Médico" Value="Medico"></asp:ListItem>
                        <asp:ListItem Text="Asistencia" Value="Asistencia"></asp:ListItem>
                        <asp:ListItem Text="Fecha" Value="Fecha"></asp:ListItem>
                    </asp:DropDownList>

                    <asp:TextBox
                        ID="txtFiltroTurno"
                        runat="server"
                        CssClass="form-control abml-search-input"
                        placeholder="Ingrese búsqueda">
                    </asp:TextBox>

                    <asp:LinkButton
                        ID="lbtnBuscarTurno"
                        runat="server"
                        CssClass="abml-search-icon"
                        Text="<i class='bi bi-search'></i>"
                        CausesValidation="False"
                        OnClick="lbtnBuscarTurno_Click"
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
            <asp:Panel ID="pnlTablaTurnos" runat="server" CssClass="table-responsive abml-table-wrapper">

                <asp:GridView
                    ID="gvTurnos"
                    runat="server"
                    CssClass="table abml-table"
                    AutoGenerateColumns="False"
                    GridLines="None"
                    DataKeyNames="ID"
                    AllowPaging="True"
                    PageSize="8"
                    ShowHeaderWhenEmpty="True"
                    EmptyDataText="No hay turnos cargados para mostrar."
                    OnPageIndexChanging="gvTurnos_PageIndexChanging"
                    OnRowCommand="gvTurnos_RowCommand">

                    <PagerSettings Mode="NumericFirstLast" FirstPageText="Primera" LastPageText="Última" />
                    <PagerStyle CssClass="abml-pager" />

                    <Columns>

                        <asp:BoundField DataField="ID" HeaderText="ID Turno" />
                        <asp:BoundField DataField="Paciente" HeaderText="Paciente" />
                        <asp:BoundField DataField="Medico" HeaderText="Médico" />
                        <asp:BoundField DataField="FechaTexto" HeaderText="Fecha" />
                        <asp:BoundField DataField="HoraTexto" HeaderText="Hora" />
                        <asp:BoundField DataField="Asistencia" HeaderText="Asistencia" />

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

                        <asp:TemplateField HeaderText="Acciones">
                            <ItemTemplate>

                                <asp:Panel ID="pnlAccionesTurno" runat="server" CssClass="grid-actions">

                                    <asp:LinkButton
                                        ID="lbtnEditarTurno"
                                        runat="server"
                                        Text="<i class='bi bi-pencil-square'></i>"
                                        ToolTip="Modificar turno"
                                        CssClass="grid-action-btn action-edit"
                                        CommandName="EditarTurno"
                                        CommandArgument='<%# Eval("ID") %>'
                                        CausesValidation="False">
                                    </asp:LinkButton>

                                    <asp:LinkButton
                                        ID="lbtnCambiarEstadoTurno"
                                        runat="server"
                                        Text='<%# Convert.ToBoolean(Eval("Estado")) ? "<i class=\"bi bi-x-circle\"></i>" : "<i class=\"bi bi-check-circle\"></i>" %>'
                                        ToolTip='<%# Convert.ToBoolean(Eval("Estado")) ? "Desactivar turno" : "Activar turno" %>'
                                        CssClass='<%# Convert.ToBoolean(Eval("Estado")) ? "grid-action-btn action-disable" : "grid-action-btn action-active" %>'
                                        CommandName="CambiarEstadoTurno"
                                        CommandArgument='<%# Eval("ID").ToString() + "|" + Eval("Estado").ToString() %>'
                                        CausesValidation="False">
                                    </asp:LinkButton>

                                </asp:Panel>

                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>

                </asp:GridView>

            </asp:Panel>

        </asp:Panel>


        <!-- MODAL / VENTANA PARA MODIFICAR -->
        <asp:Panel ID="pnlModalFormulario" runat="server" CssClass="abml-modal-overlay" Visible="False">

            <asp:Panel ID="pnlModalTurno" runat="server" CssClass="abml-modal">

                <asp:Panel ID="pnlModalHeader" runat="server" CssClass="abml-modal-header">

                    <asp:Panel ID="pnlModalTitulo" runat="server">

                        <asp:Label
                            ID="lblTituloFormulario"
                            runat="server"
                            Text="Modificar turno"
                            CssClass="abml-modal-title">
                        </asp:Label>

                        <asp:Label
                            ID="lblSubtituloFormulario"
                            runat="server"
                            Text="Actualice los datos del turno seleccionado"
                            CssClass="abml-modal-subtitle">
                        </asp:Label>

                    </asp:Panel>

                    <asp:LinkButton
                        ID="lbtnCerrarModal"
                        runat="server"
                        Text="<i class='bi bi-x-lg'></i>"
                        CssClass="abml-modal-close"
                        CausesValidation="False"
                        OnClick="lbtnCerrarModal_Click">
                    </asp:LinkButton>

                </asp:Panel>


                <asp:HiddenField ID="hfIdTurno" runat="server" />


                <asp:Panel ID="pnlFormularioGrid" runat="server" CssClass="abml-form-grid">

                    <asp:Panel ID="pnlCampoPaciente" runat="server" CssClass="form-field">
                        <asp:Label ID="lblPaciente" runat="server" Text="Paciente" CssClass="form-label"></asp:Label>

                        <asp:DropDownList 
                            ID="ddlPaciente" 
                            runat="server" 
                            CssClass="form-control select2-turno">
                            <asp:ListItem 
                                Text="--Seleccione paciente--" 
                                Value="">
                            </asp:ListItem>
                        </asp:DropDownList>

                        <asp:RequiredFieldValidator
                            ID="rfvPaciente"
                            runat="server"
                            ControlToValidate="ddlPaciente"
                            InitialValue=""
                            ErrorMessage="Seleccione un paciente."
                            CssClass="text-danger"
                            Display="Dynamic"
                            ValidationGroup="GTurno"
                            Font-Bold="True"
                            EnableClientScript="False">
                        </asp:RequiredFieldValidator>
                    </asp:Panel>


                    <asp:Panel ID="pnlCampoEspecialidad" runat="server" CssClass="form-field">
                        <asp:Label ID="lblEspecialidad" runat="server" Text="Especialidad" CssClass="form-label"></asp:Label>

                        <asp:DropDownList
                            ID="ddlEspecialidad"
                            runat="server"
                            CssClass="form-control select2-turno"
                            AutoPostBack="True"
                            OnSelectedIndexChanged="ddlEspecialidad_SelectedIndexChanged">
                            <asp:ListItem Text="--Seleccione especialidad--" Value=""></asp:ListItem>
                        </asp:DropDownList>

                        <asp:RequiredFieldValidator
                            ID="rfvEspecialidad"
                            runat="server"
                            ControlToValidate="ddlEspecialidad"
                            InitialValue=""
                            ErrorMessage="Seleccione una especialidad."
                            CssClass="text-danger"
                            Display="Dynamic"
                            ValidationGroup="GTurno"
                            Font-Bold="True"
                            EnableClientScript="False">
                        </asp:RequiredFieldValidator>
                    </asp:Panel>


                    <asp:Panel ID="pnlCampoMedico" runat="server" CssClass="form-field">
                        <asp:Label ID="lblMedico" runat="server" Text="Médico" CssClass="form-label"></asp:Label>

                        <asp:DropDownList 
                            ID="ddlMedico" 
                            runat="server" 
                            CssClass="form-control select2-turno"
                            Enabled="False"
                            AutoPostBack="True"
                            OnSelectedIndexChanged="ddlMedico_SelectedIndexChanged">
                            <asp:ListItem Text="--Seleccione médico--" Value=""></asp:ListItem>
                        </asp:DropDownList>

                        <asp:RequiredFieldValidator
                            ID="rfvMedico"
                            runat="server"
                            ControlToValidate="ddlMedico"
                            InitialValue=""
                            ErrorMessage="Seleccione un médico."
                            CssClass="text-danger"
                            Display="Dynamic"
                            ValidationGroup="GTurno"
                            Font-Bold="True"
                            EnableClientScript="False">
                        </asp:RequiredFieldValidator>
                    </asp:Panel>


                    <asp:Panel ID="pnlCampoFecha" runat="server" CssClass="form-field">
                        <asp:Label ID="lblFecha" runat="server" Text="Fecha" CssClass="form-label"></asp:Label>

                        <asp:TextBox
                            ID="txtFecha"
                            runat="server"
                            CssClass="form-control"
                            TextMode="Date"
                            AutoPostBack="True"
                            OnTextChanged="txtFecha_TextChanged">
                        </asp:TextBox>

                        <asp:RequiredFieldValidator
                            ID="rfvFecha"
                            runat="server"
                            ControlToValidate="txtFecha"
                            ErrorMessage="Ingrese la fecha."
                            CssClass="text-danger"
                            Display="Dynamic"
                            ValidationGroup="GTurno"
                            Font-Bold="True"
                            EnableClientScript="False">
                        </asp:RequiredFieldValidator>
                    </asp:Panel>


                    <asp:Panel ID="pnlCampoHora" runat="server" CssClass="form-field">
                        <asp:Label ID="lblHora" runat="server" Text="Hora" CssClass="form-label"></asp:Label>

                        <asp:DropDownList
                            ID="ddlHoraTurno"
                            runat="server"
                            CssClass="form-control"
                            Enabled="False">
                            <asp:ListItem Text="--Seleccione horario--" Value=""></asp:ListItem>
                        </asp:DropDownList>

                    </asp:Panel>

                    <asp:Panel ID="pnlCampoAsistencia" runat="server" CssClass="form-field">
                        <asp:Label ID="lblEstadoAsistencia" runat="server" Text="Estado de asistencia" CssClass="form-label"></asp:Label>

                        <asp:DropDownList ID="ddlEstadoAsistencia" runat="server" CssClass="form-control">
                            <asp:ListItem Text="Pendiente" Value="Pendiente"></asp:ListItem>
                            <asp:ListItem Text="Presente" Value="Presente"></asp:ListItem>
                            <asp:ListItem Text="Ausente" Value="Ausente"></asp:ListItem>
                        </asp:DropDownList>
                    </asp:Panel>


                    <asp:Panel ID="pnlCampoObservacion" runat="server" CssClass="form-field form-field-wide">
                        <asp:Label ID="lblObservacion" runat="server" Text="Observación" CssClass="form-label"></asp:Label>

                        <asp:TextBox
                            ID="txtObservacion"
                            runat="server"
                            CssClass="form-control"
                            TextMode="MultiLine"
                            Rows="3"
                            placeholder="Observación del turno">
                        </asp:TextBox>
                    </asp:Panel>

                </asp:Panel>


                <asp:Panel ID="pnlMensajeTurno" runat="server" CssClass="abml-message" Visible="False">
                    <asp:Label ID="lblMensajeTurno" runat="server" Text=""></asp:Label>
                </asp:Panel>


                <asp:Panel ID="pnlBotonesFormulario" runat="server" CssClass="abml-form-actions">

                    <asp:Button
                        ID="btnModificarTurno"
                        runat="server"
                        Text="Guardar cambios"
                        CssClass="btn btn-panel-warning"
                        ValidationGroup="GTurno"
                        OnClick="btnModificarTurno_Click" />

                    <asp:Button
                        ID="btnCancelarModal"
                        runat="server"
                        Text="Cancelar"
                        CssClass="btn btn-panel-secondary"
                        CausesValidation="False"
                        OnClick="btnCancelarModal_Click" />

                </asp:Panel>
            </asp:Panel>
        </asp:Panel>
    </asp:Panel>
</asp:Content>