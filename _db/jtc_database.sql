-- MySQL Script generated by MySQL Workbench
-- 11/20/16 23:26:07
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema jtc_database
-- -----------------------------------------------------
-- Este é o banco de dados relativo ao software de gerenciamento de estoque da empresa de representação têxtil JTC. 
-- Data de Criação: 22/09/2016
-- Desenvolvedores: Liany B., Lucas B., Natasha H.

-- -----------------------------------------------------
-- Schema jtc_database
--
-- Este é o banco de dados relativo ao software de gerenciamento de estoque da empresa de representação têxtil JTC. 
-- Data de Criação: 22/09/2016
-- Desenvolvedores: Liany B., Lucas B., Natasha H.
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `jtc_database` DEFAULT CHARACTER SET utf8 ;
USE `jtc_database` ;

-- -----------------------------------------------------
-- Table `jtc_database`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jtc_database`.`users` ;

CREATE TABLE IF NOT EXISTS `jtc_database`.`users` (
  `id` TINYINT(2) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Este campo serve como identificador único para usuário.',
  `username` VARCHAR(20) NOT NULL COMMENT 'Este campo é destinado a armazenar o nome de usuário.',
  `password` CHAR(32) NOT NULL COMMENT 'Este campo é a armazenar a senha para o usuário.',
  `email` VARCHAR(100) NOT NULL COMMENT 'Este campo é destinado a armazanar o e-mail do usuário.',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  UNIQUE INDEX `e_mail_UNIQUE` (`email` ASC))
ENGINE = InnoDB
COMMENT = 'Esta tabela armazena todos os usuários do software.';


-- -----------------------------------------------------
-- Table `jtc_database`.`categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jtc_database`.`categories` ;

CREATE TABLE IF NOT EXISTS `jtc_database`.`categories` (
  `id` TINYINT(2) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de categorias.',
  `category` VARCHAR(45) NOT NULL COMMENT 'Tabela destinada a registrar as categorias do produtos.',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `category_UNIQUE` (`category` ASC))
ENGINE = InnoDB
COMMENT = 'Tabela destinada a registrar as categorias do produto.';


-- -----------------------------------------------------
-- Table `jtc_database`.`manufacturers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jtc_database`.`manufacturers` ;

CREATE TABLE IF NOT EXISTS `jtc_database`.`manufacturers` (
  `id` TINYINT(2) ZEROFILL UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de fabricante.',
  `name` VARCHAR(45) NOT NULL COMMENT 'Nome fantasia de fabricante.',
  `phone` BIGINT(20) UNSIGNED NOT NULL COMMENT 'Telefone de contato de fabricante.',
  `email` VARCHAR(100) NOT NULL COMMENT 'E-mail de contato de fabricante.',
  `cnpj` BIGINT(18) UNSIGNED ZEROFILL NOT NULL COMMENT 'CNPJ de fabricante.',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  UNIQUE INDEX `e_mail_UNIQUE` (`email` ASC),
  UNIQUE INDEX `cnpj_UNIQUE` (`cnpj` ASC))
ENGINE = InnoDB
COMMENT = 'Tabela que armazena os faricantes dos produtos.';


-- -----------------------------------------------------
-- Table `jtc_database`.`products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jtc_database`.`products` ;

CREATE TABLE IF NOT EXISTS `jtc_database`.`products` (
  `id` INT(3) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de produto.',
  `categories_id` TINYINT(2) UNSIGNED ZEROFILL NOT NULL COMMENT 'Categoria de produto.',
  `manufacturers_id` TINYINT(2) ZEROFILL UNSIGNED NOT NULL COMMENT 'Identificador de fabricante.',
  `code` INT(3) NOT NULL COMMENT 'Código de produto.',
  `model` VARCHAR(45) NOT NULL COMMENT 'Modelo de produto.',
  `sex` TINYINT(1) NOT NULL COMMENT 'Sexo do produto.',
  `price` DECIMAL(5,2) UNSIGNED NOT NULL COMMENT 'Preço de produto.',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC),
  INDEX `fk_products_categories1_idx` (`categories_id` ASC),
  INDEX `fk_products_manufacturers1_idx` (`manufacturers_id` ASC),
  CONSTRAINT `fk_products_categories1`
    FOREIGN KEY (`categories_id`)
    REFERENCES `jtc_database`.`categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_products_manufacturers1`
    FOREIGN KEY (`manufacturers_id`)
    REFERENCES `jtc_database`.`manufacturers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela que armazena os produtos.';


-- -----------------------------------------------------
-- Table `jtc_database`.`sizes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jtc_database`.`sizes` ;

CREATE TABLE IF NOT EXISTS `jtc_database`.`sizes` (
  `id` TINYINT(2) ZEROFILL UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para tamanho.',
  `size` VARCHAR(10) NOT NULL COMMENT 'Campo destinado a registrar o tamanho dos produtos.',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `size_UNIQUE` (`size` ASC))
ENGINE = InnoDB
COMMENT = 'Tabela destinada a armazenar o tamanho do produto.';


-- -----------------------------------------------------
-- Table `jtc_database`.`products_has_sizes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jtc_database`.`products_has_sizes` ;

CREATE TABLE IF NOT EXISTS `jtc_database`.`products_has_sizes` (
  `id` INT(3) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de produto com tamanho.',
  `products_id` INT(3) UNSIGNED ZEROFILL NOT NULL COMMENT 'Identificador de produto.',
  `sizes_id` TINYINT(2) ZEROFILL UNSIGNED NOT NULL COMMENT 'Identificador de tamanho.',
  PRIMARY KEY (`id`),
  INDEX `fk_products_has_sizes_sizes1_idx` (`sizes_id` ASC),
  INDEX `fk_products_has_sizes_products_idx` (`products_id` ASC),
  CONSTRAINT `fk_products_has_sizes_products`
    FOREIGN KEY (`products_id`)
    REFERENCES `jtc_database`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_products_has_sizes_sizes1`
    FOREIGN KEY (`sizes_id`)
    REFERENCES `jtc_database`.`sizes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela que vincula os produtos com os seus devidos tamanhos.';


-- -----------------------------------------------------
-- Table `jtc_database`.`inventories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jtc_database`.`inventories` ;

CREATE TABLE IF NOT EXISTS `jtc_database`.`inventories` (
  `id` INT(3) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Identificador único para estoque.',
  `products_has_sizes_id` INT(3) UNSIGNED ZEROFILL NOT NULL COMMENT 'Tamanho do produo que está no estoque.',
  `quantity` SMALLINT(4) UNSIGNED NOT NULL COMMENT 'Quantidade de produto por tamanho.',
  PRIMARY KEY (`id`),
  INDEX `fk_inventories_products_has_sizes1_idx` (`products_has_sizes_id` ASC),
  CONSTRAINT `fk_inventories_products_has_sizes1`
    FOREIGN KEY (`products_has_sizes_id`)
    REFERENCES `jtc_database`.`products_has_sizes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela destinada a armazenar a quantidade de cada produto por tamanho no estoque.';


-- -----------------------------------------------------
-- Table `jtc_database`.`states`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jtc_database`.`states` ;

CREATE TABLE IF NOT EXISTS `jtc_database`.`states` (
  `id` TINYINT(2) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de estado.',
  `name` VARCHAR(45) NOT NULL COMMENT 'Nome de estado.',
  `initials` CHAR(2) NOT NULL COMMENT 'Sigla, ou iniciais, de estado.',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  UNIQUE INDEX `initials_UNIQUE` (`initials` ASC))
ENGINE = InnoDB
COMMENT = 'Tabela que armazena os estados.';


-- -----------------------------------------------------
-- Table `jtc_database`.`cities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jtc_database`.`cities` ;

CREATE TABLE IF NOT EXISTS `jtc_database`.`cities` (
  `id` TINYINT(3) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de cidade.',
  `states_id` TINYINT(2) UNSIGNED ZEROFILL NOT NULL COMMENT 'Identificador de estado onde a cidade se localiza.',
  `name` VARCHAR(45) NOT NULL COMMENT 'Nome de cidade.',
  PRIMARY KEY (`id`),
  INDEX `fk_cities_states1_idx` (`states_id` ASC),
  CONSTRAINT `fk_cities_states1`
    FOREIGN KEY (`states_id`)
    REFERENCES `jtc_database`.`states` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela que armazena as cidades relativas aos estados.';


-- -----------------------------------------------------
-- Table `jtc_database`.`sellers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jtc_database`.`sellers` ;

CREATE TABLE IF NOT EXISTS `jtc_database`.`sellers` (
  `id` INT(3) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de vendedor.',
  `cities_id` TINYINT(3) UNSIGNED ZEROFILL NOT NULL COMMENT 'Identificador de cidade onde o vendedor atua.',
  `name` VARCHAR(45) NOT NULL COMMENT 'Nome do vendedor.',
  `email` VARCHAR(100) NOT NULL COMMENT 'E-mail de vendedor.',
  `phone` BIGINT(20) NOT NULL COMMENT 'Telefone de vendedor.',
  `birth_date` DATE NOT NULL COMMENT 'Data de nascimento do vendedor.',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `e_mail_UNIQUE` (`email` ASC),
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC),
  INDEX `fk_sellers_cities1_idx` (`cities_id` ASC),
  CONSTRAINT `fk_sellers_cities1`
    FOREIGN KEY (`cities_id`)
    REFERENCES `jtc_database`.`cities` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela que armazena os vededores.';


-- -----------------------------------------------------
-- Table `jtc_database`.`checks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jtc_database`.`checks` ;

CREATE TABLE IF NOT EXISTS `jtc_database`.`checks` (
  `id` INT(4) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de cheques.',
  `sellers_id` INT(3) UNSIGNED ZEROFILL NOT NULL COMMENT 'Identificador de vendedor relativo ao cheque.',
  `number` VARCHAR(30) NOT NULL COMMENT 'Número do cheque.',
  `value` DECIMAL(6,2) UNSIGNED NOT NULL COMMENT 'Valor contido no cheque.',
  `date_receipt` DATE NOT NULL COMMENT 'Data de recebimento do cheque.',
  `status` TINYINT(1) NOT NULL COMMENT 'Status do cheque. Se foi descontado, ou ocorreu falha no desconto.',
  `date_good_for` DATE NULL COMMENT 'Data boa para o desconto do cheque.',
  PRIMARY KEY (`id`),
  INDEX `fk_checks_sellers1_idx` (`sellers_id` ASC),
  CONSTRAINT `fk_checks_sellers1`
    FOREIGN KEY (`sellers_id`)
    REFERENCES `jtc_database`.`sellers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela que armazena os cheques relativos aos vendedores.';


-- -----------------------------------------------------
-- Table `jtc_database`.`entries`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jtc_database`.`entries` ;

CREATE TABLE IF NOT EXISTS `jtc_database`.`entries` (
  `id` INT(5) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de estrada.',
  `sellers_id` INT(3) UNSIGNED ZEROFILL NULL COMMENT 'Identificador único de vendedor, pode ser nulo pois só é usado em caso de devolução.',
  `date` DATE NOT NULL COMMENT 'Data de entrada.',
  `hour` TIME NOT NULL COMMENT 'Hora de entrada.',
  `type` CHAR(1) NOT NULL COMMENT 'Tipo de entrada [produto novo, devolução ou reposição].',
  PRIMARY KEY (`id`),
  INDEX `fk_entries_sellers1_idx` (`sellers_id` ASC),
  CONSTRAINT `fk_entries_sellers1`
    FOREIGN KEY (`sellers_id`)
    REFERENCES `jtc_database`.`sellers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela que armazena as entradas de produtos no estoque.';


-- -----------------------------------------------------
-- Table `jtc_database`.`removals`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jtc_database`.`removals` ;

CREATE TABLE IF NOT EXISTS `jtc_database`.`removals` (
  `id` INT(5) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de saída.',
  `sellers_id` INT(3) UNSIGNED ZEROFILL NULL COMMENT 'Identificador de vendedor que recebe os itens da saída. Esse campo pode ser nulo, pois o tipo de saída pode ser de reparo',
  `date` DATE NOT NULL COMMENT 'Data de saída.',
  `hour` TIME NOT NULL COMMENT 'Hora de saída.',
  `type` CHAR(1) NOT NULL COMMENT 'Tipo da saída.',
  PRIMARY KEY (`id`),
  INDEX `fk_outs_sellers1_idx` (`sellers_id` ASC),
  CONSTRAINT `fk_outs_sellers1`
    FOREIGN KEY (`sellers_id`)
    REFERENCES `jtc_database`.`sellers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela que armazena as saídas de produtos do estoque.';


-- -----------------------------------------------------
-- Table `jtc_database`.`removals_has_products_has_sizes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jtc_database`.`removals_has_products_has_sizes` ;

CREATE TABLE IF NOT EXISTS `jtc_database`.`removals_has_products_has_sizes` (
  `id` INT(5) ZEROFILL UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de saída que tem produtos com tamanhos.',
  `removals_id` INT(5) UNSIGNED ZEROFILL NOT NULL,
  `products_has_sizes_id` INT(3) UNSIGNED ZEROFILL NOT NULL COMMENT 'Identificador de produto com tamnho.',
  `quantity` SMALLINT(4) UNSIGNED NOT NULL COMMENT 'Quantidade de produtos contidos na saída.',
  INDEX `fk_outs_has_products_has_sizes_products_has_sizes1_idx` (`products_has_sizes_id` ASC),
  PRIMARY KEY (`id`),
  INDEX `fk_removals_has_products_has_sizes_removals1_idx` (`removals_id` ASC),
  CONSTRAINT `fk_outs_has_products_has_sizes_products_has_sizes1`
    FOREIGN KEY (`products_has_sizes_id`)
    REFERENCES `jtc_database`.`products_has_sizes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_removals_has_products_has_sizes_removals1`
    FOREIGN KEY (`removals_id`)
    REFERENCES `jtc_database`.`removals` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela que vincula os produtos de cada tamanho com as saídas do estoque.';


-- -----------------------------------------------------
-- Table `jtc_database`.`repairs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jtc_database`.`repairs` ;

CREATE TABLE IF NOT EXISTS `jtc_database`.`repairs` (
  `id` INT(5) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de saída reparo.',
  `removals_has_products_has_sizes_id` INT(5) ZEROFILL UNSIGNED NOT NULL COMMENT 'Identificador de saída que tem produtos com tamanhos.',
  `entries_id` INT(5) UNSIGNED ZEROFILL NULL COMMENT 'Identificador de entrada de produto.',
  `date` DATE NOT NULL COMMENT 'Data de saída de reparo.',
  `hour` TIME NOT NULL COMMENT 'Hora de saída de reparo.',
  `quantity` SMALLINT(4) UNSIGNED NOT NULL COMMENT 'Quantidade de produtos.',
  PRIMARY KEY (`id`),
  INDEX `fk_repairs_outs_has_products_has_sizes1_idx` (`removals_has_products_has_sizes_id` ASC),
  INDEX `fk_repairs_entries1_idx` (`entries_id` ASC),
  CONSTRAINT `fk_repairs_outs_has_products_has_sizes1`
    FOREIGN KEY (`removals_has_products_has_sizes_id`)
    REFERENCES `jtc_database`.`removals_has_products_has_sizes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_repairs_entries1`
    FOREIGN KEY (`entries_id`)
    REFERENCES `jtc_database`.`entries` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela que armazena as saída de produtos para reparo em seus respectivos fabricantes.';


-- -----------------------------------------------------
-- Table `jtc_database`.`entries_has_products_has_sizes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jtc_database`.`entries_has_products_has_sizes` ;

CREATE TABLE IF NOT EXISTS `jtc_database`.`entries_has_products_has_sizes` (
  `id` INT(5) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de entradas que tem produtos com tamanhos.',
  `entries_id` INT(5) UNSIGNED ZEROFILL NOT NULL COMMENT 'Identificador de entradas.',
  `products_has_sizes_id` INT(3) UNSIGNED ZEROFILL NOT NULL COMMENT 'Identificador de produtos com tamanhos.',
  `quantity` SMALLINT(4) UNSIGNED NOT NULL COMMENT 'Quantidade de produtos contidos na entrada.',
  PRIMARY KEY (`id`),
  INDEX `fk_entries_has_products_has_sizes_products_has_sizes1_idx` (`products_has_sizes_id` ASC),
  INDEX `fk_entries_has_products_has_sizes_entries1_idx` (`entries_id` ASC),
  CONSTRAINT `fk_entries_has_products_has_sizes_entries1`
    FOREIGN KEY (`entries_id`)
    REFERENCES `jtc_database`.`entries` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_entries_has_products_has_sizes_products_has_sizes1`
    FOREIGN KEY (`products_has_sizes_id`)
    REFERENCES `jtc_database`.`products_has_sizes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela que vincula os produtos de cada tamanho com as estradas no estoque.';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
