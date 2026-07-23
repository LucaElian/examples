# Sistema de gestiÃ³n para clÃ­nica mÃ©dica

> Nota de identificaciÃ³n: el pedido de documentaciÃ³n menciona **ClÃ­nica MÃ©dica OSCAMI**, pero los archivos actuales del repositorio muestran la marca visible **ClÃ­nica MÃ©dica VITALIA** en `Vistas/Login.aspx`, `Vistas/Panel.Master` y en el script de datos precargados. Este README documenta el sistema tal como existe en el cÃ³digo fuente. Si el nombre institucional definitivo es OSCAMI, deberÃ­a actualizarse tambiÃ©n en las pantallas y scripts para mantener consistencia.

## 1. PresentaciÃ³n

Este repositorio contiene una aplicaciÃ³n web desarrollada con ASP.NET Web Forms para administrar la operaciÃ³n de una clÃ­nica mÃ©dica. El sistema centraliza la gestiÃ³n de pacientes, mÃ©dicos, horarios de atenciÃ³n, turnos, cuentas de usuario, paneles de seguimiento e informaciÃ³n operativa para perfiles administrativos y mÃ©dicos.

La soluciÃ³n estÃ¡ organizada en una arquitectura por capas con proyectos separados para entidades, acceso a datos, negocio y presentaciÃ³n. La aplicaciÃ³n utiliza SQL Server como motor de base de datos, ADO.NET para ejecutar consultas parametrizadas y controles Web Forms para formularios, grillas, modales, validadores y navegación.

## 2. Descripción general del proyecto

El sistema resuelve una necesidad administrativa frecuente en una institución mÃ©dica: mantener en un mismo entorno la informaciÃ³n de pacientes, profesionales, disponibilidad horaria y turnos. La aplicaciÃ³n permite que el personal administrativo registre y mantenga datos maestros, genere turnos para pacientes activos y consulte indicadores de actividad. A su vez, los mÃ©dicos pueden acceder a sus turnos pendientes, registrar la asistencia de los pacientes y consultar historiales y estadÃ­sticas propias.

El flujo general parte de una pantalla de inicio de sesiÃ³n. Una vez autenticado el usuario, el sistema identifica su rol y lo redirige al panel correspondiente. Las pÃ¡ginas protegidas verifican la sesiÃ³n y el rol antes de permitir el acceso. El administrador trabaja sobre pÃ¡ginas ABML con grillas, buscadores, paginaciÃ³n y modales. El mÃ©dico accede a vistas orientadas a su propia actividad, filtradas por el identificador de mÃ©dico almacenado en sesiÃ³n.

## 3. Objetivos del sistema

### Objetivo general

Brindar una aplicaciÃ³n web para administrar informaciÃ³n clÃ­nica operativa bÃ¡sica, permitiendo gestionar pacientes, mÃ©dicos, horarios y turnos, diferenciando las acciones disponibles segÃºn el rol del usuario autenticado.

### Objetivos específicos

- Autenticar usuarios activos mediante usuario, contraseÃ±a y rol.
- Separar el acceso entre administradores y mÃ©dicos.
- Gestionar pacientes con alta, modificaciÃ³n, búsqueda, paginaciÃ³n y cambio de estado.
- Gestionar mÃ©dicos, sus datos personales, su especialidad, su cuenta asociada y sus horarios de atenciÃ³n.
- Crear y modificar turnos, vinculando paciente, mÃ©dico, fecha, hora, usuario creador y estado de asistencia.
- Calcular horarios disponibles a partir de la agenda del mÃ©dico y turnos ya asignados.
- Permitir al mÃ©dico revisar turnos pendientes y registrar asistencia.
- Consultar historial de turnos atendidos por mÃ©dico.
- Consultar estadÃ­sticas de presentismo por paciente para el mÃ©dico logueado.
- Presentar indicadores administrativos de pacientes, mÃ©dicos, turnos y asistencia.
- Mantener la separación entre presentaciÃ³n, negocio, datos y entidades.

## 4. Alcance funcional actual

| Área | Usuario | Alcance implementado |
| --- | --- | --- |
| Inicio de sesiÃ³n | Administrador y mÃ©dico | ValidaciÃ³n de usuario, contraseÃ±a y estado activo. RedirecciÃ³n segÃºn rol. |
| Restablecimiento de contraseÃ±a | Usuario con cuenta activa | Modal con usuario, nueva contraseÃ±a y confirmación. Valida existencia y estado activo. |
| Pacientes | Administrador | Alta, modificaciÃ³n, activación/desactivación lÃ³gica, búsqueda y paginaciÃ³n. |
| MÃ©dicos | Administrador | Alta, modificaciÃ³n, activación/desactivación, cuenta automática de mÃ©dico y horarios. |
| Horarios | Administrador | Alta, listado, activación/desactivación y baja lÃ³gica de horarios por mÃ©dico. |
| Turnos | Administrador | Listado, modificaciÃ³n, activación/desactivación y creación desde modal global. |
| Cuentas | Administrador | Consulta paginada y filtrada de usuarios. No hay ABML completo de cuentas en la pÃ¡gina actual. |
| Informes | Administrador | Dos reportes puntuales sobre demanda y cantidad de turnos en julio. |
| Inicio mÃ©dico | MÃ©dico | Turnos pendientes del mÃ©dico logueado, búsqueda, paginaciÃ³n y revisión de asistencia. |
| Historial mÃ©dico | MÃ©dico | Consulta de turnos presentes o ausentes con filtros. |
| EstadÃ­sticas mÃ©dico | MÃ©dico | Resumen por paciente con presentes, ausentes, total, presentismo y Ãºltimo turno. |

## 5. Tipos de usuario y permisos

### Administrador

El rol `Administrador` estÃ¡ definido en la tabla `Usuarios` y validado en `NegocioUsuario.esAdministrador`. Cuando inicia sesiÃ³n correctamente, se guarda el rol en `Session["Rol"]` y se redirige a `~/Admin Visual/InicioAdmin.aspx`.

El administrador puede acceder al panel lateral con las pÃ¡ginas:

- `Pacientes.aspx`
- `Medicos.aspx`
- `Cuentas.aspx`
- `Turnos.aspx`
- `Informes.aspx`

TambiÃ©n ve el botón `Ingresar turno` en la barra lateral, que abre el user control `Vistas/Admin Visual/ModalCrearTurno.ascx`.

### MÃ©dico

El rol `Medico` tambiÃ©n se define en `Usuarios`. Los usuarios mÃ©dicos poseen una relación opcional con `Medicos` mediante `IDMedico_Usuario`. Cuando un mÃ©dico inicia sesiÃ³n, `Login.aspx.cs` almacena `Session["IDMedico"]` y redirige a `~/Medico Visual/InicioMedico.aspx`.

El mÃ©dico puede acceder al menú mÃ©dico:

- `Historial.aspx`
- `Estadisticas.aspx`

Además, su pÃ¡gina inicial muestra turnos pendientes y permite revisar asistencia. Las consultas se filtran con el ID de mÃ©dico tomado de la sesiÃ³n.

### Protección de pÃ¡ginas

La clase `Vistas/Utilities/PaginaProtegida.cs` define:

- `PaginaProtegida`, clase base abstracta.
- `PaginaAdmin`, que exige rol `Administrador`.
- `PaginaMedico`, que exige rol `Medico` y requiere `Session["IDMedico"]`.

Durante `OnInit`, la clase valida que existan `Session["IDUsuario"]` y `Session["Rol"]`. Si no existen, redirige al login. Si el rol no coincide con el requerido, redirige al inicio que corresponda al rol real. El control de acceso es simple y basado en sesiÃ³n, no un esquema avanzado de permisos granulares.

## 6. MÃ³dulos funcionales

### 6.1 Inicio de sesiÃ³n

La pÃ¡gina `Vistas/Login.aspx` solicita usuario y contraseÃ±a. Ambos campos tienen `RequiredFieldValidator` dentro del grupo `GLogin`. El botón `Iniciar sesion` invoca `btnIngresar_Click`, que usa `NegocioUsuario.validarLogin`.

La capa de datos consulta la tabla `Usuarios` con comparacion sensible a mayusculas y minusculas mediante `COLLATE Latin1_General_CS_AS`, filtra por contraseÃ±a y exige `Estado = 1`. Si no hay coincidencia, el login muestra un mensaje de error. Si el usuario existe, se cargan datos en sesiÃ³n y se redirige segÃºn rol.

### 6.2 Restablecimiento de contraseÃ±a

El login incluye un enlace para abrir un modal de restablecimiento. El modal contiene:

- Usuario.
- Nueva contraseÃ±a.
- Repetir nueva contraseÃ±a.

Las validaciones pertenecen al grupo `GRestablecerContrasenia`. El usuario es obligatorio y se valida con `CustomValidator`, que llama a `NegocioUsuario.existeUsuarioActivo`. La nueva contraseÃ±a es obligatoria y la repetición se compara con `CompareValidator`.

Cuando se confirma el cambio, `Login.aspx.cs` llama a `NegocioUsuario.restablecerContrasenia`, que delega en `DaoUsuario.restablecerContrasenia`. El DAO actualiza la tabla `Usuarios` para cuentas activas. El sistema muestra mensajes de resultado en el modal.

Limitacion importante: no existe envio de correo, token temporal ni verificacion de identidad adicional. La contraseÃ±a se cambia directamente si se conoce un usuario activo y se completan los campos requeridos.

### 6.3 Panel del administrador

`InicioAdmin.aspx` presenta indicadores operativos:

- Distribucion de turnos por especialidad del mes actual.
- Cantidad de pacientes activos.
- Cantidad de mÃ©dicos activos.
- Turnos pendientes vencidos o del dÃ­a.
- Turnos del dÃ­a.
- Resumen mensual de asistencias presentes, ausentes y pendientes.

La informaciÃ³n se obtiene mediante `NegocioTurno`, `NegocioPaciente` y `NegocioMedico`, con consultas agregadas en los DAO.

### 6.4 GestiÃ³n de pacientes

`Pacientes.aspx` permite listar pacientes en una `GridView` con paginaciÃ³n de 8 registros, búsqueda por ID, DNI, nombre o apellido, y acciones de editar o cambiar estado.

El formulario modal permite cargar o modificar:

- DNI.
- Nombre y apellido.
- Sexo.
- Nacionalidad.
- Fecha de nacimiento.
- Provincia y localidad.
- TelÃ©fono.
- Correo.
- DirecciÃ³n.

Las validaciones combinan `RequiredFieldValidator`, `RegularExpressionValidator` para correo y `CustomValidator` para DNI, telÃ©fono, correo repetidos y fecha de nacimiento no futura. La persistencia se realiza por `NegocioPaciente` y `DaoPaciente`.

### 6.5 GestiÃ³n de mÃ©dicos

`Medicos.aspx` lista profesionales con paginaciÃ³n, búsqueda y acciones para editar, administrar horarios o cambiar estado. El mÃ©dico tiene datos personales similares al paciente, mÃ¡s legajo y especialidad.

Al agregar un mÃ©dico, `DaoMedico.agregarMedico` inserta el registro del mÃ©dico y crea un usuario asociado con rol `Medico` dentro de una transacción SQL. La cuenta inicial usa el legajo como usuario y el DNI como contraseÃ±a, segÃºn el cÃ³digo actual.

El cambio de estado del mÃ©dico tambiÃ©n actualiza el estado de su usuario asociado. Esto mantiene sincronizada la disponibilidad del profesional y su capacidad de iniciar sesiÃ³n.

### 6.6 GestiÃ³n de horarios

Dentro de `Medicos.aspx` existe un modal especifico para horarios. Permite seleccionar dÃ­a, hora de inicio y hora de fin. Los horarios se almacenan en la tabla `Horarios` con estado logico.

El sistema valida:

- DÃ­a obligatorio.
- Hora y minuto de inicio obligatorios.
- Hora y minuto de fin obligatorios.
- Superposicion con otros horarios activos del mismo mÃ©dico y dÃ­a.
- Al reactivar un horario, que no se superponga con otro horario activo.

La capa de datos tambiÃ©n define restricciones SQL para que `HoraInicio < HoraFin` y para evitar repetir mismo mÃ©dico, dÃ­a y hora de inicio.

### 6.7 GestiÃ³n de turnos

`Turnos.aspx` muestra una grilla paginada de turnos con búsqueda por ID, paciente, mÃ©dico, asistencia o fecha. Permite modificar turnos existentes y cambiar su estado logico.

La modificaciÃ³n del turno permite seleccionar paciente, especialidad, mÃ©dico, fecha, hora disponible, estado de asistencia y observación. Los estados de asistencia definidos son `Pendiente`, `Presente` y `Ausente`.

La disponibilidad horaria se calcula en `DaoTurno.getHorariosDisponibles`: toma los horarios activos del mÃ©dico para el dÃ­a de la semana, descuenta turnos existentes del mismo mÃ©dico y fecha, y genera posibles horarios de una hora con intervalos de 15 minutos.

### 6.8 Modal para crear turnos

El control `Vistas/Admin Visual/ModalCrearTurno.ascx` se registra en `Panel.Master` y se abre desde el botón `Ingresar turno` visible solo para administradores.

El modal solicita paciente, especialidad, mÃ©dico, fecha y hora disponible. La fecha no puede ser anterior al dÃ­a actual, controlado con atributo `min` y con `CustomValidator`. Al guardar, crea un turno con:

- `EstadoAsistencia = "Pendiente"`.
- `Estado = true`.
- `IDUsuarioCreador` tomado de la sesiÃ³n.
- Observación vacia.

Si se crea desde el inicio administrativo, el control recarga la pÃ¡gina para actualizar los indicadores.

### 6.9 Cuentas de usuario

`Cuentas.aspx` lista usuarios con filtros por ID, nombre completo, ID de mÃ©dico, usuario y rol. La pÃ¡gina permite consultar estado de cuenta, pero no implementa alta, edicion o cambio de estado desde la interfaz. La gestiÃ³n de cuentas medicas se produce indirectamente al crear o cambiar estado de un mÃ©dico.

### 6.10 Informes administrativos

`Informes.aspx` muestra dos reportes:

- DÃ­a con mayor demanda de turnos en julio.
- MÃ©dico con mayor cantidad de turnos asignados en julio.

Ambos reportes se calculan en `DaoTurno` con consultas SQL. El mes estÃ¡ fijo en el cÃ³digo de datos como `MONTH(Fecha) = 7`.

### 6.11 Inicio mÃ©dico y revisión de turnos

`InicioMedico.aspx` muestra los turnos pendientes del mÃ©dico logueado, filtrando por mÃ©dico, estado activo, asistencia pendiente y fecha menor o igual a la fecha actual. La vista usa tarjetas y paginaciÃ³n manual de 6 turnos por pÃ¡gina.

El mÃ©dico puede abrir un modal de revisión, elegir resultado `Presente` o `Ausente` y guardar. Si el resultado es `Presente`, se habilita un campo de observación. El guardado actualiza `EstadoAsistencia` y `Observacion` mediante `NegocioTurno.revisarTurnoMedico`.

### 6.12 Historial y estadÃ­sticas del mÃ©dico

`Historial.aspx` lista turnos del mÃ©dico logueado ya marcados como `Presente` o `Ausente`, con filtros por ID, paciente, DNI, fecha y asistencia. La grilla pÃ¡gina 15 registros.

`Estadisticas.aspx` agrupa los turnos atendidos por paciente y muestra presentes, ausentes, total, porcentaje de presentismo y Ãºltimo turno registrado. TambiÃ©n permite filtrar por paciente o DNI.

## 7. Arquitectura del sistema

El repositorio estÃ¡ dividido en cuatro proyectos principales:

```text
Usuario
   |
Capa de presentacion: Vistas
   |
Capa de negocio: Negocio
   |
Capa de acceso a datos: Datos
   |
Base de datos SQL Server: Clinica_TPI
```

### Entidades

El proyecto `Entidades` contiene clases simples del dominio:

- `Personas`
- `Pacientes`
- `Medicos`
- `Usuarios`
- `Turnos`
- `Horarios`

Estas clases transportan datos entre la presentaciÃ³n, la capa de negocio y los DAO.

### Datos

El proyecto `Datos` encapsula el acceso a SQL Server. `AccesoDatos` obtiene la cadena `BDClinica` desde `Web.config` y expone mÃ©todos para:

- Obtener datos en `DataTable`.
- Ejecutar consultas de modificaciÃ³n.
- Ejecutar consultas escalares.

Los DAO existentes son:

- `DaoPaciente`
- `DaoMedico`
- `DaoTurno`
- `DaoHorario`
- `DaoUsuario`
- `DaoExterno`

Las consultas usan `SqlParameter` en los valores recibidos desde la aplicaciÃ³n. En algunos filtros se selecciona dinÃ¡micamente la columna mediante listas controladas en `switch`.

### Negocio

El proyecto `Negocio` actua como intermediario entre la presentaciÃ³n y los DAO. En general convierte cantidades de filas afectadas a respuestas booleanas y concentra llamadas relacionadas con cada mÃ³dulo:

- `NegocioPaciente`
- `NegocioMedico`
- `NegocioTurno`
- `NegocioHorario`
- `NegocioUsuario`
- `NegocioExterno`

Algunas reglas, como evitar activar horarios superpuestos, se resuelven desde estÃ¡ capa antes de ejecutar el cambio de estado.

### PresentaciÃ³n

El proyecto `Vistas` contiene la aplicaciÃ³n ASP.NET Web Forms:

- PÃ¡ginas `.aspx`.
- Archivos code-behind `.aspx.cs`.
- Archivos `.designer.cs`.
- User control `.ascx` para creación de turnos.
- Master page `Panel.Master`.
- CSS propio.
- JavaScript propio.
- Configuracion `Web.config`.

La interfaz usa controles Web Forms como `GridView`, `Repeater`, `Panel`, `DropDownList`, `TextBox`, `LinkButton`, `Button` y validadores ASP.NET.

## 8. Organizacion del repositorio

```text
/
|-- BD DEFINITIVA.sql
|-- DATOS SQL PRECARGADOS.sql
|-- README.md
|-- TPINT_GRUPO_6_PR3.slnx
|-- Datos/
|   |-- AccesoDatos.cs
|   |-- DaoExterno.cs
|   |-- DaoHorario.cs
|   |-- DaoMedico.cs
|   |-- DaoPaciente.cs
|   |-- DaoTurno.cs
|   |-- DaoUsuario.cs
|   |-- Datos.csproj
|-- Entidades/
|   |-- Horarios.cs
|   |-- Medicos.cs
|   |-- Pacientes.cs
|   |-- Personas.cs
|   |-- Turnos.cs
|   |-- Usuarios.cs
|   |-- Entidades.csproj
|-- Negocio/
|   |-- NegocioExterno.cs
|   |-- NegocioHorario.cs
|   |-- NegocioMedico.cs
|   |-- NegocioPaciente.cs
|   |-- NegocioTurno.cs
|   |-- NegocioUsuario.cs
|   |-- Negocio.csproj
|-- Vistas/
|   |-- Login.aspx
|   |-- Panel.Master
|   |-- Web.config
|   |-- Admin Visual/
|   |   |-- Cuentas.aspx
|   |   |-- Informes.aspx
|   |   |-- InicioAdmin.aspx
|   |   |-- Medicos.aspx
|   |   |-- ModalCrearTurno.ascx
|   |   |-- Pacientes.aspx
|   |   |-- Turnos.aspx
|   |-- Medico Visual/
|   |   |-- Estadisticas.aspx
|   |   |-- Historial.aspx
|   |   |-- InicioMedico.aspx
|   |-- Utilities/
|   |   |-- PaginaProtegida.cs
|   |   |-- Tools.cs
|   |-- Styles/
|   |   |-- base.css
|   |   |-- home.css
|   |   |-- login.css
|   |   |-- pages.css
|   |-- Scripts/
|   |   |-- functions.js
|   |-- Images/
|       |-- logo.svg
```

Las carpetas `bin`, `obj`, `.vs` y archivos compilados no forman parte de estÃ¡ descripción funcional porque son artefactos generados o configuraciones locales.

## 9. Entidades principales del dominio

| Entidad | Representa | Datos principales |
| --- | --- | --- |
| `Personas` | Base comun para pacientes y mÃ©dicos | DNI, apellido, nombre, sexo, nacionalidad, fecha de nacimiento, direcciÃ³n, localidad, correo, telÃ©fono, estado. |
| `Pacientes` | Persona atendida por la clÃ­nica | Hereda datos de persona y agrega `IDPaciente`. |
| `Medicos` | Profesional que atiende turnos | Hereda datos de persona y agrega `IDMedico`, legajo y especialidad. |
| `Usuarios` | Cuenta de acceso al sistema | Nombre completo, usuario, contraseÃ±a, rol, estado e ID de mÃ©dico asociado. |
| `Turnos` | Cita mÃ©dica asignada | Paciente, mÃ©dico, usuario creador, fecha, hora, asistencia, observación y estado. |
| `Horarios` | Franja de atenciÃ³n de un mÃ©dico | MÃ©dico, dÃ­a, hora inicio, hora fin y estado. |

Las relaciones principales se reflejan en la base de datos: pacientes y mÃ©dicos referencian localidad y nacionalidad; mÃ©dicos referencian especialidad; usuarios pueden referenciar un mÃ©dico; turnos referencian paciente, mÃ©dico y usuario creador; horarios referencian mÃ©dico.

## 10. Base de datos

La base utilizada se llama `Clinica_TPI` y se crea mediante `BD DEFINITIVA.sql`. La cadena de conexion se obtiene desde `Vistas/Web.config` con el nombre `BDClinica`.

Tablas principales:

- `Provincias`
- `Localidades`
- `Nacionalidades`
- `Especialidades`
- `Pacientes`
- `Medicos`
- `Usuarios`
- `Horarios`
- `Turnos`

El script define claves primarias, claves foraneas, restricciones `UNIQUE`, restricciones `CHECK` y estados logicos con `BIT DEFAULT 1`. Algunos ejemplos importantes:

- `Usuarios.Rol` solo admite `Administrador` o `Medico`.
- `Turnos.EstadoAsistencia` solo admite `Pendiente`, `Presente` o `Ausente`.
- `Pacientes.Sexo` y `Medicos.Sexo` admiten `F`, `M` o `X`.
- `Horarios.HoraInicio` debe ser menor a `HoraFin`.
- Un mÃ©dico no puede tener dos turnos activos el mismo dÃ­a y hora.
- Un usuario mÃ©dico solo puede vincularse una vez a un mÃ©dico mediante indice Ãºnico filtrado.

`DATOS SQL PRECARGADOS.sql` reinicia datos y carga informaciÃ³n de prueba para provincias, localidades, nacionalidades, especialidades, pacientes, mÃ©dicos, usuarios, horarios y turnos. El README no reproduce credenciales de prueba por seguridad; deben consultarse directamente en el script cuando se trabaje en un entorno acadÃ©mico o local.

Orden sugerido de ejecuciÃ³n:

1. `BD DEFINITIVA.sql`
2. `DATOS SQL PRECARGADOS.sql`

## 11. Reglas de negocio y validaciones

Las validaciones se distribuyen entre la interfaz Web Forms, el code-behind, la capa de negocio, los DAO y las restricciones SQL.

| Regla | Implementación |
| --- | --- |
| Campos obligatorios en formularios | `RequiredFieldValidator` en login, pacientes, mÃ©dicos, horarios, turnos y revisión. |
| Confirmación de contraseÃ±a | `CompareValidator` en restablecimiento. |
| Usuario activo para restablecer contraseÃ±a | `CustomValidator` en login, `NegocioUsuario.existeUsuarioActivo`, `DaoUsuario.existeUsuarioActivo`. |
| Correo valido | `RegularExpressionValidator` en pacientes y mÃ©dicos. |
| Duplicados de DNI, correo y telÃ©fono | `CustomValidator` con consultas en DAO de pacientes y mÃ©dicos. |
| Duplicado de legajo mÃ©dico | `CustomValidator` y `DaoMedico.existeLegajo`. |
| Fecha de nacimiento no futura | `CustomValidator` en pacientes y mÃ©dicos. |
| Fecha de turno no anterior al dÃ­a actual | `CustomValidator` en `ModalCrearTurno.ascx`. |
| Horarios superpuestos | `CustomValidator`, `NegocioHorario` y `DaoHorario`. |
| Disponibilidad de turnos | Calculo en `DaoTurno.getHorariosDisponibles`. |
| Control de roles | `PaginaProtegida`, `PaginaAdmin`, `PaginaMedico`. |
| Estados logicos | Campos `Estado` en pacientes, mÃ©dicos, usuarios, horarios y turnos. |

## 12. Interfaz y experiencia de usuario

La interfaz usa Bootstrap, Bootstrap Icons, Select2 en combos de turnos y CSS propio. La identidad visual se apoya en una paleta verde/menta, tarjetas, paneles, grillas y modales reutilizables.

Archivos principales de estilos:

- `base.css`: variables de color, layout, sidebar, botones, Select2, paneles y estilos generales.
- `login.css`: pantalla de login, botón de contraseÃ±a y modal de restablecimiento.
- `pages.css`: patrones ABML, grillas, modales, formularios, badges, paginaciÃ³n e informes.
- `home.css`: tarjetas de inicio, turnos del mÃ©dico, paginaciÃ³n de tarjetas y modal de revisión.

`functions.js` implementa:

- Mostrar u ocultar la contraseÃ±a en el login.
- Ocultar o mostrar la barra lateral, persistiendo el estado en `localStorage`.
- Inicializar Select2 en combos con clase `select2-turno`.

El CSS contiene reglas responsive para sidebar, formularios, grillas y tarjetas, por lo que la interfaz contempla adaptacion a distintos tamaÃ±os de pantalla.

## 13. TecnologÃ­as utilizadas

| Tecnología | Uso en el proyecto |
| --- | --- |
| C# | Lenguaje principal de entidades, negocio, datos y code-behind. |
| ASP.NET Web Forms | Framework de presentaciÃ³n del proyecto `Vistas`. |
| .NET Framework 4.7.2 | Target framework configurado en los `.csproj` y `Web.config`. |
| SQL Server | Motor de base de datos utilizado por los scripts SQL y `System.Data.SqlClient`. |
| ADO.NET | Acceso a datos con `SqlConnection`, `SqlCommand`, `SqlDataAdapter` y `SqlParameter`. |
| HTML/CSS | Estructura y estilos de las pÃ¡ginas Web Forms. |
| Bootstrap | Grilla, botones, componentes y utilidades visuales. |
| Bootstrap Icons | Iconografia de sidebar, acciones y botones. |
| Select2 | Mejora visual de combos en formularios de turnos. |
| JavaScript | Interacciones de login, sidebar y Select2. |
| Visual Studio / MSBuild | Compilacion de soluciÃ³n Web Application. |
| NuGet | Paquete `Microsoft.CodeDom.Providers.DotNetCompilerPlatform`. |

## 14. Requisitos previos

Para ejecutar el proyecto se necesita:

- Visual Studio con soporte para ASP.NET y desarrollo web.
- .NET Framework 4.7.2.
- SQL Server o SQL Server Express.
- SQL Server Management Studio u otra herramienta para ejecutar scripts SQL.
- Acceso a los paquetes NuGet incluidos o restaurables.
- Navegador web moderno.

## 15. InstalaciÃ³n y ejecuciÃ³n

1. Clonar o descargar el repositorio.
2. Abrir `TPINT_GRUPO_6_PR3.slnx` desde Visual Studio.
3. Restaurar paquetes NuGet si Visual Studio lo solicita.
4. Ejecutar `BD DEFINITIVA.sql` sobre SQL Server.
5. Ejecutar `DATOS SQL PRECARGADOS.sql` si se desean datos de prueba.
6. Revisar la cadena de conexion en `Vistas/Web.config`.

Ejemplo genÃ©rico basado en el nombre real de conexion:

```xml
<connectionStrings>
    <add
        name="BDClinica"
        connectionString="Data Source=SERVIDOR;Initial Catalog=Clinica_TPI;Integrated Security=True"
        providerName="System.Data.SqlClient" />
</connectionStrings>
```

7. Establecer `Vistas` como proyecto web de inicio, si no lo estÃ¡.
8. Compilar la soluciÃ³n.
9. Ejecutar desde Visual Studio.
10. Acceder a la pantalla `Login.aspx`.

## 16. Flujo general de uso

1. El usuario ingresa a `Login.aspx`.
2. Completa usuario y contraseÃ±a.
3. La presentaciÃ³n llama a `NegocioUsuario`.
4. `NegocioUsuario` delega la validaciÃ³n en `DaoUsuario`.
5. `DaoUsuario` consulta `Usuarios` en SQL Server.
6. Si las credenciales son vÃ¡lidas y el usuario estÃ¡ activo, se cargan variables de sesiÃ³n.
7. El sistema redirige a inicio administrativo o mÃ©dico segÃºn rol.
8. Las pÃ¡ginas protegidas verifican sesiÃ³n y rol en cada carga inicial.
9. Las operaciones de formularios pasan por la capa de negocio.
10. Los DAO leen o modifican la base con consultas SQL.
11. La interfaz actualiza grillas, tarjetas, modales o mensajes.

## 17. Seguridad y control de acceso

El sistema implementa autenticaciÃ³n bÃ¡sica por usuario y contraseÃ±a, uso de sesiÃ³n, validaciÃ³n de rol y redirecciÃ³n si el usuario no estÃ¡ autorizado.

Medidas presentes:

- ValidaciÃ³n de usuario activo.
- Separación de roles `Administrador` y `Medico`.
- Protección de pÃ¡ginas mediante clases base.
- Limpieza de sesiÃ³n al cerrar sesiÃ³n.
- Consultas parametrizadas para valores recibidos.
- Validadores Web Forms para reducir entradas invalidas.

Limitaciones actuales:

- Las contraseÃ±as se almacenan y comparan como texto en la base. No se observa hash ni sal.
- El restablecimiento de contraseÃ±a no usa correo, token ni doble factor.
- No hay registro de auditorÃ­a de cambios.
- No hay manejo centralizado de excepciones visible en la presentaciÃ³n.
- No hay permisos granulares por acción.

## 18. Estado actual del proyecto

### Implementado

- Login con redirecciÃ³n por rol.
- Protección bÃ¡sica de pÃ¡ginas por sesiÃ³n y rol.
- ABML funcional de pacientes.
- ABML funcional de mÃ©dicos.
- GestiÃ³n de horarios de mÃ©dicos.
- Listado y modificaciÃ³n de turnos.
- Modal global para crear turnos.
- Inicio administrativo con indicadores.
- Listado de cuentas de usuario.
- Informes puntuales de julio.
- Inicio mÃ©dico con revisión de turnos pendientes.
- Historial mÃ©dico.
- EstadÃ­sticas por paciente para mÃ©dicos.

### Parcial o limitado

- Cuentas: la pÃ¡gina actual es de consulta, no de alta o modificaciÃ³n directa.
- Informes: existen dos reportes fijos, ambos enfocados en julio.
- Restablecimiento de contraseÃ±a: funcional dentro del sistema, pero sin flujo seguro por correo o token.
- Historial mÃ©dico: registra asistencia y observación del turno, pero no implementa historia clÃ­nica estructurada con diagnÃ³sticos, estudios o tratamientos separados.

## 19. Posibles mejoras futuras

- Almacenar contraseÃ±as con hash seguro y sal.
- Implementar recuperacion de contraseÃ±a con token y correo.
- Agregar auditorÃ­a de altas, modificaciones, cambios de estado y revisiones medicas.
- Centralizar manejo de errores y mensajes.
- Incorporar pruebas unitarias o de integraciÃ³n.
- Agregar paginaciÃ³n desde base de datos para listados grandes.
- Permitir exportar informes.
- Parametrizar reportes por mes, aÃ±o, especialidad o mÃ©dico.
- Desarrollar un historial clinico mÃ¡s completo.
- Incorporar permisos granulares por acción.
- Separar secretos y cadenas de conexion por ambiente.
- Revisar consistencia de marca entre OSCAMI y VITALIA.

## 20. Autoria y contexto acadÃ©mico

El nombre de la carpeta del repositorio y la soluciÃ³n indican que corresponde a un trabajo prÃ¡ctico integrador de un proyecto .NET. No se encontraron en el README original ni en los archivos revisados datos completos de autores, materia, institución o docentes.

InformaciÃ³n para completar:

```text
Autor/es: completar
Materia: completar
Institucion: completar
Anio: completar
```

## 21. Verificacion documental

EstÃ¡ documentaciÃ³n fue preparada a partir de los archivos actuales del repositorio:

- SoluciÃ³n y proyectos `.slnx` / `.csproj`.
- Entidades, DAO, negocio y utilidades.
- PÃ¡ginas `.aspx`, code-behind y archivos designer.
- User control `Vistas/Admin Visual/ModalCrearTurno.ascx`.
- Clase de protección `Vistas/Utilities/PaginaProtegida.cs`.
- CSS, JavaScript y `Web.config`.
- Scripts `BD DEFINITIVA.sql` y `DATOS SQL PRECARGADOS.sql`.

No se documentaron como funcionalidad del sistema los directorios `.vs`, `bin`, `obj`, DLL, PDB ni caches de compilacion.
