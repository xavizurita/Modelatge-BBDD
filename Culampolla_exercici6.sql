-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Optica_Cul_ampolla
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Optica_Cul_ampolla
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Optica_Cul_ampolla` DEFAULT CHARACTER SET utf8 ;
USE `Optica_Cul_ampolla` ;

-- -----------------------------------------------------
-- Table `Optica_Cul_ampolla`.`TaulaProveidor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica_Cul_ampolla`.`TaulaProveidor` (
  `id_TProveidor` INT NOT NULL AUTO_INCREMENT,
  `TaulaProveidor_Nom` VARCHAR(45) NULL,
  `TaulaProveidor_Via` VARCHAR(10) NULL,
  `TaulaProveidor_Numero` VARCHAR(10) NULL,
  `TaulaProveidor_Pis` VARCHAR(10) NULL,
  `TaulaProveidor_porta` VARCHAR(10) NULL,
  `TaulaProveidor_ciutat` VARCHAR(45) NULL,
  `TaulaProveidor_CP` VARCHAR(5) NULL,
  `TaulaProveidor_Pais` VARCHAR(45) NULL,
  `TaulaProveidor_tel` VARCHAR(45) NULL,
  `TaulaProveidor_Fax` VARCHAR(45) NULL,
  `TaulaProveidor_Nif` VARCHAR(45) NULL,
  `TaulaProveidor_Email` VARCHAR(45) NULL,
  PRIMARY KEY (`id_TProveidor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica_Cul_ampolla`.`TaulaUlleres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica_Cul_ampolla`.`TaulaUlleres` (
  `id_TUlleres` INT NOT NULL AUTO_INCREMENT,
  `TaulaUlleres_proveidor` INT NULL,
  `TaulaUlleres_Marca` VARCHAR(45) NULL,
  `TaulaUlleres_TipoMontura` VARCHAR(45) NULL,
  `TaulaUlleres_Color Montura` VARCHAR(45) NULL,
  `TaulaUlleres_ColorVidreDret` VARCHAR(45) NULL,
  `TaulaUlleres_ColroVidreEsquerra` VARCHAR(45) NULL,
  `TaulaUlleres_GraduacioDret` FLOAT NULL,
  `TaulaUlleres_GraduacioEsquerra` FLOAT NULL,
  `TaulaUlleres_Preu` FLOAT NULL,
  PRIMARY KEY (`id_TUlleres`),
  INDEX `TaulaUlleres_TaulaProveidor_idx` (`TaulaUlleres_proveidor` ASC),
  CONSTRAINT `TaulaUlleres_TaulaProveidor`
    FOREIGN KEY (`TaulaUlleres_proveidor`)
    REFERENCES `Optica_Cul_ampolla`.`TaulaProveidor` (`id_TProveidor`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica_Cul_ampolla`.`TaulaEmpleats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica_Cul_ampolla`.`TaulaEmpleats` (
  `id_TEmpleats` INT NOT NULL AUTO_INCREMENT,
  `TaulaEmpleats_Nom` VARCHAR(45) NULL,
  `TaulaEmpleats_Cognoms` VARCHAR(45) NULL,
  `TaulaEmpleats_CatProfesional` VARCHAR(45) NULL,
  `TaulaEmpleats_DataAlta` DATE NULL,
  PRIMARY KEY (`id_TEmpleats`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica_Cul_ampolla`.`TaulaClient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica_Cul_ampolla`.`TaulaClient` (
  `id_TClient` INT NOT NULL AUTO_INCREMENT,
  `TaulaClient_Nom` VARCHAR(45) NULL,
  `TaulaClient_Adreça` VARCHAR(45) NULL,
  `TaulaClient_Tel` VARCHAR(15) NULL,
  `TaulaClient_Email` VARCHAR(45) NULL,
  `TaulaClient_DataAlta` DATE NULL,
  `TaulaClientNif` VARCHAR(45) NULL,
  `TaulaClient_RecomanatX` INT NULL,
  PRIMARY KEY (`id_TClient`))
ENGINE = InnoDB
COMMENT = '	';


-- -----------------------------------------------------
-- Table `Optica_Cul_ampolla`.`TaulaFactura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica_Cul_ampolla`.`TaulaFactura` (
  `id_TFactura` INT NOT NULL,
  `TaulaFactura_NumFactura` VARCHAR(45) NULL,
  `TaulaFactura_Client` INT NULL,
  `TaulaFactura_Empleats` INT NULL,
  `TaulaFactura_DataVenda` DATETIME NULL,
  `TaulaFactura_Subtotal` FLOAT NULL,
  `TaulaFactura_Iva` FLOAT NULL,
  `TaulaFactura_TotalFactura` FLOAT NULL,
  PRIMARY KEY (`id_TFactura`),
  INDEX `TaulaFactura_TaulaClient_idx` (`TaulaFactura_Client` ASC),
  INDEX `TaulaFactura_TaulaEmpleat_idx` (`TaulaFactura_Empleats` ASC),
  CONSTRAINT `TaulaFactura_TaulaClient`
    FOREIGN KEY (`TaulaFactura_Client`)
    REFERENCES `Optica_Cul_ampolla`.`TaulaClient` (`id_TClient`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `TaulaFactura_TaulaEmpleat`
    FOREIGN KEY (`TaulaFactura_Empleats`)
    REFERENCES `Optica_Cul_ampolla`.`TaulaEmpleats` (`id_TEmpleats`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica_Cul_ampolla`.`TaulaDetallaVendes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica_Cul_ampolla`.`TaulaDetallaVendes` (
  `id_TDetallaVendes` INT NOT NULL AUTO_INCREMENT,
  `TaulaDetallaVendes_Factura` INT NULL,
  `TaulaDetallaVendes_Ulleres` INT NULL,
  `TaulaDetallaVendes_Quantitat` INT NULL,
  `TaulaDetallaVendes_preu` FLOAT NULL,
  `TaulaDetallaVendes_Import` FLOAT NULL,
  PRIMARY KEY (`id_TDetallaVendes`),
  INDEX `Tauladetallavendes_TaulaFactura_idx` (`TaulaDetallaVendes_Factura` ASC),
  INDEX `TaulaDetallaVendes_TaulaUlleres_idx` (`TaulaDetallaVendes_Ulleres` ASC),
  CONSTRAINT `Tauladetallavendes_TaulaFactura`
    FOREIGN KEY (`TaulaDetallaVendes_Factura`)
    REFERENCES `Optica_Cul_ampolla`.`TaulaFactura` (`id_TFactura`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `TaulaDetallaVendes_TaulaUlleres`
    FOREIGN KEY (`TaulaDetallaVendes_Ulleres`)
    REFERENCES `Optica_Cul_ampolla`.`TaulaUlleres` (`id_TUlleres`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
