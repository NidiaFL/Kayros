-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 11-12-2023 a las 07:26:09
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `kayros`
--
CREATE DATABASE IF NOT EXISTS `kayros` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `kayros`;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `CambiarEstadoADestiempo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CambiarEstadoADestiempo` (IN `new_id_Cita` INT)   BEGIN
  DECLARE tiempo_pasado INT;
  
  SELECT TIMESTAMPDIFF(MINUTE, CONCAT(Fecha_Cita, ' ', Hora_Cita), NOW()) INTO tiempo_pasado
  FROM Cita
  WHERE id_Cita = new_id_Cita;

  IF tiempo_pasado > 30 THEN
    UPDATE Cita SET Estado = 'A Destiempo' WHERE id_Cita = new_id_Cita;
  END IF;
END$$

DROP PROCEDURE IF EXISTS `CambiarEstadoAEnCamino`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CambiarEstadoAEnCamino` (IN `new_id_Cita` INT)   BEGIN
  DECLARE tiempo_pasado INT;
  
  SELECT TIMESTAMPDIFF(MINUTE, CONCAT(Fecha_Cita, ' ', Hora_Cita), NOW()) INTO tiempo_pasado
  FROM Cita
  WHERE id_Cita = new_id_Cita;

  IF tiempo_pasado >= 0 AND tiempo_pasado <= 60 THEN
    UPDATE Cita SET Estado = 'En Camino' WHERE id_Cita = new_id_Cita;
  END IF;
END$$

DROP PROCEDURE IF EXISTS `CambiarEstadoARecibida`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CambiarEstadoARecibida` (IN `new_id_Cita` INT)   BEGIN
  DECLARE tiempo_pasado INT;
  
  SELECT TIMESTAMPDIFF(MINUTE, CONCAT(Fecha_Cita, ' ', Hora_Cita), NOW()) INTO tiempo_pasado
  FROM Cita
  WHERE id_Cita = new_id_Cita;

  IF tiempo_pasado <= 0 THEN
    UPDATE Cita SET Estado = 'Recibida' WHERE id_Cita = new_id_Cita;
  END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `acceso`
--

DROP TABLE IF EXISTS `acceso`;
CREATE TABLE IF NOT EXISTS `acceso` (
  `id_Acceso` int(11) NOT NULL AUTO_INCREMENT,
  `Hora_Acceso` datetime NOT NULL,
  `id_Operador_Interno` int(11) DEFAULT NULL,
  `id_Operador_Externo` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_Acceso`),
  KEY `id_Operador_Interno` (`id_Operador_Interno`),
  KEY `id_Operador_Externo` (`id_Operador_Externo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `acceso`:
--   `id_Operador_Interno`
--       `operador_interno` -> `id_Operador_Interno`
--   `id_Operador_Externo`
--       `operador_externo` -> `id_Operador_Externo`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cita`
--

DROP TABLE IF EXISTS `cita`;
CREATE TABLE IF NOT EXISTS `cita` (
  `id_Cita` int(11) NOT NULL AUTO_INCREMENT,
  `Fecha_Cita` date NOT NULL,
  `Hora_Cita` time NOT NULL,
  `Descripcion` varchar(200) DEFAULT NULL,
  `id_Operador_Interno` int(11) NOT NULL,
  `id_RutaCitas` int(11) NOT NULL,
  `id_TransporteCitas` int(11) NOT NULL,
  `Estado` varchar(20) NOT NULL DEFAULT 'Agendada',
  PRIMARY KEY (`id_Cita`),
  KEY `id_Operador_Interno` (`id_Operador_Interno`),
  KEY `id_TransporteCitas` (`id_TransporteCitas`),
  KEY `cita_ibfk_2` (`id_RutaCitas`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `cita`:
--   `id_Operador_Interno`
--       `operador_interno` -> `id_Operador_Interno`
--   `id_RutaCitas`
--       `ruta` -> `id_Rutas`
--   `id_TransporteCitas`
--       `transportes` -> `id_Transportes`
--

--
-- Volcado de datos para la tabla `cita`
--

INSERT INTO `cita` (`id_Cita`, `Fecha_Cita`, `Hora_Cita`, `Descripcion`, `id_Operador_Interno`, `id_RutaCitas`, `id_TransporteCitas`, `Estado`) VALUES
(9, '2023-11-30', '14:17:00', 'ssdcad', 1, 2, 1, 'Agendada'),
(10, '2023-11-29', '14:16:00', 'sdasd', 1, 1, 22, 'Agendada'),
(11, '2023-11-30', '14:23:00', 'sadasd', 1, 1, 2, 'Agendada'),
(12, '2023-11-30', '14:24:00', 'PRUEBA TRIGGERS', 1, 1, 24, 'Agendada'),
(13, '2023-11-30', '19:33:00', 'PRUEBA 2.2', 2, 1, 22, 'Agendada'),
(14, '2023-12-06', '11:56:17', 'prueba de adentro', 1, 3, 1, 'Adentro'),
(15, '2023-12-06', '14:32:58', 'Prueba 2.2', 2, 3, 1, 'Adentro'),
(16, '2023-12-06', '15:47:00', 'jijiji', 1, 1, 2, 'Agendada'),
(17, '2023-12-06', '15:47:00', 'jijiji', 1, 1, 2, 'Agendada'),
(18, '2023-12-06', '16:21:00', 'VICTOR', 1, 1, 2, 'Agendada'),
(19, '2023-12-07', '15:24:00', 'victor1', 2, 1, 12, 'Agendada');

--
-- Disparadores `cita`
--
DROP TRIGGER IF EXISTS `TriggerCambiarADestiempo`;
DELIMITER $$
CREATE TRIGGER `TriggerCambiarADestiempo` AFTER UPDATE ON `cita` FOR EACH ROW CALL CambiarEstadoADestiempo(NEW.id_Cita)
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `TriggerCambiarEnCamino`;
DELIMITER $$
CREATE TRIGGER `TriggerCambiarEnCamino` AFTER UPDATE ON `cita` FOR EACH ROW CALL CambiarEstadoAEnCamino(NEW.id_Cita)
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `TriggerCambiarRecibida`;
DELIMITER $$
CREATE TRIGGER `TriggerCambiarRecibida` AFTER UPDATE ON `cita` FOR EACH ROW CALL CambiarEstadoARecibida(NEW.id_Cita)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `citas`
--

DROP TABLE IF EXISTS `citas`;
CREATE TABLE IF NOT EXISTS `citas` (
  `id_Cita` int(11) NOT NULL AUTO_INCREMENT,
  `Fecha_Cita` date NOT NULL,
  `Hora_Cita` time NOT NULL,
  `Descripcion` varchar(200) DEFAULT NULL,
  `id_Operador_interno` int(11) NOT NULL,
  `id_RutaCita` int(11) DEFAULT NULL,
  `id_TransporteCita` int(11) NOT NULL,
  PRIMARY KEY (`id_Cita`),
  KEY `Operador_id` (`id_Operador_interno`) USING BTREE,
  KEY `id_TransporteCita` (`id_TransporteCita`),
  KEY `id_RutaCita` (`id_RutaCita`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `citas`:
--   `id_Operador_interno`
--       `operador_interno` -> `id_Operador_Interno`
--

--
-- Volcado de datos para la tabla `citas`
--

INSERT INTO `citas` (`id_Cita`, `Fecha_Cita`, `Hora_Cita`, `Descripcion`, `id_Operador_interno`, `id_RutaCita`, `id_TransporteCita`) VALUES
(1, '2023-10-25', '17:18:00', 'pruebaaa', 1, 0, 0),
(2, '2023-10-25', '17:18:00', 'pruebaaa', 1, 0, 0),
(3, '2023-10-16', '20:18:00', 'pruebaaa', 1, 0, 0),
(4, '2023-10-31', '07:04:00', 'hola', 2, 0, 0),
(5, '2023-10-09', '09:10:00', 'phjjbb', 1, 0, 0),
(6, '2023-10-09', '09:10:00', 'phjjbb', 2, 0, 0),
(7, '2023-10-17', '13:13:00', 'HOLA MUNDO', 1, 0, 0),
(8, '2023-11-22', '09:05:00', 'CARGAMENTO DE JITOMATE', 1, 0, 0),
(9, '2023-11-01', '16:43:00', 'Prueba', 1, 0, 0),
(10, '2023-11-10', '04:48:00', 'Prueba 2', 2, 0, 0),
(11, '2023-11-29', '03:49:00', 'Prueba 3', 1, 0, 0),
(12, '2023-11-01', '04:04:00', 'Dia de muertos', 1, 0, 0),
(13, '2023-11-01', '20:09:00', 'kjkjkj', 1, 0, 0),
(14, '2023-11-01', '20:09:00', 'kjkjkj', 1, 0, 0),
(16, '2023-10-17', '18:22:00', 'jashjdasd', 2, 0, 0),
(20, '2023-10-23', '18:54:00', 'PRUEBA', 1, 0, 0),
(21, '2023-11-13', '00:22:00', 'Prueba', 1, 0, 0),
(22, '2023-11-07', '16:16:00', 'Prueba', 1, 0, 0),
(24, '2023-11-13', '11:20:30', 'PRUEBA', 2, 3, 1),
(27, '2023-11-06', '17:25:00', 'PRUEBA 2.0', 1, 0, 12);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `citasdestiempo`
--

DROP TABLE IF EXISTS `citasdestiempo`;
CREATE TABLE IF NOT EXISTS `citasdestiempo` (
  `id_CitaDestiempo` int(11) NOT NULL AUTO_INCREMENT,
  `id_Cita` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_CitaDestiempo`),
  UNIQUE KEY `UQ_Cita` (`id_Cita`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `citasdestiempo`:
--   `id_Cita`
--       `cita` -> `id_Cita`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentarios`
--

DROP TABLE IF EXISTS `comentarios`;
CREATE TABLE IF NOT EXISTS `comentarios` (
  `id_Comentario` int(11) NOT NULL AUTO_INCREMENT,
  `Comentario` varchar(500) NOT NULL,
  `id_Cita` int(11) NOT NULL,
  PRIMARY KEY (`id_Comentario`),
  KEY `id_Cita` (`id_Cita`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `comentarios`:
--   `id_Cita`
--       `cita` -> `id_Cita`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `credenciales`
--

DROP TABLE IF EXISTS `credenciales`;
CREATE TABLE IF NOT EXISTS `credenciales` (
  `id_Credencial` int(11) NOT NULL AUTO_INCREMENT,
  `Correo` varchar(200) NOT NULL,
  `Contrasena` varchar(200) NOT NULL,
  `Nombre_Usuario` varchar(200) DEFAULT NULL,
  `Usuario_id` int(11) NOT NULL,
  PRIMARY KEY (`id_Credencial`),
  UNIQUE KEY `Correo` (`Correo`),
  KEY `Usuario_id` (`Usuario_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `credenciales`:
--   `Usuario_id`
--       `usuarios` -> `id_Usuario`
--

--
-- Volcado de datos para la tabla `credenciales`
--

INSERT INTO `credenciales` (`id_Credencial`, `Correo`, `Contrasena`, `Nombre_Usuario`, `Usuario_id`) VALUES
(1, 'juan@email.com', '1234', 'juanperez', 1),
(2, 'jose@email.com', '1234', 'jose.garcia', 2),
(3, 'pedrito@email.com', '1234', 'pedrito.villa', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documentos`
--

DROP TABLE IF EXISTS `documentos`;
CREATE TABLE IF NOT EXISTS `documentos` (
  `id_Documentos` int(11) NOT NULL AUTO_INCREMENT,
  `INE` varchar(18) DEFAULT NULL,
  `Seguro_IMSS` varchar(20) DEFAULT NULL,
  `Licencia_Conducir` varchar(20) DEFAULT NULL,
  `id_Operador_Interno` int(11) DEFAULT NULL,
  `id_Operador_Externo` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_Documentos`),
  UNIQUE KEY `INE` (`INE`),
  UNIQUE KEY `Seguro_IMSS` (`Seguro_IMSS`),
  UNIQUE KEY `Licencia_Conducir` (`Licencia_Conducir`),
  KEY `id_Operador_Interno` (`id_Operador_Interno`),
  KEY `id_Operador_Externo` (`id_Operador_Externo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `documentos`:
--   `id_Operador_Interno`
--       `operador_interno` -> `id_Operador_Interno`
--   `id_Operador_Externo`
--       `operador_externo` -> `id_Operador_Externo`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entrada`
--

DROP TABLE IF EXISTS `entrada`;
CREATE TABLE IF NOT EXISTS `entrada` (
  `id_Entrada` int(11) NOT NULL AUTO_INCREMENT,
  `Hora_Entrada` datetime NOT NULL,
  `id_Operador_Interno` int(11) DEFAULT NULL,
  `id_Operador_Externo` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_Entrada`),
  KEY `id_Operador_Interno` (`id_Operador_Interno`),
  KEY `id_Operador_Externo` (`id_Operador_Externo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `entrada`:
--   `id_Operador_Interno`
--       `operador_interno` -> `id_Operador_Interno`
--   `id_Operador_Externo`
--       `operador_externo` -> `id_Operador_Externo`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ganancias`
--

DROP TABLE IF EXISTS `ganancias`;
CREATE TABLE IF NOT EXISTS `ganancias` (
  `id_Ganancias` int(11) NOT NULL AUTO_INCREMENT,
  `id_Viaje` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_Ganancias`),
  KEY `id_Viaje` (`id_Viaje`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `ganancias`:
--   `id_Viaje`
--       `tipo_viaje` -> `id_Tipo_Viaje`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gastos`
--

DROP TABLE IF EXISTS `gastos`;
CREATE TABLE IF NOT EXISTS `gastos` (
  `id_Gastos` int(11) NOT NULL AUTO_INCREMENT,
  `Gasolina` decimal(10,2) DEFAULT NULL,
  `Seguro` decimal(10,2) DEFAULT NULL,
  `Maniobra` decimal(10,2) DEFAULT NULL,
  `Servicio` decimal(10,2) DEFAULT NULL,
  `Casetas` decimal(10,2) DEFAULT NULL,
  `Pago_Chofer` decimal(10,2) DEFAULT NULL,
  `Depreciacion` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_Gastos`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `gastos`:
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `operador_externo`
--

DROP TABLE IF EXISTS `operador_externo`;
CREATE TABLE IF NOT EXISTS `operador_externo` (
  `id_Operador_Externo` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(200) NOT NULL,
  `Apellido_Paterno` varchar(200) NOT NULL,
  `Apellido_Materno` varchar(200) DEFAULT NULL,
  `Correo` varchar(200) NOT NULL,
  `Usuario_id` int(11) NOT NULL,
  PRIMARY KEY (`id_Operador_Externo`),
  UNIQUE KEY `Correo` (`Correo`),
  KEY `Usuario_id` (`Usuario_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `operador_externo`:
--   `Usuario_id`
--       `usuarios` -> `id_Usuario`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `operador_interno`
--

DROP TABLE IF EXISTS `operador_interno`;
CREATE TABLE IF NOT EXISTS `operador_interno` (
  `id_Operador_Interno` int(11) NOT NULL AUTO_INCREMENT,
  `Usuario_id` int(11) NOT NULL,
  `Proveedor_id` int(11) NOT NULL,
  PRIMARY KEY (`id_Operador_Interno`),
  KEY `Usuario_id` (`Usuario_id`),
  KEY `Proveedor_id` (`Proveedor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `operador_interno`:
--   `Usuario_id`
--       `usuarios` -> `id_Usuario`
--   `Proveedor_id`
--       `proveedores` -> `ID_Proveedor`
--

--
-- Volcado de datos para la tabla `operador_interno`
--

INSERT INTO `operador_interno` (`id_Operador_Interno`, `Usuario_id`, `Proveedor_id`) VALUES
(1, 3, 4),
(2, 4, 1),
(7, 7, 4),
(8, 6, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permisos`
--

DROP TABLE IF EXISTS `permisos`;
CREATE TABLE IF NOT EXISTS `permisos` (
  `id_Permiso` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre_Permiso` varchar(200) NOT NULL,
  PRIMARY KEY (`id_Permiso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `permisos`:
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

DROP TABLE IF EXISTS `proveedores`;
CREATE TABLE IF NOT EXISTS `proveedores` (
  `ID_Proveedor` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(200) NOT NULL,
  `Direccion` varchar(200) DEFAULT NULL,
  `Telefono` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`ID_Proveedor`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `proveedores`:
--

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`ID_Proveedor`, `Nombre`, `Direccion`, `Telefono`) VALUES
(1, 'AMAZON MEXICO', 'TEPOZOTLAN, EDO MEX, CUAUTITLAN IZCALLI', '5632140265'),
(2, 'Transportes Castores', 'Av Nidia #2, Melchor Ocampo', '5412368798'),
(3, 'Estafeta', 'Av Huehuetoca Sin Numero', '7412589632'),
(4, 'Paty SA de CV', 'Dirección 1', '123-456-7890'),
(5, 'Corona', 'Dirección 2', '987-654-3210'),
(8, 'ESTAFETA', 'EJEMPLO', '5555555555'),
(9, '99 Minutos', 'S/N México, Coyoacan 18B', '5521456325');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `qr_cita`
--

DROP TABLE IF EXISTS `qr_cita`;
CREATE TABLE IF NOT EXISTS `qr_cita` (
  `id_QR_Cita` int(11) NOT NULL AUTO_INCREMENT,
  `Codigo_QR` varchar(500) DEFAULT NULL,
  `id_Cita` int(11) NOT NULL,
  PRIMARY KEY (`id_QR_Cita`),
  KEY `id_Cita` (`id_Cita`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `qr_cita`:
--   `id_Cita`
--       `cita` -> `id_Cita`
--

--
-- Volcado de datos para la tabla `qr_cita`
--

INSERT INTO `qr_cita` (`id_QR_Cita`, `Codigo_QR`, `id_Cita`) VALUES
(5, '6568ec70a8088.png', 9),
(6, '6568ed1891031.png', 10),
(7, '6568ee05140ff.png', 11),
(8, '6568eefdc8577.png', 12),
(9, '6568f1ae96203.png', 13),
(10, '6570e66350044.png', 19);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `qr_citas`
--

DROP TABLE IF EXISTS `qr_citas`;
CREATE TABLE IF NOT EXISTS `qr_citas` (
  `id_QR_Cita` int(11) NOT NULL AUTO_INCREMENT,
  `Codigo_QR` varchar(200) NOT NULL,
  `id_Cita` int(11) NOT NULL,
  PRIMARY KEY (`id_QR_Cita`),
  UNIQUE KEY `Codigo_QR` (`Codigo_QR`),
  KEY `id_Cita` (`id_Cita`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `qr_citas`:
--

--
-- Volcado de datos para la tabla `qr_citas`
--

INSERT INTO `qr_citas` (`id_QR_Cita`, `Codigo_QR`, `id_Cita`) VALUES
(1, '654149fd9c214.png', 9),
(3, '65414acad7802.png', 10),
(5, '65414bd815676.png', 11),
(6, '65414f2aaaea9.png', 12),
(7, '654150b9013f0.png', 13),
(8, '654151915770c.png', 14),
(9, '654152d6ce8d0.png', 16),
(10, '6541698943565.png', 20),
(11, '65427b6ae5a3c.png', 21),
(12, '654d2106bfedc.png', 22),
(13, '655fa6f1b3fb5.png', 26),
(14, '655fa750d200b.png', 27);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reportes`
--

DROP TABLE IF EXISTS `reportes`;
CREATE TABLE IF NOT EXISTS `reportes` (
  `id_Reportes` int(11) NOT NULL AUTO_INCREMENT,
  `id_Ganancias` int(11) DEFAULT NULL,
  `id_Viaje` int(11) DEFAULT NULL,
  `Proveedor_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_Reportes`),
  KEY `Proveedor_id` (`Proveedor_id`),
  KEY `id_Ganancias` (`id_Ganancias`),
  KEY `id_Viaje` (`id_Viaje`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `reportes`:
--   `Proveedor_id`
--       `proveedores` -> `ID_Proveedor`
--   `id_Ganancias`
--       `ganancias` -> `id_Ganancias`
--   `id_Viaje`
--       `tipo_viaje` -> `id_Tipo_Viaje`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id_Rol` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre_Rol` varchar(200) NOT NULL,
  PRIMARY KEY (`id_Rol`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `roles`:
--

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id_Rol`, `Nombre_Rol`) VALUES
(1, 'ADMIN'),
(2, 'VIGILANTE'),
(3, 'OPERADOR');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol_permiso`
--

DROP TABLE IF EXISTS `rol_permiso`;
CREATE TABLE IF NOT EXISTS `rol_permiso` (
  `id_Rol` int(11) DEFAULT NULL,
  `id_Permiso` int(11) DEFAULT NULL,
  KEY `id_Rol` (`id_Rol`),
  KEY `id_Permiso` (`id_Permiso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `rol_permiso`:
--   `id_Rol`
--       `roles` -> `id_Rol`
--   `id_Permiso`
--       `permisos` -> `id_Permiso`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ruta`
--

DROP TABLE IF EXISTS `ruta`;
CREATE TABLE IF NOT EXISTS `ruta` (
  `id_Rutas` int(11) NOT NULL AUTO_INCREMENT,
  `Destino` varchar(200) DEFAULT NULL,
  `Kilometros` varchar(200) DEFAULT NULL,
  `Precio` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_Rutas`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `ruta`:
--

--
-- Volcado de datos para la tabla `ruta`
--

INSERT INTO `ruta` (`id_Rutas`, `Destino`, `Kilometros`, `Precio`) VALUES
(1, 'Ciudad de México, CDMX - Monterrey, Nuevo León', '975 KM', 50000.00),
(2, 'Ciudad de México, CDMX - Guadalajara, Jalisco', '554 KM', 35000.00),
(3, 'Ciudad de México, CDMX - Culiacán, Sinaloa', '1233 KM', 75000.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rutas`
--

DROP TABLE IF EXISTS `rutas`;
CREATE TABLE IF NOT EXISTS `rutas` (
  `id_Rutas` int(11) NOT NULL AUTO_INCREMENT,
  `Destino` varchar(200) DEFAULT NULL,
  `Kilometros` varchar(20) DEFAULT NULL,
  `Precio` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_Rutas`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `rutas`:
--

--
-- Volcado de datos para la tabla `rutas`
--

INSERT INTO `rutas` (`id_Rutas`, `Destino`, `Kilometros`, `Precio`) VALUES
(1, 'Ciudad de México, Cd. de México - Monterrey, Nuevo León', '975 km', 50000.00),
(2, 'Ciudad de México, Cd. de México - Guadalajara, Jalisco', '554 km', 20000.00),
(3, 'Ciudad de México, Cd. de México - Culiacán, Sinaloa', '1233', 80000.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `salida`
--

DROP TABLE IF EXISTS `salida`;
CREATE TABLE IF NOT EXISTS `salida` (
  `id_Salida` int(11) NOT NULL AUTO_INCREMENT,
  `Hora_Salida` datetime NOT NULL,
  `id_Operador_Interno` int(11) DEFAULT NULL,
  `id_Operador_Externo` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_Salida`),
  KEY `id_Operador_Interno` (`id_Operador_Interno`),
  KEY `id_Operador_Externo` (`id_Operador_Externo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `salida`:
--   `id_Operador_Interno`
--       `operador_interno` -> `id_Operador_Interno`
--   `id_Operador_Externo`
--       `operador_externo` -> `id_Operador_Externo`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `status`
--

DROP TABLE IF EXISTS `status`;
CREATE TABLE IF NOT EXISTS `status` (
  `id_Status` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre_Status` varchar(200) NOT NULL,
  PRIMARY KEY (`id_Status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `status`:
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `statusviaje`
--

DROP TABLE IF EXISTS `statusviaje`;
CREATE TABLE IF NOT EXISTS `statusviaje` (
  `id_StatusViaje` int(11) NOT NULL AUTO_INCREMENT,
  `FechaHora` datetime NOT NULL,
  `id_Tipo_Viaje` int(11) NOT NULL,
  `id_Status` int(11) NOT NULL,
  `Comentario` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_StatusViaje`),
  KEY `id_Tipo_Viaje` (`id_Tipo_Viaje`),
  KEY `id_Status` (`id_Status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `statusviaje`:
--   `id_Tipo_Viaje`
--       `tipo_viaje` -> `id_Tipo_Viaje`
--   `id_Status`
--       `status` -> `id_Status`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipoproducto`
--

DROP TABLE IF EXISTS `tipoproducto`;
CREATE TABLE IF NOT EXISTS `tipoproducto` (
  `id_Producto` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre_Producto` varchar(200) DEFAULT NULL,
  `Proveedor_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_Producto`),
  KEY `Proveedor_id` (`Proveedor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `tipoproducto`:
--   `Proveedor_id`
--       `proveedores` -> `ID_Proveedor`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_viaje`
--

DROP TABLE IF EXISTS `tipo_viaje`;
CREATE TABLE IF NOT EXISTS `tipo_viaje` (
  `id_Tipo_Viaje` int(11) NOT NULL AUTO_INCREMENT,
  `Duracion` varchar(20) DEFAULT NULL,
  `Descripcion` varchar(200) DEFAULT NULL,
  `Precio` decimal(10,2) DEFAULT NULL,
  `id_Ruta` int(11) DEFAULT NULL,
  `id_Documentos` int(11) DEFAULT NULL,
  `id_Gasto` int(11) DEFAULT NULL,
  `id_StatusViaje` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_Tipo_Viaje`),
  KEY `id_StatusViaje` (`id_StatusViaje`),
  KEY `id_Ruta` (`id_Ruta`),
  KEY `id_Documentos` (`id_Documentos`),
  KEY `id_Gasto` (`id_Gasto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `tipo_viaje`:
--   `id_StatusViaje`
--       `statusviaje` -> `id_StatusViaje`
--   `id_Ruta`
--       `rutas` -> `id_Rutas`
--   `id_Documentos`
--       `documentos` -> `id_Documentos`
--   `id_Gasto`
--       `gastos` -> `id_Gastos`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transportes`
--

DROP TABLE IF EXISTS `transportes`;
CREATE TABLE IF NOT EXISTS `transportes` (
  `id_Transportes` int(11) NOT NULL AUTO_INCREMENT,
  `Ano` int(11) DEFAULT NULL,
  `Placas` varchar(20) DEFAULT NULL,
  `Capacidad_Carga` varchar(20) DEFAULT NULL,
  `Modelo` varchar(200) DEFAULT NULL,
  `Numero_Economico` varchar(20) DEFAULT NULL,
  `Tipo_Contenedor_Asignado` varchar(200) DEFAULT NULL,
  `Proveedor_id` int(11) NOT NULL,
  PRIMARY KEY (`id_Transportes`),
  UNIQUE KEY `Placas` (`Placas`),
  UNIQUE KEY `Numero_Economico` (`Numero_Economico`),
  KEY `Proveedor_id` (`Proveedor_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `transportes`:
--   `Proveedor_id`
--       `proveedores` -> `ID_Proveedor`
--

--
-- Volcado de datos para la tabla `transportes`
--

INSERT INTO `transportes` (`id_Transportes`, `Ano`, `Placas`, `Capacidad_Carga`, `Modelo`, `Numero_Economico`, `Tipo_Contenedor_Asignado`, `Proveedor_id`) VALUES
(1, 2023, 'MNX541', '10000', 'Torton 3.5', '12345', 'Contenedor A', 5),
(2, 3015, 'MJH54C', '523', 'Torton 3.5', '54D2C', 'Contenedor A', 2),
(12, 2023, 'KJL-58-22', '10', 'Torton 3.5', '54792-JYT', 'Contenedor A', 2),
(22, 2023, 'PATY-54', '20 Toneladas', 'Trailer', 'MUY54', 'Contenedor A', 4),
(23, 2024, 'AQW-14-LP', '20 Toneladas', 'Trailer', '15-GH-XD', 'Contenedor C', 8),
(24, 2023, 'XPY-159', '20 Toneladas', 'Trailer', 'YHT14X', 'Contenedor A', 9);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id_Usuario` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(200) NOT NULL,
  `Apellido_Paterno` varchar(200) NOT NULL,
  `Apellido_Materno` varchar(200) DEFAULT NULL,
  `Telefono` varchar(200) DEFAULT NULL,
  `Direccion` varchar(200) DEFAULT NULL,
  `CURP` varchar(200) NOT NULL,
  `Licencia_de_conducir` varchar(200) DEFAULT NULL,
  `Rol_id` int(11) NOT NULL,
  PRIMARY KEY (`id_Usuario`),
  UNIQUE KEY `CURP` (`CURP`),
  KEY `Rol_id` (`Rol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `usuarios`:
--   `Rol_id`
--       `roles` -> `id_Rol`
--

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_Usuario`, `Nombre`, `Apellido_Paterno`, `Apellido_Materno`, `Telefono`, `Direccion`, `CURP`, `Licencia_de_conducir`, `Rol_id`) VALUES
(1, 'Juan', 'Pérez', 'Gómez', '555-123-4567', '123 Calle Principal', 'ABC123XYZ456', 'LIC-12345', 1),
(2, 'José', 'Hernan', 'Garcia', '555-562-3214', '123 Calle Principal', '123XYZ456ABC', 'LIC-54321', 2),
(3, 'Pedrito', 'Villa', 'De carbon', '555-548-4789', '123 Calle Elm', '123HJK456ZDC', 'LIC-9546', 1),
(4, 'Danny', 'Baez', 'Martinez', '555-369-6524', '123 Plaza sesamo', '255HJK456MNB', 'LIC-456', 3),
(5, 'Alfonso', 'Carranza', 'Lopez', '5548963215', 'Street #16', 'LCOA198515HDFRC25', '156CHF', 1),
(6, 'Paty', 'Moreno', 'Florecita', '552136547895', 'Paris #13 Melchor', 'MFPAA152498MDFCRFAD', 'LIND2541', 3),
(7, 'Jazmin', 'Serrano', 'Soris', '568794562135', 'Av coacalco, Edo mex', 'SSJA196547MDFRCCND', 'MJNK24C', 3),
(8, 'Roberto', 'Hernandez', 'Robles', '5465897416', 'TEPOZOTLAN, EDO MEX, CUAUTITLAN IZCALLI', 'RHRHHSGHD25CR', 'LIND2541', 1);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `acceso`
--
ALTER TABLE `acceso`
  ADD CONSTRAINT `acceso_ibfk_1` FOREIGN KEY (`id_Operador_Interno`) REFERENCES `operador_interno` (`id_Operador_Interno`),
  ADD CONSTRAINT `acceso_ibfk_2` FOREIGN KEY (`id_Operador_Externo`) REFERENCES `operador_externo` (`id_Operador_Externo`);

--
-- Filtros para la tabla `cita`
--
ALTER TABLE `cita`
  ADD CONSTRAINT `cita_ibfk_1` FOREIGN KEY (`id_Operador_Interno`) REFERENCES `operador_interno` (`id_Operador_Interno`),
  ADD CONSTRAINT `cita_ibfk_2` FOREIGN KEY (`id_RutaCitas`) REFERENCES `ruta` (`id_Rutas`),
  ADD CONSTRAINT `cita_ibfk_3` FOREIGN KEY (`id_TransporteCitas`) REFERENCES `transportes` (`id_Transportes`);

--
-- Filtros para la tabla `citas`
--
ALTER TABLE `citas`
  ADD CONSTRAINT `citas_ibfk_1` FOREIGN KEY (`id_Operador_interno`) REFERENCES `operador_interno` (`id_Operador_Interno`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `citasdestiempo`
--
ALTER TABLE `citasdestiempo`
  ADD CONSTRAINT `citasdestiempo_ibfk_1` FOREIGN KEY (`id_Cita`) REFERENCES `cita` (`id_Cita`);

--
-- Filtros para la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD CONSTRAINT `comentarios_ibfk_1` FOREIGN KEY (`id_Cita`) REFERENCES `cita` (`id_Cita`);

--
-- Filtros para la tabla `credenciales`
--
ALTER TABLE `credenciales`
  ADD CONSTRAINT `credenciales_ibfk_1` FOREIGN KEY (`Usuario_id`) REFERENCES `usuarios` (`id_Usuario`);

--
-- Filtros para la tabla `documentos`
--
ALTER TABLE `documentos`
  ADD CONSTRAINT `documentos_ibfk_1` FOREIGN KEY (`id_Operador_Interno`) REFERENCES `operador_interno` (`id_Operador_Interno`),
  ADD CONSTRAINT `documentos_ibfk_2` FOREIGN KEY (`id_Operador_Externo`) REFERENCES `operador_externo` (`id_Operador_Externo`);

--
-- Filtros para la tabla `entrada`
--
ALTER TABLE `entrada`
  ADD CONSTRAINT `entrada_ibfk_1` FOREIGN KEY (`id_Operador_Interno`) REFERENCES `operador_interno` (`id_Operador_Interno`),
  ADD CONSTRAINT `entrada_ibfk_2` FOREIGN KEY (`id_Operador_Externo`) REFERENCES `operador_externo` (`id_Operador_Externo`);

--
-- Filtros para la tabla `ganancias`
--
ALTER TABLE `ganancias`
  ADD CONSTRAINT `ganancias_ibfk_1` FOREIGN KEY (`id_Viaje`) REFERENCES `tipo_viaje` (`id_Tipo_Viaje`);

--
-- Filtros para la tabla `operador_externo`
--
ALTER TABLE `operador_externo`
  ADD CONSTRAINT `operador_externo_ibfk_1` FOREIGN KEY (`Usuario_id`) REFERENCES `usuarios` (`id_Usuario`);

--
-- Filtros para la tabla `operador_interno`
--
ALTER TABLE `operador_interno`
  ADD CONSTRAINT `operador_interno_ibfk_1` FOREIGN KEY (`Usuario_id`) REFERENCES `usuarios` (`id_Usuario`),
  ADD CONSTRAINT `operador_interno_ibfk_2` FOREIGN KEY (`Proveedor_id`) REFERENCES `proveedores` (`ID_Proveedor`);

--
-- Filtros para la tabla `qr_cita`
--
ALTER TABLE `qr_cita`
  ADD CONSTRAINT `qr_cita_ibfk_1` FOREIGN KEY (`id_Cita`) REFERENCES `cita` (`id_Cita`);

--
-- Filtros para la tabla `reportes`
--
ALTER TABLE `reportes`
  ADD CONSTRAINT `reportes_ibfk_1` FOREIGN KEY (`Proveedor_id`) REFERENCES `proveedores` (`ID_Proveedor`),
  ADD CONSTRAINT `reportes_ibfk_2` FOREIGN KEY (`id_Ganancias`) REFERENCES `ganancias` (`id_Ganancias`),
  ADD CONSTRAINT `reportes_ibfk_3` FOREIGN KEY (`id_Viaje`) REFERENCES `tipo_viaje` (`id_Tipo_Viaje`);

--
-- Filtros para la tabla `rol_permiso`
--
ALTER TABLE `rol_permiso`
  ADD CONSTRAINT `rol_permiso_ibfk_1` FOREIGN KEY (`id_Rol`) REFERENCES `roles` (`id_Rol`),
  ADD CONSTRAINT `rol_permiso_ibfk_2` FOREIGN KEY (`id_Permiso`) REFERENCES `permisos` (`id_Permiso`);

--
-- Filtros para la tabla `salida`
--
ALTER TABLE `salida`
  ADD CONSTRAINT `salida_ibfk_1` FOREIGN KEY (`id_Operador_Interno`) REFERENCES `operador_interno` (`id_Operador_Interno`),
  ADD CONSTRAINT `salida_ibfk_2` FOREIGN KEY (`id_Operador_Externo`) REFERENCES `operador_externo` (`id_Operador_Externo`);

--
-- Filtros para la tabla `statusviaje`
--
ALTER TABLE `statusviaje`
  ADD CONSTRAINT `statusviaje_ibfk_1` FOREIGN KEY (`id_Tipo_Viaje`) REFERENCES `tipo_viaje` (`id_Tipo_Viaje`),
  ADD CONSTRAINT `statusviaje_ibfk_2` FOREIGN KEY (`id_Status`) REFERENCES `status` (`id_Status`);

--
-- Filtros para la tabla `tipoproducto`
--
ALTER TABLE `tipoproducto`
  ADD CONSTRAINT `tipoproducto_ibfk_1` FOREIGN KEY (`Proveedor_id`) REFERENCES `proveedores` (`ID_Proveedor`);

--
-- Filtros para la tabla `tipo_viaje`
--
ALTER TABLE `tipo_viaje`
  ADD CONSTRAINT `tipo_viaje_ibfk_1` FOREIGN KEY (`id_StatusViaje`) REFERENCES `statusviaje` (`id_StatusViaje`),
  ADD CONSTRAINT `tipo_viaje_ibfk_3` FOREIGN KEY (`id_Ruta`) REFERENCES `rutas` (`id_Rutas`),
  ADD CONSTRAINT `tipo_viaje_ibfk_4` FOREIGN KEY (`id_Documentos`) REFERENCES `documentos` (`id_Documentos`),
  ADD CONSTRAINT `tipo_viaje_ibfk_5` FOREIGN KEY (`id_Gasto`) REFERENCES `gastos` (`id_Gastos`);

--
-- Filtros para la tabla `transportes`
--
ALTER TABLE `transportes`
  ADD CONSTRAINT `transportes_ibfk_1` FOREIGN KEY (`Proveedor_id`) REFERENCES `proveedores` (`ID_Proveedor`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`Rol_id`) REFERENCES `roles` (`id_Rol`);


--
-- Metadatos
--
USE `phpmyadmin`;

--
-- Metadatos para la tabla acceso
--

--
-- Metadatos para la tabla cita
--

--
-- Metadatos para la tabla citas
--

--
-- Metadatos para la tabla citasdestiempo
--

--
-- Metadatos para la tabla comentarios
--

--
-- Metadatos para la tabla credenciales
--

--
-- Metadatos para la tabla documentos
--

--
-- Metadatos para la tabla entrada
--

--
-- Metadatos para la tabla ganancias
--

--
-- Metadatos para la tabla gastos
--

--
-- Metadatos para la tabla operador_externo
--

--
-- Metadatos para la tabla operador_interno
--

--
-- Metadatos para la tabla permisos
--

--
-- Metadatos para la tabla proveedores
--

--
-- Metadatos para la tabla qr_cita
--

--
-- Metadatos para la tabla qr_citas
--

--
-- Metadatos para la tabla reportes
--

--
-- Metadatos para la tabla roles
--

--
-- Metadatos para la tabla rol_permiso
--

--
-- Metadatos para la tabla ruta
--

--
-- Metadatos para la tabla rutas
--

--
-- Metadatos para la tabla salida
--

--
-- Metadatos para la tabla status
--

--
-- Metadatos para la tabla statusviaje
--

--
-- Metadatos para la tabla tipoproducto
--

--
-- Metadatos para la tabla tipo_viaje
--

--
-- Metadatos para la tabla transportes
--

--
-- Metadatos para la tabla usuarios
--

--
-- Metadatos para la base de datos kayros
--
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
