# Base de Datos para un Centro Médico
Repositorio para el Proyecto de un Centro Médico del Curso de Certificación de SQL SERVER de IBM SkillsBuild, DataHack y Fundae
# 1. Diseñando la base de datos
En la base de datos tenemos una serie de tablas y tipos de datos que nos van a facilitar la gestión de un centro médico. Los detalles se muestran a continuación:
## 1.1. **Tipos de datos definidos por el usuario**:
   - `historia`: Tipo de dato `int` para identificar historias.
   - `medico`: Tipo de dato `int` para identificar médicos.
   - `observacion`: Tipo de dato `varchar(1000)` para observaciones.
   - `paciente`: Tipo de dato `int` para identificar pacientes.
   - `turno`: Tipo de dato `int` para identificar turnos.
## 1.2. **Tablas**:
   - **Concepto**: Contiene `idconcepto` (identificador) y `descripcion` (de tipo `varchar(100)`).
   - **Especialidad**: Define especialidades médicas, con un identificador `idEspecialidad` y su descripción.
   - **Historia**: Almacena las historias médicas, con un `idHistoria`, la `fechaHistoria`, y una `observacion`.
   - **HistoriaPaciente**: Relaciona las historias médicas con pacientes y médicos a través de las claves `idHistoria`, `idPaciente`, y `idMedico`.
   - **Medico**: Información de los médicos, con `idMedico`, `Nombre`, y `Apellido`.
   - **MedicoEspecialidad**: Relaciona médicos con especialidades, con `idMedico`, `idEspecialidad`, y `Descripcion`.
   - **Paciente**: Contiene información de los pacientes, como `idPaciente`, `nombre`, `apellido`, `fNacimiento`, `domicilio`, etc.
   - **Pago**: Registra pagos realizados, con detalles como `idpago`, `concepto`, `fecha`, `monto`, `estado`, y `observacion`.
   - **PagoPaciente**: Relaciona pagos con pacientes y turnos, con claves como `idpago`, `idpaciente`, y `idturno`.
   - **Pais**: Información sobre países, con un identificador `idPais` y el nombre del país.
   - **Turno**: Almacena los turnos, con información sobre `idTurno`, `fechaTurno`, `estado`, y `observacion`.
   - **TurnoEstado**: Define los posibles estados de un turno, con `idEstado` y `Descripcion`.
   - **TurnoPaciente**: Relaciona turnos con pacientes y médicos, utilizando `idTurno`, `idPaciente`, y `idMedico`.
## 1.3. **Tipos y restricciones**:
### **1. Tabla: Concepto**
- **idconcepto**: `tinyint` (NOT NULL) → **Clave primaria**
- **descripcion**: `varchar(100)` (NULL)

### **2. Tabla: Especialidad**
- **idEspecialidad**: `int` (NOT NULL) → **Clave primaria**
- **Especialidad**: `varchar(30)` (NULL)

### **3. Tabla: Historia**
- **idHistoria**: `dbo.historia` (NOT NULL) → **Clave primaria**
- **fechaHistoria**: `datetime` (NULL)
- **observacion**: `dbo.observacion` (NULL)

### **4. Tabla: HistoriaPaciente**
- **idHistoria**: `dbo.historia` (NOT NULL) → **Clave foránea** referencia a `Historia`
- **idPaciente**: `dbo.paciente` (NOT NULL) → **Clave foránea** referencia a `Paciente`
- **idMedico**: `dbo.medico` (NOT NULL) → **Clave foránea** referencia a `Medico`
- **Claves primarias:** (`idHistoria`, `idPaciente`, `idMedico`).

### **5. Tabla: Medico**
- **idMedico**: `dbo.medico` (NOT NULL) → **Clave primaria**
- **Nombre**: `varchar(50)` (NOT NULL)
- **Apellido**: `varchar(50)` (NOT NULL)

### **6. Tabla: MedicoEspecialidad**
- **idMedico**: `dbo.medico` (NOT NULL) → **Clave foránea** referencia a `Medico`
- **idEspecialidad**: `int` (NOT NULL) → **Clave foránea** referencia a `Especialidad`
- **Descripcion**: `varchar(50)` (NOT NULL)
- **Claves primarias**: (`idMedico`, `idEspecialidad`, `Descripcion`).

### **7. Tabla: Paciente**
- **idPaciente**: `dbo.paciente` (NOT NULL) → **Clave primaria**
- **nombre**: `varchar(50)` (NOT NULL)
- **apellido**: `varchar(50)` (NOT NULL)
- **fNacimiento**: `date` (NOT NULL)
- **domicilio**: `varchar(50)` (NOT NULL)
- **idPais**: `char(3)` (NULL) → **Clave foránea** referencia a `Pais`
- **telefono**: `varchar(20)` (NULL)
- **email**: `varchar(30)` (NOT NULL)
- **observacion**: `dbo.observacion` (NULL)

### **8. Tabla: Pago**
- **idpago**: `int` (NOT NULL) → **Clave primaria**
- **concepto**: `tinyint` (NOT NULL) → **Clave foránea** referencia a `Concepto`
- **fecha**: `datetime` (NOT NULL)
- **monto**: `money` (NOT NULL)
- **estado**: `tinyint` (NULL)
- **observacion**: `dbo.observacion` (NULL)

### **9. Tabla: PagoPaciente**
- **idpago**: `int` (NOT NULL) → **Clave foránea** referencia a `Pago`
- **idpaciente**: `dbo.paciente` (NOT NULL) → **Clave foránea** referencia a `Paciente`
- **idturno**: `int` (NOT NULL) → **Clave foránea** referencia a `Turno`
- **Claves primarias**: (`idpago`, `idpaciente`, `idturno`).
  
### **10. Tabla: Pais**
- **idPais**: `char(3)` (NOT NULL) → **Clave primaria**
- **Pais**: `varchar(30)` (NULL)

### **11. Tabla: Turno**
- **idTurno**: `dbo.turno` (NOT NULL) → **Clave primaria**
- **fechaTurno**: `datetime` (NULL)
- **estado**: `smallint` (NULL)
- **observacion**: `dbo.observacion` (NULL)

### **12. Tabla: TurnoEstado**
- **idEstado**: `smallint` (NOT NULL) → **Clave primaria**
- **Descripcion**: `varchar(50)` (NULL)

### **13. Tabla: TurnoPaciente**
- **idTurno**: `int` (NOT NULL) → **Clave foránea** referencia a `Turno`
- **idPaciente**: `dbo.paciente` (NOT NULL) → **Clave foránea** referencia a `Paciente`
- **idMedico**: `dbo.medico` (NOT NULL) → **Clave foránea** referencia a `Medico`
- **Claves primarias**: (`idTurno`, `idPaciente`, `idMedico`)
- **Claves primarias**: (`idTurno`, `idPaciente`, `idMedico`)

## 1.4. **Diagrama de la base de datos Centro Medico**
![Diagrama de la base de datos](images/CentroMedico.png)
