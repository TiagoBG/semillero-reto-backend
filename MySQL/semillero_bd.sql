--GRANT ALL PRIVILEGES ON semillero.* TO 'santiago'@'localhost';

--CREATE DATABASE semillero;

USE semillero;

-- CREATION OF TABLES
DROP TABLE IF EXISTS vehiculos;
DROP TABLE IF EXISTS tipo_linea;
DROP TABLE IF EXISTS tipo_marca;
DROP TABLE IF EXISTS modelo;

CREATE TABLE vehiculos(
    id_vehiculo INT(5) PRIMARY KEY AUTO_INCREMENT,
    nro_placa VARCHAR(8) NOT NULL,
    id_linea INT(5) NOT NULL,
    id_modelo INT(5) NOT NULL,
    fecha_ven_seguro DATE NOT NULL,
    fecha_ven_tecnomecanica DATE NOT NULL,
    fecha_ven_contratodo DATE NOT NULL
);

CREATE TABLE tipo_linea(
    id_linea INT(5) PRIMARY KEY AUTO_INCREMENT,
    desc_linea VARCHAR(255) COMMENT 'Descripción de la línea',
    id_marca INT(10) NOT NULL,
    activo ENUM('S','N') NOT NULL
);

CREATE TABLE tipo_marca(
    id_marca INT(5) PRIMARY KEY AUTO_INCREMENT,
    desc_marca VARCHAR(255) COMMENT 'Descripción de la marca',
    activo ENUM('S','N') NOT NULL
);

CREATE TABLE modelo(
    id_modelo INT(5) PRIMARY KEY AUTO_INCREMENT,
    year_modelo INT(5) NOT NULL,
    desc_modelo VARCHAR(255) COMMENT 'Descripción del modelo'
);