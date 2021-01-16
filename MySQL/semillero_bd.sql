DROP TABLE IF EXISTS vehiculos;
DROP TABLE IF EXISTS tipo_linea;
DROP TABLE IF EXISTS tipo_marca;

CREATE TABLE vehiculos(
    nro_placa VARCHAR(6) PRIMARY KEY,
    id_linea INT(5) FOREIGN KEY,
    modelo,
    fecha_ven_seguro TIMESTAMP,
    fecha_ven_tecnomecanica TIMESTAMP,
    fecha_ven_contratodo TIMESTAMP
);

CREATE TABLE tipo_linea(
    id_linea INT(5) PRIMARY KEY AUTO_INCREMENT,
    desc_linea INT(5) NULL,
    id_marca FOREIGN KEY INT(10),
    activo ENUM('S','N')
);

CREATE TABLE tipo_marca(
    id_marca INT(5) PRIMARY KEY AUTO_INCREMENT,
    desc_marca INT(5) NULL,
    activo ENUM('S','N')
);