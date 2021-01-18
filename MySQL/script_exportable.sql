-- MariaDB dump 10.18  Distrib 10.4.17-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: semillero
-- ------------------------------------------------------
-- Server version	10.4.17-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `modelo`
--

DROP TABLE IF EXISTS `modelo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modelo` (
  `id_modelo` int(5) unsigned NOT NULL AUTO_INCREMENT,
  `year_modelo` int(5) unsigned NOT NULL,
  `desc_modelo` varchar(255) DEFAULT NULL COMMENT 'Descripción del modelo. Este campo puede recibir valores NULL debido a que no son estrictamente necesarios dentro del funcionamiento y análisis del SGBD. Las personas en este campo pondrían información adicional, es por esto que no es un campo obligatorio. En este caso con el year_modelo bastaría',
  PRIMARY KEY (`id_modelo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modelo`
--

LOCK TABLES `modelo` WRITE;
/*!40000 ALTER TABLE `modelo` DISABLE KEYS */;
/*!40000 ALTER TABLE `modelo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_linea`
--

DROP TABLE IF EXISTS `tipo_linea`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_linea` (
  `id_linea` int(5) unsigned NOT NULL AUTO_INCREMENT,
  `desc_linea` varchar(255) DEFAULT NULL COMMENT 'Descripción de la línea. Este campo puede recibir valores NULL debido a que no son estrictamente necesarios dentro del funcionamiento y análisis del SGBD. Las personas en este campo pondrían información adicional, es por esto que no es un campo obligatorio',
  `id_marca` int(10) unsigned NOT NULL,
  `activo` enum('S','N') NOT NULL,
  PRIMARY KEY (`id_linea`),
  KEY `fk_id_marca` (`id_marca`),
  CONSTRAINT `fk_id_marca` FOREIGN KEY (`id_marca`) REFERENCES `tipo_marca` (`id_marca`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_linea`
--

LOCK TABLES `tipo_linea` WRITE;
/*!40000 ALTER TABLE `tipo_linea` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_linea` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_marca`
--

DROP TABLE IF EXISTS `tipo_marca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_marca` (
  `id_marca` int(5) unsigned NOT NULL AUTO_INCREMENT,
  `desc_marca` varchar(255) NOT NULL COMMENT 'Descripción de la marca. Este campo podría recibir valores NULL si existiera otro canmpo como nombre_marca. Pero debido a que no se cuenta en el modelo con este canmpo, es estrictamente necesario dentro del funcionamiento y análisis del SGBD.',
  `activo` enum('S','N') NOT NULL,
  PRIMARY KEY (`id_marca`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_marca`
--

LOCK TABLES `tipo_marca` WRITE;
/*!40000 ALTER TABLE `tipo_marca` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_marca` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehiculos`
--

DROP TABLE IF EXISTS `vehiculos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehiculos` (
  `id_vehiculo` int(5) unsigned NOT NULL AUTO_INCREMENT,
  `nro_placa` varchar(8) NOT NULL,
  `id_linea` int(5) unsigned NOT NULL,
  `id_modelo` int(5) unsigned NOT NULL,
  `fecha_ven_seguro` date NOT NULL,
  `fecha_ven_tecnomecanica` date NOT NULL,
  `fecha_ven_contratodo` date NOT NULL,
  PRIMARY KEY (`id_vehiculo`),
  UNIQUE KEY `nro_placa` (`nro_placa`),
  KEY `id_modelo` (`id_modelo`),
  KEY `fk_id_linea` (`id_linea`),
  CONSTRAINT `fk_id_linea` FOREIGN KEY (`id_linea`) REFERENCES `tipo_linea` (`id_linea`) ON UPDATE CASCADE,
  CONSTRAINT `vehiculos_ibfk_1` FOREIGN KEY (`id_modelo`) REFERENCES `modelo` (`id_modelo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehiculos`
--

LOCK TABLES `vehiculos` WRITE;
/*!40000 ALTER TABLE `vehiculos` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehiculos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-01-17 19:03:38
