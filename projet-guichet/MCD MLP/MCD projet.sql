-- ----------------------------------------------------------
-- Script MYSQL pour mcd 
-- ----------------------------------------------------------


-- ----------------------------
-- Table: guichets
-- ----------------------------
CREATE TABLE guichets (
  id_guichet AUTO_INCREMENT NOT NULL,
  libeller_guichet VARCHAR(50) NOT NULL,
  CONSTRAINT guichets_PK PRIMARY KEY (id_guichet)
)ENGINE=InnoDB;


-- ----------------------------
-- Table: utlisateurs
-- ----------------------------
CREATE TABLE utlisateurs (
  id_utllisateur AUTO_INCREMENT NOT NULL,
  nom VARCHAR(50) NOT NULL,
  prenom VARCHAR(50) NOT NULL,
  creat_at DATETIME NOT NULL,
  id_guichet INT NOT NULL,
  CONSTRAINT utlisateurs_PK PRIMARY KEY (id_utllisateur),
  CONSTRAINT utlisateurs_id_guichet_FK FOREIGN KEY (id_guichet) REFERENCES guichets (id_guichet)
)ENGINE=InnoDB;