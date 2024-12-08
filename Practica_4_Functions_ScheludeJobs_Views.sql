--========================
-- Fecha en formato texto
--========================

ALTER FUNCTION FUNCION_FechaTexto(@fecha datetime)

RETURNS VARCHAR(60)

AS
BEGIN

DECLARE @dia VARCHAR(20)
DECLARE @mes VARCHAR(20)
DECLARE @fechatexto VARCHAR(50)

SET @dia = (CASE WHEN datepart(dw,@fecha) = 1 THEN 'Domingo ' + convert(char(2), datepart(dd,@fecha))
				WHEN datepart(dw,@fecha) = 2 THEN 'Lunes ' + convert(char(2), datepart(dd,@fecha))
				WHEN datepart(dw,@fecha) = 3 THEN 'Martes ' + convert(char(2), datepart(dd,@fecha))
				WHEN datepart(dw,@fecha) = 4 THEN 'Miércoles ' + convert(char(2), datepart(dd,@fecha))
				WHEN datepart(dw,@fecha) = 5 THEN 'Jueves ' + convert(char(2), datepart(dd,@fecha))
				WHEN datepart(dw,@fecha) = 6 THEN 'Viernes ' + convert(char(2), datepart(dd,@fecha))
				WHEN datepart(dw,@fecha) = 7 THEN 'Sábado ' + convert(char(2), datepart(dd,@fecha))
			END)

SET @mes = (CASE WHEN datepart(mm,@fecha) = 1 THEN 'Enero' 
				WHEN datepart(mm,@fecha) = 2 THEN 'Febrero' 
				WHEN datepart(mm,@fecha) = 3 THEN 'Marzo' 
				WHEN datepart(mm,@fecha) = 4 THEN 'Abril' 
				WHEN datepart(mm,@fecha) = 5 THEN 'Mayo' 
				WHEN datepart(mm,@fecha) = 6 THEN 'Junio' 
				WHEN datepart(mm,@fecha) = 7 THEN 'Julio' 
				WHEN datepart(mm,@fecha) = 8 THEN 'Agosto' 
				WHEN datepart(mm,@fecha) = 9 THEN 'Septiembre' 
				WHEN datepart(mm,@fecha) = 10 THEN 'Octubre' 
				WHEN datepart(mm,@fecha) = 11 THEN 'Noviembre' 
				WHEN datepart(mm,@fecha) = 12 THEN 'Diciembre' 
			END)

SET @fechatexto = @dia + 'de ' + @mes
RETURN @fechatexto

END

PRINT dbo.FUNCION_FechaTexto('20190501')


--==============================
-- JOB Cancela Turnos Vencidos
--==============================

--Traemos todas las fechas a partir de hoy hacia atras que tengan el estado igual a cero que son los turnos que estan sin atender

UPDATE turno SET estado = 2 WHERE convert(char(8), fechaturno,  112) < convert(char(8),getdate(),112) AND estado = 0

--=====================================
-- Vista Especialidades de los Médicos
--=====================================

--SELECT * FROM VISTA_MedicosEspecialidades

SELECT * FROM Medico
SELECT * FROM MedicoEspecialidad

CREATE VIEW VISTA_MedicosEspecialidades AS

SELECT M.idMedico, M.nombre, M.apellido, ME.idEspecialidad, ME.descripcion FROM Medico AS M
INNER JOIN MedicoEspecialidad AS ME
ON ME.idmedico = M.idMedico