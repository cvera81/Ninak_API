-- MySQL Script generated by MySQL Workbench
-- Mon Aug  3 22:55:31 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema ninak
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `ninak` ;

-- -----------------------------------------------------
-- Schema ninak
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ninak` DEFAULT CHARACTER SET utf8 ;
USE `ninak` ;

-- -----------------------------------------------------
-- Table `ninak`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ninak`.`User` (
  `id` INT NOT NULL,
  `first_name` VARCHAR(30) NOT NULL,
  `middle_name` VARCHAR(30) NULL,
  `last_name` VARCHAR(30) NOT NULL,
  `type_doc` INT NOT NULL,
  `num_doc` VARCHAR(30) NOT NULL,
  `id_country` INT NOT NULL,
  `id_state` INT NOT NULL,
  `id_city` INT NOT NULL,
  `registered_on` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ninak`.`Account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ninak`.`Account` (
  `id` INT NOT NULL,
  `id_user` INT NOT NULL,
  `id_institute` INT NOT NULL,
  `email` VARCHAR(30) NOT NULL,
  `password_hash` VARCHAR(100) NOT NULL,
  `old_password` VARCHAR(100) NOT NULL,
  `wrong_login_attempt` INT NULL,
  `today_login_attempt` VARCHAR(100) NULL,
  `is_now_login` INT NULL,
  `registered_on` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_idx` (`id_user` ASC),
  CONSTRAINT `id`
    FOREIGN KEY (`id_user`)
    REFERENCES `ninak`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ninak`.`Teacher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ninak`.`Teacher` (
  `id` INT NOT NULL,
  `id_account` INT NOT NULL,
  `teacher_code` VARCHAR(30) NOT NULL,
  `registered_on` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_idaccountTeacherx` (`id_account` ASC),
  CONSTRAINT `id_Teacher_constraint`
    FOREIGN KEY (`id_account`)
    REFERENCES `ninak`.`Account` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ninak`.`Student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ninak`.`Student` (
  `id` INT NOT NULL,
  `id_account` INT NOT NULL,
  `student_code` VARCHAR(30) NOT NULL,
  `registered` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_idaccountStudentx` (`id_account` ASC),
  CONSTRAINT `id_Student_constraint`
    FOREIGN KEY (`id_account`)
    REFERENCES `ninak`.`Account` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ninak`.`Course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ninak`.`Course` (
  `id` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `Description` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ninak`.`Institute`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ninak`.`Institute` (
  `id` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(30) NOT NULL,
  `id_country` INT NOT NULL,
  `id_state` INT NOT NULL,
  `id_city` INT NOT NULL,
  `registered_on` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;