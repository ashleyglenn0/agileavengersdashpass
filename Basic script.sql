-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema FastPassDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema FastPassDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `FastPassDB` DEFAULT CHARACTER SET utf8 ;
USE `FastPassDB` ;

-- -----------------------------------------------------
-- Table `FastPassDB`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FastPassDB`.`Customer` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `First_Name` VARCHAR(45) NOT NULL,
  `Last_Name` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(80) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `UserName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FastPassDB`.`FastPass`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FastPassDB`.`FastPass` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `CustomerID` INT UNSIGNED NOT NULL,
  `DateOfPurchase` DATE NOT NULL,
  `ExpDate` DATE NOT NULL,
  `Used` TINYINT(1) NOT NULL,
  `FastPasscol` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `idFastPass_UNIQUE` (`ID` ASC) VISIBLE,
  INDEX `CustomerID_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `CustomerID`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `FastPassDB`.`Customer` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FastPassDB`.`FlightTicket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FastPassDB`.`FlightTicket` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Customer ID` INT UNSIGNED NOT NULL,
  `Flight ID` INT UNSIGNED NOT NULL,
  `Airport ID` INT UNSIGNED NOT NULL,
  `Date Of Flight` DATE NOT NULL,
  `Date Of Purchase` DATE NOT NULL,
  `FastPassCompatible` TINYINT(1) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE,
  INDEX `Customer ID_idx` (`Customer ID` ASC) VISIBLE,
  CONSTRAINT `Customer ID FK`
    FOREIGN KEY (`Customer ID`)
    REFERENCES `FastPassDB`.`Customer` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FastPassDB`.`FastPass Tickets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FastPassDB`.`FastPass Tickets` (
  `FastPass ID` INT UNSIGNED NOT NULL,
  `Ticket ID` INT UNSIGNED NOT NULL,
  `Customer ID` INT UNSIGNED NOT NULL,
  `Airport ID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`FastPass ID`, `Ticket ID`, `Customer ID`, `Airport ID`),
  INDEX `Ticket ID_idx` (`Ticket ID` ASC) VISIBLE,
  INDEX `Customer ID_idx` (`Customer ID` ASC) VISIBLE,
  CONSTRAINT `FastPass ID`
    FOREIGN KEY (`FastPass ID`)
    REFERENCES `FastPassDB`.`FastPass` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Ticket ID`
    FOREIGN KEY (`Ticket ID`)
    REFERENCES `FastPassDB`.`FlightTicket` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Customer ID`
    FOREIGN KEY (`Customer ID`)
    REFERENCES `FastPassDB`.`Customer` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
