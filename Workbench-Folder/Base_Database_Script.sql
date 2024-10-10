-- MySQL Workbench Forward Engineering
-- Written by Nathaniel Smith

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema dashPass_DB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema dashPass_DB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dashPass_DB` DEFAULT CHARACTER SET utf8 ;
USE `dashPass_DB` ;

-- -----------------------------------------------------
-- Table `dashPass_DB`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dashPass_DB`.`user` (
  `ID` INT UNSIGNED NOT NULL,
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `email` VARCHAR(80) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `userType` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dashPass_DB`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dashPass_DB`.`customer` (
  `customerID` INT UNSIGNED NOT NULL,
  `numberOfDashPassesAvailable` INT UNSIGNED NOT NULL,
  `totalDashPasses` INT UNSIGNED NOT NULL,
  `numberOfDashPassesUsed` INT UNSIGNED NOT NULL,
  `canPurchaseDashPass` TINYINT(1) NOT NULL,
  `canFly` TINYINT(1) NOT NULL,
  `canPurchaseFlight` TINYINT(1) NOT NULL,
  PRIMARY KEY (`customerID`),
  CONSTRAINT `userCustomer_FK`
    FOREIGN KEY (`customerID`)
    REFERENCES `dashPass_DB`.`user` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dashPass_DB`.`EMPLOYEE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dashPass_DB`.`EMPLOYEE` (
  `employeeID` INT UNSIGNED NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  `canSellDashPass` TINYINT(1) NOT NULL,
  `canAddCustomerFlight` TINYINT(1) NOT NULL,
  `canAddCustomer` TINYINT(1) NOT NULL,
  `canRedeemDashPass` TINYINT(1) NOT NULL,
  `canRemoveDashPass` TINYINT(1) NOT NULL,
  `canEditFlightInformation` TINYINT(1) NOT NULL,
  PRIMARY KEY (`employeeID`),
  CONSTRAINT `userEmployee`
    FOREIGN KEY (`employeeID`)
    REFERENCES `dashPass_DB`.`user` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dashPass_DB`.`dashPass`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dashPass_DB`.`dashPass` (
  `dashPassID` INT UNSIGNED NOT NULL,
  `customerID` INT UNSIGNED NOT NULL,
  `dateOfPurchase` DATE NOT NULL,
  `expirationDate` DATE NOT NULL,
  `isRedeemed` TINYINT(1) NOT NULL,
  PRIMARY KEY (`dashPassID`),
  INDEX `customerDashPass_idx` (`customerID` ASC) VISIBLE,
  CONSTRAINT `customerDashPass`
    FOREIGN KEY (`customerID`)
    REFERENCES `dashPass_DB`.`customer` (`customerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dashPass_DB`.`dashPass Reservation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dashPass_DB`.`dashPass Reservation` (
  `ID` INT UNSIGNED NOT NULL,
  `dashPassID` INT UNSIGNED NOT NULL,
  `customerID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `dashPassDPR_FK_idx` (`dashPassID` ASC) VISIBLE,
  INDEX `customerDPR_FK_idx` (`customerID` ASC) VISIBLE,
  CONSTRAINT `dashPassDPR`
    FOREIGN KEY (`dashPassID`)
    REFERENCES `dashPass_DB`.`dashPass` (`dashPassID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `customerDPR`
    FOREIGN KEY (`customerID`)
    REFERENCES `dashPass_DB`.`customer` (`customerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dashPass_DB`.`airport`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dashPass_DB`.`airport` (
  `airportID` INT UNSIGNED NOT NULL,
  `airportCode` CHAR(3) NOT NULL,
  PRIMARY KEY (`airportID`, `airportCode`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dashPass_DB`.`flight`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dashPass_DB`.`flight` (
  `flightID` INT UNSIGNED NOT NULL,
  `flightDepartureAirport` CHAR(3) NOT NULL,
  `flightArrivalAirport` CHAR(3) NOT NULL,
  `numberOfSeatsAvailable` INT UNSIGNED NOT NULL,
  `numberOfSeatsSold` INT UNSIGNED NOT NULL,
  `numberOfSeatsRemaining` INT UNSIGNED NOT NULL,
  `maxNumberOfDashPassesForFlight` INT UNSIGNED NOT NULL,
  `numberOfDashPassesAvailable` INT UNSIGNED NOT NULL,
  `DashPassAllowed` TINYINT(1) NOT NULL,
  PRIMARY KEY (`flightID`),
  INDEX `airportDeparture_idx` (`flightDepartureAirport` ASC) VISIBLE,
  INDEX `airportArrival_idx` (`flightArrivalAirport` ASC) VISIBLE,
  CONSTRAINT `airportDepartureFK`
    FOREIGN KEY (`flightDepartureAirport`)
    REFERENCES `dashPass_DB`.`airport` (`airportCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `airportArrival`
    FOREIGN KEY (`flightArrivalAirport`)
    REFERENCES `dashPass_DB`.`airport` (`airportCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dashPass_DB`.`reservation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dashPass_DB`.`reservation` (
  `reservationID` INT UNSIGNED NOT NULL,
  `customerID` INT UNSIGNED NOT NULL,
  `flightID` INT UNSIGNED NOT NULL,
  `airportCode` CHAR(3) NOT NULL,
  `dateBooked` DATE NOT NULL,
  PRIMARY KEY (`reservationID`),
  INDEX `customerReservation_idx` (`customerID` ASC) VISIBLE,
  INDEX `flightRV_idx` (`flightID` ASC) VISIBLE,
  INDEX `airportReservation_idx` (`airportCode` ASC) VISIBLE,
  CONSTRAINT `customerReservation`
    FOREIGN KEY (`customerID`)
    REFERENCES `dashPass_DB`.`customer` (`customerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `flightRV`
    FOREIGN KEY (`flightID`)
    REFERENCES `dashPass_DB`.`flight` (`flightID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `airportReservation`
    FOREIGN KEY (`airportCode`)
    REFERENCES `dashPass_DB`.`airport` (`airportCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
