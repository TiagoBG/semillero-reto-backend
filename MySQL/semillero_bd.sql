-- GRANT ALL PRIVILEGES ON semillero.* TO 'santiago'@'localhost';

-- CREATE DATABASE semillero;

USE semillero;

-- INITIAL CLEAR TABLES
DROP TABLE IF EXISTS vehiculos;
DROP TABLE IF EXISTS modelo;
DROP TABLE IF EXISTS tipo_linea;
DROP TABLE IF EXISTS tipo_marca;

-- CREATION OF TABLES
CREATE TABLE modelo(
    id_modelo INT(5) UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    year_modelo INT(5) UNSIGNED UNIQUE NOT NULL,
    desc_modelo VARCHAR(255) COMMENT 'Descripción del modelo. Este campo puede recibir valores NULL debido a que en algunos casos los vehiculos no tienen modelo en especifico y simplemente adopta el nombre de la línea'
);

CREATE TABLE vehiculos(
    id_vehiculo INT(5) UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nro_placa VARCHAR(8) UNIQUE NOT NULL,
    id_linea INT(5) UNSIGNED NOT NULL,
    id_modelo INT(5) UNSIGNED NOT NULL,
    fecha_ven_seguro DATETIME NOT NULL,
    fecha_ven_tecnomecanica DATETIME NOT NULL,
    fecha_ven_contratodo DATETIME NOT NULL
);

CREATE TABLE tipo_marca(
    id_marca INT(5) UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    desc_marca VARCHAR(255) NOT NULL COMMENT 'Descripción de la marca. Este campo podría recibir valores NULL si existiera otro canmpo como nombre_marca. Pero debido a que no se cuenta en el modelo con este canmpo, es estrictamente necesario dentro del funcionamiento y análisis del SGBD.',
    activo ENUM('S','N') NOT NULL    
);

CREATE TABLE tipo_linea(
    id_linea INT(5) UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    desc_linea VARCHAR(255) UNIQUE NOT NULL COMMENT 'Descripción de la línea. Este campo NO puede recibir valores NULL debido a que en algunos casos los vehiculos no tienen modelo en especifico y simplemente adopta el nombre de la línea',
    id_marca INT(10) UNSIGNED NOT NULL,
    activo ENUM('S','N') NOT NULL
);

-- DEFINING FOREIGN KEYS EXTERNALLY

ALTER TABLE tipo_linea
ADD CONSTRAINT `fk_id_marca`
FOREIGN KEY (`id_marca`)
REFERENCES `tipo_marca`(`id_marca`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

ALTER TABLE vehiculos
ADD CONSTRAINT `fk_id_linea`
FOREIGN KEY (`id_linea`)
REFERENCES `tipo_linea`(`id_linea`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

ALTER TABLE vehiculos
ADD CONSTRAINT `fk_id_modelo` 
FOREIGN KEY (`id_modelo`) 
REFERENCES `modelo`(`id_modelo`) 
    ON DELETE RESTRICT 
    ON UPDATE CASCADE;

-- INSERT FIELDS ON MODELO
INSERT INTO `modelo` VALUES (1, 2012, '500C');
INSERT INTO `modelo` VALUES (2, 2019, NULL);
INSERT INTO `modelo` VALUES (3, 2015, 'CS34');
INSERT INTO `modelo` VALUES (4, 2017, 'LX60');
INSERT INTO `modelo` VALUES (5, 2005, NULL);
INSERT INTO `modelo` VALUES (6, 2004, 'L');
INSERT INTO `modelo` VALUES (7, 2009, 'SANDERO');
INSERT INTO `modelo` VALUES (8, 2016, NULL);

-- INSERT FIELDS ON TIPO_MARCA
INSERT INTO `tipo_marca` VALUES (1, 'MAZDA', 'S');
INSERT INTO `tipo_marca` VALUES (2, 'LEXUS', 'S');
INSERT INTO `tipo_marca` VALUES (3, 'CHEVROLET', 'S');
INSERT INTO `tipo_marca` VALUES (4, 'PONTIAC', 'N');
INSERT INTO `tipo_marca` VALUES (5, 'DAEWOO', 'N');
INSERT INTO `tipo_marca` VALUES (6, 'TOYOTA', 'S');
INSERT INTO `tipo_marca` VALUES (7, 'HUMMER', 'N');
INSERT INTO `tipo_marca` VALUES (8, 'RENAULT', 'S');

-- INSERT FIELDS ON TIPO_LINEA
INSERT INTO `tipo_linea` VALUES (1, 'AVEO', 3, 'S');
INSERT INTO `tipo_linea` VALUES (2, 'CLIO', 8, 'N');
INSERT INTO `tipo_linea` VALUES (3, 'MAZDA3', 1, 'N');
INSERT INTO `tipo_linea` VALUES (4, 'GS', 2, 'S');
INSERT INTO `tipo_linea` VALUES (5, 'SPARK', 3, 'S');
INSERT INTO `tipo_linea` VALUES (6, 'TWINGO', 8, 'N');
INSERT INTO `tipo_linea` VALUES (7, 'SEDAN', 1, 'N');
INSERT INTO `tipo_linea` VALUES (8, 'IS', 2, 'S');
INSERT INTO `tipo_linea` VALUES (9, 'MAZDA2', 1, 'N');
INSERT INTO `tipo_linea` VALUES (10, 'LS', 2, 'S');
INSERT INTO `tipo_linea` VALUES (11, 'CRUZE', 3, 'S');
INSERT INTO `tipo_linea` VALUES (12, 'LOGAN', 8, 'N');
INSERT INTO `tipo_linea` VALUES (13, 'CXS', 1, 'N');
INSERT INTO `tipo_linea` VALUES (14, 'NX', 2, 'S');
INSERT INTO `tipo_linea` VALUES (15, 'CAMARO', 3, 'S');
INSERT INTO `tipo_linea` VALUES (16, 'KOLEOS', 8, 'N');
INSERT INTO `tipo_linea` VALUES (17, 'AURIS', 6, 'N');
INSERT INTO `tipo_linea` VALUES (18, 'PRIUS', 6, 'S');
INSERT INTO `tipo_linea` VALUES (19, 'MAZDA6', 1, 'N');
INSERT INTO `tipo_linea` VALUES (20, 'LAND CRUISER', 6, 'S');

-- INSERT FIELDS ON VEHICULOS
INSERT INTO `vehiculos` VALUES (1, 'FJQ770', 1, 1, '2021-10-09 00:31:57', '2021-05-15 00:31:57', '2021-06-24 00:31:57');
INSERT INTO `vehiculos` VALUES (2, 'ENW147', 1, 2, '2021-10-09 01:12:23', '2021-09-15 01:12:23', '2021-07-24 01:12:23');
INSERT INTO `vehiculos` VALUES (3, 'CNC330', 4, 3, '2021-11-09 01:12:11', '2021-05-15 01:12:11', '2021-07-24 01:12:11');
INSERT INTO `vehiculos` VALUES (4, 'IIT859', 2, 4, '2021-08-09 01:15:56', '2021-06-15 01:15:56', '2021-05-24 01:15:56');
INSERT INTO `vehiculos` VALUES (5, 'MCM864', 3, 7, '2021-10-13 01:15:56', '2021-07-15 01:15:56', '2021-12-24 01:15:56');
INSERT INTO `vehiculos` VALUES (6, 'KLU374', 4, 8, '2021-03-09 02:49:07', '2021-08-15 02:49:07', '2021-07-24 02:49:07');
INSERT INTO `vehiculos` VALUES (7, 'CQM770', 1, 1, '2021-10-09 00:31:57', '2021-10-15 00:31:57', '2021-05-24 00:31:57');
INSERT INTO `vehiculos` VALUES (8, 'MAT147', 1, 2, '2021-12-09 01:12:23', '2021-09-15 01:12:23', '2021-05-24 01:12:23');
INSERT INTO `vehiculos` VALUES (9, 'AYK330', 4, 3, '2021-10-09 01:12:11', '2021-05-15 01:12:11', '2021-07-24 01:12:11');
INSERT INTO `vehiculos` VALUES (10, 'MNO859', 2, 4, '2021-10-09 01:15:56', '2021-05-15 01:15:56', '2021-07-24 01:15:56');
INSERT INTO `vehiculos` VALUES (11, 'NVG864', 3, 7, '2021-10-09 01:15:56', '2021-07-15 01:15:56', '2021-07-24 01:15:56');
INSERT INTO `vehiculos` VALUES (12, 'KTM374', 4, 8, '2021-10-09 02:49:07', '2021-07-15 02:49:07', '2021-06-24 02:49:07');
INSERT INTO `vehiculos` VALUES (13, 'HDO859', 2, 4, '2021-12-09 01:15:56', '2021-08-15 01:15:56', '2021-07-24 01:15:56');
INSERT INTO `vehiculos` VALUES (14, 'EQS864', 3, 7, '2021-11-09 01:15:56', '2021-09-15 01:15:56', '2021-08-24 01:15:56');
INSERT INTO `vehiculos` VALUES (15, 'XBW374', 4, 8, '2021-10-09 02:49:07', '2021-04-15 02:49:07', '2021-07-24 02:49:07');
INSERT INTO `vehiculos` VALUES (16, 'MCL770', 1, 1, '2021-10-09 00:31:57', '2021-04-15 00:31:57', '2021-08-24 00:31:57');
INSERT INTO `vehiculos` VALUES (17, 'UNO147', 1, 2, '2021-10-09 01:12:23', '2021-06-15 01:12:23', '2021-07-24 01:12:23');
INSERT INTO `vehiculos` VALUES (18, 'FQG330', 4, 3, '2021-12-09 01:12:11', '2021-05-15 01:12:11', '2021-11-24 01:12:11');
INSERT INTO `vehiculos` VALUES (19, 'IIT939', 2, 4, '2021-10-09 01:15:56', '2021-06-15 01:15:56', '2021-07-24 01:15:56');
INSERT INTO `vehiculos` VALUES (20, 'MCM915', 3, 7, '2021-10-10 01:15:56', '2021-04-15 01:15:56', '2021-11-24 01:15:56');
INSERT INTO `vehiculos` VALUES (21, 'KLU299', 4, 8, '2021-10-09 02:49:07', '2021-04-15 02:49:07', '2021-07-24 02:49:07');
INSERT INTO `vehiculos` VALUES (22, 'FJQ575', 1, 1, '2021-11-09 00:31:57', '2021-10-15 00:31:57', '2021-10-24 00:31:57');
INSERT INTO `vehiculos` VALUES (23, 'ENW569', 1, 2, '2021-10-13 01:12:23', '2021-11-15 01:12:23', '2021-11-24 01:12:23');
INSERT INTO `vehiculos` VALUES (24, 'CNC439', 4, 3, '2021-10-09 01:12:11', '2021-05-15 01:12:11', '2021-07-24 01:12:11');
INSERT INTO `vehiculos` VALUES (25, 'IIT658', 2, 4, '2021-11-09 01:15:56', '2021-05-15 01:15:56', '2021-11-24 01:15:56');
INSERT INTO `vehiculos` VALUES (26, 'MCM253', 3, 7, '2021-10-03 01:15:56', '2021-12-15 01:15:56', '2021-06-24 01:15:56');
INSERT INTO `vehiculos` VALUES (27, 'KLU548', 4, 8, '2021-10-13 02:49:07', '2021-11-15 02:49:07', '2021-06-24 02:49:07');
INSERT INTO `vehiculos` VALUES (28, 'IIT169', 2, 4, '2021-10-09 01:15:56', '2021-11-15 01:15:56', '2021-08-24 01:15:56');
INSERT INTO `vehiculos` VALUES (29, 'MCM390', 3, 7, '2021-10-03 01:15:56', '2021-05-15 01:15:56', '2021-07-24 01:15:56');
INSERT INTO `vehiculos` VALUES (30, 'KLU276', 4, 8, '2021-09-09 02:49:07', '2021-05-15 02:49:07', '2021-07-24 02:49:07');