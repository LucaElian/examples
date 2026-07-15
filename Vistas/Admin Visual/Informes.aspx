<%@ Page Title="Informes" Language="C#" MasterPageFile="~/Panel.Master" AutoEventWireup="true" CodeBehind="Informes.aspx.cs" Inherits="Vistas.Informes" %>

<asp:Content ID="ContentTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Informes
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="MainContent" runat="server">

    <asp:Panel ID="pnlInformes" runat="server" CssClass="inicio-container">

        <asp:Panel ID="pnlInformesCard" runat="server" CssClass="panel-card informes-panel">

            <asp:Panel ID="pnlInformesHeader" runat="server" CssClass="informes-header">

                <asp:Label
                    ID="lblTituloInformes"
                    runat="server"
                    Text="Reportes"
                    CssClass="panel-title">
                </asp:Label>

                <asp:Label
                    ID="lblSubtituloInformes"
                    runat="server"
                    Text="Visualización general de reportes del sistema"
                    CssClass="panel-subtitle">
                </asp:Label>

            </asp:Panel>


            <asp:Panel ID="pnlInformesContenido" runat="server" CssClass="informes-cards">

                <!-- REPORTE 1 -->
                <asp:Panel ID="pnlReporte1" runat="server" CssClass="informe-card-modern">

                    <asp:Label
                        ID="lblReporte1Titulo"
                        runat="server"
                        Text="Día con mayor demanda de turnos en el mes de Julio"
                        CssClass="informe-title">
                    </asp:Label>

                    <asp:Label
                        ID="lblReporte1Cantidad"
                        runat="server"
                        Text=""
                        CssClass="informe-value">
                    </asp:Label>

                </asp:Panel>


                <!-- REPORTE 2 -->
                <asp:Panel ID="pnlReporte2" runat="server" CssClass="informe-card-modern">

                    <asp:Label
                        ID="lblReporte2Titulo"
                        runat="server"
                        Text="Médico con mayor cantidad de turnos asignados en el mes de Julio"
                        CssClass="informe-title">
                    </asp:Label>

                    <asp:Label
                        ID="lblReporte2Cantidad"
                        runat="server"
                        Text=""
                        CssClass="informe-value">
                    </asp:Label>

                </asp:Panel>

            </asp:Panel>

        </asp:Panel>

    </asp:Panel>

</asp:Content>