-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 29-01-2025 a las 02:05:53
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `lottica`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `agudeza`
--

CREATE TABLE `agudeza` (
  `id` int(11) NOT NULL,
  `nombre` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='guarda los parámetros de la tabla agudeza visual ';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `agudeza_visual`
--

CREATE TABLE `agudeza_visual` (
  `id` int(11) NOT NULL,
  `id_paciente` int(11) NOT NULL,
  `id_agudeza` int(11) NOT NULL,
  `oi` varchar(255) NOT NULL,
  `od` varchar(255) NOT NULL,
  `deleted_at` int(11) DEFAULT NULL,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ahf`
--

CREATE TABLE `ahf` (
  `id` int(11) NOT NULL,
  `id_paciente` int(11) NOT NULL,
  `hipertencion` varchar(255) NOT NULL,
  `diabetes` varchar(255) NOT NULL,
  `glaucoma` varchar(255) NOT NULL,
  `catarata` varchar(255) NOT NULL,
  `queratocono` varchar(255) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `anexos_oculares`
--

CREATE TABLE `anexos_oculares` (
  `id` int(11) NOT NULL,
  `id_paciente` int(11) NOT NULL,
  `id_revision` int(11) NOT NULL COMMENT 'parte del ojo revisado',
  `od` varchar(255) NOT NULL,
  `oi` varchar(255) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `autorrefractometria`
--

CREATE TABLE `autorrefractometria` (
  `id` int(11) NOT NULL,
  `id_paciente` int(11) NOT NULL,
  `id_tipo` int(11) NOT NULL,
  `oi` varchar(255) NOT NULL,
  `od` varchar(255) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `determinacion_adicion`
--

CREATE TABLE `determinacion_adicion` (
  `id` int(11) NOT NULL,
  `id_paciente` int(11) NOT NULL,
  `edad` varchar(255) NOT NULL,
  `ocupacion` varchar(255) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `diagnostico`
--

CREATE TABLE `diagnostico` (
  `id` int(11) NOT NULL,
  `id_paciente` int(11) NOT NULL,
  `oi` varchar(255) NOT NULL,
  `od` varchar(255) NOT NULL,
  `correccion` varchar(255) NOT NULL,
  `observaciones` varchar(255) NOT NULL,
  `optimetrista` varchar(255) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dip`
--

CREATE TABLE `dip` (
  `id` int(11) NOT NULL,
  `id_paciente` int(11) NOT NULL,
  `lejana` varchar(255) NOT NULL,
  `cercana` varchar(255) NOT NULL,
  `dnp` varchar(255) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `graduacion`
--

CREATE TABLE `graduacion` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `graduacion_anterior`
--

CREATE TABLE `graduacion_anterior` (
  `id` int(11) NOT NULL,
  `id_paciente` int(11) NOT NULL,
  `id_graduacion` int(11) NOT NULL,
  `od` varchar(255) NOT NULL,
  `oi` varchar(255) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `graduacion_final`
--

CREATE TABLE `graduacion_final` (
  `id` int(11) NOT NULL,
  `id_paciente` int(11) NOT NULL,
  `id_tipo` int(11) NOT NULL,
  `oi` varchar(255) NOT NULL,
  `od` varchar(255) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_optico`
--

CREATE TABLE `historial_optico` (
  `id` int(11) NOT NULL,
  `id_paciente` int(11) NOT NULL,
  `ultimo_examen_vista` varchar(255) NOT NULL,
  `tiempo_ultima_graduacion` varchar(255) NOT NULL,
  `vista_actual` varchar(255) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pacientes`
--

CREATE TABLE `pacientes` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `telefono` varchar(11) NOT NULL,
  `correo` varchar(255) NOT NULL,
  `ocupacion` varchar(255) NOT NULL,
  `pasatiempo` varchar(255) NOT NULL,
  `id_revisor` int(11) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pruebas`
--

CREATE TABLE `pruebas` (
  `id` int(11) NOT NULL,
  `id_paciente` int(11) NOT NULL,
  `ambulatoria` varchar(255) NOT NULL,
  `bicromatica` varchar(255) NOT NULL,
  `cilindro_cruzado` varchar(255) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recuperacion_ocular`
--

CREATE TABLE `recuperacion_ocular` (
  `id` int(11) NOT NULL,
  `id_paciente` int(11) NOT NULL,
  `id_sintoma` int(11) NOT NULL,
  `tiempo_evolucion` varchar(255) NOT NULL,
  `tratamiento` varchar(255) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reloj_astigmatico`
--

CREATE TABLE `reloj_astigmatico` (
  `id` int(11) NOT NULL,
  `id_paciente` int(11) NOT NULL,
  `id_tipo` int(11) NOT NULL,
  `oi` varchar(255) NOT NULL,
  `od` varchar(255) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `retinoscopia`
--

CREATE TABLE `retinoscopia` (
  `id` int(11) NOT NULL,
  `id_paciente` int(11) NOT NULL,
  `id_tipo` int(11) NOT NULL,
  `oi` varchar(255) NOT NULL,
  `od` varchar(255) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `revision`
--

CREATE TABLE `revision` (
  `id` int(11) NOT NULL,
  `nombre` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='guardara las partes del ojo a revisar';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rols`
--

CREATE TABLE `rols` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `rols`
--

INSERT INTO `rols` (`id`, `nombre`) VALUES
(5, 'SU'),
(7, 'Revisor');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sintomas`
--

CREATE TABLE `sintomas` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tiempo`
--

CREATE TABLE `tiempo` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tiempo`
--

INSERT INTO `tiempo` (`id`, `descripcion`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Nunca', '2024-05-20 19:46:35', '2024-05-20 19:46:35', NULL),
(2, '2 semanas', '2024-05-20 19:46:35', '2024-05-20 19:46:35', NULL),
(3, '1 mes', '2024-05-20 19:46:35', '2024-05-20 19:46:35', NULL),
(4, '2 meses', '2024-05-20 19:46:35', '2024-05-20 19:46:35', NULL),
(5, '3 meses', '2024-05-20 19:46:35', '2024-05-20 19:46:35', NULL),
(6, '4 meses', '2024-05-20 19:46:35', '2024-05-20 19:46:35', NULL),
(7, '5 meses', '2024-05-20 19:46:35', '2024-05-20 19:46:35', NULL),
(8, '6 meses', '2024-05-20 19:46:35', '2024-05-20 19:46:35', NULL),
(9, '1 año', '2024-05-20 19:46:35', '2024-05-20 19:46:35', NULL),
(10, '1 año y medio', '2024-05-20 19:46:35', '2024-05-20 19:46:35', NULL),
(11, '2 años', '2024-05-20 19:46:35', '2024-05-20 19:46:35', NULL),
(12, '2 años y medio', '2024-05-20 19:46:35', '2024-05-20 19:46:35', NULL),
(13, '3 años', '2024-05-20 19:46:35', '2024-05-20 19:46:35', NULL),
(14, '3 años y medio', '2024-05-20 19:46:35', '2024-05-20 19:46:35', NULL),
(15, '4 años', '2024-05-20 19:46:35', '2024-05-20 19:46:35', NULL),
(16, '5 años', '2024-05-20 19:46:35', '2024-05-20 19:46:35', NULL),
(17, '6 años', '2024-05-20 19:46:35', '2024-05-20 19:46:35', NULL),
(18, '7 años', '2024-05-20 19:46:35', '2024-05-20 19:46:35', NULL),
(19, '8 años', '2024-05-20 19:46:35', '2024-05-20 19:46:35', NULL),
(20, '9 años', '2024-05-20 19:46:35', '2024-05-20 19:46:35', NULL),
(21, '10 años', '2024-05-20 19:46:35', '2024-05-20 19:46:35', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_graduacion`
--

CREATE TABLE `tipo_graduacion` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `telefono` varchar(11) NOT NULL,
  `correo` varchar(255) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `id_rol`, `nombre`, `telefono`, `correo`, `contrasena`, `deleted_at`, `created_at`, `updated_at`) VALUES
(2, 5, 'willian', '7441511450', 'delacruz@gmail.com', 'sda', NULL, NULL, NULL),
(5, 7, 'diosce', '1234567890', 'diosce@gmail.com', '8cb2237d0679ca88db6464eac60da96345513964', NULL, '2023-12-16 05:07:06', '2023-12-16 05:07:06'),
(8, 7, 'diosce', '1234567890', 'diosce@gmail.co', '8cb2237d0679ca88db6464eac60da96345513964', NULL, '2024-03-04 23:04:13', '2024-03-04 23:04:13');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `agudeza`
--
ALTER TABLE `agudeza`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `agudeza_visual`
--
ALTER TABLE `agudeza_visual`
  ADD PRIMARY KEY (`id`),
  ADD KEY `agudeza_paciente` (`id_paciente`),
  ADD KEY `agudeza_fk` (`id_agudeza`);

--
-- Indices de la tabla `ahf`
--
ALTER TABLE `ahf`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ahf_fk` (`id_paciente`);

--
-- Indices de la tabla `anexos_oculares`
--
ALTER TABLE `anexos_oculares`
  ADD PRIMARY KEY (`id`),
  ADD KEY `revision_fk` (`id_revision`),
  ADD KEY `revision_paciente_fk` (`id_paciente`);

--
-- Indices de la tabla `autorrefractometria`
--
ALTER TABLE `autorrefractometria`
  ADD PRIMARY KEY (`id`),
  ADD KEY `autorre_paciente` (`id_paciente`),
  ADD KEY `autorre_fk` (`id_tipo`);

--
-- Indices de la tabla `determinacion_adicion`
--
ALTER TABLE `determinacion_adicion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `adicion_fk` (`id_paciente`);

--
-- Indices de la tabla `diagnostico`
--
ALTER TABLE `diagnostico`
  ADD PRIMARY KEY (`id`),
  ADD KEY `diagnostico` (`id_paciente`);

--
-- Indices de la tabla `dip`
--
ALTER TABLE `dip`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dip_fk` (`id_paciente`);

--
-- Indices de la tabla `graduacion`
--
ALTER TABLE `graduacion`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `graduacion_anterior`
--
ALTER TABLE `graduacion_anterior`
  ADD PRIMARY KEY (`id`),
  ADD KEY `graduacion` (`id_graduacion`),
  ADD KEY `graduacion_paciente` (`id_paciente`);

--
-- Indices de la tabla `graduacion_final`
--
ALTER TABLE `graduacion_final`
  ADD PRIMARY KEY (`id`),
  ADD KEY `graduacion_pacientes_fk` (`id_paciente`),
  ADD KEY `graduacion_tipo` (`id_tipo`);

--
-- Indices de la tabla `historial_optico`
--
ALTER TABLE `historial_optico`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_paciente` (`id_paciente`);

--
-- Indices de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_revisor` (`id_revisor`);

--
-- Indices de la tabla `pruebas`
--
ALTER TABLE `pruebas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `preubas_fk` (`id_paciente`);

--
-- Indices de la tabla `recuperacion_ocular`
--
ALTER TABLE `recuperacion_ocular`
  ADD PRIMARY KEY (`id`),
  ADD KEY `recuperacion_fk` (`id_paciente`),
  ADD KEY `sintoma_fk` (`id_sintoma`);

--
-- Indices de la tabla `reloj_astigmatico`
--
ALTER TABLE `reloj_astigmatico`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reloj_paciente` (`id_paciente`),
  ADD KEY `reloj_fk` (`id_tipo`);

--
-- Indices de la tabla `retinoscopia`
--
ALTER TABLE `retinoscopia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `retinoscopia_paciente` (`id_paciente`),
  ADD KEY `retinoscopia_fk` (`id_tipo`);

--
-- Indices de la tabla `revision`
--
ALTER TABLE `revision`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `rols`
--
ALTER TABLE `rols`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `sintomas`
--
ALTER TABLE `sintomas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tiempo`
--
ALTER TABLE `tiempo`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipo_graduacion`
--
ALTER TABLE `tipo_graduacion`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_rol` (`id_rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `agudeza`
--
ALTER TABLE `agudeza`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `agudeza_visual`
--
ALTER TABLE `agudeza_visual`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ahf`
--
ALTER TABLE `ahf`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `anexos_oculares`
--
ALTER TABLE `anexos_oculares`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `autorrefractometria`
--
ALTER TABLE `autorrefractometria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `determinacion_adicion`
--
ALTER TABLE `determinacion_adicion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `diagnostico`
--
ALTER TABLE `diagnostico`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `dip`
--
ALTER TABLE `dip`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `graduacion`
--
ALTER TABLE `graduacion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `graduacion_anterior`
--
ALTER TABLE `graduacion_anterior`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `graduacion_final`
--
ALTER TABLE `graduacion_final`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `historial_optico`
--
ALTER TABLE `historial_optico`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pruebas`
--
ALTER TABLE `pruebas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `recuperacion_ocular`
--
ALTER TABLE `recuperacion_ocular`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `reloj_astigmatico`
--
ALTER TABLE `reloj_astigmatico`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `retinoscopia`
--
ALTER TABLE `retinoscopia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `revision`
--
ALTER TABLE `revision`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `rols`
--
ALTER TABLE `rols`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `sintomas`
--
ALTER TABLE `sintomas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tiempo`
--
ALTER TABLE `tiempo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT de la tabla `tipo_graduacion`
--
ALTER TABLE `tipo_graduacion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `agudeza_visual`
--
ALTER TABLE `agudeza_visual`
  ADD CONSTRAINT `agudeza_fk` FOREIGN KEY (`id_agudeza`) REFERENCES `agudeza` (`id`),
  ADD CONSTRAINT `agudeza_paciente` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `ahf`
--
ALTER TABLE `ahf`
  ADD CONSTRAINT `ahf_fk` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `anexos_oculares`
--
ALTER TABLE `anexos_oculares`
  ADD CONSTRAINT `revision_fk` FOREIGN KEY (`id_revision`) REFERENCES `revision` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `revision_paciente_fk` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `autorrefractometria`
--
ALTER TABLE `autorrefractometria`
  ADD CONSTRAINT `autorre_fk` FOREIGN KEY (`id_tipo`) REFERENCES `tipo_graduacion` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `autorre_paciente` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `determinacion_adicion`
--
ALTER TABLE `determinacion_adicion`
  ADD CONSTRAINT `adicion_fk` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `diagnostico`
--
ALTER TABLE `diagnostico`
  ADD CONSTRAINT `diagnostico` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `dip`
--
ALTER TABLE `dip`
  ADD CONSTRAINT `dip_fk` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `graduacion_anterior`
--
ALTER TABLE `graduacion_anterior`
  ADD CONSTRAINT `graduacion` FOREIGN KEY (`id_graduacion`) REFERENCES `graduacion` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `graduacion_paciente` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `graduacion_final`
--
ALTER TABLE `graduacion_final`
  ADD CONSTRAINT `graduacion_pacientes_fk` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `graduacion_tipo` FOREIGN KEY (`id_tipo`) REFERENCES `tipo_graduacion` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `historial_optico`
--
ALTER TABLE `historial_optico`
  ADD CONSTRAINT `historia_fk` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `pacientes`
--
ALTER TABLE `pacientes`
  ADD CONSTRAINT `pacientes_fk` FOREIGN KEY (`id_revisor`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `pruebas`
--
ALTER TABLE `pruebas`
  ADD CONSTRAINT `preubas_fk` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id`);

--
-- Filtros para la tabla `recuperacion_ocular`
--
ALTER TABLE `recuperacion_ocular`
  ADD CONSTRAINT `recuperacion_fk` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `sintoma_fk` FOREIGN KEY (`id_sintoma`) REFERENCES `sintomas` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `reloj_astigmatico`
--
ALTER TABLE `reloj_astigmatico`
  ADD CONSTRAINT `reloj_fk` FOREIGN KEY (`id_tipo`) REFERENCES `tipo_graduacion` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `reloj_paciente` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `retinoscopia`
--
ALTER TABLE `retinoscopia`
  ADD CONSTRAINT `retinoscopia_fk` FOREIGN KEY (`id_tipo`) REFERENCES `tipo_graduacion` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `retinoscopia_paciente` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `rol_fk` FOREIGN KEY (`id_rol`) REFERENCES `rols` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
