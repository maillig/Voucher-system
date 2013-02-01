SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `AO_project` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `AO_project` ;

-- -----------------------------------------------------
-- Table `AO_project`.`merchants`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `AO_project`.`merchants` (
  `merchant_ID` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NULL DEFAULT NULL ,
  `email` VARCHAR(90) NULL ,
  `adress` VARCHAR(50) NULL ,
  `city` VARCHAR(50) NULL ,
  PRIMARY KEY (`merchant_ID`) )
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `AO_project`.`games`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `AO_project`.`games` (
  `game_ID` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NOT NULL DEFAULT NULL ,
  `merchant_ID` INT(11) NOT NULL ,
  PRIMARY KEY (`game_ID`, `name`) ,
  INDEX `fk_games_merchants1` (`merchant_ID` ASC) ,
  CONSTRAINT `fk_games_merchants1`
    FOREIGN KEY (`merchant_ID` )
    REFERENCES `AO_project`.`merchants` (`merchant_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `AO_project`.`products`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `AO_project`.`products` (
  `product_ID` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NULL ,
  `code` VARCHAR(30) NULL ,
  `price` VARCHAR(50) NULL ,
  `merchant_ID` INT(11) NOT NULL ,
  PRIMARY KEY (`product_ID`) ,
  INDEX `fk_products_merchants1` (`merchant_ID` ASC) ,
  CONSTRAINT `fk_products_merchants1`
    FOREIGN KEY (`merchant_ID` )
    REFERENCES `AO_project`.`merchants` (`merchant_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AO_project`.`deals`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `AO_project`.`deals` (
  `deal_ID` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NOT NULL ,
  `product_ID` INT NOT NULL ,
  PRIMARY KEY (`deal_ID`) ,
  INDEX `fk_deals_products1` (`product_ID` ASC) ,
  CONSTRAINT `fk_deals_products1`
    FOREIGN KEY (`product_ID` )
    REFERENCES `AO_project`.`products` (`product_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `AO_project`.`users`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `AO_project`.`users` (
  `user_ID` INT(11) NOT NULL AUTO_INCREMENT ,
  `username` VARCHAR(50) NOT NULL ,
  `password` VARCHAR(50) NOT NULL ,
  `email` VARCHAR(90) NULL ,
  `address` VARCHAR(50) NULL ,
  `city` VARCHAR(50) NULL ,
  `user_level` INT NULL ,
  PRIMARY KEY (`user_ID`) ,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `AO_project`.`vouchers`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `AO_project`.`vouchers` (
  `voucher_ID` INT(11) NOT NULL AUTO_INCREMENT ,
  `voucher_code` VARCHAR(30) NULL DEFAULT NULL ,
  `date_added` DATE NULL DEFAULT NULL ,
  `date_expired` DATE NULL DEFAULT NULL ,
  `deal_ID` INT(11) NOT NULL ,
  `game_ID` INT(11) NOT NULL ,
  `user_ID` INT(11) NOT NULL ,
  PRIMARY KEY (`voucher_ID`) ,
  INDEX `fk_vouchers_deals1` (`deal_ID` ASC) ,
  INDEX `fk_vouchers_games1` (`game_ID` ASC) ,
  INDEX `fk_vouchers_users1` (`user_ID` ASC) ,
  CONSTRAINT `fk_vouchers_deals1`
    FOREIGN KEY (`deal_ID` )
    REFERENCES `AO_project`.`deals` (`deal_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vouchers_games1`
    FOREIGN KEY (`game_ID` )
    REFERENCES `AO_project`.`games` (`game_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vouchers_users1`
    FOREIGN KEY (`user_ID` )
    REFERENCES `AO_project`.`users` (`user_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 12
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `AO_project`.`mashed_games`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `AO_project`.`mashed_games` (
  `deal_ID` INT(11) NOT NULL ,
  `game_ID` INT(11) NOT NULL ,
  `user_ID` INT(11) NOT NULL ,
  PRIMARY KEY (`deal_ID`, `game_ID`, `user_ID`) ,
  INDEX `fk_deals_has_games_games1` (`game_ID` ASC) ,
  INDEX `fk_deals_has_games_deals1` (`deal_ID` ASC) ,
  INDEX `fk_deals_has_games_users1` (`user_ID` ASC) ,
  CONSTRAINT `fk_deals_has_games_deals1`
    FOREIGN KEY (`deal_ID` )
    REFERENCES `AO_project`.`deals` (`deal_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_deals_has_games_games1`
    FOREIGN KEY (`game_ID` )
    REFERENCES `AO_project`.`games` (`game_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_deals_has_games_users1`
    FOREIGN KEY (`user_ID` )
    REFERENCES `AO_project`.`users` (`user_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
