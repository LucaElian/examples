<%@ Page Title="Inicio Administrador" Language="C#" MasterPageFile="~/Panel.Master" AutoEventWireup="true" CodeBehind="InicioAdmin.aspx.cs" Inherits="Vistas.InicioAdmin" %>

<asp:Content ID="ContentTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Inicio
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="MainContent" runat="server">

    <asp:Panel ID="pnlDashboard" runat="server" CssClass="inicio-container">

        <asp:Panel ID="pnlTurnosEspecialidad" runat="server" CssClass="panel-card mb-3">

            <asp:Panel ID="pnlHeaderEspecialidades" runat="server" CssClass="panel-header compact">

                <asp:Panel ID="pnlTituloEspecialidades" runat="server">
                    <asp:Label
                        ID="lblTituloEspecialidades"
                        runat="server"
                        Text="Turnos por especialidad"
                        CssClass="panel-title">
                    </asp:Label>

                    <asp:Label
                        ID="lblSubtituloEspecialidades"
                        runat="server"
                        Text="Distribución de turnos del mes actual"
                        CssClass="panel-subtitle">
                    </asp:Label>
                </asp:Panel>

                <asp:Panel ID="pnlTotalTurnos" runat="server" CssClass="panel-total">
                    <asp:Label
                        ID="lblTotalTexto"
                        runat="server"
                        Text="Total"
                        CssClass="panel-total-label">
                    </asp:Label>

                    <asp:Label
                        ID="lblTotalTurnoMes"
                        runat="server"
                        Text="0 turnos"
                        CssClass="panel-total-number">
                    </asp:Label>
                </asp:Panel>

            </asp:Panel>

            <asp:Panel ID="pnlEspecialidadesGrid" runat="server" CssClass="especialidades-grid">

                <asp:Repeater ID="rptEspecialidades" runat="server">
                    <ItemTemplate>

                        <asp:Panel ID="pnlEspecialidad" runat="server" CssClass="especialidad-item">

                            <asp:Panel ID="pnlInfoEspecialidad" runat="server" CssClass="especialidad-info">

                                <asp:Label
                                    ID="lblNombreEspecialidad"
                                    runat="server"
                                    Text='<%# Eval("Especialidad") %>'
                                    CssClass="especialidad-nombre">
                                </asp:Label>

                                <asp:Label
                                    ID="lblCantidadEspecialidad"
                                    runat="server"
                                    Text='<%# Eval("CantidadTexto") %>'
                                    CssClass="especialidad-cantidad">
                                </asp:Label>

                            </asp:Panel>

                            <asp:Panel ID="pnlProgressEspecialidad" runat="server" CssClass="progress especialidad-progress">

                                <asp:Panel
                                    ID="pnlBarEspecialidad"
                                    runat="server"
                                    CssClass="progress-bar"
                                    Style='<%# "width:" + Eval("Porcentaje") + "%;" %>'>

                                    <asp:Label
                                        ID="lblPorcentajeEspecialidad"
                                        runat="server"
                                        Text='<%# Eval("PorcentajeTexto") %>'>
                                    </asp:Label>

                                </asp:Panel>

                            </asp:Panel>

                        </asp:Panel>

                    </ItemTemplate>
                </asp:Repeater>

            </asp:Panel>

        </asp:Panel>

        <asp:Panel ID="pnlCards" runat="server" CssClass="row g-3 mb-3">

            <asp:Panel ID="pnlColPacientes" runat="server" CssClass="col-12 col-md-6">
                <asp:Panel ID="pnlPacientesActivos" runat="server" CssClass="stat-card">

                    <asp:Panel ID="pnlIconPacientes" runat="server" CssClass="stat-icon paciente">
                        <i class="bi bi-people"></i>
                    </asp:Panel>

                    <asp:Panel ID="pnlTextPacientes" runat="server">
                        <asp:Label
                            ID="lblPacientesTexto"
                            runat="server"
                            Text="Pacientes activos"
                            CssClass="stat-label">
                        </asp:Label>

                        <asp:Label
                            ID="lblPacientesActivos"
                            runat="server"
                            Text="0"
                            CssClass="stat-number">
                        </asp:Label>
                    </asp:Panel>

                </asp:Panel>
            </asp:Panel>

            <asp:Panel ID="pnlColMedicos" runat="server" CssClass="col-12 col-md-6">
                <asp:Panel ID="pnlMedicosActivos" runat="server" CssClass="stat-card">

                    <asp:Panel ID="pnlIconMedicos" runat="server" CssClass="stat-icon medico">
                        <i class="bi bi-person-badge"></i>
                    </asp:Panel>

                    <asp:Panel ID="pnlTextMedicos" runat="server">
                        <asp:Label
                            ID="lblMedicosTexto"
                            runat="server"
                            Text="Médicos activos"
                            CssClass="stat-label">
                        </asp:Label>

                        <asp:Label
                            ID="lblMedicosActivos"
                            runat="server"
                            Text="0"
                            CssClass="stat-number">
                        </asp:Label>
                    </asp:Panel>

                </asp:Panel>
            </asp:Panel>

            <asp:Panel ID="pnColTurnosPendientes" runat="server" CssClass="col-12 col-md-6">
                <asp:Panel ID="pnlTurnosPendientes" runat="server" CssClass="stat-card">

                    <asp:Panel ID="pnlIconTurnosPendientes" runat="server" CssClass="stat-icon warning">
                        <i class="bi bi-hourglass-split"></i>
                    </asp:Panel>

                    <asp:Panel ID="pnlTextPendientes" runat="server">
                        <asp:Label
                            ID="lblTurnosPendientesTexto"
                            runat="server"
                            Text="Turnos pendientes"
                            CssClass="stat-label">
                        </asp:Label>

                        <asp:Label
                            ID="lblTurnosPendientes"
                            runat="server"
                            Text="0"
                            CssClass="stat-number">
                        </asp:Label>
                    </asp:Panel>

                </asp:Panel>
            </asp:Panel>

            <asp:Panel ID="pnlColTurnosHoy" runat="server" CssClass="col-12 col-md-6">
                <asp:Panel ID="pnlTurnosHoy" runat="server" CssClass="stat-card">

                    <asp:Panel ID="pnlIconTurnosHoy" runat="server" CssClass="stat-icon turno-hoy">
                        <i class="bi bi-calendar-check"></i>
                    </asp:Panel>

                    <asp:Panel ID="pnlTextTurnosHoy" runat="server">
                        <asp:Label
                            ID="lblTurnosHoyTexto"
                            runat="server"
                            Text="Turnos hoy"
                            CssClass="stat-label">
                        </asp:Label>

                        <asp:Label
                            ID="lblTurnosHoy"
                            runat="server"
                            Text="0"
                            CssClass="stat-number">
                        </asp:Label>
                    </asp:Panel>

                </asp:Panel>
            </asp:Panel>

        </asp:Panel>

        <asp:Panel ID="pnlAsistencia" runat="server" CssClass="panel-card asistencia-panel">

            <asp:Panel ID="pnlHeaderAsistencia" runat="server" CssClass="panel-header compact">

                <asp:Panel ID="pnlTituloAsistencia" runat="server">
                    <asp:Label
                        ID="lblTituloAsistencia"
                        runat="server"
                        Text="Resumen de asistencia"
                        CssClass="panel-title">
                    </asp:Label>

                    <asp:Label
                        ID="lblSubtituloAsistencia"
                        runat="server"
                        Text="Datos del mes actual"
                        CssClass="panel-subtitle">
                    </asp:Label>
                </asp:Panel>

            </asp:Panel>

            <asp:Panel ID="pnlMiniStats" runat="server" CssClass="row g-3">

                <asp:Panel ID="pnlColPresentes" runat="server" CssClass="col-12 col-md-4">
                    <asp:Panel ID="pnlPresentes" runat="server" CssClass="resumen-stat">
                        <asp:Label
                            ID="lblPresentesTexto"
                            runat="server"
                            Text="Presentes"
                            CssClass="resumen-stat-label">
                        </asp:Label>

                        <asp:Label
                            ID="lblPresentes"
                            runat="server"
                            Text="0"
                            CssClass="resumen-stat-number">
                        </asp:Label>
                    </asp:Panel>
                </asp:Panel>

                <asp:Panel ID="pnlColAusentes" runat="server" CssClass="col-12 col-md-4">
                    <asp:Panel ID="pnlAusentes" runat="server" CssClass="resumen-stat">
                        <asp:Label
                            ID="lblAusentesTexto"
                            runat="server"
                            Text="Ausentes"
                            CssClass="resumen-stat-label">
                        </asp:Label>

                        <asp:Label
                            ID="lblAusentes"
                            runat="server"
                            Text="0"
                            CssClass="resumen-stat-number">
                        </asp:Label>
                    </asp:Panel>
                </asp:Panel>

                <asp:Panel ID="pnlColPendientes" runat="server" CssClass="col-12 col-md-4">
                    <asp:Panel ID="pnlPendientes" runat="server" CssClass="resumen-stat">
                        <asp:Label
                            ID="lblPendientesTexto"
                            runat="server"
                            Text="Pendientes"
                            CssClass="resumen-stat-label">
                        </asp:Label>

                        <asp:Label
                            ID="lblPendientes"
                            runat="server"
                            Text="0"
                            CssClass="resumen-stat-number">
                        </asp:Label>
                    </asp:Panel>
                </asp:Panel>

            </asp:Panel>

        </asp:Panel>

    </asp:Panel>

</asp:Content>