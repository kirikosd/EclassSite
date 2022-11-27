-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema coursegrades
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema coursegrades
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `coursegrades` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `coursegrades` ;

-- -----------------------------------------------------
-- Table `coursegrades`.`courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coursegrades`.`courses` (
  `courseID` INT NOT NULL,
  `title` VARCHAR(45) NULL DEFAULT NULL,
  `professors_afm` VARCHAR(45) NOT NULL,
  `department` VARCHAR(45) NULL DEFAULT NULL,
  `semester` INT NULL DEFAULT NULL,
  PRIMARY KEY (`courseID`, `professors_afm`),
  INDEX `professors_afm_idx` (`professors_afm` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `coursegrades`.`grades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coursegrades`.`grades` (
  `courseID` INT NOT NULL,
  `registrationNumber` VARCHAR(45) NOT NULL,
  `grade` INT NULL DEFAULT NULL,
  PRIMARY KEY (`courseID`, `registrationNumber`),
  INDEX `students_registrationNumber_idx` (`registrationNumber` ASC) VISIBLE,
  INDEX `st_registrationNumber_idx` (`registrationNumber` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `coursegrades`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coursegrades`.`users` (
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NULL DEFAULT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `surname` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`username`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `coursegrades`.`professors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coursegrades`.`professors` (
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NULL DEFAULT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `surname` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `department` VARCHAR(45) NULL DEFAULT NULL,
  `afm` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`username`, `afm`),
  CONSTRAINT `fk_professors_username`
    FOREIGN KEY (`username`)
    REFERENCES `coursegrades`.`users` (`username`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `coursegrades`.`secretaries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coursegrades`.`secretaries` (
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NULL DEFAULT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `surname` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `phone` VARCHAR(45) NULL DEFAULT NULL,
  `afm` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`afm`),
  INDEX `fk_secretaries_username_idx` (`username` ASC) VISIBLE,
  CONSTRAINT `fk_secretaries_username`
    FOREIGN KEY (`username`)
    REFERENCES `coursegrades`.`users` (`username`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `coursegrades`.`students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coursegrades`.`students` (
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NULL DEFAULT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `surname` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `department` VARCHAR(45) NULL DEFAULT NULL,
  `registrationNumber` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`username`, `registrationNumber`),
  CONSTRAINT `fk_students_username`
    FOREIGN KEY (`username`)
    REFERENCES `coursegrades`.`users` (`username`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
