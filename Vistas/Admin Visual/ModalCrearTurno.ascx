<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ModalCrearTurno.ascx.cs" Inherits="Vistas.ModalCrearTurno" %>

<asp:Panel ID="pnlModalCrearTurno" runat="server" CssClass="abml-modal-overlay" Visible="False">

    <asp:Panel ID="pnlModalTurno" runat="server" CssClass="abml-modal">

        <asp:Panel ID="pnlModalHeader" runat="server" CssClass="abml-modal-header">

            <asp:Panel ID="pnlModalTitulo" runat="server">

                <asp:Label
                    ID="lblTituloFormulario"
                    runat="server"
                    Text="Ingresar nuevo turno"
                    CssClass="abml-modal-title">
                </asp:Label>

                <asp:Label
                    ID="lblSubtituloFormulario"
                    runat="server"
                    Text="Complete los datos del turno"
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
                    ValidationGroup="GCrearTurno"
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
                    <asp:ListItem 
                        Text="--Seleccione especialidad--" 
                        Value="">
                    </asp:ListItem>
                </asp:DropDownList>

                <asp:RequiredFieldValidator
                    ID="rfvEspecialidad"
                    runat="server"
                    ControlToValidate="ddlEspecialidad"
                    InitialValue=""
                    ErrorMessage="Seleccione una especialidad."
                    CssClass="text-danger"
                    Display="Dynamic"
                    ValidationGroup="GCrearTurno"
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
                    <asp:ListItem 
                        Text="--Seleccione médico--" 
                        Value="">
                    </asp:ListItem>
                </asp:DropDownList>

                <asp:RequiredFieldValidator
                    ID="rfvMedico"
                    runat="server"
                    ControlToValidate="ddlMedico"
                    InitialValue=""
                    ErrorMessage="Seleccione un médico."
                    CssClass="text-danger"
                    Display="Dynamic"
                    ValidationGroup="GCrearTurno"
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
                    ValidationGroup="GCrearTurno"
                    Font-Bold="True"
                    EnableClientScript="False">
                </asp:RequiredFieldValidator>

                <asp:CustomValidator
                    ID="cvFechaTurno"
                    runat="server"
                    ControlToValidate="txtFecha"
                    ErrorMessage="La fecha no puede ser anterior a hoy."
                    CssClass="text-danger"
                    Display="Dynamic"
                    ValidationGroup="GCrearTurno"
                    Font-Bold="True"
                    EnableClientScript="False"
                    OnServerValidate="cvFechaTurno_ServerValidate">
                </asp:CustomValidator>

            </asp:Panel>


            <asp:Panel ID="pnlCampoHora" runat="server" CssClass="form-field">
                <asp:Label ID="lblHora" runat="server" Text="Hora disponible" CssClass="form-label"></asp:Label>

                <asp:DropDownList
                    ID="ddlHoraTurno"
                    runat="server"
                    CssClass="form-control"
                    Enabled="False">
                    <asp:ListItem Text="--Seleccione horario--" Value=""></asp:ListItem>
                </asp:DropDownList>

                <asp:RequiredFieldValidator
                    ID="rfvHora"
                    runat="server"
                    ControlToValidate="ddlHoraTurno"
                    InitialValue=""
                    ErrorMessage="Seleccione un horario."
                    CssClass="text-danger"
                    Display="Dynamic"
                    ValidationGroup="GCrearTurno"
                    Font-Bold="True"
                    EnableClientScript="False">
                </asp:RequiredFieldValidator>
            </asp:Panel>

        </asp:Panel>


        <asp:Panel ID="pnlMensajeTurno" runat="server" CssClass="abml-message" Visible="False">
            <asp:Label ID="lblMensajeTurno" runat="server" Text=""></asp:Label>
        </asp:Panel>


        <asp:Panel ID="pnlBotonesFormulario" runat="server" CssClass="abml-form-actions">

            <asp:Button
                ID="btnGuardarTurno"
                runat="server"
                Text="Guardar turno"
                CssClass="btn btn-panel-primary"
                ValidationGroup="GCrearTurno"
                OnClick="btnGuardarTurno_Click" />

            <asp:Button
                ID="btnLimpiar"
                runat="server"
                Text="Limpiar"
                CssClass="btn btn-panel-secondary"
                CausesValidation="False"
                OnClick="btnLimpiar_Click" />

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
