
-- ==================================================
-- Creación de la Base de Datos Centro Médico
-- ==================================================

DROP DATABASE IF EXISTS CentroMedico;

CREATE DATABASE CentroMedico;

-- ==================================================
-- Creación de los tipos definidos por el usuario
-- ==================================================

CREATE TYPE historia AS INT;
CREATE TYPE medico AS INT;
CREATE TYPE observacion AS VARCHAR(1000);
CREATE TYPE paciente AS INT;
CREATE TYPE turno AS INT;

-- ==================================================
-- Creación de las tablas de la base de datos
-- ==================================================

-- Crear tabla Concepto
CREATE TABLE Concepto (
    idconcepto TINYINT NOT NULL PRIMARY KEY,
    descripcion VARCHAR(100) NULL
);

-- Crear tabla Especialidad
CREATE TABLE Especialidad (
    idEspecialidad INT NOT NULL PRIMARY KEY,
    Especialidad VARCHAR(30) NULL
);

-- Crear tabla Historia
CREATE TABLE Historia (
    idHistoria historia NOT NULL PRIMARY KEY,
    fechaHistoria DATETIME NULL,
    observacion observacion NULL
);

-- Crear tabla HistoriaPaciente
CREATE TABLE HistoriaPaciente (
    idHistoria historia NOT NULL,
    idPaciente paciente NOT NULL,
    idMedico medico NOT NULL,
    PRIMARY KEY (idHistoria, idPaciente, idMedico),
    FOREIGN KEY (idHistoria) REFERENCES Historia(idHistoria),
    FOREIGN KEY (idPaciente) REFERENCES Paciente(idPaciente),
    FOREIGN KEY (idMedico) REFERENCES Medico(idMedico)
);

-- Crear tabla Medico
CREATE TABLE Medico (
    idMedico medico NOT NULL PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL
);

-- Crear tabla MedicoEspecialidad
CREATE TABLE MedicoEspecialidad (
    idMedico medico NOT NULL,
    idEspecialidad INT NOT NULL,
    Descripcion VARCHAR(50) NOT NULL,
    PRIMARY KEY (idMedico, idEspecialidad, Descripcion),
    FOREIGN KEY (idMedico) REFERENCES Medico(idMedico),
    FOREIGN KEY (idEspecialidad) REFERENCES Especialidad(idEspecialidad)
);

-- Crear tabla Paciente
CREATE TABLE Paciente (
    idPaciente paciente NOT NULL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    fNacimiento DATE NOT NULL,
    domicilio VARCHAR(50) NOT NULL,
    idPais CHAR(3) NULL,
    telefono VARCHAR(20) NULL,
    email VARCHAR(30) NOT NULL,
    observacion observacion NULL,
    FOREIGN KEY (idPais) REFERENCES Pais(idPais)
);

-- Crear tabla Pago
CREATE TABLE Pago (
    idpago INT NOT NULL PRIMARY KEY,
    concepto TINYINT NOT NULL,
    fecha DATETIME NOT NULL,
    monto MONEY NOT NULL,
    estado TINYINT NULL,
    observacion observacion NULL,
    FOREIGN KEY (concepto) REFERENCES Concepto(idconcepto)
);

-- Crear tabla PagoPaciente
CREATE TABLE PagoPaciente (
    idpago INT NOT NULL,
    idpaciente paciente NOT NULL,
    idturno turno NOT NULL,
    PRIMARY KEY (idpago, idpaciente, idturno),
    FOREIGN KEY (idpago) REFERENCES Pago(idpago),
    FOREIGN KEY (idpaciente) REFERENCES Paciente(idPaciente),
    FOREIGN KEY (idturno) REFERENCES Turno(idTurno)
);

-- Crear tabla Pais
CREATE TABLE Pais (
    idPais CHAR(3) NOT NULL PRIMARY KEY,
    Pais VARCHAR(30) NULL
);

-- Crear tabla Turno
CREATE TABLE Turno (
    idTurno turno NOT NULL PRIMARY KEY,
    fechaTurno DATETIME NULL,
    estado SMALLINT NULL,
    observacion observacion NULL
);

-- Crear tabla TurnoEstado
CREATE TABLE TurnoEstado (
    idEstado SMALLINT NOT NULL PRIMARY KEY,
    Descripcion VARCHAR(50) NULL
);

-- Crear tabla TurnoPaciente
CREATE TABLE TurnoPaciente (
    idTurno turno NOT NULL,
    idPaciente paciente NOT NULL,
    idMedico medico NOT NULL,
    PRIMARY KEY (idTurno, idPaciente, idMedico),
    FOREIGN KEY (idTurno) REFERENCES Turno(idTurno),
    FOREIGN KEY (idPaciente) REFERENCES Paciente(idPaciente),
    FOREIGN KEY (idMedico) REFERENCES Medico(idMedico)
);


-- ==================================================
-- Inserción de registros
-- ==================================================

-- Insertar en la tabla Pais
INSERT INTO Pais (idPais, Pais) 
VALUES 
    ('ARG', 'Argentina'),
    ('ESP', 'España'),
    ('USA', 'Estados Unidos');

-- Insertar en la tabla Concepto
INSERT INTO Concepto (idconcepto, descripcion) 
VALUES 
    (1, 'Consulta General'),
    (2, 'Chequeo Anual'),
    (3, 'Emergencia'),
    (4, 'Tratamiento Especial');

-- Insertar en la tabla Especialidad
INSERT INTO Especialidad (idEspecialidad, Especialidad) 
VALUES 
    (1, 'Cardiología'),
    (2, 'Dermatología'),
    (3, 'Neurología'),
    (4, 'Pediatría');

-- Insertar en la tabla Medico
INSERT INTO Medico (idMedico, Nombre, Apellido) 
VALUES 
    (1, 'Juan', 'Pérez'),
    (2, 'Ana', 'Gómez'),
    (3, 'Carlos', 'Sánchez'),
    (4, 'Lucía', 'Martínez');

-- Insertar en la tabla Historia
INSERT INTO Historia (idHistoria, fechaHistoria, observacion) 
VALUES 
    (1001, '2024-11-10 08:30:00', 'Paciente presenta dolor torácico recurrente. Se solicita ecocardiograma.'),
    (1002, '2024-11-09 14:15:00', 'Chequeo de rutina, todos los signos normales.'),
    (1003, '2024-11-08 10:00:00', 'Paciente refiere migraña constante desde hace una semana.');

-- Insertar en la tabla HistoriaPaciente
INSERT INTO HistoriaPaciente (idHistoria, idPaciente, idMedico) 
VALUES 
    (1001, 1, 1),  -- Historia 1001 para Paciente 1, Medico 1
    (1002, 2, 2),  -- Historia 1002 para Paciente 2, Medico 2
    (1003, 3, 3);  -- Historia 1003 para Paciente 3, Medico 3

-- Insertar en la tabla MedicoEspecialidad
INSERT INTO MedicoEspecialidad (idMedico, idEspecialidad, Descripcion) 
VALUES 
    (1, 1, 'Cardiología General'),
    (2, 2, 'Dermatología Estética'),
    (3, 3, 'Neurología Pediátrica'),
    (4, 4, 'Pediatría Preventiva');

-- Insertar en la tabla Paciente
INSERT INTO Paciente (idPaciente, nombre, apellido, fNacimiento, domicilio, idPais, telefono, email, observacion) 
VALUES 
    (1, 'Pedro', 'González', '1985-04-25', 'Calle Ficticia 123, Madrid', 'ESP', '123456789', 'pedro.gonzalez@email.com', 'Paciente con antecedentes de hipertensión.'),
    (2, 'María', 'López', '1990-06-15', 'Avenida Principal 456, Barcelona', 'ESP', '987654321', 'maria.lopez@email.com', 'Sin antecedentes médicos relevantes.'),
    (3, 'Carlos', 'Martínez', '2000-08-05', 'Calle Real 789, Valencia', 'ESP', '555123456', 'carlos.martinez@email.com', 'Paciente con antecedentes de migrañas frecuentes.');

-- Insertar en la tabla Pago
INSERT INTO Pago (idpago, concepto, fecha, monto, estado, observacion) 
VALUES 
    (1, 1, '2024-11-10 09:00:00', 50.00, 1, 'Pago por consulta general'),
    (2, 3, '2024-11-09 16:30:00', 150.00, 1, 'Emergencia por dolor abdominal'),
    (3, 2, '2024-11-08 11:00:00', 100.00, 1, 'Pago por chequeo anual');

-- Insertar en la tabla PagoPaciente
INSERT INTO PagoPaciente (idpago, idpaciente, idturno) 
VALUES 
    (1, 1, 101),  -- Pago 1, Paciente 1, Turno 101
    (2, 2, 102),  -- Pago 2, Paciente 2, Turno 102
    (3, 3, 103);  -- Pago 3, Paciente 3, Turno 103

-- Insertar en la tabla Turno
INSERT INTO Turno (idTurno, fechaTurno, estado, observacion) 
VALUES 
    (101, '2024-11-10 08:00:00', 1, 'Turno confirmado para consulta general'),
    (102, '2024-11-09 14:00:00', 2, 'Turno para consulta de emergencia'),
    (103, '2024-11-08 10:30:00', 1, 'Turno para chequeo de rutina');

-- Insertar en la tabla TurnoEstado
INSERT INTO TurnoEstado (idEstado, Descripcion) 
VALUES 
    (1, 'Confirmado'),
    (2, 'Pendiente'),
    (3, 'Cancelado');

-- Insertar en la tabla TurnoPaciente
INSERT INTO TurnoPaciente (idTurno, idPaciente, idMedico) 
VALUES 
    (101, 1, 1),  -- Turno 101 para Paciente 1, Medico 1
    (102, 2, 2),  -- Turno 102 para Paciente 2, Medico 2
    (103, 3, 3);  -- Turno 103 para Paciente 3, Medico 3
