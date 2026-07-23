USE MASTER
GO

CREATE DATABASE Clinica_TPI
GO

USE Clinica_TPI
GO

/*===============================*/
/*       TABLA PROVINCIAS        */
/*===============================*/

CREATE TABLE Provincias
(
	IDProvincia INT IDENTITY(1,1) NOT NULL,
	NombreProvincia VARCHAR(50) NOT NULL UNIQUE,

	CONSTRAINT PK_Provincias PRIMARY KEY(IDProvincia)
)
GO

/*===============================*/
/*       TABLA LOCALIDADES       */
/*===============================*/

CREATE TABLE Localidades
(
	IDLocalidad INT IDENTITY(1,1) NOT NULL,
	NombreLocalidad VARCHAR(50) NOT NULL,
	IDProvincia_Localidad INT NOT NULL,

	CONSTRAINT PK_Localidades PRIMARY KEY(IDLocalidad),

	CONSTRAINT FK_Localidades_Provincias FOREIGN KEY(IDProvincia_Localidad)
	REFERENCES Provincias(IDProvincia),

	CONSTRAINT UQ_Localidades_NombreLocalidad_Provincia UNIQUE(NombreLocalidad, IDProvincia_Localidad) /* Evitar repetir localidad en misma provincia */
)
GO

/*===============================*/
/*      TABLA NACIONALIDADES     */
/*===============================*/

CREATE TABLE Nacionalidades
(
	IDNacionalidad INT IDENTITY(1,1) NOT NULL,
	NombreNacionalidad VARCHAR(50) NOT NULL UNIQUE,

	CONSTRAINT PK_Nacionalidades PRIMARY KEY(IDNacionalidad)
)
GO

/*===============================*/
/*     TABLA ESPECIALIDADES      */
/*===============================*/

CREATE TABLE Especialidades
(
	IDEspecialidad INT IDENTITY(1,1) NOT NULL,
	NombreEspecialidad VARCHAR(50) NOT NULL UNIQUE,

	CONSTRAINT PK_Especialidades PRIMARY KEY(IDEspecialidad)
)
GO

/*===============================*/
/*        TABLA PACIENTES        */
/*===============================*/

CREATE TABLE Pacientes
(
	IDPaciente INT IDENTITY(1,1) NOT NULL,
	DNI VARCHAR(20) NOT NULL UNIQUE,
	Apellido VARCHAR(30) NOT NULL,
	Nombre VARCHAR(30) NOT NULL,
	Sexo CHAR(1) NOT NULL CHECK(Sexo IN ('F', 'M', 'X')),
	IDNacionalidad_Paciente INT NOT NULL,
	FechaNacimiento DATE NOT NULL,
	Direccion VARCHAR(30) NOT NULL,
	IDLocalidad_Paciente INT NOT NULL,
	Correo VARCHAR(50) NOT NULL,
	Telefono VARCHAR(20) NOT NULL,
	Estado BIT NOT NULL DEFAULT 1,

	CONSTRAINT PK_Pacientes PRIMARY KEY(IDPaciente),

	CONSTRAINT FK_Pacientes_Nacionalidades FOREIGN KEY(IDNacionalidad_Paciente)
	REFERENCES Nacionalidades(IDNacionalidad),

	CONSTRAINT FK_Pacientes_Localidades FOREIGN KEY(IDLocalidad_Paciente)
	REFERENCES Localidades(IDLocalidad)
)
GO

/*===============================*/
/*        TABLA MEDICOS          */
/*===============================*/

CREATE TABLE Medicos
(
	IDMedico INT IDENTITY(1,1) NOT NULL,
	Legajo VARCHAR(15) NOT NULL UNIQUE,
	DNI VARCHAR(20) NOT NULL UNIQUE,
	Apellido VARCHAR(30) NOT NULL,
	Nombre VARCHAR(30) NOT NULL,
	Sexo CHAR(1) NOT NULL CHECK(Sexo IN ('F', 'M', 'X')),
	IDNacionalidad_Medico INT NOT NULL,
	FechaNacimiento DATE NOT NULL,
	Direccion VARCHAR(30) NOT NULL,
	IDLocalidad_Medico INT NOT NULL,
	IDEspecialidad_Medico INT NOT NULL,
	Correo VARCHAR(50) NOT NULL,
	Telefono VARCHAR(20) NOT NULL,
	Estado BIT NOT NULL DEFAULT 1,

	CONSTRAINT PK_Medicos PRIMARY KEY(IDMedico),

	CONSTRAINT FK_Medicos_Nacionalidades FOREIGN KEY(IDNacionalidad_Medico)
	REFERENCES Nacionalidades(IDNacionalidad),

	CONSTRAINT FK_Medicos_Localidades FOREIGN KEY(IDLocalidad_Medico)
	REFERENCES Localidades(IDLocalidad),

	CONSTRAINT FK_Medicos_Especialidades FOREIGN KEY(IDEspecialidad_Medico)
	REFERENCES Especialidades(IDEspecialidad)
)
GO

/*===============================*/
/*         TABLA USUARIOS        */
/*===============================*/

CREATE TABLE Usuarios
(
	IDUsuario INT IDENTITY(1,1) NOT NULL,
	NombreCompleto VARCHAR(50) NOT NULL,
	Usuario VARCHAR(50) NOT NULL UNIQUE,
	Contrasenia VARCHAR(50) NOT NULL,
	Rol VARCHAR(13) NOT NULL CHECK(Rol IN ('Administrador', 'Medico')),
	Estado BIT NOT NULL DEFAULT 1,
	IDMedico_Usuario INT NULL,

	CONSTRAINT PK_Usuarios PRIMARY KEY(IDUsuario),

	CONSTRAINT FK_Usuarios_Medicos FOREIGN KEY(IDMedico_Usuario)
	REFERENCES Medicos(IDMedico)
)
GO

/* Para que si el rol es Medico el IDMedico sea UNIQUE, si no, NULL. */
SET QUOTED_IDENTIFIER ON
GO

CREATE UNIQUE INDEX UX_Usuarios_IDMedico_Usuario
ON Usuarios(IDMedico_Usuario)
WHERE IDMedico_Usuario IS NOT NULL
GO

/*===============================*/
/*        TABLA HORARIOS         */
/*===============================*/

CREATE TABLE Horarios
(
	IDHorario INT IDENTITY(1,1) NOT NULL,
	IDMedico_Horario INT NOT NULL,
	Dia VARCHAR(10) NOT NULL CHECK(Dia IN ('Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado', 'Domingo')),
	HoraInicio TIME NOT NULL,
	HoraFin TIME NOT NULL,
	Estado BIT NOT NULL DEFAULT 1,

	CONSTRAINT PK_Horarios PRIMARY KEY(IDHorario),

	CONSTRAINT FK_Horarios_Medicos FOREIGN KEY(IDMedico_Horario)
	REFERENCES Medicos(IDMedico),

	CONSTRAINT CK_Horarios_HoraInicio_HoraFin CHECK(HoraInicio < HoraFin),

	/* Evitar que un medico tenga cargado el mismo dia y hora de inicio */
	CONSTRAINT UQ_Horarios_Medico_Dia_HoraInicio UNIQUE(IDMedico_Horario, Dia, HoraInicio)
)
GO

/*===============================*/
/*         TABLA TURNOS          */
/*===============================*/

CREATE TABLE Turnos
(
	IDTurno INT IDENTITY(1,1) NOT NULL,
	IDPaciente_Turno INT NOT NULL,
	IDMedico_Turno INT NOT NULL,
	IDUsuarioCreador_Turno INT NOT NULL,
	Fecha DATE NOT NULL,
	Hora TIME NOT NULL,
	EstadoAsistencia VARCHAR(10) NOT NULL DEFAULT 'Pendiente' CHECK(EstadoAsistencia IN ('Pendiente', 'Presente', 'Ausente')),
	Observacion VARCHAR(MAX) NULL,
	Estado BIT NOT NULL DEFAULT 1,

	CONSTRAINT PK_Turnos PRIMARY KEY(IDTurno),

	CONSTRAINT FK_Turnos_Pacientes FOREIGN KEY(IDPaciente_Turno)
	REFERENCES Pacientes(IDPaciente),

	CONSTRAINT FK_Turnos_Medicos FOREIGN KEY(IDMedico_Turno)
	REFERENCES Medicos(IDMedico),

	CONSTRAINT FK_Turnos_Usuarios FOREIGN KEY(IDUsuarioCreador_Turno)
	REFERENCES Usuarios(IDUsuario),

	/* Evitar que un medico tenga cargado dos turnos el mismo dia al mismo horario */
	CONSTRAINT UQ_Turnos_Medico_Fecha_Hora UNIQUE(IDMedico_Turno, Fecha, Hora)
)
GO
