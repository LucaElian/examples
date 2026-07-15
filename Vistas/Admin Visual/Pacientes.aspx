<%@ Page Title="Pacientes" Language="C#" MasterPageFile="~/Panel.Master" AutoEventWireup="true" CodeBehind="Pacientes.aspx.cs" Inherits="Vistas.Pacientes" %>

<asp:Content ID="ContentTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Pacientes
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="MainContent" runat="server">

    <asp:Panel ID="pnlPacientes" runat="server" CssClass="inicio-container abml-container">

        <!-- LISTADO -->
        <asp:Panel ID="pnlListadoPacientes" runat="server" CssClass="panel-card abml-list-panel">

            <asp:Panel ID="pnlHeaderListado" runat="server" CssClass="panel-header compact">

                <asp:Panel ID="pnlTituloListado" runat="server">

                    <asp:Label
                        ID="lblTituloListado"
                        runat="server"
                        Text="Pacientes"
                        CssClass="panel-title">
                    </asp:Label>

                    <asp:Label
                        ID="lblSubtituloListado"
                        runat="server"
                        Text="Se muestran hasta 8 pacientes por página"
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
            <asp:Panel ID="pnlBuscadorPacientes" runat="server" CssClass="abml-toolbar">

                <asp:Panel ID="pnlSearchPaciente" runat="server" CssClass="abml-search-area">

                    <asp:DropDownList
                        ID="ddlCampoBusqueda"
                        runat="server"
                        CssClass="form-control abml-search-select">
                        <asp:ListItem Text="ID" Value="ID"></asp:ListItem>
                        <asp:ListItem Text="DNI" Value="DNI"></asp:ListItem>
                        <asp:ListItem Text="Nombre" Value="Nombre"></asp:ListItem>
                        <asp:ListItem Text="Apellido" Value="Apellido"></asp:ListItem>
                    </asp:DropDownList>

                    <asp:TextBox
                        ID="txtFiltroPaciente"
                        runat="server"
                        CssClass="form-control abml-search-input"
                        placeholder="Ingrese búsqueda">
                    </asp:TextBox>

                    <asp:LinkButton
                        ID="lbtnBuscarPaciente"
                        runat="server"
                        CssClass="abml-search-icon"
                        Text="<i class='bi bi-search'></i>"
                        CausesValidation="False"
                        OnClick="lbtnBuscarPaciente_Click"
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
            <asp:Panel ID="pnlTablaPacientes" runat="server" CssClass="table-responsive abml-table-wrapper">

                <asp:GridView
                    ID="gvPacientes"
                    runat="server"
                    CssClass="table abml-table"
                    AutoGenerateColumns="False"
                    GridLines="None"
                    DataKeyNames="ID"
                    AllowPaging="True"
                    PageSize="8"
                    ShowHeaderWhenEmpty="True"
                    EmptyDataText="No hay pacientes cargados para mostrar."
                    OnPageIndexChanging="gvPacientes_PageIndexChanging"
                    OnRowCommand="gvPacientes_RowCommand">

                    <PagerSettings Mode="NumericFirstLast" FirstPageText="Primera" LastPageText="Última" />
                    <PagerStyle CssClass="abml-pager" />

                    <Columns>

                        <asp:BoundField DataField="ID" HeaderText="ID" />
                        <asp:BoundField DataField="DNI" HeaderText="DNI" />
                        <asp:BoundField DataField="Apellido" HeaderText="Apellido" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                        <asp:BoundField DataField="Correo" HeaderText="Correo" />
                        <asp:BoundField DataField="Telefono" HeaderText="Teléfono" />

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

                                <asp:Panel ID="pnlAccionesPaciente" runat="server" CssClass="grid-actions">

                                    <asp:LinkButton
                                        ID="lbtnEditarPaciente"
                                        runat="server"
                                        Text="<i class='bi bi-pencil-square'></i>"
                                        ToolTip="Modificar paciente"
                                        CssClass="grid-action-btn action-edit"
                                        CommandName="EditarPaciente"
                                        CommandArgument='<%# Eval("ID") %>'
                                        CausesValidation="False">
                                    </asp:LinkButton>

                                    <asp:LinkButton
                                        ID="lbtnCambiarEstadoPaciente"
                                        runat="server"
                                        Text='<%# Convert.ToBoolean(Eval("Estado")) ? "<i class=\"bi bi-person-dash\"></i>" : "<i class=\"bi bi-person-check\"></i>" %>'
                                        ToolTip='<%# Convert.ToBoolean(Eval("Estado")) ? "Desactivar paciente" : "Activar paciente" %>'
                                        CssClass='<%# Convert.ToBoolean(Eval("Estado")) ? "grid-action-btn action-disable" : "grid-action-btn action-active" %>'
                                        CommandName="CambiarEstadoPaciente"
                                        CommandArgument='<%# Eval("ID").ToString() + "|" + Eval("Estado").ToString() %>'
                                        CausesValidation="False">
                                    </asp:LinkButton>

                                </asp:Panel>

                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>

                </asp:GridView>

            </asp:Panel>


            <!-- BOTÓN AGREGAR -->
            <asp:Panel ID="pnlBotonAgregarListado" runat="server" CssClass="abml-list-footer">

                <asp:Button
                    ID="btnAbrirModalAgregar"
                    runat="server"
                    Text="Agregar nuevo paciente"
                    CssClass="btn btn-panel-primary"
                    CausesValidation="False"
                    OnClick="btnAbrirModalAgregar_Click" />

            </asp:Panel>

        </asp:Panel>


        <!-- MODAL / VENTANA EMERGENTE -->
        <asp:Panel ID="pnlModalFormulario" runat="server" CssClass="abml-modal-overlay" Visible="False">

            <asp:Panel ID="pnlModalPaciente" runat="server" CssClass="abml-modal">

                <asp:Panel ID="pnlModalHeader" runat="server" CssClass="abml-modal-header">

                    <asp:Panel ID="pnlModalTitulo" runat="server">

                        <asp:Label
                            ID="lblTituloFormulario"
                            runat="server"
                            Text="Agregar paciente"
                            CssClass="abml-modal-title">
                        </asp:Label>

                        <asp:Label
                            ID="lblSubtituloFormulario"
                            runat="server"
                            Text="Complete los datos del paciente"
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


                <asp:HiddenField ID="hfIdPaciente" runat="server" />

                <asp:Panel ID="pnlFormularioGrid" runat="server" CssClass="abml-form-grid paciente-form-grid">

                    <!-- FILA 1: DNI, NOMBRE Y APELLIDO -->
                    <asp:Panel ID="pnlCampoDni" runat="server" CssClass="form-field paciente-field-third">
                        <asp:Label ID="lblDni" runat="server" Text="DNI" CssClass="form-label"></asp:Label>

                        <asp:TextBox
                            ID="txtDni"
                            runat="server"
                            CssClass="form-control"
                            placeholder="DNI">
                        </asp:TextBox>

                        <asp:RequiredFieldValidator
                            ID="rfvDni"
                            runat="server"
                            ControlToValidate="txtDni"
                            ErrorMessage="Ingrese el DNI."
                            CssClass="text-danger"
                            Display="Dynamic"
                            ValidationGroup="GPaciente"
                            Font-Bold="True"
                            EnableClientScript="False">
                        </asp:RequiredFieldValidator>

                        <asp:CustomValidator
                            ID="cvDniRepetido"
                            runat="server"
                            ControlToValidate="txtDni"
                            ErrorMessage="Este DNI ya está registrado."
                            CssClass="text-danger"
                            Display="Dynamic"
                            ValidationGroup="GPaciente"
                            OnServerValidate="cvDniRepetido_ServerValidate"
                            Font-Bold="True"
                            EnableClientScript="False">
                        </asp:CustomValidator>
                    </asp:Panel>

                    <asp:Panel ID="pnlCampoNombre" runat="server" CssClass="form-field paciente-field-third">
                        <asp:Label ID="lblNombre" runat="server" Text="Nombre" CssClass="form-label"></asp:Label>

                        <asp:TextBox
                            ID="txtNombre"
                            runat="server"
                            CssClass="form-control"
                            placeholder="Nombre">
                        </asp:TextBox>

                        <asp:RequiredFieldValidator
                            ID="rfvNombre"
                            runat="server"
                            ControlToValidate="txtNombre"
                            ErrorMessage="Ingrese el nombre."
                            CssClass="text-danger"
                            Display="Dynamic"
                            ValidationGroup="GPaciente"
                            Font-Bold="True"
                            EnableClientScript="False">
                        </asp:RequiredFieldValidator>
                </asp:Panel>

                <asp:Panel ID="pnlCampoApellido" runat="server" CssClass="form-field paciente-field-third">
                    <asp:Label ID="lblApellido" runat="server" Text="Apellido" CssClass="form-label"></asp:Label>

                    <asp:TextBox
                        ID="txtApellido"
                        runat="server"
                        CssClass="form-control"
                        placeholder="Apellido">
                    </asp:TextBox>

                    <asp:RequiredFieldValidator
                        ID="rfvApellido"
                        runat="server"
                        ControlToValidate="txtApellido"
                        ErrorMessage="Ingrese el apellido."
                        CssClass="text-danger"
                        Display="Dynamic"
                        ValidationGroup="GPaciente"
                        Font-Bold="True"
                        EnableClientScript="False">
                    </asp:RequiredFieldValidator>
                </asp:Panel>


                <!-- FILA 2: SEXO, NACIONALIDAD Y FECHA NACIMIENTO -->
                <asp:Panel ID="pnlCampoSexo" runat="server" CssClass="form-field paciente-field-third">
                    <asp:Label ID="lblSexo" runat="server" Text="Sexo" CssClass="form-label"></asp:Label>

                    <asp:DropDownList ID="ddlSexo" runat="server" CssClass="form-control">
                        <asp:ListItem Text="--Seleccione sexo--" Value=""></asp:ListItem>
                        <asp:ListItem Text="Masculino" Value="M"></asp:ListItem>
                        <asp:ListItem Text="Femenino" Value="F"></asp:ListItem>
                        <asp:ListItem Text="Otro" Value="X"></asp:ListItem>
                    </asp:DropDownList>

                    <asp:RequiredFieldValidator
                        ID="rfvSexo"
                        runat="server"
                        ControlToValidate="ddlSexo"
                        InitialValue=""
                        ErrorMessage="Seleccione el sexo."
                        CssClass="text-danger"
                        Display="Dynamic"
                        ValidationGroup="GPaciente"
                        Font-Bold="True"
                        EnableClientScript="False">
                    </asp:RequiredFieldValidator>
                </asp:Panel>

                <asp:Panel ID="pnlCampoNacionalidad" runat="server" CssClass="form-field paciente-field-third">
                    <asp:Label ID="lblNacionalidad" runat="server" Text="Nacionalidad" CssClass="form-label"></asp:Label>

                    <asp:DropDownList ID="ddlNacionalidad" runat="server" CssClass="form-control">
                        <asp:ListItem Text="--Seleccione nacionalidad--" Value=""></asp:ListItem>
                    </asp:DropDownList>

                    <asp:RequiredFieldValidator
                        ID="rfvNacionalidad"
                        runat="server"
                        ControlToValidate="ddlNacionalidad"
                        InitialValue=""
                        ErrorMessage="Seleccione una nacionalidad."
                        CssClass="text-danger"
                        Display="Dynamic"
                        ValidationGroup="GPaciente"
                        Font-Bold="True"
                        EnableClientScript="False">
                    </asp:RequiredFieldValidator>
                </asp:Panel>

                <asp:Panel ID="pnlCampoFechaNacimiento" runat="server" CssClass="form-field paciente-field-third">
                    <asp:Label ID="lblFechaNacimiento" runat="server" Text="Fecha de nacimiento" CssClass="form-label"></asp:Label>

                    <asp:TextBox
                        ID="txtFechaNacimiento"
                        runat="server"
                        CssClass="form-control"
                        TextMode="Date">
                    </asp:TextBox>

                    <asp:RequiredFieldValidator
                        ID="rfvFechaNacimiento"
                        runat="server"
                        ControlToValidate="txtFechaNacimiento"
                        ErrorMessage="Ingrese la fecha de nacimiento."
                        CssClass="text-danger"
                        Display="Dynamic"
                        ValidationGroup="GPaciente"
                        Font-Bold="True"
                        EnableClientScript="False">
                    </asp:RequiredFieldValidator>

                    <asp:CustomValidator
                        ID="cvFechaNacimiento"
                        runat="server"
                        ControlToValidate="txtFechaNacimiento"
                        ErrorMessage="La fecha no es válida."
                        CssClass="text-danger"
                        Display="Dynamic"
                        ValidationGroup="GPaciente"
                        OnServerValidate="cvFechaNacimiento_ServerValidate"
                        Font-Bold="True"
                        EnableClientScript="False">
                    </asp:CustomValidator>
                </asp:Panel>

                <!-- FILA 3: PROVINCIA, LOCALIDAD -->
                <asp:Panel ID="pnlCampoProvincia" runat="server" CssClass="form-field paciente-field-half">
                    <asp:Label ID="lblProvincia" runat="server" Text="Provincia" CssClass="form-label"></asp:Label>

                    <asp:DropDownList
                        ID="ddlProvincia"
                        runat="server"
                        CssClass="form-control"
                        AutoPostBack="True"
                        OnSelectedIndexChanged="ddlProvincia_SelectedIndexChanged">
                        <asp:ListItem Text="--Seleccione provincia--" Value=""></asp:ListItem>
                    </asp:DropDownList>

                    <asp:RequiredFieldValidator
                        ID="rfvProvincia"
                        runat="server"
                        ControlToValidate="ddlProvincia"
                        InitialValue=""
                        ErrorMessage="Seleccione una provincia."
                        CssClass="text-danger"
                        Display="Dynamic"
                        ValidationGroup="GPaciente"
                        Font-Bold="True"
                        EnableClientScript="False">
                    </asp:RequiredFieldValidator>
                </asp:Panel>

                <asp:Panel ID="pnlCampoLocalidad" runat="server" CssClass="form-field paciente-field-half">
                    <asp:Label ID="lblLocalidad" runat="server" Text="Localidad" CssClass="form-label"></asp:Label>

                    <asp:DropDownList ID="ddlLocalidad" runat="server" CssClass="form-control">
                        <asp:ListItem Text="--Seleccione localidad--" Value=""></asp:ListItem>
                    </asp:DropDownList>

                    <asp:RequiredFieldValidator
                        ID="rfvLocalidad"
                        runat="server"
                        ControlToValidate="ddlLocalidad"
                        InitialValue=""
                        ErrorMessage="Seleccione una localidad."
                        CssClass="text-danger"
                        Display="Dynamic"
                        ValidationGroup="GPaciente"
                        Font-Bold="True"
                        EnableClientScript="False">
                    </asp:RequiredFieldValidator>
                </asp:Panel>

                <!-- FILA 4: TELEFONO, CORREO -->
                <asp:Panel ID="pnlCampoTelefono" runat="server" CssClass="form-field paciente-field-half">
                    <asp:Label ID="lblTelefono" runat="server" Text="Teléfono" CssClass="form-label"></asp:Label>

                    <asp:TextBox
                        ID="txtTelefono"
                        runat="server"
                        CssClass="form-control"
                        placeholder="Teléfono">
                    </asp:TextBox>

                    <asp:RequiredFieldValidator
                        ID="rfvTelefono"
                        runat="server"
                        ControlToValidate="txtTelefono"
                        ErrorMessage="Ingrese el teléfono."
                        CssClass="text-danger"
                        Display="Dynamic"
                        ValidationGroup="GPaciente"
                        Font-Bold="True"
                        EnableClientScript="False">
                    </asp:RequiredFieldValidator>

                    <asp:CustomValidator
                        ID="cvTelefonoRepetido"
                        runat="server"
                        ControlToValidate="txtTelefono"
                        ErrorMessage="Este teléfono ya está registrado."
                        CssClass="text-danger"
                        Display="Dynamic"
                        ValidationGroup="GPaciente"
                        OnServerValidate="cvTelefonoRepetido_ServerValidate"
                        Font-Bold="True"
                        EnableClientScript="False">
                    </asp:CustomValidator>
                </asp:Panel>

                <asp:Panel ID="pnlCampoCorreo" runat="server" CssClass="form-field paciente-field-half">
                    <asp:Label ID="lblCorreo" runat="server" Text="Correo" CssClass="form-label"></asp:Label>

                    <asp:TextBox
                        ID="txtCorreo"
                        runat="server"
                        CssClass="form-control"
                        TextMode="Email"
                        placeholder="correo@ejemplo.com">
                    </asp:TextBox>

                    <asp:RequiredFieldValidator
                        ID="rfvCorreo"
                        runat="server"
                        ControlToValidate="txtCorreo"
                        ErrorMessage="Ingrese el correo."
                        CssClass="text-danger"
                        Display="Dynamic"
                        ValidationGroup="GPaciente"
                        Font-Bold="True"
                        EnableClientScript="False">
                    </asp:RequiredFieldValidator>

                    <asp:RegularExpressionValidator
                        ID="revCorreo"
                        runat="server"
                        ControlToValidate="txtCorreo"
                        ErrorMessage="Ingrese un correo válido."
                        CssClass="text-danger"
                        Display="Dynamic"
                        ValidationGroup="GPaciente"
                        ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                        Font-Bold="True"
                        EnableClientScript="False">
                    </asp:RegularExpressionValidator>

                    
                    <asp:CustomValidator
                        ID="cvCorreoRepetido"
                        runat="server"
                        ControlToValidate="txtCorreo"
                        ErrorMessage="Este correo ya está registrado."
                        CssClass="text-danger"
                        Display="Dynamic"
                        ValidationGroup="GPaciente"
                        OnServerValidate="cvCorreoRepetido_ServerValidate"
                        Font-Bold="True"
                        EnableClientScript="False">
                    </asp:CustomValidator>
                </asp:Panel>

                <!-- FILA 5: DIRRECION -->
                <asp:Panel ID="pnlCampoDireccion" runat="server" CssClass="form-field paciente-field-full">
                    <asp:Label ID="lblDireccion" runat="server" Text="Dirección" CssClass="form-label"></asp:Label>

                    <asp:TextBox
                        ID="txtDireccion"
                        runat="server"
                        CssClass="form-control"
                        placeholder="Dirección">
                    </asp:TextBox>

                    <asp:RequiredFieldValidator
                        ID="rfvDireccion"
                        runat="server"
                        ControlToValidate="txtDireccion"
                        ErrorMessage="Ingrese la dirección."
                        CssClass="text-danger"
                        Display="Dynamic"
                        ValidationGroup="GPaciente"
                        Font-Bold="True"
                        EnableClientScript="False">
                    </asp:RequiredFieldValidator>
                </asp:Panel>

            </asp:Panel>


            <asp:Panel ID="pnlMensajePaciente" runat="server" CssClass="abml-message" Visible="False">
                <asp:Label ID="lblMensajePaciente" runat="server" Text=""></asp:Label>
            </asp:Panel>


            <asp:Panel ID="pnlBotonesFormulario" runat="server" CssClass="abml-form-actions">

                <asp:Button
                    ID="btnAgregarPaciente"
                    runat="server"
                    Text="Guardar paciente"
                    CssClass="btn btn-panel-primary"
                    ValidationGroup="GPaciente"
                    OnClick="btnAgregarPaciente_Click" />

                <asp:Button
                    ID="btnModificarPaciente"
                    runat="server"
                    Text="Guardar cambios"
                    CssClass="btn btn-panel-warning"
                    Visible="False"
                    ValidationGroup="GPaciente"
                    OnClick="btnModificarPaciente_Click" />

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