--GRANT ALL PRIVILEGES ON semillero.* TO 'santiago'@'localhost';

--CREATE DATABASE semillero;

USE semillero;

--INITIAL CLEAR TABLES
DROP TABLE IF EXISTS vehiculos;
DROP TABLE IF EXISTS modelo;
DROP TABLE IF EXISTS tipo_linea;
DROP TABLE IF EXISTS tipo_marca;

-- CREATION OF TABLES
CREATE TABLE modelo(
    id_modelo INT(5) UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    year_modelo INT(5) UNSIGNED NOT NULL,
    desc_modelo VARCHAR(255) COMMENT 'Descripción del modelo. Este campo puede recibir valores NULL debido a que no son estrictamente necesarios dentro del funcionamiento y análisis del SGBD. Las personas en este campo pondrían información adicional, es por esto que no es un campo obligatorio. En este caso con el year_modelo bastaría'
);

CREATE TABLE vehiculos(
    id_vehiculo INT(5) UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nro_placa VARCHAR(8) UNIQUE NOT NULL,
    id_linea INT(5) UNSIGNED NOT NULL,
    id_modelo INT(5) UNSIGNED NOT NULL,
    fecha_ven_seguro DATE NOT NULL,
    fecha_ven_tecnomecanica DATE NOT NULL,
    fecha_ven_contratodo DATE NOT NULL,
    FOREIGN KEY (id_modelo) REFERENCES modelo(id_modelo)
);

CREATE TABLE tipo_marca(
    id_marca INT(5) UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    desc_marca VARCHAR(255) NOT NULL COMMENT 'Descripción de la marca. Este campo podría recibir valores NULL si existiera otro canmpo como nombre_marca. Pero debido a que no se cuenta en el modelo con este canmpo, es estrictamente necesario dentro del funcionamiento y análisis del SGBD.',
    activo ENUM('S','N') NOT NULL    
);

CREATE TABLE tipo_linea(
    id_linea INT(5) UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    desc_linea VARCHAR(255) COMMENT 'Descripción de la línea. Este campo puede recibir valores NULL debido a que no son estrictamente necesarios dentro del funcionamiento y análisis del SGBD. Las personas en este campo pondrían información adicional, es por esto que no es un campo obligatorio',
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