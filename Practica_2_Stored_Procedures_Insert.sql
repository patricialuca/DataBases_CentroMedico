-- ==================================================
-- Procedimiento para dar de alta pacientes
-- ==================================================

--EXEC Alta_Paciente '17715783P', 'Samuel', 'Benitez', '20180518','Calle Expreso Shangai 10', 'PER','','samu@gmail.com',''

CREATE PROC Alta_Paciente(
	@dni VARCHAR(20),
	@nombre VARCHAR(50),
	@apellido VARCHAR(50),
	@fNacimiento VARCHAR(8),
	@domicilio VARCHAR(50),
	@idpais CHAR(3),
	@telefono VARCHAR(20),
	@email VARCHAR(30),
	@observacion VARCHAR(1000) =''
)
AS

IF NOT EXISTS(SELECT * FROM Paciente WHERE dni=@dni)
BEGIN
	INSERT INTO Paciente (dni, nombre, apellido, fNacimiento, domicilio, idpais, telefono, email, observacion)
	VALUES (@dni, @nombre, @apellido, @fNacimiento, @domicilio, @idpais, @telefono, @email, @observacion)
	print 'El paciente se agregó correctamente'
END
ELSE
BEGIN
	print 'El paciente ya existe'
	return
END

-- ==================================================
-- Procedimiento para dar de alta turnos
-- ==================================================

--EXEC Alta_Turno '20190220 09:15', 6,3, 'Nada'

CREATE PROC Alta_Turno(
	@fecha CHAR(14), --20190215 12:00
	@idpaciente paciente,
	@idmedico medico,
	@observacion observacuib=''
)
AS

/*
ESTADO = 0 (pendiente)
ESTADO = 1 (realizado)
ESTADO = 2 (cancelado)
*/

SET NOCOUNT ON
IF NOT EXISTS(SELECT TOP 1 idturno FROM Turno WHERE fechaTurno=@fecha)
BEGIN
	INSERT INTO Turno (fechaTurno, estado, observacion)
	VALUES (@fecha, 0, @observacion)

	DECLARE @auxIdTurno turno
	SET @auxIdTurno = @@IDENTITY --Obtiene el último valor insertado

	INSERT INTO TurnoPaciente (idturno, idpaciente, idmedico)
	VALUES (@auxIdTurno, @idpaciente, @idmedico)
	print 'El turno se agregó correctamente'
END
ELSE
BEGIN
	print 'El turno ya existe'
	return
END

-- ==================================================
-- Procedimiento para dar de alta médicos
-- ==================================================

--EXEC Alta_Medico 'Gerardo', 'Martinez',1, 'Medico residente'

CREATE PROC Alta_Medico(
	@nombre VARCHAR(50),
	@apellido VARCHAR(50),
	@idEspecialidad INT,
	@descripcion VARCHAR(50)
)
AS
SET NOCOUNT ON

IF NOT EXISTS(SELECT TOP 1 idMedico FROM Medico WHERE Nombre=@nombre and Apellido=@apellido)
BEGIN
	INSERT INTO Medico (Nombre, Apellido)
	VALUES (@nombre, @apellido)

	DECLARE @auxIdMedico INT
	SET @auxIdMedico = @@IDENTITY --Obtiene el último valor insertado

	INSERT INTO MedicoEspecialidad (idMedico, idEspecialidad, Descripcion)
	VALUES (@auxIdMedico, @idEspecialidad, @descripcion)
	print 'El médico se agregó correctamente'
END
ELSE
BEGIN
	print 'El médico ya existe'
	return
END

