# Base de Datos para un Centro Médico
Repositorio para el Proyecto de un Centro Médico del Curso de Certificación de SQL SERVER de IBM SkillsBuild, DataHack y Fundae
# 1. Diseñando la base de datos
En la base de datos tenemos una serie de tablas y tipos de datos que nos van a facilitar la gestión de un centro médico. Los detalles se muestran a continuación:
## 1.1. **Tipos de datos definidos por el usuario**:
   - `historia`: Tipo de dato `int` para identificar historias.
   - `medico`: Tipo de dato `int` para identificar médicos.
   - `observacuib`: Tipo de dato `varchar(1000)` para observaciones.
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
## 1.3. **Diagrama de la base de datos Centro Medico**
![Diagrama de la base de datos](images/CentroMedico.png)
