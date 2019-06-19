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
  `Mentor_id` INT NULL,
  `Mentee_id` INT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Profile_Location1`
    FOREIGN KEY (`Location_id`)
    REFERENCES `Location` (`id`)
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
-- Table `Review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Review` ;

CREATE TABLE IF NOT EXISTS `Review` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` VARCHAR(500) NULL,
  `rating` INT NULL,
  `Profile_id` INT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Review_Profile1`
    FOREIGN KEY (`Profile_id`)
    REFERENCES `Profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Review_Profile1_idx` ON `Review` (`Profile_id` ASC);


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
  `name` VARCHAR(150) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Job`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Job` ;

CREATE TABLE IF NOT EXISTS `Job` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Sector_id` INT NULL,
  `name` VARCHAR(150) NULL,
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
  `Job_id` INT NOT NULL,
  `Mentee_id` INT NOT NULL,
  CONSTRAINT `fk_table1_Occupation1`
    FOREIGN KEY (`Job_id`)
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
  `Job_id` INT NOT NULL,
  `Mentor_id` INT NOT NULL,
  CONSTRAINT `fk_table2_Occupation1`
    FOREIGN KEY (`Job_id`)
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


-- -----------------------------------------------------
-- Data for table `Sector`
-- -----------------------------------------------------
START TRANSACTION;
USE `vetddb`;
INSERT INTO `Sector` (`id`, `name`) VALUES (1, 'Management ');
INSERT INTO `Sector` (`id`, `name`) VALUES (2, 'Business and Financial Operations ');
INSERT INTO `Sector` (`id`, `name`) VALUES (3, 'Computer and Mathematical ');
INSERT INTO `Sector` (`id`, `name`) VALUES (4, 'Architecture and Engineering ');
INSERT INTO `Sector` (`id`, `name`) VALUES (5, 'Life, Physical, and Social Science ');
INSERT INTO `Sector` (`id`, `name`) VALUES (6, 'Community and Social Service ');
INSERT INTO `Sector` (`id`, `name`) VALUES (7, 'Legal ');
INSERT INTO `Sector` (`id`, `name`) VALUES (8, 'Educational Instruction and Library ');
INSERT INTO `Sector` (`id`, `name`) VALUES (9, 'Arts, Design, Entertainment, Sports, and Media ');
INSERT INTO `Sector` (`id`, `name`) VALUES (10, 'Healthcare Practitioners and Technical ');
INSERT INTO `Sector` (`id`, `name`) VALUES (11, 'Healthcare Support ');
INSERT INTO `Sector` (`id`, `name`) VALUES (12, 'Protective Service ');
INSERT INTO `Sector` (`id`, `name`) VALUES (13, 'Food Preparation and Serving Related ');
INSERT INTO `Sector` (`id`, `name`) VALUES (14, 'Building and Grounds Cleaning and Maintenance ');
INSERT INTO `Sector` (`id`, `name`) VALUES (15, 'Personal Care and Service ');
INSERT INTO `Sector` (`id`, `name`) VALUES (16, 'Sales and Related ');
INSERT INTO `Sector` (`id`, `name`) VALUES (17, 'Office and Administrative Support ');
INSERT INTO `Sector` (`id`, `name`) VALUES (18, 'Farming, Fishing, and Forestry ');
INSERT INTO `Sector` (`id`, `name`) VALUES (19, 'Construction and Extraction ');
INSERT INTO `Sector` (`id`, `name`) VALUES (20, 'Installation, Maintenance, and Repair ');
INSERT INTO `Sector` (`id`, `name`) VALUES (21, 'Production ');
INSERT INTO `Sector` (`id`, `name`) VALUES (22, 'Transportation and Material Moving ');
INSERT INTO `Sector` (`id`, `name`) VALUES (23, 'Military Specific ');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Job`
-- -----------------------------------------------------
START TRANSACTION;
USE `vetddb`;
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (1, 1, 'Chief Executives');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (2, 1, 'General and Operations Managers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (3, 1, 'Legislators');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (4, 1, 'Advertising and Promotions Managers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (5, 1, 'Marketing and Sales Managers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (6, 1, 'Public Relations and Fundraising Managers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (7, 1, 'Administrative Services and Facilities Managers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (8, 1, 'Computer and Information Systems Managers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (9, 1, 'Financial Managers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (10, 1, 'Industrial Production Managers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (11, 1, 'Purchasing Managers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (12, 1, 'Transportation, Storage, and Distribution Managers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (13, 1, 'Compensation and Benefits Managers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (14, 1, 'Human Resources Managers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (15, 1, 'Training and Development Managers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (16, 1, 'Farmers, Ranchers, and Other Agricultural Managers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (17, 1, 'Construction Managers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (18, 1, 'Education and Childcare Administrators');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (19, 1, 'Architectural and Engineering Managers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (20, 1, 'Food Service Managers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (21, 1, 'Entertainment and Recreation Managers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (22, 1, 'Lodging Managers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (23, 1, 'Medical and Health Services Managers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (24, 1, 'Natural Sciences Managers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (25, 1, 'Postmasters and Mail Superintendents');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (26, 1, 'Property, Real Estate, and Community Association Managers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (27, 1, 'Social and Community Service Managers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (28, 1, 'Emergency Management Directors');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (29, 1, 'Personal Service Managers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (30, 1, 'Miscellaneous Managers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (31, 2, 'Agents and Business Managers of Artists, Performers, and Athletes');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (32, 2, 'Buyers and Purchasing Agents');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (33, 2, 'Claims Adjusters, Appraisers, Examiners, and Investigators');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (34, 2, 'Compliance Officers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (35, 2, 'Cost Estimators');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (36, 2, 'Human Resources Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (37, 2, 'Logisticians and Project Management Specialists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (38, 2, 'Management Analysts');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (39, 2, 'Meeting, Convention, and Event Planners');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (40, 2, 'Fundraisers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (41, 2, 'Compensation, Benefits, and Job Analysis Specialists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (42, 2, 'Training and Development Specialists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (43, 2, 'Market Research Analysts and Marketing Specialists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (44, 2, 'Miscellaneous Business Operations Specialists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (45, 2, 'Accountants and Auditors');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (46, 2, 'Property Appraisers and Assessors');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (47, 2, 'Budget Analysts');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (48, 2, 'Credit Analysts');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (49, 2, 'Financial Analysts and Advisors');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (50, 2, 'Financial Examiners');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (51, 2, 'Credit Counselors and Loan Officers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (52, 2, 'Tax Examiners, Collectors and Preparers, and Revenue Agents');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (53, 2, 'Miscellaneous Financial Specialists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (54, 3, 'Computer and Information Analysts');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (55, 3, 'Computer and Information Research Scientists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (56, 3, 'Computer Support Specialists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (57, 3, 'Database and Network Administrators and Architects');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (58, 3, 'Software and Web Developers, Programmers, and Testers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (59, 3, 'Miscellaneous Computer ');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (60, 3, 'Actuaries');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (61, 3, 'Mathematicians');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (62, 3, 'Operations Research Analysts');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (63, 3, 'Statisticians');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (64, 3, 'Data Scientists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (65, 3, 'Miscellaneous Mathematical Science ');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (66, 4, 'Architects, Except Naval');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (67, 4, 'Surveyors, Cartographers, and Photogrammetrists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (68, 4, 'Aerospace Engineers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (69, 4, 'Agricultural Engineers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (70, 4, 'Bioengineers and Biomedical Engineers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (71, 4, 'Chemical Engineers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (72, 4, 'Civil Engineers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (73, 4, 'Computer Hardware Engineers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (74, 4, 'Electrical and Electronics Engineers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (75, 4, 'Environmental Engineers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (76, 4, 'Industrial Engineers, Including Health and Safety');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (77, 4, 'Marine Engineers and Naval Architects');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (78, 4, 'Materials Engineers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (79, 4, 'Mechanical Engineers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (80, 4, 'Mining and Geological Engineers, Including Mining Safety Engineers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (81, 4, 'Nuclear Engineers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (82, 4, 'Petroleum Engineers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (83, 4, 'Miscellaneous Engineers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (84, 4, 'Drafters');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (85, 4, 'Engineering Technologists and Technicians, Except Drafters');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (86, 4, 'Surveying and Mapping Technicians');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (87, 5, 'Agricultural and Food Scientists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (88, 5, 'Biological Scientists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (89, 5, 'Conservation Scientists and Foresters');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (90, 5, 'Medical Scientists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (91, 5, 'Miscellaneous Life Scientists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (92, 5, 'Astronomers and Physicists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (93, 5, 'Atmospheric and Space Scientists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (94, 5, 'Chemists and Materials Scientists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (95, 5, 'Environmental Scientists and Geoscientists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (96, 5, 'Miscellaneous Physical Scientists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (97, 5, 'Economists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (98, 5, 'Survey Researchers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (99, 5, 'Psychologists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (100, 5, 'Sociologists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (101, 5, 'Urban and Regional Planners');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (102, 5, 'Miscellaneous Social Scientists and Related Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (103, 5, 'Agricultural and Food Science Technicians');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (104, 5, 'Biological Technicians');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (105, 5, 'Chemical Technicians');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (106, 5, 'Environmental Science and Geoscience Technicians');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (107, 5, 'Nuclear Technicians');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (108, 5, 'Social Science Research Assistants');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (109, 5, 'Forest and Conservation Technicians');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (110, 5, 'Miscellaneous Life, Physical, and Social Science Technicians');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (111, 5, 'Occupational Health and Safety Specialists and Technicians');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (112, 6, 'Counselors');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (113, 6, 'Social Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (114, 6, 'Miscellaneous Community and Social Service Specialists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (115, 6, 'Clergy');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (116, 6, 'Directors, Religious Activities and Education');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (117, 6, 'Miscellaneous Religious Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (118, 7, 'Lawyers and Judicial Law Clerks');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (119, 7, 'Judges, Magistrates, and Other Judicial Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (120, 7, 'Paralegals and Legal Assistants');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (121, 7, 'Miscellaneous Legal Support Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (122, 8, 'Business Teachers, Postsecondary');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (123, 8, 'Math and Computer Science Teachers, Postsecondary');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (124, 8, 'Engineering and Architecture Teachers, Postsecondary');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (125, 8, 'Life Sciences Teachers, Postsecondary');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (126, 8, 'Physical Sciences Teachers, Postsecondary');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (127, 8, 'Social Sciences Teachers, Postsecondary');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (128, 8, 'Health Teachers, Postsecondary');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (129, 8, 'Education and Library Science Teachers, Postsecondary');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (130, 8, 'Law, Criminal Justice, and Social Work Teachers, Postsecondary');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (131, 8, 'Arts, Communications, History, and Humanities Teachers, Postsecondary');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (132, 8, 'Miscellaneous Postsecondary Teachers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (133, 8, 'Preschool and Kindergarten Teachers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (134, 8, 'Elementary and Middle School Teachers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (135, 8, 'Secondary School Teachers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (136, 8, 'Special Education Teachers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (137, 8, 'Adult Basic Education, Adult Secondary Education, and English as a Second Language Instructors');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (138, 8, 'Self-Enrichment Teachers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (139, 8, 'Substitute Teachers, Short-Term');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (140, 8, 'Tutors');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (141, 8, 'Miscellaneous Teachers and Instructors');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (142, 8, 'Archivists, Curators, and Museum Technicians');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (143, 8, 'Librarians and Media Collections Specialists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (144, 8, 'Library Technicians');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (145, 8, 'Farm and Home Management Educators');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (146, 8, 'Instructional Coordinators');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (147, 8, 'Teaching Assistants');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (148, 8, 'Miscellaneous Educational Instruction and Library Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (149, 9, 'Artists and Related Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (150, 9, 'Designers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (151, 9, 'Actors, Producers, and Directors');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (152, 9, 'Athletes, Coaches, Umpires, and Related Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (153, 9, 'Dancers and Choreographers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (154, 9, 'Musicians, Singers, and Related Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (155, 9, 'Miscellaneous Entertainers and Performers, Sports and Related Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (156, 9, 'Broadcast Announcers and Radio Disc Jockeys');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (157, 9, 'News Analysts, Reporters and Journalists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (158, 9, 'Public Relations Specialists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (159, 9, 'Writers and Editors');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (160, 9, 'Miscellaneous Media and Communication Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (161, 9, 'Broadcast, Sound, and Lighting Technicians');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (162, 9, 'Photographers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (163, 9, 'Television, Video, and Film Camera Operators and Editors');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (164, 9, 'Miscellaneous Media and Communication Equipment Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (165, 10, 'Chiropractors');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (166, 10, 'Dentists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (167, 10, 'Dietitians and Nutritionists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (168, 10, 'Optometrists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (169, 10, 'Pharmacists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (170, 10, 'Physician Assistants');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (171, 10, 'Podiatrists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (172, 10, 'Therapists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (173, 10, 'Veterinarians');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (174, 10, 'Registered Nurses');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (175, 10, 'Nurse Anesthetists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (176, 10, 'Nurse Midwives');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (177, 10, 'Nurse Practitioners');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (178, 10, 'Audiologists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (179, 10, 'Physicians');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (180, 10, 'Surgeons');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (181, 10, 'Miscellaneous Healthcare Diagnosing or Treating Practitioners');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (182, 10, 'Clinical Laboratory Technologists and Technicians');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (183, 10, 'Diagnostic Related Technologists and Technicians');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (184, 10, 'Emergency Medical Technicians and Paramedics');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (185, 10, 'Health Practitioner Support Technologists and Technicians');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (186, 10, 'Licensed Practical and Licensed Vocational Nurses');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (187, 10, 'Medical Records Specialists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (188, 10, 'Opticians, Dispensing');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (189, 10, 'Miscellaneous Health Technologists and Technicians');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (190, 10, 'Health Information Technologists and Medical Registrars');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (191, 10, 'Miscellaneous Health Practitioners and Technical Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (192, 11, 'Home Health and Personal Care Aides');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (193, 11, 'Nursing Assistants, Orderlies, and Psychiatric Aides');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (194, 11, 'Occupational Therapy Assistants and Aides');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (195, 11, 'Physical Therapist Assistants and Aides');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (196, 11, 'Massage Therapists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (197, 11, 'Miscellaneous Healthcare Support ');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (198, 12, 'First-Line Supervisors of Law Enforcement Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (199, 12, 'First-Line Supervisors of Firefighting and Prevention Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (200, 12, 'Miscellaneous First-Line Supervisors, Protective Service Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (201, 12, 'Firefighters');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (202, 12, 'Fire Inspectors');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (203, 12, 'Bailiffs, Correctional Officers, and Jailers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (204, 12, 'Detectives and Criminal Investigators');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (205, 12, 'Fish and Game Wardens');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (206, 12, 'Parking Enforcement Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (207, 12, 'Police Officers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (208, 12, 'Animal Control Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (209, 12, 'Private Detectives and Investigators');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (210, 12, 'Security Guards and Gambling Surveillance Officers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (211, 12, 'Miscellaneous Protective Service Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (212, 13, 'Supervisors of Food Preparation and Serving Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (213, 13, 'Cooks');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (214, 13, 'Food Preparation Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (215, 13, 'Bartenders');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (216, 13, 'Fast Food and Counter Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (217, 13, 'Waiters and Waitresses');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (218, 13, 'Food Servers, Nonrestaurant');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (219, 13, 'Dining Room and Cafeteria Attendants and Bartender Helpers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (220, 13, 'Dishwashers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (221, 13, 'Hosts and Hostesses, Restaurant, Lounge, and Coffee Shop');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (222, 13, 'Miscellaneous Food Preparation and Serving Related Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (223, 14, 'First-Line Supervisors of Building and Grounds Cleaning and Maintenance Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (224, 14, 'Building Cleaning Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (225, 14, 'Pest Control Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (226, 14, 'Grounds Maintenance Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (227, 15, 'First-Line Supervisors of Entertainment and Recreation Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (228, 15, 'First-Line Supervisors of Personal Service Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (229, 15, 'Animal Trainers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (230, 15, 'Animal Caretakers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (231, 15, 'Gambling Services Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (232, 15, 'Motion Picture Projectionists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (233, 15, 'Ushers, Lobby Attendants, and Ticket Takers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (234, 15, 'Miscellaneous Entertainment Attendants and Related Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (235, 15, 'Embalmers and Crematory Operators');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (236, 15, 'Funeral Attendants');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (237, 15, 'Morticians, Undertakers, and Funeral Arrangers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (238, 15, 'Barbers, Hairdressers, Hairstylists and Cosmetologists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (239, 15, 'Miscellaneous Personal Appearance Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (240, 15, 'Baggage Porters, Bellhops, and Concierges');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (241, 15, 'Tour and Travel Guides');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (242, 15, 'Childcare Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (243, 15, 'Recreation and Fitness Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (244, 15, 'Residential Advisors');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (245, 15, 'Miscellaneous Personal Care and Service Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (246, 16, 'First-Line Supervisors of Sales Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (247, 16, 'Cashiers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (248, 16, 'Counter and Rental Clerks and Parts Salespersons');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (249, 16, 'Retail Salespersons');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (250, 16, 'Advertising Sales Agents');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (251, 16, 'Insurance Sales Agents');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (252, 16, 'Securities, Commodities, and Financial Services Sales Agents');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (253, 16, 'Travel Agents');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (254, 16, 'Miscellaneous Sales Representatives, Services');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (255, 16, 'Sales Representatives, Wholesale and Manufacturing');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (256, 16, 'Models, Demonstrators, and Product Promoters');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (257, 16, 'Real Estate Brokers and Sales Agents');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (258, 16, 'Sales Engineers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (259, 16, 'Telemarketers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (260, 16, 'Miscellaneous Sales and Related Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (261, 17, 'First-Line Supervisors of Office and Administrative Support Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (262, 17, 'Switchboard Operators, Including Answering Service');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (263, 17, 'Telephone Operators');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (264, 17, 'Miscellaneous Communications Equipment Operators');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (265, 17, 'Bill and Account Collectors');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (266, 17, 'Billing and Posting Clerks');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (267, 17, 'Bookkeeping, Accounting, and Auditing Clerks');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (268, 17, 'Gambling Cage Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (269, 17, 'Payroll and Timekeeping Clerks');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (270, 17, 'Procurement Clerks');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (271, 17, 'Tellers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (272, 17, 'Miscellaneous Financial Clerks');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (273, 17, 'Brokerage Clerks');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (274, 17, 'Correspondence Clerks');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (275, 17, 'Court, Municipal, and License Clerks');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (276, 17, 'Credit Authorizers, Checkers, and Clerks');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (277, 17, 'Customer Service Representatives');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (278, 17, 'Eligibility Interviewers, Government Programs');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (279, 17, 'File Clerks');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (280, 17, 'Hotel, Motel, and Resort Desk Clerks');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (281, 17, 'Interviewers, Except Eligibility and Loan');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (282, 17, 'Library Assistants, Clerical');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (283, 17, 'Loan Interviewers and Clerks');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (284, 17, 'New Accounts Clerks');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (285, 17, 'Order Clerks');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (286, 17, 'Human Resources Assistants, Except Payroll and Timekeeping');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (287, 17, 'Receptionists and Information Clerks');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (288, 17, 'Reservation and Transportation Ticket Agents and Travel Clerks');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (289, 17, 'Miscellaneous Information and Record Clerks');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (290, 17, 'Cargo and Freight Agents');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (291, 17, 'Couriers and Messengers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (292, 17, 'Dispatchers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (293, 17, 'Meter Readers, Utilities');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (294, 17, 'Postal Service Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (295, 17, 'Production, Planning, and Expediting Clerks');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (296, 17, 'Shipping, Receiving, and Inventory Clerks');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (297, 17, 'Weighers, Measurers, Checkers, and Samplers, Recordkeeping');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (298, 17, 'Secretaries and Administrative Assistants');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (299, 17, 'Data Entry and Information Processing Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (300, 17, 'Desktop Publishers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (301, 17, 'Insurance Claims and Policy Processing Clerks');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (302, 17, 'Mail Clerks and Mail Machine Operators, Except Postal Service');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (303, 17, 'Office Clerks, General');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (304, 17, 'Office Machine Operators, Except Computer');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (305, 17, 'Proofreaders and Copy Markers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (306, 17, 'Statistical Assistants');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (307, 17, 'Miscellaneous Office and Administrative Support Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (308, 18, 'First-Line Supervisors of Farming, Fishing, and Forestry Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (309, 18, 'Agricultural Inspectors');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (310, 18, 'Animal Breeders');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (311, 18, 'Graders and Sorters, Agricultural Products');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (312, 18, 'Miscellaneous Agricultural Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (313, 18, 'Fishing and Hunting Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (314, 18, 'Forest and Conservation Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (315, 18, 'Logging Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (316, 19, 'First-Line Supervisors of Construction Trades and Extraction Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (317, 19, 'Boilermakers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (318, 19, 'Brickmasons, Blockmasons, and Stonemasons');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (319, 19, 'Carpenters');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (320, 19, 'Carpet, Floor, and Tile Installers and Finishers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (321, 19, 'Cement Masons, Concrete Finishers, and Terrazzo Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (322, 19, 'Construction Laborers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (323, 19, 'Construction Equipment Operators');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (324, 19, 'Drywall Installers, Ceiling Tile Installers, and Tapers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (325, 19, 'Electricians');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (326, 19, 'Glaziers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (327, 19, 'Insulation Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (328, 19, 'Painters and Paperhangers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (329, 19, 'Pipelayers, Plumbers, Pipefitters, and Steamfitters');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (330, 19, 'Plasterers and Stucco Masons');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (331, 19, 'Reinforcing Iron and Rebar Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (332, 19, 'Roofers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (333, 19, 'Sheet Metal Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (334, 19, 'Structural Iron and Steel Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (335, 19, 'Solar Photovoltaic Installers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (336, 19, 'Helpers, Construction Trades');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (337, 19, 'Construction and Building Inspectors');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (338, 19, 'Elevator and Escalator Installers and Repairers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (339, 19, 'Fence Erectors');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (340, 19, 'Hazardous Materials Removal Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (341, 19, 'Highway Maintenance Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (342, 19, 'Rail-Track Laying and Maintenance Equipment Operators');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (343, 19, 'Septic Tank Servicers and Sewer Pipe Cleaners');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (344, 19, 'Miscellaneous Construction and Related Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (345, 19, 'Derrick, Rotary Drill, and Service Unit Operators, Oil and Gas');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (346, 19, 'Surface Mining Machine Operators and Earth Drillers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (347, 19, 'Explosives Workers, Ordnance Handling Experts, and Blasters');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (348, 19, 'Underground Mining Machine Operators');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (349, 19, 'Rock Splitters, Quarry');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (350, 19, 'Roustabouts, Oil and Gas');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (351, 19, 'Helpers--Extraction Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (352, 19, 'Miscellaneous Extraction Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (353, 20, 'First-Line Supervisors of Mechanics, Installers, and Repairers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (354, 20, 'Computer, Automated Teller, and Office Machine Repairers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (355, 20, 'Radio and Telecommunications Equipment Installers and Repairers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (356, 20, 'Miscellaneous Electrical and Electronic Equipment Mechanics, Installers, and Repairers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (357, 20, 'Aircraft Mechanics and Service Technicians');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (358, 20, 'Automotive Technicians and Repairers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (359, 20, 'Bus and Truck Mechanics and Diesel Engine Specialists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (360, 20, 'Heavy Vehicle and Mobile Equipment Service Technicians and Mechanics');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (361, 20, 'Small Engine Mechanics');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (362, 20, 'Miscellaneous Vehicle and Mobile Equipment Mechanics, Installers, and Repairers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (363, 20, 'Control and Valve Installers and Repairers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (364, 20, 'Heating, Air Conditioning, and Refrigeration Mechanics and Installers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (365, 20, 'Home Appliance Repairers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (366, 20, 'Industrial Machinery Installation, Repair, and Maintenance Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (367, 20, 'Line Installers and Repairers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (368, 20, 'Precision Instrument and Equipment Repairers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (369, 20, 'Maintenance and Repair Workers, General');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (370, 20, 'Wind Turbine Service Technicians');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (371, 20, 'Miscellaneous Installation, Maintenance, and Repair Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (372, 21, 'First-Line Supervisors of Production and Operating Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (373, 21, 'Aircraft Structure, Surfaces, Rigging, and Systems Assemblers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (374, 21, 'Electrical, Electronics, and Electromechanical Assemblers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (375, 21, 'Engine and Other Machine Assemblers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (376, 21, 'Structural Metal Fabricators and Fitters');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (377, 21, 'Fiberglass Laminators and Fabricators');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (378, 21, 'Timing Device Assemblers and Adjusters');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (379, 21, 'Miscellaneous Assemblers and Fabricators');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (380, 21, 'Bakers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (381, 21, 'Butchers and Other Meat, Poultry, and Fish Processing Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (382, 21, 'Miscellaneous Food Processing Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (383, 21, 'Forming Machine Setters, Operators, and Tenders, Metal and Plastic');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (384, 21, 'Machine Tool Cutting Setters, Operators, and Tenders, Metal and Plastic');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (385, 21, 'Machinists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (386, 21, 'Metal Furnace Operators, Tenders, Pourers, and Casters');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (387, 21, 'Model Makers and Patternmakers, Metal and Plastic');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (388, 21, 'Molders and Molding Machine Setters, Operators, and Tenders, Metal and Plastic');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (389, 21, 'Multiple Machine Tool Setters, Operators, and Tenders, Metal and Plastic');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (390, 21, 'Tool and Die Makers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (391, 21, 'Welding, Soldering, and Brazing Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (392, 21, 'Miscellaneous Metal Workers and Plastic Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (393, 21, 'Printing Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (394, 21, 'Laundry and Dry-Cleaning Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (395, 21, 'Pressers, Textile, Garment, and Related Materials');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (396, 21, 'Sewing Machine Operators');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (397, 21, 'Shoe and Leather Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (398, 21, 'Tailors, Dressmakers, and Sewers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (399, 21, 'Textile Machine Setters, Operators, and Tenders');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (400, 21, 'Miscellaneous Textile, Apparel, and Furnishings Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (401, 21, 'Cabinetmakers and Bench Carpenters');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (402, 21, 'Furniture Finishers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (403, 21, 'Model Makers and Patternmakers, Wood');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (404, 21, 'Woodworking Machine Setters, Operators, and Tenders');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (405, 21, 'Miscellaneous Woodworkers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (406, 21, 'Power Plant Operators, Distributors, and Dispatchers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (407, 21, 'Stationary Engineers and Boiler Operators');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (408, 21, 'Water and Wastewater Treatment Plant and System Operators');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (409, 21, 'Miscellaneous Plant and System Operators');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (410, 21, 'Chemical Processing Machine Setters, Operators, and Tenders');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (411, 21, 'Crushing, Grinding, Polishing, Mixing, and Blending Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (412, 21, 'Cutting Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (413, 21, 'Extruding, Forming, Pressing, and Compacting Machine Setters, Operators, and Tenders');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (414, 21, 'Furnace, Kiln, Oven, Drier, and Kettle Operators and Tenders');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (415, 21, 'Inspectors, Testers, Sorters, Samplers, and Weighers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (416, 21, 'Jewelers and Precious Stone and Metal Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (417, 21, 'Dental and Ophthalmic Laboratory Technicians and Medical Appliance Technicians');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (418, 21, 'Packaging and Filling Machine Operators and Tenders');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (419, 21, 'Painting Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (420, 21, 'Semiconductor Processing Technicians');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (421, 21, 'Photographic Process Workers and Processing Machine Operators');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (422, 21, 'Computer Numerically Controlled Tool Operators and Programmers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (423, 21, 'Miscellaneous Production Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (424, 22, 'First-Line Supervisors of Transportation and Material Moving Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (425, 22, 'Aircraft Pilots and Flight Engineers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (426, 22, 'Air Traffic Controllers and Airfield Operations Specialists');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (427, 22, 'Flight Attendants');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (428, 22, 'Ambulance Drivers and Attendants, Except Emergency Medical Technicians');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (429, 22, 'Driver/Sales Workers and Truck Drivers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (430, 22, 'Passenger Vehicle Drivers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (431, 22, 'Miscellaneous Motor Vehicle Operators');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (432, 22, 'Locomotive Engineers and Operators');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (433, 22, 'Railroad Brake, Signal, and Switch Operators and Locomotive Firers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (434, 22, 'Railroad Conductors and Yardmasters');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (435, 22, 'Subway and Streetcar Operators');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (436, 22, 'Miscellaneous Rail Transportation Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (437, 22, 'Sailors and Marine Oilers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (438, 22, 'Ship and Boat Captains and Operators');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (439, 22, 'Ship Engineers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (440, 22, 'Bridge and Lock Tenders');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (441, 22, 'Parking Attendants');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (442, 22, 'Transportation Service Attendants');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (443, 22, 'Traffic Technicians');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (444, 22, 'Transportation Inspectors');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (445, 22, 'Passenger Attendants');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (446, 22, 'Miscellaneous Transportation Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (447, 22, 'Conveyor Operators and Tenders');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (448, 22, 'Crane and Tower Operators');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (449, 22, 'Dredge Operators');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (450, 22, 'Hoist and Winch Operators');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (451, 22, 'Industrial Truck and Tractor Operators');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (452, 22, 'Laborers and Material Movers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (453, 22, 'Pumping Station Operators');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (454, 22, 'Refuse and Recyclable Material Collectors');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (455, 22, 'Tank Car, Truck, and Ship Loaders');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (456, 22, 'Miscellaneous Material Moving Workers');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (457, 23, 'Military Officer Special and Tactical Operations Leaders');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (458, 23, 'First-Line Enlisted Military Supervisors');
INSERT INTO `Job` (`id`, `Sector_id`, `name`) VALUES (459, 23, 'Military Enlisted Tactical Operations and Air/Weapons Specialists and Crew Members');

COMMIT;

