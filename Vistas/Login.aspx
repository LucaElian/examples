<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Vistas.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>

    <!-- Bootstrap -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet" />

    <!-- Bootstrap Icons -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
        rel="stylesheet" />

    <!-- CSS -->
    <link href="Styles/base.css?v=1" rel="stylesheet" />
    <link href="Styles/pages.css?v=1" rel="stylesheet" />
    <link href="Styles/login.css?v=3" rel="stylesheet" />

</head>

<body>

    <form id="form1" runat="server">

        <asp:Panel
            ID="pnlLoginPage"
            runat="server"
            CssClass="login-page">

            <asp:Panel
                ID="pnlContainer"
                runat="server"
                CssClass="container">

                <asp:Panel
                    ID="pnlRow"
                    runat="server"
                    CssClass="row justify-content-center align-items-center min-vh-100">

                    <asp:Panel
                        ID="pnlColumn"
                        runat="server"
                        CssClass="col-12 col-sm-10 col-md-7 col-lg-5 col-xl-4">

                        <asp:Panel
                            ID="pnlLoginCard"
                            runat="server"
                            CssClass="login-card">

                            <asp:Panel
                                ID="pnlHeaderLogin"
                                runat="server"
                                CssClass="text-center mb-4">

                                <asp:Panel
                                    ID="pnlLogo"
                                    runat="server"
                                    CssClass="login-logo">

                                    <asp:Image
                                        ID="imgLogo"
                                        runat="server"
                                        ImageUrl="~/Images/logo.svg"
                                        CssClass="login-logo-img" />

                                </asp:Panel>

                                <asp:Label
                                    ID="lblTituloLogin"
                                    runat="server"
                                    Text="Clínica Médica VITALIA"
                                    CssClass="login-title">
                                </asp:Label>

                            </asp:Panel>

                            <!-- USUARIO -->
                            <asp:Panel
                                ID="pnlUsuario"
                                runat="server"
                                CssClass="mb-3">

                                <asp:Label
                                    ID="lblUsuario"
                                    runat="server"
                                    Text="Usuario"
                                    AssociatedControlID="txtUser"
                                    CssClass="form-label">
                                </asp:Label>

                                <asp:TextBox
                                    ID="txtUser"
                                    runat="server"
                                    ClientIDMode="Static"
                                    CssClass="form-control"
                                    placeholder="Ingrese su usuario">
                                </asp:TextBox>

                                <asp:RequiredFieldValidator
                                    ID="rfvUser"
                                    runat="server"
                                    ControlToValidate="txtUser"
                                    Display="Dynamic"
                                    EnableClientScript="False"
                                    ErrorMessage="El usuario no puede estar vacío"
                                    ValidationGroup="GLogin"
                                    CssClass="text-danger small"
                                    Font-Bold="True">
                                </asp:RequiredFieldValidator>

                            </asp:Panel>

                            <!-- CONTRASEÑA -->
                            <asp:Panel
                                ID="pnlPassword"
                                runat="server"
                                CssClass="mb-2">

                                <asp:Label
                                    ID="lblPassword"
                                    runat="server"
                                    Text="Contraseña"
                                    AssociatedControlID="txtPassword"
                                    CssClass="form-label">
                                </asp:Label>

                                <asp:Panel
                                    ID="pnlInputPassword"
                                    runat="server"
                                    CssClass="input-group">

                                    <asp:TextBox
                                        ID="txtPassword"
                                        runat="server"
                                        ClientIDMode="Static"
                                        TextMode="Password"
                                        CssClass="form-control"
                                        placeholder="Ingrese su contraseña">
                                    </asp:TextBox>

                                    <button
                                        ID="btnVerPassword"
                                        type="button"
                                        class="btn btn-password">

                                        <i
                                            ID="iconPassword"
                                            class="bi bi-eye">
                                        </i>

                                    </button>

                                </asp:Panel>

                                <asp:RequiredFieldValidator
                                    ID="rfvPassword"
                                    runat="server"
                                    ControlToValidate="txtPassword"
                                    Display="Dynamic"
                                    EnableClientScript="False"
                                    ErrorMessage="La contraseña no puede estar vacía"
                                    ValidationGroup="GLogin"
                                    CssClass="text-danger small"
                                    Font-Bold="True">
                                </asp:RequiredFieldValidator>

                            </asp:Panel>

                            <!-- OLVIDÉ MI CONTRASEÑA -->
                            <asp:Panel
                                ID="pnlAccionRestablecer"
                                runat="server"
                                CssClass="text-end mb-3">

                                <asp:LinkButton
                                    ID="lbtnAbrirModalRestablecerContrasenia"
                                    runat="server"
                                    Text="¿Olvidaste tu contraseña?"
                                    CssClass="forgot-password-link"
                                    CausesValidation="False"
                                    OnClick="lbtnAbrirModalRestablecerContrasenia_Click">
                                </asp:LinkButton>

                            </asp:Panel>

                            <!-- INICIAR SESIÓN -->
                            <asp:Button
                                ID="btnIngresar"
                                runat="server"
                                Text="Iniciar sesión"
                                ValidationGroup="GLogin"
                                CssClass="btn btn-login w-100"
                                OnClick="btnIngresar_Click" />

                            <!-- MENSAJE LOGIN -->
                            <asp:Label
                                ID="lblMensaje"
                                runat="server"
                                Text="El usuario o la contraseña es incorrecta"
                                Visible="False"
                                CssClass="alert alert-danger mt-3 py-2 text-center d-block"
                                Font-Bold="False">
                            </asp:Label>

                        </asp:Panel>

                    </asp:Panel>

                </asp:Panel>

            </asp:Panel>

        </asp:Panel>


        <!--=================================-->
        <!-- MODAL RESTABLECER CONTRASEÑA   -->
        <!--=================================-->

        <asp:Panel
            ID="pnlModalRestablecerContrasenia"
            runat="server"
            CssClass="abml-modal-overlay"
            Visible="False">

            <asp:Panel
                ID="pnlModalContrasenia"
                runat="server"
                CssClass="abml-modal login-password-modal">

                <!-- ENCABEZADO -->
                <asp:Panel
                    ID="pnlModalHeader"
                    runat="server"
                    CssClass="abml-modal-header">

                    <asp:Panel
                        ID="pnlModalTitulo"
                        runat="server">

                        <asp:Label
                            ID="lblTituloModalRestablecer"
                            runat="server"
                            Text="Restablecer contraseña"
                            CssClass="abml-modal-title">
                        </asp:Label>

                        <asp:Label
                            ID="lblSubtituloModalRestablecer"
                            runat="server"
                            Text="Ingrese su usuario y escriba la nueva contraseña"
                            CssClass="abml-modal-subtitle">
                        </asp:Label>

                    </asp:Panel>

                    <asp:LinkButton
                        ID="lbtnCerrarModalRestablecer"
                        runat="server"
                        Text="<i class='bi bi-x-lg'></i>"
                        CssClass="abml-modal-close"
                        CausesValidation="False"
                        OnClick="lbtnCerrarModalRestablecer_Click">
                    </asp:LinkButton>

                </asp:Panel>

                <!-- FORMULARIO -->
                <asp:Panel
                    ID="pnlFormularioRestablecer"
                    runat="server"
                    CssClass="abml-form-grid login-password-grid">

                    <!-- USUARIO -->
                    <asp:Panel
                        ID="pnlUsuarioRecuperacion"
                        runat="server"
                        CssClass="form-field form-field-wide">

                        <asp:Label
                            ID="lblUsuarioRecuperacion"
                            runat="server"
                            Text="Usuario"
                            AssociatedControlID="txtUsuarioRecuperacion"
                            CssClass="form-label">
                        </asp:Label>

                        <asp:TextBox
                            ID="txtUsuarioRecuperacion"
                            runat="server"
                            CssClass="form-control"
                            placeholder="Ingrese su usuario">
                        </asp:TextBox>

                        <asp:RequiredFieldValidator
                            ID="rfvUsuarioRecuperacion"
                            runat="server"
                            ControlToValidate="txtUsuarioRecuperacion"
                            Display="Dynamic"
                            EnableClientScript="False"
                            ValidationGroup="GRestablecerContrasenia"
                            ErrorMessage="El usuario no puede estar vacío"
                            CssClass="text-danger small"
                            Font-Bold="True">
                        </asp:RequiredFieldValidator>

                        <asp:CustomValidator
                            ID="cvUsuarioRecuperacion"
                            runat="server"
                            ControlToValidate="txtUsuarioRecuperacion"
                            Display="Dynamic"
                            EnableClientScript="False"
                            ValidationGroup="GRestablecerContrasenia"
                            ErrorMessage="El usuario no existe o no está activo"
                            CssClass="text-danger small"
                            Font-Bold="True"
                            OnServerValidate="cvUsuarioRecuperacion_ServerValidate">
                        </asp:CustomValidator>

                    </asp:Panel>

                    <!-- NUEVA CONTRASEÑA -->
                    <asp:Panel
                        ID="pnlNuevaContrasenia"
                        runat="server"
                        CssClass="form-field form-field-wide">

                        <asp:Label
                            ID="lblNuevaContrasenia"
                            runat="server"
                            Text="Nueva contraseña"
                            AssociatedControlID="txtNuevaContrasenia"
                            CssClass="form-label">
                        </asp:Label>

                        <asp:TextBox
                            ID="txtNuevaContrasenia"
                            runat="server"
                            TextMode="Password"
                            CssClass="form-control"
                            placeholder="Ingrese la nueva contraseña">
                        </asp:TextBox>

                        <asp:RequiredFieldValidator
                            ID="rfvNuevaContrasenia"
                            runat="server"
                            ControlToValidate="txtNuevaContrasenia"
                            Display="Dynamic"
                            EnableClientScript="False"
                            ValidationGroup="GRestablecerContrasenia"
                            ErrorMessage="La nueva contraseña no puede estar vacía"
                            CssClass="text-danger small"
                            Font-Bold="True">
                        </asp:RequiredFieldValidator>

                    </asp:Panel>

                    <!-- REPETIR CONTRASEÑA -->
                    <asp:Panel
                        ID="pnlRepetirContrasenia"
                        runat="server"
                        CssClass="form-field form-field-wide">

                        <asp:Label
                            ID="lblRepetirContrasenia"
                            runat="server"
                            Text="Repetir nueva contraseña"
                            AssociatedControlID="txtRepetirContrasenia"
                            CssClass="form-label">
                        </asp:Label>

                        <asp:TextBox
                            ID="txtRepetirContrasenia"
                            runat="server"
                            TextMode="Password"
                            CssClass="form-control"
                            placeholder="Repita la nueva contraseña">
                        </asp:TextBox>

                        <asp:RequiredFieldValidator
                            ID="rfvRepetirContrasenia"
                            runat="server"
                            ControlToValidate="txtRepetirContrasenia"
                            Display="Dynamic"
                            EnableClientScript="False"
                            ValidationGroup="GRestablecerContrasenia"
                            ErrorMessage="Debe repetir la nueva contraseña"
                            CssClass="text-danger small"
                            Font-Bold="True">
                        </asp:RequiredFieldValidator>

                        <asp:CompareValidator
                            ID="cvContrasenias"
                            runat="server"
                            ControlToValidate="txtRepetirContrasenia"
                            ControlToCompare="txtNuevaContrasenia"
                            Display="Dynamic"
                            EnableClientScript="False"
                            ValidationGroup="GRestablecerContrasenia"
                            ErrorMessage="Las contraseñas no coinciden"
                            CssClass="text-danger small"
                            Font-Bold="True">
                        </asp:CompareValidator>

                    </asp:Panel>

                </asp:Panel>

                <!-- MENSAJE -->
                <asp:Panel
                    ID="pnlMensajeRecuperacion"
                    runat="server"
                    CssClass="abml-message"
                    Visible="False">

                    <asp:Label
                        ID="lblMensajeRecuperacion"
                        runat="server"
                        Text="">
                    </asp:Label>

                </asp:Panel>

                <!-- BOTONES -->
                <asp:Panel
                    ID="pnlBotonesRestablecer"
                    runat="server"
                    CssClass="abml-form-actions">

                    <asp:Button
                        ID="btnCancelarRestablecer"
                        runat="server"
                        Text="Cancelar"
                        CssClass="btn btn-panel-secondary"
                        CausesValidation="False"
                        OnClick="btnCancelarRestablecer_Click" />

                    <asp:Button
                        ID="btnRestablecerContrasenia"
                        runat="server"
                        Text="Cambiar contraseña"
                        ValidationGroup="GRestablecerContrasenia"
                        CssClass="btn btn-panel-primary"
                        OnClick="btnRestablecerContrasenia_Click" />

                </asp:Panel>

            </asp:Panel>

        </asp:Panel>

    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src='<%= ResolveUrl("~/Scripts/functions.js") %>'></script>

</body>
</html>