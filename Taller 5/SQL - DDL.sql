-- sql10588366.`Enfermedad antigua` definition

CREATE TABLE `Enfermedad antigua` (
  `Id_enfermedadAntigua` int(11) NOT NULL,
  `Nombre_enfermedad` varchar(120) NOT NULL,
  `Descripción` varchar(300) NOT NULL,
  `Tratamiento` varchar(500) NOT NULL,
  PRIMARY KEY (`Id_enfermedadAntigua`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- sql10588366.Turnos definition

CREATE TABLE `Turnos` (
  `Id_turno` int(11) NOT NULL,
  `Horario` varchar(400) NOT NULL,
  PRIMARY KEY (`Id_turno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- sql10588366.`Enfermedad actual` definition

CREATE TABLE `Enfermedad actual` (
  `Id_enfermedadActual` int(11) NOT NULL,
  `Nombre_enfermedad` varchar(120) NOT NULL,
  `Descripcion` varchar(300) NOT NULL,
  `Tratamiento` varchar(500) NOT NULL,
  PRIMARY KEY (`Id_enfermedadActual`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- sql10588366.Persona definition

CREATE TABLE `Persona` (
  `Id_persona` int(11) NOT NULL,
  `Nombre` varchar(120) NOT NULL,
  `CC` int(11) NOT NULL,
  `Ocupacion_actual` varchar(100) NOT NULL,
  `Estado_civil` varchar(100) NOT NULL,
  `Fecha_nacimiento` date NOT NULL,
  `Lugar_procedencia` varchar(120) NOT NULL,
  `Lugar_residencia` varchar(120) NOT NULL,
  PRIMARY KEY (`Id_persona`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- sql10588366.`Historial de turnos` definition

CREATE TABLE `Historial de turnos` (
  `Id_historialTurnos` int(11) NOT NULL,
  `Id_turno` int(11) NOT NULL,
  PRIMARY KEY (`Id_historialTurnos`),
  KEY `Historial_de_turnos_FK` (`Id_turno`),
  CONSTRAINT `Historial_de_turnos_FK` FOREIGN KEY (`Id_turno`) REFERENCES `Turnos` (`Id_turno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- sql10588366.Diagnostico definition

CREATE TABLE `Diagnostico` (
  `Id_diagnostico` int(11) NOT NULL,
  `Descripcion` varchar(1200) NOT NULL,
  `Id_enfermedadActual` int(11) NOT NULL,
  PRIMARY KEY (`Id_diagnostico`),
  KEY `Diagnostico_FK` (`Id_enfermedadActual`),
  CONSTRAINT `Diagnostico_FK` FOREIGN KEY (`Id_enfermedadActual`) REFERENCES `Enfermedad actual` (`Id_enfermedadActual`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- sql10588366.`Historia clinica` definition

CREATE TABLE `Historia clinica` (
  `Id_historia` int(11) NOT NULL,
  `Id_enfermedadActual` int(11) NOT NULL,
  `Id_enfermedadAntigua` int(11) NOT NULL,
  PRIMARY KEY (`Id_historia`),
  KEY `Historia_clinica_FK` (`Id_enfermedadAntigua`),
  KEY `Historia_clinica_FK_1` (`Id_enfermedadActual`),
  CONSTRAINT `Historia_clinica_FK` FOREIGN KEY (`Id_enfermedadAntigua`) REFERENCES `Enfermedad antigua` (`Id_enfermedadAntigua`),
  CONSTRAINT `Historia_clinica_FK_1` FOREIGN KEY (`Id_enfermedadActual`) REFERENCES `Enfermedad actual` (`Id_enfermedadActual`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- sql10588366.Usuario definition

CREATE TABLE `Usuario` (
  `Id_usuario` int(11) NOT NULL,
  `Id_historia` int(11) NOT NULL,
  `Tipo_especialidad` varchar(120) NOT NULL,
  PRIMARY KEY (`Id_usuario`),
  KEY `Usuario_FK_1` (`Id_historia`),
  CONSTRAINT `Usuario_FK` FOREIGN KEY (`Id_usuario`) REFERENCES `Persona` (`Id_persona`),
  CONSTRAINT `Usuario_FK_1` FOREIGN KEY (`Id_historia`) REFERENCES `Historia clinica` (`Id_historia`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- sql10588366.Paciente definition

CREATE TABLE `Paciente` (
  `Id_paciente` int(11) NOT NULL,
  `Id_historia` int(11) NOT NULL,
  `Tipo_especialidad` varchar(120) NOT NULL,
  PRIMARY KEY (`Id_paciente`),
  KEY `Paciente_FK` (`Id_historia`),
  CONSTRAINT `Paciente_FK` FOREIGN KEY (`Id_historia`) REFERENCES `Historia clinica` (`Id_historia`),
  CONSTRAINT `Paciente_FK_1` FOREIGN KEY (`Id_paciente`) REFERENCES `Persona` (`Id_persona`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- sql10588366.Medico definition

CREATE TABLE `Medico` (
  `Id_medico` int(11) NOT NULL,
  `Id_turno` int(11) NOT NULL,
  `Especialidad` varchar(120) NOT NULL,
  `Id_historialTurnos` int(11) NOT NULL,
  PRIMARY KEY (`Id_medico`),
  KEY `Medico_FK` (`Id_turno`),
  KEY `Medico_FK_1` (`Id_historialTurnos`),
  CONSTRAINT `Medico_FK` FOREIGN KEY (`Id_turno`) REFERENCES `Turnos` (`Id_turno`),
  CONSTRAINT `Medico_FK_1` FOREIGN KEY (`Id_historialTurnos`) REFERENCES `Historial de turnos` (`Id_historialTurnos`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- sql10588366.`Responsable de turno` definition

CREATE TABLE `Responsable de turno` (
  `Id_respTurno` int(11) NOT NULL,
  `Id_turno` int(11) NOT NULL,
  `Id_historialTurnos` int(11) NOT NULL,
  PRIMARY KEY (`Id_respTurno`),
  KEY `Responsable_de_turno_FK` (`Id_historialTurnos`),
  KEY `Responsable_de_turno_FK_1` (`Id_turno`),
  CONSTRAINT `Responsable_de_turno_FK` FOREIGN KEY (`Id_historialTurnos`) REFERENCES `Historial de turnos` (`Id_historialTurnos`),
  CONSTRAINT `Responsable_de_turno_FK_1` FOREIGN KEY (`Id_turno`) REFERENCES `Turnos` (`Id_turno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- sql10588366.Informacion definition

CREATE TABLE `Informacion` (
  `Id_informacion` int(11) NOT NULL,
  `Informacion` varchar(400) NOT NULL,
  `Cobro` float NOT NULL,
  `Id_usuario` int(11) NOT NULL,
  PRIMARY KEY (`Id_informacion`),
  KEY `Informacion_FK` (`Id_usuario`),
  CONSTRAINT `Informacion_FK` FOREIGN KEY (`Id_usuario`) REFERENCES `Usuario` (`Id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- sql10588366.`Nuevo paciente` definition

CREATE TABLE `Nuevo paciente` (
  `Id_nuevoPaciente` int(11) NOT NULL,
  `Observacion_directa` varchar(300) NOT NULL,
  `Exploracion` varchar(300) NOT NULL,
  `Carnet_afiliacion` tinyint(1) DEFAULT NULL,
  `Orden_medica` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`Id_nuevoPaciente`),
  CONSTRAINT `Nuevo_paciente_FK` FOREIGN KEY (`Id_nuevoPaciente`) REFERENCES `Paciente` (`Id_paciente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- sql10588366.Administrativo definition

CREATE TABLE `Administrativo` (
  `Id_administrativo` int(11) NOT NULL,
  `Estudios` varchar(300) NOT NULL,
  `Especialidad` varchar(120) NOT NULL,
  `Id_informacion` int(11) NOT NULL,
  PRIMARY KEY (`Id_administrativo`),
  KEY `Administrativo_FK` (`Id_informacion`),
  CONSTRAINT `Administrativo_FK` FOREIGN KEY (`Id_informacion`) REFERENCES `Informacion` (`Id_informacion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- sql10588366.`Consulta externa` definition

CREATE TABLE `Consulta externa` (
  `Id_consulta` int(11) NOT NULL,
  `Id_respTurno` int(11) NOT NULL,
  `Id_paciente` int(11) NOT NULL,
  `Id_medico` int(11) NOT NULL,
  `Id_usuario` int(11) NOT NULL,
  `Id_informacion` int(11) NOT NULL,
  `Id_diagnostico` int(11) NOT NULL,
  `Id_turno` int(11) NOT NULL,
  `Id_administrativo` int(11) NOT NULL,
  `Id_nuevoPaciente` int(11) NOT NULL,
  PRIMARY KEY (`Id_consulta`),
  KEY `Consulta_externa_FK` (`Id_usuario`),
  KEY `Consulta_externa_FK_1` (`Id_medico`),
  KEY `Consulta_externa_FK_2` (`Id_administrativo`),
  KEY `Consulta_externa_FK_3` (`Id_paciente`),
  KEY `Consulta_externa_FK_4` (`Id_respTurno`),
  KEY `Consulta_externa_FK_5` (`Id_nuevoPaciente`),
  KEY `Consulta_externa_FK_6` (`Id_turno`),
  KEY `Consulta_externa_FK_7` (`Id_informacion`),
  KEY `Consulta_externa_FK_8` (`Id_diagnostico`),
  CONSTRAINT `Consulta_externa_FK` FOREIGN KEY (`Id_usuario`) REFERENCES `Usuario` (`Id_usuario`),
  CONSTRAINT `Consulta_externa_FK_1` FOREIGN KEY (`Id_medico`) REFERENCES `Medico` (`Id_medico`),
  CONSTRAINT `Consulta_externa_FK_2` FOREIGN KEY (`Id_administrativo`) REFERENCES `Administrativo` (`Id_administrativo`),
  CONSTRAINT `Consulta_externa_FK_3` FOREIGN KEY (`Id_paciente`) REFERENCES `Paciente` (`Id_paciente`),
  CONSTRAINT `Consulta_externa_FK_4` FOREIGN KEY (`Id_respTurno`) REFERENCES `Responsable de turno` (`Id_respTurno`),
  CONSTRAINT `Consulta_externa_FK_5` FOREIGN KEY (`Id_nuevoPaciente`) REFERENCES `Nuevo paciente` (`Id_nuevoPaciente`),
  CONSTRAINT `Consulta_externa_FK_6` FOREIGN KEY (`Id_turno`) REFERENCES `Turnos` (`Id_turno`),
  CONSTRAINT `Consulta_externa_FK_7` FOREIGN KEY (`Id_informacion`) REFERENCES `Informacion` (`Id_informacion`),
  CONSTRAINT `Consulta_externa_FK_8` FOREIGN KEY (`Id_diagnostico`) REFERENCES `Diagnostico` (`Id_diagnostico`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;