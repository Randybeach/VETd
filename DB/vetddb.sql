-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema vetddb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `vetddb` ;

-- -----------------------------------------------------
-- Schema vetddb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `vetddb` DEFAULT CHARACTER SET utf8 ;
USE `vetddb` ;

-- -----------------------------------------------------
-- Table `Location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Location` ;

CREATE TABLE IF NOT EXISTS `Location` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `zipcode` VARCHAR(5) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Review` ;

CREATE TABLE IF NOT EXISTS `Review` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` VARCHAR(500) NULL,
  `rating` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Mentor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Mentor` ;

CREATE TABLE IF NOT EXISTS `Mentor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `story` VARCHAR(500) NULL,
  `created_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Mentee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Mentee` ;

CREATE TABLE IF NOT EXISTS `Mentee` (
  `id` INT NOT NULL,
  `story` VARCHAR(500) NULL,
  `created_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Profile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Profile` ;

CREATE TABLE IF NOT EXISTS `Profile` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `summary` VARCHAR(200) NULL,
  `created_at` DATETIME NULL,
  `Location_id` INT NULL,
  `Review_id` INT NULL,
  `Mentor_id` INT NULL,
  `Mentee_id` INT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Profile_Location1`
    FOREIGN KEY (`Location_id`)
    REFERENCES `Location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Profile_Review1`
    FOREIGN KEY (`Review_id`)
    REFERENCES `Review` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Profile_Mentor1`
    FOREIGN KEY (`Mentor_id`)
    REFERENCES `Mentor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Profile_Mentee1`
    FOREIGN KEY (`Mentee_id`)
    REFERENCES `Mentee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Profile_Location1_idx` ON `Profile` (`Location_id` ASC);

CREATE INDEX `fk_Profile_Review1_idx` ON `Profile` (`Review_id` ASC);

CREATE INDEX `fk_Profile_Mentor1_idx` ON `Profile` (`Mentor_id` ASC);

CREATE INDEX `fk_Profile_Mentee1_idx` ON `Profile` (`Mentee_id` ASC);


-- -----------------------------------------------------
-- Table `User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `User` ;

CREATE TABLE IF NOT EXISTS `User` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `role` VARCHAR(45) NULL,
  `enamble` TINYINT NULL,
  `Profile_id` INT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_User_Profile`
    FOREIGN KEY (`Profile_id`)
    REFERENCES `Profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_User_Profile_idx` ON `User` (`Profile_id` ASC);


-- -----------------------------------------------------
-- Table `Mentor_Mentee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Mentor_Mentee` ;

CREATE TABLE IF NOT EXISTS `Mentor_Mentee` (
  `id` INT NOT NULL,
  `created_at` DATETIME NULL,
  `Mentee_id` INT NOT NULL,
  `Mentor_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Mentor_Mentee_Mentee1`
    FOREIGN KEY (`Mentee_id`)
    REFERENCES `Mentee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mentor_Mentee_Mentor1`
    FOREIGN KEY (`Mentor_id`)
    REFERENCES `Mentor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Mentor_Mentee_Mentee1_idx` ON `Mentor_Mentee` (`Mentee_id` ASC);

CREATE INDEX `fk_Mentor_Mentee_Mentor1_idx` ON `Mentor_Mentee` (`Mentor_id` ASC);


-- -----------------------------------------------------
-- Table `Sector`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Sector` ;

CREATE TABLE IF NOT EXISTS `Sector` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Job`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Job` ;

CREATE TABLE IF NOT EXISTS `Job` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `Sector_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Occupation_Sector1`
    FOREIGN KEY (`Sector_id`)
    REFERENCES `Sector` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Occupation_Sector1_idx` ON `Job` (`Sector_id` ASC);


-- -----------------------------------------------------
-- Table `Mentee_Job`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Mentee_Job` ;

CREATE TABLE IF NOT EXISTS `Mentee_Job` (
  `Occupation_id` INT NOT NULL,
  `Mentee_id` INT NOT NULL,
  CONSTRAINT `fk_table1_Occupation1`
    FOREIGN KEY (`Occupation_id`)
    REFERENCES `Job` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table1_Mentee1`
    FOREIGN KEY (`Mentee_id`)
    REFERENCES `Mentee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_table1_Mentee1_idx` ON `Mentee_Job` (`Mentee_id` ASC);


-- -----------------------------------------------------
-- Table `Mentor_Job`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Mentor_Job` ;

CREATE TABLE IF NOT EXISTS `Mentor_Job` (
  `Occupation_id` INT NOT NULL,
  `Mentor_id` INT NOT NULL,
  CONSTRAINT `fk_table2_Occupation1`
    FOREIGN KEY (`Occupation_id`)
    REFERENCES `Job` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table2_Mentor1`
    FOREIGN KEY (`Mentor_id`)
    REFERENCES `Mentor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_table2_Mentor1_idx` ON `Mentor_Job` (`Mentor_id` ASC);

GRANT SELECT, INSERT, TRIGGER ON TABLE `vetddb`.* TO 'user'@'localhost';
GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE `vetddb`.* TO 'user'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `User`
-- -----------------------------------------------------
START TRANSACTION;
USE `vetddb`;
INSERT INTO `User` (`id`, `username`, `email`, `password`, `role`, `enamble`, `Profile_id`) VALUES (1, 'bob', 'bob@bob.com', 'bob', 'user', true, NULL);
INSERT INTO `User` (`id`, `username`, `email`, `password`, `role`, `enamble`, `Profile_id`) VALUES (2, 'sue', 'sue@sue.com', 'sue', 'user', true, NULL);

COMMIT;

