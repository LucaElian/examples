:ON ERROR EXIT

SET QUOTED_IDENTIFIER ON
GO

IF DB_ID('Clinica_TPI') IS NULL
BEGIN
	RAISERROR('La base Clinica_TPI no existe. Ejecute primero BD DEFINITIVA.sql.', 16, 1)
END
GO

USE Clinica_TPI
GO

/* ============================= */
/* DATOS DE PRUEBA - VITALIA     */
/* ============================= */

/* Reinicia los datos de prueba. No depende de IDs fijos: las FK se resuelven
   por nombre, legajo o usuario para que el script sea mas resistente. */

DELETE FROM Turnos
DELETE FROM Horarios
DELETE FROM Usuarios
DELETE FROM Medicos
DELETE FROM Pacientes
DELETE FROM Especialidades
DELETE FROM Nacionalidades
DELETE FROM Localidades
DELETE FROM Provincias
GO

/* ============================= */
/* PROVINCIAS - 15               */
/* ============================= */

INSERT INTO Provincias (NombreProvincia)
VALUES
('Buenos Aires'),
('Cordoba'),
('Santa Fe'),
('Mendoza'),
('Entre Rios'),
('Corrientes'),
('Misiones'),
('Salta'),
('Tucuman'),
('Neuquen'),
('Rio Negro'),
('Chubut'),
('San Juan'),
('San Luis'),
('La Pampa')
GO

/* ============================= */
/* LOCALIDADES - 15              */
/* ============================= */

INSERT INTO Localidades (NombreLocalidad, IDProvincia_Localidad)
VALUES
('San Miguel', (SELECT IDProvincia FROM Provincias WHERE NombreProvincia = 'Buenos Aires')),
('Muniz', (SELECT IDProvincia FROM Provincias WHERE NombreProvincia = 'Buenos Aires')),
('Bella Vista', (SELECT IDProvincia FROM Provincias WHERE NombreProvincia = 'Buenos Aires')),
('Tigre', (SELECT IDProvincia FROM Provincias WHERE NombreProvincia = 'Buenos Aires')),
('San Isidro', (SELECT IDProvincia FROM Provincias WHERE NombreProvincia = 'Buenos Aires')),
('La Plata', (SELECT IDProvincia FROM Provincias WHERE NombreProvincia = 'Buenos Aires')),
('Mar del Plata', (SELECT IDProvincia FROM Provincias WHERE NombreProvincia = 'Buenos Aires')),
('Cordoba Capital', (SELECT IDProvincia FROM Provincias WHERE NombreProvincia = 'Cordoba')),
('Villa Carlos Paz', (SELECT IDProvincia FROM Provincias WHERE NombreProvincia = 'Cordoba')),
('Rosario', (SELECT IDProvincia FROM Provincias WHERE NombreProvincia = 'Santa Fe')),
('Santa Fe Capital', (SELECT IDProvincia FROM Provincias WHERE NombreProvincia = 'Santa Fe')),
('Mendoza Capital', (SELECT IDProvincia FROM Provincias WHERE NombreProvincia = 'Mendoza')),
('Godoy Cruz', (SELECT IDProvincia FROM Provincias WHERE NombreProvincia = 'Mendoza')),
('Parana', (SELECT IDProvincia FROM Provincias WHERE NombreProvincia = 'Entre Rios')),
('Concordia', (SELECT IDProvincia FROM Provincias WHERE NombreProvincia = 'Entre Rios'))
GO

/* ============================= */
/* NACIONALIDADES - 15           */
/* ============================= */

INSERT INTO Nacionalidades (NombreNacionalidad)
VALUES
('Argentina'),
('Uruguaya'),
('Chilena'),
('Paraguaya'),
('Boliviana'),
('Peruana'),
('Brasilena'),
('Colombiana'),
('Venezolana'),
('Italiana'),
('Espanola'),
('Mexicana'),
('Ecuatoriana'),
('Cubana'),
('Francesa')
GO

/* ============================= */
/* ESPECIALIDADES - 15           */
/* ============================= */

INSERT INTO Especialidades (NombreEspecialidad)
VALUES
('Clinica Medica'),
('Cardiologia'),
('Pediatria'),
('Dermatologia'),
('Traumatologia'),
('Ginecologia'),
('Oftalmologia'),
('Neurologia'),
('Odontologia'),
('Psicologia'),
('Endocrinologia'),
('Gastroenterologia'),
('Kinesiologia'),
('Otorrinolaringologia'),
('Urologia')
GO

/* ============================= */
/* PACIENTES - 15                */
/* ============================= */

INSERT INTO Pacientes
(
	DNI,
	Apellido,
	Nombre,
	Sexo,
	IDNacionalidad_Paciente,
	FechaNacimiento,
	Direccion,
	IDLocalidad_Paciente,
	Correo,
	Telefono,
	Estado
)
VALUES
('40123456', 'Gonzalez', 'Sofia', 'F', (SELECT IDNacionalidad FROM Nacionalidades WHERE NombreNacionalidad = 'Argentina'), '1991-04-18', 'Rivadavia 1240', (SELECT IDLocalidad FROM Localidades WHERE NombreLocalidad = 'San Miguel'), 'sofia.gonzalez@mail.com', '1150011001', 1),
('38987654', 'Rodriguez', 'Mateo', 'M', (SELECT IDNacionalidad FROM Nacionalidades WHERE NombreNacionalidad = 'Argentina'), '1988-11-03', 'Belgrano 582', (SELECT IDLocalidad FROM Localidades WHERE NombreLocalidad = 'Muniz'), 'mateo.rodriguez@mail.com', '1150011002', 1),
('42555111', 'Fernandez', 'Camila', 'F', (SELECT IDNacionalidad FROM Nacionalidades WHERE NombreNacionalidad = 'Uruguaya'), '1996-07-27', 'Mitre 934', (SELECT IDLocalidad FROM Localidades WHERE NombreLocalidad = 'Bella Vista'), 'camila.fernandez@mail.com', '1150011003', 1),
('37666777', 'Lopez', 'Nicolas', 'M', (SELECT IDNacionalidad FROM Nacionalidades WHERE NombreNacionalidad = 'Argentina'), '1985-02-12', 'San Martin 210', (SELECT IDLocalidad FROM Localidades WHERE NombreLocalidad = 'Tigre'), 'nicolas.lopez@mail.com', '1150011004', 1),
('44111222', 'Martinez', 'Valentina', 'F', (SELECT IDNacionalidad FROM Nacionalidades WHERE NombreNacionalidad = 'Chilena'), '2000-09-05', 'Sarmiento 870', (SELECT IDLocalidad FROM Localidades WHERE NombreLocalidad = 'San Isidro'), 'valentina.martinez@mail.com', '1150011005', 1),
('35777888', 'Perez', 'Julian', 'M', (SELECT IDNacionalidad FROM Nacionalidades WHERE NombreNacionalidad = 'Argentina'), '1979-12-19', 'Moreno 452', (SELECT IDLocalidad FROM Localidades WHERE NombreLocalidad = 'La Plata'), 'julian.perez@mail.com', '1150011006', 1),
('46888999', 'Sanchez', 'Lucia', 'F', (SELECT IDNacionalidad FROM Nacionalidades WHERE NombreNacionalidad = 'Paraguaya'), '2003-01-30', 'Alsina 315', (SELECT IDLocalidad FROM Localidades WHERE NombreLocalidad = 'Mar del Plata'), 'lucia.sanchez@mail.com', '1150011007', 1),
('33444555', 'Romero', 'Diego', 'M', (SELECT IDNacionalidad FROM Nacionalidades WHERE NombreNacionalidad = 'Argentina'), '1974-06-11', 'Pueyrredon 760', (SELECT IDLocalidad FROM Localidades WHERE NombreLocalidad = 'Cordoba Capital'), 'diego.romero@mail.com', '1150011008', 1),
('45222333', 'Torres', 'Martina', 'F', (SELECT IDNacionalidad FROM Nacionalidades WHERE NombreNacionalidad = 'Boliviana'), '1998-03-22', 'Italia 1065', (SELECT IDLocalidad FROM Localidades WHERE NombreLocalidad = 'Villa Carlos Paz'), 'martina.torres@mail.com', '1150011009', 1),
('39999123', 'Diaz', 'Agustin', 'M', (SELECT IDNacionalidad FROM Nacionalidades WHERE NombreNacionalidad = 'Argentina'), '1990-08-14', 'Espana 231', (SELECT IDLocalidad FROM Localidades WHERE NombreLocalidad = 'Rosario'), 'agustin.diaz@mail.com', '1150011010', 1),
('41777444', 'Alvarez', 'Florencia', 'F', (SELECT IDNacionalidad FROM Nacionalidades WHERE NombreNacionalidad = 'Peruana'), '1994-10-08', 'Colon 543', (SELECT IDLocalidad FROM Localidades WHERE NombreLocalidad = 'Santa Fe Capital'), 'florencia.alvarez@mail.com', '1150011011', 1),
('36222111', 'Ruiz', 'Federico', 'M', (SELECT IDNacionalidad FROM Nacionalidades WHERE NombreNacionalidad = 'Argentina'), '1981-05-25', 'Laprida 999', (SELECT IDLocalidad FROM Localidades WHERE NombreLocalidad = 'Mendoza Capital'), 'federico.ruiz@mail.com', '1150011012', 1),
('48888777', 'Morales', 'Renata', 'F', (SELECT IDNacionalidad FROM Nacionalidades WHERE NombreNacionalidad = 'Brasilena'), '2005-12-02', 'Maipu 118', (SELECT IDLocalidad FROM Localidades WHERE NombreLocalidad = 'Godoy Cruz'), 'renata.morales@mail.com', '1150011013', 1),
('34555888', 'Silva', 'Tomas', 'M', (SELECT IDNacionalidad FROM Nacionalidades WHERE NombreNacionalidad = 'Argentina'), '1977-09-16', 'Lavalle 631', (SELECT IDLocalidad FROM Localidades WHERE NombreLocalidad = 'Parana'), 'tomas.silva@mail.com', '1150011014', 1),
('43123987', 'Herrera', 'Bianca', 'X', (SELECT IDNacionalidad FROM Nacionalidades WHERE NombreNacionalidad = 'Colombiana'), '1997-02-07', 'Urquiza 487', (SELECT IDLocalidad FROM Localidades WHERE NombreLocalidad = 'Concordia'), 'bianca.herrera@mail.com', '1150011015', 1)
GO

/* ============================= */
/* MEDICOS - 15                  */
/* ============================= */

INSERT INTO Medicos
(
	Legajo,
	DNI,
	Apellido,
	Nombre,
	Sexo,
	IDNacionalidad_Medico,
	FechaNacimiento,
	Direccion,
	IDLocalidad_Medico,
	IDEspecialidad_Medico,
	Correo,
	Telefono,
	Estado
)
VALUES
('MED001', '30111001', 'Mendez', 'Laura', 'F', (SELECT IDNacionalidad FROM Nacionalidades WHERE NombreNacionalidad = 'Argentina'), '1980-04-12', 'Av Salud 101', (SELECT IDLocalidad FROM Localidades WHERE NombreLocalidad = 'San Miguel'), (SELECT IDEspecialidad FROM Especialidades WHERE NombreEspecialidad = 'Clinica Medica'), 'laura.mendez@vitalia.com', '1150022001', 1),
('MED002', '30222002', 'Garcia', 'Pablo', 'M', (SELECT IDNacionalidad FROM Nacionalidades WHERE NombreNacionalidad = 'Argentina'), '1978-08-21', 'Av Salud 102', (SELECT IDLocalidad FROM Localidades WHERE NombreLocalidad = 'Muniz'), (SELECT IDEspecialidad FROM Especialidades WHERE NombreEspecialidad = 'Cardiologia'), 'pablo.garcia@vitalia.com', '1150022002', 1),
('MED003', '30333003', 'Benitez', 'Mariana', 'F', (SELECT IDNacionalidad FROM Nacionalidades WHERE NombreNacionalidad = 'Argentina'), '1985-01-10', 'Av Salud 103', (SELECT IDLocalidad FROM Localidades WHERE NombreLocalidad = 'Bella Vista'), (SELECT IDEspecialidad FROM Especialidades WHERE NombreEspecialidad = 'Pediatria'), 'mariana.benitez@vitalia.com', '1150022003', 1),
('MED004', '30444004', 'Castro', 'Andres', 'M', (SELECT IDNacionalidad FROM Nacionalidades WHERE NombreNacionalidad = 'Uruguaya'), '1976-05-14', 'Av Salud 104', (SELECT IDLocalidad FROM Localidades WHERE NombreLocalidad = 'Tigre'), (SELECT IDEspecialidad FROM Especialidades WHERE NombreEspecialidad = 'Dermatologia'), 'andres.castro@vitalia.com', '1150022004', 1),
('MED005', '30555005', 'Acosta', 'Valeria', 'F', (SELECT IDNacionalidad FROM Nacionalidades WHERE NombreNacionalidad = 'Argentina'), '1983-11-30', 'Av Salud 105', (SELECT IDLocalidad FROM Localidades WHERE NombreLocalidad = 'San Isidro'), (SELECT IDEspecialidad FROM Especialidades WHERE NombreEspecialidad = 'Traumatologia'), 'valeria.acosta@vitalia.com', '1150022005', 1),
('MED006', '30666006', 'Rojas', 'Santiago', 'M', (SELECT IDNacionalidad FROM Nacionalidades WHERE NombreNacionalidad = 'Argentina'), '1979-07-18', 'Av Salud 106', (SELECT IDLocalidad FROM Localidades WHERE NombreLocalidad = 'La Plata'), (SELECT IDEspecialidad FROM Especialidades WHERE NombreEspecialidad = 'Ginecologia'), 'santiago.rojas@vitalia.com', '1150022006', 1),
('MED007', '30777007', 'Campos', 'Daniela', 'F', (SELECT IDNacionalidad FROM Nacionalidades WHERE NombreNacionalidad = 'Chilena'), '1987-09-25', 'Av Salud 107', (SELECT IDLocalidad FROM Localidades WHERE NombreLocalidad = 'Mar del Plata'), (SELECT IDEspecialidad FROM Especialidades WHERE NombreEspecialidad = 'Oftalmologia'), 'daniela.campos@vitalia.com', '1150022007', 1),
('MED008', '30888008', 'Vega', 'Martin', 'M', (SELECT IDNacionalidad FROM Nacionalidades WHERE NombreNacionalidad = 'Argentina'), '1975-03-09', 'Av Salud 108', (SELECT IDLocalidad FROM Localidades WHERE NombreLocalidad = 'Cordoba Capital'), (SELECT IDEspecialidad FROM Especialidades WHERE NombreEspecialidad = 'Neurologia'), 'martin.vega@vitalia.com', '1150022008', 1),
('MED009', '30999009', 'Molina', 'Paula', 'F', (SELECT IDNacionalidad FROM Nacionalidades WHERE NombreNacionalidad = 'Paraguaya'), '1982-06-02', 'Av Salud 109', (SELECT IDLocalidad FROM Localidades WHERE NombreLocalidad = 'Villa Carlos Paz'), (SELECT IDEspecialidad FROM Especialidades WHERE NombreEspecialidad = 'Odontologia'), 'paula.molina@vitalia.com', '1150022009', 1),
('MED010', '31000110', 'Ibarra', 'Gabriel', 'M', (SELECT IDNacionalidad FROM Nacionalidades WHERE NombreNacionalidad = 'Argentina'), '1981-12-17', 'Av Salud 110', (SELECT IDLocalidad FROM Localidades WHERE NombreLocalidad = 'Rosario'), (SELECT IDEspecialidad FROM Especialidades WHERE NombreEspecialidad = 'Psicologia'), 'gabriel.ibarra@vitalia.com', '1150022010', 1),
('MED011', '31111211', 'Navarro', 'Carolina', 'F', (SELECT IDNacionalidad FROM Nacionalidades WHERE NombreNacionalidad = 'Argentina'), '1984-10-06', 'Av Salud 111', (SELECT IDLocalidad FROM Localidades WHERE NombreLocalidad = 'Santa Fe Capital'), (SELECT IDEspecialidad FROM Especialidades WHERE NombreEspecialidad = 'Endocrinologia'), 'carolina.navarro@vitalia.com', '1150022011', 1),
('MED012', '31222312', 'Peralta', 'Joaquin', 'M', (SELECT IDNacionalidad FROM Nacionalidades WHERE NombreNacionalidad = 'Boliviana'), '1977-02-28', 'Av Salud 112', (SELECT IDLocalidad FROM Localidades WHERE NombreLocalidad = 'Mendoza Capital'), (SELECT IDEspecialidad FROM Especialidades WHERE NombreEspecialidad = 'Gastroenterologia'), 'joaquin.peralta@vitalia.com', '1150022012', 1),
('MED013', '31333413', 'Luna', 'Cecilia', 'F', (SELECT IDNacionalidad FROM Nacionalidades WHERE NombreNacionalidad = 'Argentina'), '1986-08-08', 'Av Salud 113', (SELECT IDLocalidad FROM Localidades WHERE NombreLocalidad = 'Godoy Cruz'), (SELECT IDEspecialidad FROM Especialidades WHERE NombreEspecialidad = 'Kinesiologia'), 'cecilia.luna@vitalia.com', '1150022013', 1),
('MED014', '31444514', 'Paz', 'Leandro', 'M', (SELECT IDNacionalidad FROM Nacionalidades WHERE NombreNacionalidad = 'Peruana'), '1980-01-19', 'Av Salud 114', (SELECT IDLocalidad FROM Localidades WHERE NombreLocalidad = 'Parana'), (SELECT IDEspecialidad FROM Especialidades WHERE NombreEspecialidad = 'Otorrinolaringologia'), 'leandro.paz@vitalia.com', '1150022014', 1),
('MED015', '31555615', 'Sosa', 'Natalia', 'F', (SELECT IDNacionalidad FROM Nacionalidades WHERE NombreNacionalidad = 'Argentina'), '1988-04-04', 'Av Salud 115', (SELECT IDLocalidad FROM Localidades WHERE NombreLocalidad = 'Concordia'), (SELECT IDEspecialidad FROM Especialidades WHERE NombreEspecialidad = 'Urologia'), 'natalia.sosa@vitalia.com', '1150022015', 1)
GO

/* ============================= */
/* USUARIOS                      */
/* ============================= */

INSERT INTO Usuarios (NombreCompleto, Usuario, Contrasenia, Rol, Estado, IDMedico_Usuario)
VALUES
('Administrador General', 'admin', 'admin123', 'Administrador', 1, NULL),
('Mesa de Entrada', 'recepcion', 'admin123', 'Administrador', 1, NULL)
GO

;WITH MedicosOrdenados AS
(
	SELECT
		IDMedico,
		Nombre,
		Apellido,
		ROW_NUMBER() OVER (ORDER BY Legajo) AS NumeroMedico
	FROM Medicos
)
INSERT INTO Usuarios
(
	NombreCompleto,
	Usuario,
	Contrasenia,
	Rol,
	Estado,
	IDMedico_Usuario
)
SELECT
	Nombre + ' ' + Apellido,
	'medico' + CAST(NumeroMedico AS VARCHAR(10)),
	'medico123',
	'Medico',
	1,
	IDMedico
FROM MedicosOrdenados
GO

/* ============================= */
/* HORARIOS - 75                 */
/* ============================= */

INSERT INTO Horarios (IDMedico_Horario, Dia, HoraInicio, HoraFin, Estado)
SELECT
	M.IDMedico,
	H.Dia,
	H.HoraInicio,
	H.HoraFin,
	1
FROM Medicos AS M
CROSS JOIN
(
	VALUES
	('Lunes', CAST('08:00' AS TIME), CAST('12:00' AS TIME)),
	('Martes', CAST('14:00' AS TIME), CAST('18:00' AS TIME)),
	('Miercoles', CAST('09:00' AS TIME), CAST('13:00' AS TIME)),
	('Jueves', CAST('10:00' AS TIME), CAST('14:00' AS TIME)),
	('Viernes', CAST('15:00' AS TIME), CAST('19:00' AS TIME))
) AS H(Dia, HoraInicio, HoraFin)
GO

/* ============================= */
/* TURNOS - 240                  */
/* ============================= */

;WITH Fechas AS
(
	SELECT *
	FROM
	(
		VALUES
		(1, CAST('2024-01-15' AS DATE)),
		(2, CAST('2024-03-20' AS DATE)),
		(3, CAST('2024-06-10' AS DATE)),
		(4, CAST('2024-11-05' AS DATE)),
		(5, CAST('2025-02-14' AS DATE)),
		(6, CAST('2025-04-22' AS DATE)),
		(7, CAST('2025-07-09' AS DATE)),
		(8, CAST('2025-10-18' AS DATE)),
		(9, CAST('2026-01-12' AS DATE)),
		(10, CAST('2026-03-25' AS DATE)),
		(11, CAST('2026-05-08' AS DATE)),
		(12, CAST('2026-06-17' AS DATE)),
		(13, CAST('2026-07-01' AS DATE)),
		(14, CAST('2026-07-08' AS DATE)),
		(15, CAST('2026-07-15' AS DATE)),
		(16, CAST('2026-08-05' AS DATE))
	) AS F(IDFecha, Fecha)
),
MedicosOrdenados AS
(
	SELECT
		IDMedico,
		ROW_NUMBER() OVER (ORDER BY Legajo) AS NumeroMedico
	FROM Medicos
),
PacientesOrdenados AS
(
	SELECT
		IDPaciente,
		ROW_NUMBER() OVER (ORDER BY Apellido, Nombre) AS NumeroPaciente
	FROM Pacientes
),
Administradores AS
(
	SELECT
		Usuario,
		IDUsuario
	FROM Usuarios
	WHERE Usuario IN ('admin', 'recepcion')
),
TurnosPreparados AS
(
	SELECT
		P.IDPaciente,
		M.IDMedico,
		CASE
			WHEN M.NumeroMedico % 2 = 0 THEN (SELECT IDUsuario FROM Administradores WHERE Usuario = 'admin')
			ELSE (SELECT IDUsuario FROM Administradores WHERE Usuario = 'recepcion')
		END AS IDUsuarioCreador,
		F.Fecha,
		CAST(RIGHT('0' + CAST(8 + ((M.NumeroMedico + F.IDFecha) % 10) AS VARCHAR(2)), 2) + ':00' AS TIME) AS Hora,
		CASE
			WHEN F.Fecha > CAST(GETDATE() AS DATE) THEN 'Pendiente'
			WHEN (F.IDFecha + M.NumeroMedico) % 5 = 0 THEN 'Ausente'
			WHEN (F.IDFecha + M.NumeroMedico) % 3 = 0 THEN 'Pendiente'
			ELSE 'Presente'
		END AS EstadoAsistencia,
		M.NumeroMedico
	FROM Fechas AS F
	CROSS JOIN MedicosOrdenados AS M
	INNER JOIN PacientesOrdenados AS P
		ON P.NumeroPaciente = (((F.IDFecha - 1) * 4 + M.NumeroMedico - 1) % 15) + 1
)
INSERT INTO Turnos
(
	IDPaciente_Turno,
	IDMedico_Turno,
	IDUsuarioCreador_Turno,
	Fecha,
	Hora,
	EstadoAsistencia,
	Observacion,
	Estado
)
SELECT
	IDPaciente,
	IDMedico,
	IDUsuarioCreador,
	Fecha,
	Hora,
	EstadoAsistencia,
	CASE
		WHEN EstadoAsistencia = 'Presente' AND NumeroMedico % 4 = 0 THEN 'Control realizado. Se solicita seguimiento en 30 dias.'
		WHEN EstadoAsistencia = 'Presente' AND NumeroMedico % 4 = 1 THEN 'Consulta sin complicaciones. Continua tratamiento indicado.'
		WHEN EstadoAsistencia = 'Presente' AND NumeroMedico % 4 = 2 THEN 'Paciente estable. Se indican estudios de rutina.'
		WHEN EstadoAsistencia = 'Presente' THEN 'Evaluacion completa. Se entrega indicacion medica.'
		ELSE NULL
	END,
	1
FROM TurnosPreparados
GO
