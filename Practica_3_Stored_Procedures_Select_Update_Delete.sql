-- ===============================================================
-- Creamos un Store Procedure para obtener los turnos del paciente
-- ===============================================================

--EXEC SELECT_TurnosPaciente 1

CREATE PROCEDURE SELECT_TurnosPaciente(
	@idpaciente paciente
)

AS
SET NOCOUNT ON

/*SELECT * FROM Turno
SELECT * FROM TurnoPaciente
SELECT * FROM Paciente
SELECT * FROM MedicoEspecialidad*/

SELECT * FROM Paciente AS P
INNER JOIN TurnoPaciente AS TP
ON TP.idPaciente = P.idPaciente 
INNER JOIN Turno AS T
ON T.idTurno = TP.idTurno
INNER JOIN MedicoEspecialidad AS M
ON M.idEspecialidad = TP.idMedico
WHERE P.idPaciente = @idpaciente


-- =================================================================
-- Creamos un Store Procedure para obtener el historial del paciente
-- =================================================================

-- EXEC SELECT_HistoriaPaciente 1

CREATE PROCEDURE SELECT_HistoriaPaciente(
	@idpaciente paciente
)

AS
SET NOCOUNT ON

/*
SELECT * FROM Historia
SELECT * FROM HistoriaPaciente
*/

IF exists (SELECT * FROM Paciente AS P
			INNER JOIN HistoriaPaciente AS HP
			ON HP.idPaciente = P.idPaciente
			INNER JOIN Historia AS H
			ON H.idHistoria = HP.idHistoria 
			INNER JOIN MedicoEspecialidad AS ME
			ON ME.idMedico = HP.idMedico
			INNER JOIN Medico AS M
			ON M.idMedico = ME.idMedico
			WHERE P.idPaciente = @idpaciente)

	SELECT * FROM Paciente AS P
	INNER JOIN HistoriaPaciente AS HP
	ON HP.idPaciente = P.idPaciente
	INNER JOIN Historia AS H
	ON H.idHistoria = HP.idHistoria 
	INNER JOIN MedicoEspecialidad AS ME
	ON ME.idMedico = HP.idMedico
	INNER JOIN Medico AS M
	ON M.idMedico = ME.idMedico
	WHERE P.idPaciente = @idpaciente
ELSE
	--PRINT('No existen historias clinicas para el paciente')
	SELECT 0 AS resultado


-- ==================================================================
-- Creamos un Store Procedure para obtener las especialidades médicas
-- ==================================================================

-- En este caso no necesitamos pasar ningun parametro porque estamos
-- obteniendo todas las especialidades medicas

--EXEC SELECT_EspecialidadesMedicas

CREATE PROCEDURE SELECT_EspecialidadesMedicas
AS
SET NOCOUNT ON

IF EXISTS (SELECT * FROM Especialidad)
	SELECT * FROM Especialidad
ELSE
	SELECT 0 AS Resultado


-- ==================================================================
-- Creamos un Store Procedure para actualizar los turnos
-- ==================================================================

/*
SELECT * FROM Turno
SELECT * FROM TurnoPaciente
*/

-- Podemos actualizar en los turnos el estado, también la observación

EXEC UPDATE_Turno 4,1,'El paciente ha sido atendido'

ALTER PROCEDURE UPDATE_Turno(
	@idturno turno,
	@estado tinyint,
	@observacion observacuib
)

AS
SET NOCOUNT ON

IF EXISTS(SELECT * FROM Turno WHERE idTurno = @idturno)
	BEGIN
		UPDATE Turno SET estado = @estado, observacion = @observacion
		WHERE idTurno = @idturno
	END
ELSE
	SELECT 0 AS Resultado

-- ==================================================================
-- Creamos un Store Procedure para actualizar un paciente
-- ==================================================================

/*
SELECT * FROM Paciente
*/

CREATE PROCEDURE UPDATE_Paciente(
	@idpaciente paciente,
	@nombre varchar(50),
	@apellido varchar(50),
	@domicilio varchar(50),
	@email varchar(30)
)

AS
SET NOCOUNT ON

IF EXISTS (SELECT * FROM Paciente WHERE idPaciente = @idpaciente)
	UPDATE Paciente SET nombre = @nombre, apellido = @apellido, domicilio = @domicilio, email = @email
	WHERE idpaciente = @idpaciente
ELSE
	SELECT 0 as resultado

-- ==================================================================
-- Creamos un Store Procedure para eliminar un turno
-- ==================================================================

/*
SELECT * FROM Turno
SELECT * FROM TurnoPaciente
*/

EXEC DELETE_Turno 11

CREATE PROCEDURE DELETE_Turno(
	@idturno turno
)

AS
SET NOCOUNT ON

IF EXISTS(SELECT * FROM Turno WHERE idTurno = @idturno)
	BEGIN
		DELETE FROM TurnoPaciente WHERE idTurno = @idturno
		DELETE FROM Turno WHERE idTurno = @idturno
	END
ELSE
	SELECT 0 AS Resultado
