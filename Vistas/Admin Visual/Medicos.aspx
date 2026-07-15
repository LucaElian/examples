<%@ Page Title="Médicos" Language="C#" MasterPageFile="~/Panel.Master" AutoEventWireup="true" CodeBehind="Medicos.aspx.cs" Inherits="Vistas.Medicos" %>

<asp:Content ID="ContentTitle" ContentPlaceHolderID="TitleContent" runat="server">
Médicos
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="MainContent" runat="server">

<asp:Panel ID="pnlMedicos" runat="server" CssClass="inicio-container abml-container">

    <!-- LISTADO -->
    <asp:Panel ID="pnlListadoMedicos" runat="server" CssClass="panel-card abml-list-panel">

        <asp:Panel ID="pnlHeaderListado" runat="server" CssClass="panel-header compact">

            <asp:Panel ID="pnlTituloListado" runat="server">

                <asp:Label
                    ID="lblTituloListado"
                    runat="server"
                    Text="Médicos"
                    CssClass="panel-title">
                </asp:Label>

                <asp:Label
                    ID="lblSubtituloListado"
                    runat="server"
                    Text="Se muestran hasta 8 médicos por página"
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
        <asp:Panel ID="pnlBuscadorMedicos" runat="server" CssClass="abml-toolbar">

            <asp:Panel ID="pnlSearchMedico" runat="server" CssClass="abml-search-area">

                <asp:DropDownList
                    ID="ddlCampoBusqueda"
                    runat="server"
                    CssClass="form-control abml-search-select">
                    <asp:ListItem Text="ID" Value="ID"></asp:ListItem>
                    <asp:ListItem Text="DNI" Value="DNI"></asp:ListItem>
                    <asp:ListItem Text="Legajo" Value="Legajo"></asp:ListItem>
                    <asp:ListItem Text="Nombre" Value="Nombre"></asp:ListItem>
                    <asp:ListItem Text="Apellido" Value="Apellido"></asp:ListItem>
                    <asp:ListItem Text="Especialidad" Value="Especialidad"></asp:ListItem>
                </asp:DropDownList>

                <asp:TextBox
                    ID="txtFiltroMedico"
                    runat="server"
                    CssClass="form-control abml-search-input"
                    placeholder="Ingrese búsqueda">
                </asp:TextBox>

                <asp:LinkButton
                    ID="lbtnBuscarMedico"
                    runat="server"
                    CssClass="abml-search-icon"
                    Text="<i class='bi bi-search'></i>"
                    CausesValidation="False"
                    OnClick="lbtnBuscarMedico_Click"
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
        <asp:Panel ID="pnlTablaMedicos" runat="server" CssClass="table-responsive abml-table-wrapper">

            <asp:GridView
                ID="gvMedicos"
                runat="server"
                CssClass="table abml-table"
                AutoGenerateColumns="False"
                GridLines="None"
                DataKeyNames="ID"
                AllowPaging="True"
                PageSize="8"
                ShowHeaderWhenEmpty="True"
                EmptyDataText="No hay médicos cargados para mostrar."
                OnPageIndexChanging="gvMedicos_PageIndexChanging"
                OnRowCommand="gvMedicos_RowCommand">

                <PagerSettings Mode="NumericFirstLast" FirstPageText="Primera" LastPageText="Última" />
                <PagerStyle CssClass="abml-pager" />

                <Columns>

                    <asp:BoundField DataField="ID" HeaderText="ID" />
                    <asp:BoundField DataField="Legajo" HeaderText="Legajo" />
                    <asp:BoundField DataField="DNI" HeaderText="DNI" />
                    <asp:BoundField DataField="Apellido" HeaderText="Apellido" />
                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                    <asp:BoundField DataField="Especialidad" HeaderText="Especialidad" />
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

                            <asp:Panel ID="pnlAccionesMedico" runat="server" CssClass="grid-actions">

                                <asp:LinkButton
                                    ID="lbtnEditarMedico"
                                    runat="server"
                                    Text="<i class='bi bi-pencil-square'></i>"
                                    ToolTip="Modificar médico"
                                    CssClass="grid-action-btn action-edit"
                                    CommandName="EditarMedico"
                                    CommandArgument='<%# Eval("ID") %>'
                                    CausesValidation="False">
                                </asp:LinkButton>

                                <asp:LinkButton
                                    ID="lbtnHorariosMedico"
                                    runat="server"
                                    Text="<i class='bi bi-calendar-week'></i>"
                                    ToolTip="Asignar horarios"
                                    CssClass="grid-action-btn action-schedule"
                                    CommandName="HorariosMedico"
                                    CommandArgument='<%# Eval("ID") %>'
                                    CausesValidation="False">
                                </asp:LinkButton>

                                <asp:LinkButton
                                    ID="lbtnCambiarEstadoMedico"
                                    runat="server"
                                    Text='<%# Convert.ToBoolean(Eval("Estado")) ? "<i class=\"bi bi-person-dash\"></i>" : "<i class=\"bi bi-person-check\"></i>" %>'
                                    ToolTip='<%# Convert.ToBoolean(Eval("Estado")) ? "Desactivar médico" : "Activar médico" %>'
                                    CssClass='<%# Convert.ToBoolean(Eval("Estado")) ? "grid-action-btn action-disable" : "grid-action-btn action-active" %>'
                                    CommandName="CambiarEstadoMedico"
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
                Text="Agregar nuevo médico"
                CssClass="btn btn-panel-primary"
                CausesValidation="False"
                OnClick="btnAbrirModalAgregar_Click" />

        </asp:Panel>

    </asp:Panel>


    <!-- MODAL / VENTANA EMERGENTE -->
    <asp:Panel ID="pnlModalFormulario" runat="server" CssClass="abml-modal-overlay" Visible="False">

        <asp:Panel ID="pnlModalMedico" runat="server" CssClass="abml-modal">

            <asp:Panel ID="pnlModalHeader" runat="server" CssClass="abml-modal-header">

                <asp:Panel ID="pnlModalTitulo" runat="server">

                    <asp:Label
                        ID="lblTituloFormulario"
                        runat="server"
                        Text="Agregar médico"
                        CssClass="abml-modal-title">
                    </asp:Label>

                    <asp:Label
                        ID="lblSubtituloFormulario"
                        runat="server"
                        Text="Complete los datos del médico"
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


            <asp:HiddenField ID="hfIdMedico" runat="server" />

            <asp:Panel ID="pnlFormularioGrid" runat="server" CssClass="abml-form-grid">

                <!-- FILA 1: DATOS PRINCIPALES -->
                <asp:Panel ID="pnlCampoLegajo" runat="server" CssClass="form-field">
                    <asp:Label ID="lblLegajo" runat="server" Text="Legajo" CssClass="form-label"></asp:Label>

                    <asp:TextBox
                        ID="txtLegajo"
                        runat="server"
                        CssClass="form-control"
                        placeholder="Legajo">
                    </asp:TextBox>

                    <asp:RequiredFieldValidator
                        ID="rfvLegajo"
                        runat="server"
                        ControlToValidate="txtLegajo"
                        ErrorMessage="Ingrese el legajo."
                        CssClass="text-danger"
                        Display="Dynamic"
                        ValidationGroup="GMedico"
                        Font-Bold="True"
                        EnableClientScript="False">
                    </asp:RequiredFieldValidator>

                    <asp:CustomValidator
                        ID="cvLegajoRepetido"
                        runat="server"
                        ControlToValidate="txtLegajo"
                        ErrorMessage="Este legajo ya está registrado."
                        CssClass="text-danger"
                        Display="Dynamic"
                        ValidationGroup="GMedico"
                        OnServerValidate="cvLegajoRepetido_ServerValidate"
                        Font-Bold="True"
                        EnableClientScript="False">
                    </asp:CustomValidator>
                </asp:Panel>

                <asp:Panel ID="pnlCampoDni" runat="server" CssClass="form-field">
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
                        ValidationGroup="GMedico"
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
                        ValidationGroup="GMedico"
                        OnServerValidate="cvDniRepetido_ServerValidate"
                        Font-Bold="True"
                        EnableClientScript="False">
                    </asp:CustomValidator>
                </asp:Panel>

                <asp:Panel ID="pnlCampoEspecialidad" runat="server" CssClass="form-field">
                    <asp:Label ID="lblEspecialidad" runat="server" Text="Especialidad" CssClass="form-label"></asp:Label>

                    <asp:DropDownList ID="ddlEspecialidad" runat="server" CssClass="form-control">
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
                        ValidationGroup="GMedico"
                        Font-Bold="True"
                        EnableClientScript="False">
                    </asp:RequiredFieldValidator>
                </asp:Panel>


                <!-- FILA 2: NOMBRE Y SEXO -->
                <asp:Panel ID="pnlCampoNombre" runat="server" CssClass="form-field">
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
                        ValidationGroup="GMedico"
                        Font-Bold="True"
                        EnableClientScript="False">
                    </asp:RequiredFieldValidator>
                </asp:Panel>

                <asp:Panel ID="pnlCampoApellido" runat="server" CssClass="form-field">
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
                        ValidationGroup="GMedico"
                        Font-Bold="True"
                        EnableClientScript="False">
                    </asp:RequiredFieldValidator>
                </asp:Panel>

                <asp:Panel ID="pnlCampoSexo" runat="server" CssClass="form-field">
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
                        ValidationGroup="GMedico"
                        Font-Bold="True"
                        EnableClientScript="False">
                    </asp:RequiredFieldValidator>
                </asp:Panel>


                <!-- FILA 3: NACIONALIDAD Y UBICACIÓN -->
                <asp:Panel ID="pnlCampoNacionalidad" runat="server" CssClass="form-field">
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
                        ValidationGroup="GMedico"
                        Font-Bold="True"
                        EnableClientScript="False">
                    </asp:RequiredFieldValidator>
                </asp:Panel>

                <asp:Panel ID="pnlCampoProvincia" runat="server" CssClass="form-field">
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
                        ValidationGroup="GMedico"
                        Font-Bold="True"
                        EnableClientScript="False">
                    </asp:RequiredFieldValidator>
                </asp:Panel>

                <asp:Panel ID="pnlCampoLocalidad" runat="server" CssClass="form-field">
                    <asp:Label ID="lblLocalidad" runat="server" Text="Localidad" CssClass="form-label"></asp:Label>

                    <asp:DropDownList ID="ddlLocalidad" runat="server" CssClass="form-control" Enabled="False">
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
                        ValidationGroup="GMedico"
                        Font-Bold="True"
                        EnableClientScript="False">
                    </asp:RequiredFieldValidator>
                </asp:Panel>


                <!-- FILA 4: FECHA Y CONTACTO -->
                <asp:Panel ID="pnlCampoFechaNacimiento" runat="server" CssClass="form-field">
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
                        ValidationGroup="GMedico"
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
                        ValidationGroup="GMedico"
                        OnServerValidate="cvFechaNacimiento_ServerValidate"
                        Font-Bold="True"
                        EnableClientScript="False">
                    </asp:CustomValidator>
                </asp:Panel>

                <asp:Panel ID="pnlCampoTelefono" runat="server" CssClass="form-field">
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
                        ValidationGroup="GMedico"
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
                        ValidationGroup="GMedico"
                        OnServerValidate="cvTelefonoRepetido_ServerValidate"
                        Font-Bold="True"
                        EnableClientScript="False">
                    </asp:CustomValidator>
                </asp:Panel>

                <asp:Panel ID="pnlCampoCorreo" runat="server" CssClass="form-field">
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
                        ValidationGroup="GMedico"
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
                        ValidationGroup="GMedico"
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
                        ValidationGroup="GMedico"
                        OnServerValidate="cvCorreoRepetido_ServerValidate"
                        Font-Bold="True"
                        EnableClientScript="False">
                    </asp:CustomValidator>
                </asp:Panel>


                <!-- FILA 5: DIRECCIÓN -->
                <asp:Panel ID="pnlCampoDireccion" runat="server" CssClass="form-field form-field-wide">
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
                        ValidationGroup="GMedico"
                        Font-Bold="True"
                        EnableClientScript="False">
                    </asp:RequiredFieldValidator>
                </asp:Panel>

            </asp:Panel>


            <asp:Panel ID="pnlMensajeMedico" runat="server" CssClass="abml-message" Visible="False">
                <asp:Label ID="lblMensajeMedico" runat="server" Text=""></asp:Label>
            </asp:Panel>


            <asp:Panel ID="pnlBotonesFormulario" runat="server" CssClass="abml-form-actions">

                <asp:Button
                    ID="btnAgregarMedico"
                    runat="server"
                    Text="Guardar médico"
                    CssClass="btn btn-panel-primary"
                    ValidationGroup="GMedico"
                    OnClick="btnAgregarMedico_Click" />

                <asp:Button
                    ID="btnModificarMedico"
                    runat="server"
                    Text="Guardar cambios"
                    CssClass="btn btn-panel-warning"
                    Visible="False"
                    ValidationGroup="GMedico"
                    OnClick="btnModificarMedico_Click" />

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


    <!-- MODAL HORARIOS -->
    <asp:Panel ID="pnlModalHorarios" runat="server" CssClass="abml-modal-overlay" Visible="False">

        <asp:Panel ID="pnlModalHorariosContenido" runat="server" CssClass="abml-modal horarios-modal">

            <asp:Panel ID="pnlHeaderHorarios" runat="server" CssClass="abml-modal-header">

                <asp:Panel ID="pnlTituloHorarios" runat="server">

                    <asp:Label
                        ID="lblTituloHorarios"
                        runat="server"
                        Text="Horarios del médico"
                        CssClass="abml-modal-title">
                    </asp:Label>

                    <asp:Label
                        ID="lblSubtituloHorarios"
                        runat="server"
                        Text="Agregue o quite horarios de atención"
                        CssClass="abml-modal-subtitle">
                    </asp:Label>

                </asp:Panel>

                <asp:LinkButton
                    ID="lbtnCerrarHorarios"
                    runat="server"
                    Text="<i class='bi bi-x-lg'></i>"
                    CssClass="abml-modal-close"
                    CausesValidation="False"
                    OnClick="lbtnCerrarHorarios_Click">
                </asp:LinkButton>

            </asp:Panel>


            <asp:HiddenField ID="hfIdMedicoHorario" runat="server" />


            <!-- FORMULARIO HORARIO -->
            <asp:Panel ID="pnlFormularioHorario" runat="server" CssClass="abml-form-grid">

                <asp:Panel ID="pnlCampoDiaHorario" runat="server" CssClass="form-field">

                    <asp:Label
                        ID="lblDiaHorario"
                        runat="server"
                        Text="Día"
                        CssClass="form-label">
                    </asp:Label>

                    <asp:DropDownList
                        ID="ddlDiaHorario"
                        runat="server"
                        CssClass="form-control">
                        <asp:ListItem Text="--Seleccione día--" Value=""></asp:ListItem>
                        <asp:ListItem Text="Lunes" Value="Lunes"></asp:ListItem>
                        <asp:ListItem Text="Martes" Value="Martes"></asp:ListItem>
                        <asp:ListItem Text="Miércoles" Value="Miercoles"></asp:ListItem>
                        <asp:ListItem Text="Jueves" Value="Jueves"></asp:ListItem>
                        <asp:ListItem Text="Viernes" Value="Viernes"></asp:ListItem>
                        <asp:ListItem Text="Sábado" Value="Sabado"></asp:ListItem>
                        <asp:ListItem Text="Domingo" Value="Domingo"></asp:ListItem>
                    </asp:DropDownList>

                    <asp:RequiredFieldValidator 
                        ID="rfvDiaHorario" 
                        runat="server" 
                        ControlToValidate="ddlDiaHorario" 
                        InitialValue="" 
                        ErrorMessage="Seleccione un día." 
                        CssClass="text-danger" 
                        Display="Dynamic" 
                        ValidationGroup="GHorario" 
                        Font-Bold="True" 
                        EnableClientScript="False"> 
                    </asp:RequiredFieldValidator>

                </asp:Panel>


                <asp:Panel ID="pnlCampoHoraInicio" runat="server" CssClass="form-field">

                    <asp:Label
                        ID="lblHoraInicio"
                        runat="server"
                        Text="Hora inicio"
                        CssClass="form-label">
                    </asp:Label>

                    <asp:Panel ID="pnlHoraInicioSelects" runat="server" CssClass="hora-select-row">

                        <asp:DropDownList
                            ID="ddlHoraInicio"
                            runat="server"
                            CssClass="form-control hora-select"
                            AutoPostBack="True"
                            OnSelectedIndexChanged="ddlHoraInicio_SelectedIndexChanged">
                            <asp:ListItem Text="HH" Value=""></asp:ListItem>
                            <asp:ListItem Text="07" Value="7"></asp:ListItem>
                            <asp:ListItem Text="08" Value="8"></asp:ListItem>
                            <asp:ListItem Text="09" Value="9"></asp:ListItem>
                            <asp:ListItem Text="10" Value="10"></asp:ListItem>
                            <asp:ListItem Text="11" Value="11"></asp:ListItem>
                            <asp:ListItem Text="12" Value="12"></asp:ListItem>
                            <asp:ListItem Text="13" Value="13"></asp:ListItem>
                            <asp:ListItem Text="14" Value="14"></asp:ListItem>
                            <asp:ListItem Text="15" Value="15"></asp:ListItem>
                            <asp:ListItem Text="16" Value="16"></asp:ListItem>
                            <asp:ListItem Text="17" Value="17"></asp:ListItem>
                            <asp:ListItem Text="18" Value="18"></asp:ListItem>
                            <asp:ListItem Text="19" Value="19"></asp:ListItem>
                        </asp:DropDownList>

                        <span class="hora-separador">:</span>

                        <asp:DropDownList
                            ID="ddlMinutoInicio"
                            runat="server"
                            CssClass="form-control minuto-select"
                            AutoPostBack="True"
                            OnSelectedIndexChanged="ddlHoraInicio_SelectedIndexChanged">
                            <asp:ListItem Text="MM" Value=""></asp:ListItem>
                            <asp:ListItem Text="00" Value="0"></asp:ListItem>
                            <asp:ListItem Text="15" Value="15"></asp:ListItem>
                            <asp:ListItem Text="30" Value="30"></asp:ListItem>
                            <asp:ListItem Text="45" Value="45"></asp:ListItem>
                        </asp:DropDownList>

                    </asp:Panel>

                    <asp:RequiredFieldValidator 
                        ID="rfvHoraInicio" 
                        runat="server" 
                        ControlToValidate="ddlHoraInicio" 
                        InitialValue=""
                        ErrorMessage="Seleccione la hora de inicio." 
                        CssClass="text-danger" 
                        Display="Dynamic" 
                        ValidationGroup="GHorario" 
                        Font-Bold="True" 
                        EnableClientScript="False"> 
                    </asp:RequiredFieldValidator>

                    <asp:RequiredFieldValidator 
                        ID="rfvMinutoInicio" 
                        runat="server" 
                        ControlToValidate="ddlMinutoInicio" 
                        InitialValue=""
                        ErrorMessage="Seleccione los minutos de inicio." 
                        CssClass="text-danger" 
                        Display="Dynamic" 
                        ValidationGroup="GHorario" 
                        Font-Bold="True" 
                        EnableClientScript="False"> 
                    </asp:RequiredFieldValidator>

                </asp:Panel>


                <asp:Panel ID="pnlCampoHoraFin" runat="server" CssClass="form-field">

                    <asp:Label
                        ID="lblHoraFin"
                        runat="server"
                        Text="Hora fin"
                        CssClass="form-label">
                    </asp:Label>

                    <asp:Panel ID="pnlHoraFinSelects" runat="server" CssClass="hora-select-row">

                        <asp:DropDownList
                            ID="ddlHoraFin"
                            runat="server"
                            CssClass="form-control hora-select"
                            AutoPostBack="True"
                            OnSelectedIndexChanged="ddlHoraFin_SelectedIndexChanged"
                            Enabled="False">
                            <asp:ListItem Text="HH" Value=""></asp:ListItem>
                        </asp:DropDownList>

                        <span class="hora-separador">:</span>

                        <asp:DropDownList
                            ID="ddlMinutoFin"
                            runat="server"
                            CssClass="form-control minuto-select"
                            Enabled="False">
                            <asp:ListItem Text="MM" Value=""></asp:ListItem>
                        </asp:DropDownList>

                    </asp:Panel>

                    <asp:RequiredFieldValidator 
                        ID="rfvHoraFin" 
                        runat="server" 
                        ControlToValidate="ddlHoraFin" 
                        InitialValue=""
                        ErrorMessage="Seleccione la hora de fin." 
                        CssClass="text-danger"
                        Display="Dynamic" 
                        ValidationGroup="GHorario" 
                        Font-Bold="True" 
                        EnableClientScript="False"> 
                    </asp:RequiredFieldValidator>

                    <asp:RequiredFieldValidator 
                        ID="rfvMinutoFin" 
                        runat="server" 
                        ControlToValidate="ddlMinutoFin" 
                        InitialValue=""
                        ErrorMessage="Seleccione los minutos de fin." 
                        CssClass="text-danger"
                        Display="Dynamic" 
                        ValidationGroup="GHorario" 
                        Font-Bold="True" 
                        EnableClientScript="False"> 
                    </asp:RequiredFieldValidator>

                    <asp:CustomValidator 
                        ID="cvHorarioSuperpuesto" 
                        runat="server" 
                        ControlToValidate="ddlMinutoFin" 
                        ErrorMessage="El médico ya tiene un horario cargado que se superpone con ese rango." 
                        CssClass="text-danger" 
                        Display="Dynamic" 
                        ValidationGroup="GHorario" 
                        OnServerValidate="cvHorarioSuperpuesto_ServerValidate" 
                        Font-Bold="True" 
                        EnableClientScript="False"> 
                    </asp:CustomValidator>

                </asp:Panel>

            </asp:Panel>


            <asp:Panel ID="pnlMensajeHorario" runat="server" CssClass="abml-message" Visible="False">
                <asp:Label ID="lblMensajeHorario" runat="server" Text=""></asp:Label>
            </asp:Panel>


            <asp:Panel ID="pnlBotonesHorario" runat="server" CssClass="abml-form-actions">

                <asp:Button
                    ID="btnAgregarHorario"
                    runat="server"
                    Text="Agregar horario"
                    CssClass="btn btn-panel-primary"
                    ValidationGroup="GHorario"
                    OnClick="btnAgregarHorario_Click" />

            </asp:Panel>


            <!-- TABLA HORARIOS -->
            <asp:Panel ID="pnlTablaHorarios" runat="server" CssClass="table-responsive abml-table-wrapper mt-3">

                <asp:GridView
                    ID="gvHorarios"
                    runat="server"
                    CssClass="table abml-table horarios-table"
                    AutoGenerateColumns="False"
                    GridLines="None"
                    ShowHeaderWhenEmpty="True"
                    EmptyDataText="Este médico no tiene horarios cargados."
                    AllowPaging="True"
                    PageSize="5"
                    OnPageIndexChanging="gvHorarios_PageIndexChanging"
                    OnRowCommand="gvHorarios_RowCommand">

                    <PagerSettings Mode="NumericFirstLast" FirstPageText="Primera" LastPageText="Última" />
                    <PagerStyle CssClass="abml-pager" />

                    <Columns>

                        <asp:BoundField DataField="Dia" HeaderText="Día" />
                        <asp:BoundField DataField="HoraInicioTexto" HeaderText="Desde" />
                        <asp:BoundField DataField="HoraFinTexto" HeaderText="Hasta" />

                        <asp:TemplateField HeaderText="Estado">
                            <ItemTemplate>
                                <asp:Label
                                    ID="lblEstadoHorario"
                                    runat="server"
                                    Text='<%# Eval("EstadoTexto") %>'
                                    CssClass='<%# Eval("EstadoCSS") %>'>
                                </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Acciones">
                            <ItemTemplate>

                                <asp:Panel ID="pnlAccionesHorario" runat="server" CssClass="grid-actions">

                                    <asp:LinkButton
                                        ID="lbtnCambiarEstadoHorario"
                                        runat="server"
                                        Text='<%# Convert.ToBoolean(Eval("Estado")) ? "<i class=\"bi bi-calendar-x\"></i>" : "<i class=\"bi bi-calendar-check\"></i>" %>'
                                        ToolTip='<%# Convert.ToBoolean(Eval("Estado")) ? "Desactivar horario" : "Activar horario" %>'
                                        CssClass='<%# Convert.ToBoolean(Eval("Estado")) ? "grid-action-btn action-disable" : "grid-action-btn action-active" %>'
                                        CommandName="CambiarEstadoHorario"
                                        CommandArgument='<%# Eval("IDHorario").ToString() + "|" + Eval("Estado").ToString() %>'
                                        CausesValidation="False">
                                    </asp:LinkButton>

                                    <asp:LinkButton
                                        ID="lbtnEliminarHorario"
                                        runat="server"
                                        Text="<i class='bi bi-trash'></i>"
                                        ToolTip="Eliminar horario"
                                        CssClass="grid-action-btn action-disable"
                                        CommandName="EliminarHorario"
                                        CommandArgument='<%# Eval("IDHorario") %>'
                                        CausesValidation="False"
                                        OnClientClick="return confirm('¿Seguro que desea eliminar este horario?');">
                                    </asp:LinkButton>

                                </asp:Panel>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </asp:Panel>
        </asp:Panel>
    </asp:Panel>
</asp:Panel>
</asp:Content>