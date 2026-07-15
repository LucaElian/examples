<%@ Page Title="Inicio Médico" Language="C#" MasterPageFile="~/Panel.Master" AutoEventWireup="true" CodeBehind="InicioMedico.aspx.cs" Inherits="Vistas.InicioMedico" %>

<asp:Content ID="ContentTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Inicio
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="MainContent" runat="server">

    <asp:Panel ID="pnlMedicoDashboard" runat="server" CssClass="inicio-container">

        <asp:Panel ID="pnlBusqueda" runat="server" CssClass="search-panel medico-search-panel">

            <asp:Panel ID="pnlTituloBusquedaMedico" runat="server" CssClass="medico-search-title">

                <asp:Label
                    ID="lblTituloInicioMedico"
                    runat="server"
                    Text="Turnos pendientes"
                    CssClass="panel-title">
                </asp:Label>

                <asp:Label
                    ID="lblSubtituloInicioMedico"
                    runat="server"
                    Text="Visualización de los turnos asignados pendientes">
                </asp:Label>

            </asp:Panel>


            <asp:Panel ID="pnlControlesBusqueda" runat="server" CssClass="medico-search-controls">

                <asp:DropDownList
                    ID="ddlCampoBusqueda"
                    runat="server"
                    CssClass="form-control abml-search-select">
                    <asp:ListItem Text="Paciente" Value="Paciente"></asp:ListItem>
                    <asp:ListItem Text="DNI" Value="DNI"></asp:ListItem>
                    <asp:ListItem Text="Fecha" Value="Fecha"></asp:ListItem>
                    <asp:ListItem Text="Hora" Value="Hora"></asp:ListItem>
                </asp:DropDownList>

                <asp:TextBox
                    ID="txtBuscar"
                    runat="server"
                    CssClass="form-control search-input medico-search-input"
                    placeholder="Ingrese búsqueda">
                </asp:TextBox>

                <asp:LinkButton
                    ID="lbtnBuscarTurno"
                    runat="server"
                    CssClass="btn btn-search"
                    Text="<i class='bi bi-search'></i>"
                    CausesValidation="False"
                    OnClick="lbtnBuscarTurno_Click">
                </asp:LinkButton>

                <asp:Button
                    ID="btnMostrarTodos"
                    runat="server"
                    Text="Todos"
                    CssClass="btn btn-panel-secondary medico-btn-todos"
                    CausesValidation="False"
                    OnClick="btnMostrarTodos_Click" />


            </asp:Panel>

        </asp:Panel>


        <asp:Panel ID="pnlTurnosPanel" runat="server" CssClass="panel-card turnos-panel">

            <asp:Panel ID="pnlHeaderTurnos" runat="server" CssClass="panel-header compact">

                <asp:Panel ID="pnlTituloTurnos" runat="server">

                    <asp:Label
                        ID="lblTituloTurnos"
                        runat="server"
                        Text="Listado de turnos"
                        CssClass="panel-title">
                    </asp:Label>

                    <asp:Label
                        ID="lblSubtituloTurnos"
                        runat="server"
                        Text="Se muestran hasta 6 turnos por página"
                        CssClass="panel-subtitle">
                    </asp:Label>

                </asp:Panel>

                <asp:Panel ID="pnlTotalTurnosHoy" runat="server" CssClass="panel-total">

                    <asp:Label
                        ID="lblTotalTexto"
                        runat="server"
                        Text="Total pendientes"
                        CssClass="panel-total-label">
                    </asp:Label>

                    <asp:Label
                        ID="lblTotalTurnosHoy"
                        runat="server"
                        Text="0 turnos"
                        CssClass="panel-total-number">
                    </asp:Label>

                </asp:Panel>

            </asp:Panel>


            <asp:Panel ID="pnlMensajeListado" runat="server" CssClass="abml-list-message" Visible="False">
                <asp:Label ID="lblMensajeListado" runat="server" Text=""></asp:Label>
            </asp:Panel>


            <asp:Panel ID="pnlTurnosGrid" runat="server" CssClass="turnos-grid">

                <asp:Repeater
                    ID="rptTurnosHoy"
                    runat="server"
                    OnItemCommand="rptTurnosHoy_ItemCommand">

                    <ItemTemplate>

                        <asp:Panel ID="pnlTurnoCard" runat="server" CssClass="turno-card">

                            <asp:Panel ID="pnlTurnoHeader" runat="server" CssClass="turno-card-header">

                                <asp:Label
                                    ID="lblTurnoTitulo"
                                    runat="server"
                                    Text='<%# "Turno " + Eval("NumeroTurno") %>'
                                    CssClass="turno-title">
                                </asp:Label>

                            </asp:Panel>


                            <asp:Panel ID="pnlTurnoBody" runat="server" CssClass="turno-card-body">

                                <asp:Panel ID="pnlPaciente" runat="server" CssClass="turno-info">

                                    <i class="bi bi-person"></i>

                                    <asp:Label
                                        ID="lblPaciente"
                                        runat="server"
                                        Text='<%# Eval("NombrePaciente") %>'>
                                    </asp:Label>

                                </asp:Panel>


                                <asp:Panel ID="pnlDni" runat="server" CssClass="turno-info">

                                    <i class="bi bi-card-text"></i>

                                    <asp:Label
                                        ID="lblDniTexto"
                                        runat="server"
                                        Text="DNI: ">
                                    </asp:Label>

                                    <asp:Label
                                        ID="lblDniPaciente"
                                        runat="server"
                                        Text='<%# Eval("DniPaciente") %>'>
                                    </asp:Label>

                                </asp:Panel>


                                <asp:Panel ID="pnlFecha" runat="server" CssClass="turno-info">

                                    <i class="bi bi-calendar-event"></i>

                                    <asp:Label
                                        ID="lblFechaTexto"
                                        runat="server"
                                        Text="Fecha: ">
                                    </asp:Label>

                                    <asp:Label
                                        ID="lblFechaTurno"
                                        runat="server"
                                        Text='<%# Eval("FechaTexto") %>'>
                                    </asp:Label>

                                </asp:Panel>


                                <asp:Panel ID="pnlHorario" runat="server" CssClass="turno-info">

                                    <i class="bi bi-clock"></i>

                                    <asp:Label
                                        ID="lblHoraInicio"
                                        runat="server"
                                        Text='<%# Eval("HoraInicio") %>'>
                                    </asp:Label>

                                    <asp:Label
                                        ID="lblSeparadorHorario"
                                        runat="server"
                                        Text=" - ">
                                    </asp:Label>

                                    <asp:Label
                                        ID="lblHoraFin"
                                        runat="server"
                                        Text='<%# Eval("HoraFin") %>'>
                                    </asp:Label>

                                </asp:Panel>

                            </asp:Panel>


                            <asp:Button
                                ID="btnRevisarTurno"
                                runat="server"
                                Text="Revisar turno"
                                CssClass="btn btn-revisar-turno"
                                CommandName="RevisarTurno"
                                CommandArgument='<%# Eval("IdTurno") %>'
                                CausesValidation="False" />


                            <asp:Panel ID="pnlTurnoFooter" runat="server" CssClass="turno-footer">

                                <asp:Panel ID="pnlCreadorTurno" runat="server">

                                    <asp:Label
                                        ID="lblCreadorTexto"
                                        runat="server"
                                        Text="Creador de turno"
                                        CssClass="turno-footer-label">
                                    </asp:Label>

                                    <asp:Label
                                        ID="lblCreadorTurno"
                                        runat="server"
                                        Text='<%# Eval("CreadorTurno") %>'
                                        CssClass="turno-footer-value">
                                    </asp:Label>

                                </asp:Panel>

                                <asp:Panel ID="pnlEstadoTurno" runat="server">

                                    <asp:Label
                                        ID="lblEstadoTexto"
                                        runat="server"
                                        Text="Estado"
                                        CssClass="turno-footer-label text-end">
                                    </asp:Label>

                                    <asp:Label
                                        ID="lblEstadoTurno"
                                        runat="server"
                                        Text="Pendiente"
                                        CssClass="turno-footer-value text-end">
                                    </asp:Label>

                                </asp:Panel>

                            </asp:Panel>

                        </asp:Panel>

                    </ItemTemplate>

                </asp:Repeater>

            </asp:Panel>


            <asp:Panel ID="pnlPaginacionTurnos" runat="server" CssClass="turnos-pagination" Visible="False">

                <asp:LinkButton
                    ID="lbtnPaginaAnterior"
                    runat="server"
                    Text="<i class='bi bi-chevron-left'></i>"
                    CssClass="turnos-page"
                    CausesValidation="False"
                    OnClick="lbtnPaginaAnterior_Click">
                </asp:LinkButton>

                <asp:Repeater ID="rptPaginacion" runat="server" OnItemCommand="rptPaginacion_ItemCommand">

                    <ItemTemplate>

                        <asp:LinkButton
                            ID="lbtnPagina"
                            runat="server"
                            Text='<%# Eval("NumeroPagina") %>'
                            CommandName="CambiarPagina"
                            CommandArgument='<%# Eval("NumeroPagina") %>'
                            CssClass='<%# Eval("CssClass") %>'
                            CausesValidation="False">
                        </asp:LinkButton>

                    </ItemTemplate>

                </asp:Repeater>

                <asp:LinkButton
                    ID="lbtnPaginaSiguiente"
                    runat="server"
                    Text="<i class='bi bi-chevron-right'></i>"
                    CssClass="turnos-page"
                    CausesValidation="False"
                    OnClick="lbtnPaginaSiguiente_Click">
                </asp:LinkButton>

            </asp:Panel>

        </asp:Panel>


        <!-- MODAL REVISAR TURNO -->
        <asp:Panel ID="pnlModalRevisarTurno" runat="server" CssClass="abml-modal-overlay" Visible="False">

            <asp:Panel ID="pnlModalContenido" runat="server" CssClass="abml-modal modal-revision-turno">

                <asp:Panel ID="pnlModalHeader" runat="server" CssClass="abml-modal-header">

                    <asp:Label
                        ID="lblTituloModalRevision"
                        runat="server"
                        Text="Revisar turno"
                        CssClass="abml-modal-title">
                    </asp:Label>

                    <asp:LinkButton
                        ID="lbtnCerrarModalRevision"
                        runat="server"
                        CssClass="abml-modal-close"
                        Text="<i class='bi bi-x-lg'></i>"
                        CausesValidation="False"
                        OnClick="lbtnCerrarModalRevision_Click">
                    </asp:LinkButton>

                </asp:Panel>


                <asp:Panel ID="pnlMensajeRevision" runat="server" CssClass="abml-list-message" Visible="False">
                    <asp:Label ID="lblMensajeRevision" runat="server" Text=""></asp:Label>
                </asp:Panel>


                <asp:HiddenField ID="hfIdTurnoRevision" runat="server" />


                <asp:Panel ID="pnlDatosTurnoRevision" runat="server" CssClass="abml-form-grid revision-grid">

                    <asp:Panel ID="pnlDatoPacienteRevision" runat="server" CssClass="form-group revision-field-third">

                        <asp:Label
                            ID="lblPacienteRevisionTexto"
                            runat="server"
                            Text="Paciente"
                            CssClass="form-label">
                        </asp:Label>

                        <asp:Label
                            ID="lblPacienteRevision"
                            runat="server"
                            CssClass="form-control revision-readonly">
                        </asp:Label>

                    </asp:Panel>


                    <asp:Panel ID="pnlDatoDniRevision" runat="server" CssClass="form-group revision-field-third">

                        <asp:Label
                            ID="lblDniRevisionTexto"
                            runat="server"
                            Text="DNI"
                            CssClass="form-label">
                        </asp:Label>

                        <asp:Label
                            ID="lblDniRevision"
                            runat="server"
                            CssClass="form-control revision-readonly">
                        </asp:Label>

                    </asp:Panel>


                    <asp:Panel ID="pnlDatoFechaRevision" runat="server" CssClass="form-group revision-field-third">

                        <asp:Label
                            ID="lblFechaRevisionTexto"
                            runat="server"
                            Text="Fecha"
                            CssClass="form-label">
                        </asp:Label>

                        <asp:Label
                            ID="lblFechaRevision"
                            runat="server"
                            CssClass="form-control revision-readonly">
                        </asp:Label>

                    </asp:Panel>


                    <asp:Panel ID="pnlDatoHorarioRevision" runat="server" CssClass="form-group revision-field-half">

                        <asp:Label
                            ID="lblHorarioRevisionTexto"
                            runat="server"
                            Text="Horario"
                            CssClass="form-label">
                        </asp:Label>

                        <asp:Label
                            ID="lblHorarioRevision"
                            runat="server"
                            CssClass="form-control revision-readonly">
                        </asp:Label>

                    </asp:Panel>


                    <asp:Panel ID="pnlAsistenciaRevision" runat="server" CssClass="form-group revision-field-half">

                        <asp:Label
                            ID="lblAsistenciaRevision"
                            runat="server"
                            Text="Resultado"
                            CssClass="form-label">
                        </asp:Label>

                        <asp:DropDownList
                            ID="ddlAsistenciaRevision"
                            runat="server"
                            CssClass="form-control"
                            AutoPostBack="True"
                            OnSelectedIndexChanged="ddlAsistenciaRevision_SelectedIndexChanged">
                            <asp:ListItem Text="--Seleccione resultado--" Value=""></asp:ListItem>
                            <asp:ListItem Text="Presente" Value="Presente"></asp:ListItem>
                            <asp:ListItem Text="Ausente" Value="Ausente"></asp:ListItem>
                        </asp:DropDownList>

                        <asp:RequiredFieldValidator
                            ID="rfvAsistenciaRevision"
                            runat="server"
                            ControlToValidate="ddlAsistenciaRevision"
                            InitialValue=""
                            ErrorMessage="Seleccione si el paciente estuvo presente o ausente."
                            CssClass="text-danger"
                            Display="Dynamic"
                            ValidationGroup="GRevisionTurno">
                        </asp:RequiredFieldValidator>

                    </asp:Panel>


                    <asp:Panel
                        ID="pnlObservacionRevision"
                        runat="server"
                        CssClass="form-group revision-field-full"
                        Visible="False">

                        <asp:Label
                            ID="lblObservacionRevision"
                            runat="server"
                            Text="Observación"
                            CssClass="form-label">
                        </asp:Label>

                        <asp:TextBox
                            ID="txtObservacionRevision"
                            runat="server"
                            CssClass="form-control"
                            TextMode="MultiLine"
                            Rows="4"
                            MaxLength="500"
                            placeholder="Ingrese una observación sobre la atención del paciente">
                        </asp:TextBox>

                    </asp:Panel>

                </asp:Panel>


                <asp:Panel ID="pnlAccionesRevision" runat="server" CssClass="abml-modal-actions">

                    <asp:Button
                        ID="btnGuardarRevision"
                        runat="server"
                        Text="Guardar revisión"
                        CssClass="btn btn-panel-primary"
                        ValidationGroup="GRevisionTurno"
                        OnClick="btnGuardarRevision_Click" />

                    <asp:Button
                        ID="btnCancelarRevision"
                        runat="server"
                        Text="Cancelar"
                        CssClass="btn btn-panel-secondary"
                        CausesValidation="False"
                        OnClick="btnCancelarRevision_Click" />

                </asp:Panel>
            </asp:Panel>
        </asp:Panel>
    </asp:Panel>
</asp:Content>