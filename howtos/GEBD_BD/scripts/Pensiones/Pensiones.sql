-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Pensiones
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Pensiones
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Pensiones` DEFAULT CHARACTER SET utf8 ;
USE `Pensiones` ;

-- -----------------------------------------------------
-- Table `Pensiones`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pensiones`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `apellidos` VARCHAR(50) NOT NULL,
  `fechaDeNacimiento` DATE NOT NULL,
  `profesion` VARCHAR(45) NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pensiones`.`Plan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pensiones`.`Plan` (
  `idPlanDGS` VARCHAR(5) NOT NULL,
  `plan` VARCHAR(50) NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`idPlanDGS`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pensiones`.`Poliza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pensiones`.`Poliza` (
  `idPoliza` VARCHAR(19) NOT NULL,
  `fechaCreacion` DATE NULL,
  `fechaVencimiento` DATE NULL,
  `idCliente` INT NOT NULL,
  `idPlanDGS` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`idPoliza`),
  INDEX `fk_Poliza_Cliente_idx` (`idCliente` ASC),
  INDEX `fk_Poliza_Plan1_idx` (`idPlanDGS` ASC),
  CONSTRAINT `fk_Poliza_Cliente`
    FOREIGN KEY (`idCliente`)
    REFERENCES `Pensiones`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Poliza_Plan1`
    FOREIGN KEY (`idPlanDGS`)
    REFERENCES `Pensiones`.`Plan` (`idPlanDGS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pensiones`.`Aportacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pensiones`.`Aportacion` (
  `idAportacion` INT NOT NULL,
  `idPoliza` VARCHAR(19) NOT NULL,
  `fecha` DATE NOT NULL,
  `importe` FLOAT NOT NULL,
  `idCliente` INT NOT NULL,
  PRIMARY KEY (`idAportacion`, `idPoliza`),
  INDEX `fk_Aportacion_Poliza1_idx` (`idPoliza` ASC),
  INDEX `fk_Aportacion_Cliente1_idx` (`idCliente` ASC),
  CONSTRAINT `fk_Aportacion_Poliza1`
    FOREIGN KEY (`idPoliza`)
    REFERENCES `Pensiones`.`Poliza` (`idPoliza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Aportacion_Cliente1`
    FOREIGN KEY (`idCliente`)
    REFERENCES `Pensiones`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pensiones`.`Clausula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pensiones`.`Clausula` (
  `idClausula` INT NOT NULL AUTO_INCREMENT,
  `clausula` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(200) NULL,
  PRIMARY KEY (`idClausula`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pensiones`.`ClausulaPlan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pensiones`.`ClausulaPlan` (
  `idClausula` INT NOT NULL,
  `idPlanDGS` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`idClausula`, `idPlanDGS`),
  INDEX `fk_Clausula_has_Plan_Plan1_idx` (`idPlanDGS` ASC),
  INDEX `fk_Clausula_has_Plan_Clausula1_idx` (`idClausula` ASC),
  CONSTRAINT `fk_Clausula_has_Plan_Clausula1`
    FOREIGN KEY (`idClausula`)
    REFERENCES `Pensiones`.`Clausula` (`idClausula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Clausula_has_Plan_Plan1`
    FOREIGN KEY (`idPlanDGS`)
    REFERENCES `Pensiones`.`Plan` (`idPlanDGS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
