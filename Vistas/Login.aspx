<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Vistas.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />

    <!-- CSS -->
    <link href="Styles/base.css?v=1" rel="stylesheet" />
    <link href="Styles/login.css?v=1" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">

        <asp:Panel ID="pnlLoginPage" runat="server" CssClass="login-page">
            <asp:Panel ID="pnlContainer" runat="server" CssClass="container">
                <asp:Panel ID="pnlRow" runat="server" CssClass="row justify-content-center align-items-center min-vh-100">
                    <asp:Panel ID="pnlColumn" runat="server" CssClass="col-12 col-sm-10 col-md-7 col-lg-5 col-xl-4">

                        <asp:Panel ID="pnlLoginCard" runat="server" CssClass="login-card">
                            <asp:Panel ID="pnlHeaderLogin" runat="server" CssClass="text-center mb-4">

                                <asp:Panel ID="pnlLogo" runat="server" CssClass="login-logo">
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

                            <asp:Panel ID="pnlUsuario" runat="server" CssClass="mb-3">

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
                                    CssClass="text-danger small" Font-Bold="True"></asp:RequiredFieldValidator>

                            </asp:Panel>

                            <asp:Panel ID="pnlPassword" runat="server" CssClass="mb-3">

                                <asp:Label
                                    ID="lblPassword"
                                    runat="server"
                                    Text="Contraseña"
                                    AssociatedControlID="txtPassword"
                                    CssClass="form-label">
                                </asp:Label>

                                <asp:Panel ID="pnlInputPassword" runat="server" CssClass="input-group">

                                    <asp:TextBox
                                        ID="txtPassword"
                                        runat="server"
                                        ClientIDMode="Static"
                                        TextMode="Password"
                                        CssClass="form-control"
                                        placeholder="Ingrese su contraseña">
                                    </asp:TextBox>

                                    <button
                                        class="btn btn-password"
                                        type="button"
                                        id="btnVerPassword">
                                        <i id="iconPassword" class="bi bi-eye"></i>
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
                                    CssClass="text-danger small" Font-Bold="True"></asp:RequiredFieldValidator>

                            </asp:Panel>

                            <asp:Button
                                ID="btnIngresar"
                                runat="server"
                                OnClick="btnIngresar_Click"
                                Text="Iniciar sesión"
                                ValidationGroup="GLogin"
                                CssClass="btn btn-login w-100" />

                            <asp:Label
                                ID="lblMensaje"
                                runat="server"
                                Text="El usuario o la contraseña es incorrecta"
                                Visible="False"
                                CssClass="alert alert-danger mt-3 py-2 text-center d-block" Font-Bold="False"></asp:Label>

                        </asp:Panel>

                    </asp:Panel>
                </asp:Panel>
            </asp:Panel>
        </asp:Panel>

    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src='<%= ResolveUrl("~/Scripts/functions.js") %>'></script>

</body>
</html>