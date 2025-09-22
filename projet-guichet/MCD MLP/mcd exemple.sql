-- ----------------------------------------------------------
-- Script MYSQL pour mcd 
-- ----------------------------------------------------------


-- ----------------------------
-- Table: clients
-- ----------------------------
CREATE TABLE clients (
  id_client INT NOT NULL,
  nom_client VARCHAR(50) NOT NULL,
  prenom_client VARCHAR(50) NOT NULL,
  adresse_client VARCHAR(50) NOT NULL,
  telephone_client VARCHAR(50) NOT NULL,
  email_client VARCHAR(50) NOT NULL,
  CONSTRAINT clients_PK PRIMARY KEY (id_client),
  CONSTRAINT id_client_UNQ UNIQUE (id_client)
)ENGINE=InnoDB;


-- ----------------------------
-- Table: mode_paiement
-- ----------------------------
CREATE TABLE mode_paiement (
  id_mode_paiement INT NOT NULL,
  libelle_mode_paiement VARCHAR(50) NOT NULL,
  CONSTRAINT mode_paiement_PK PRIMARY KEY (id_mode_paiement)
)ENGINE=InnoDB;


-- ----------------------------
-- Table: categorie_produit
-- ----------------------------
CREATE TABLE categorie_produit (
  id_categorie INT NOT NULL,
  lebelle_categorie VARCHAR(500) NOT NULL,
  CONSTRAINT categorie_produit_PK PRIMARY KEY (id_categorie)
)ENGINE=InnoDB;


-- ----------------------------
-- Table: Paniers
-- ----------------------------
CREATE TABLE Paniers (
  id_panier INT NOT NULL,
  CONSTRAINT Paniers_PK PRIMARY KEY (id_panier)
)ENGINE=InnoDB;


-- ----------------------------
-- Table: produits
-- ----------------------------
CREATE TABLE produits (
  id_produit INT NOT NULL,
  nom_produit VARCHAR(50) NOT NULL,
  description_produit VARCHAR(500) NOT NULL,
  qte_stock_produit INT NOT NULL,
  prix_produit DECIMAL(10,2) NOT NULL,
  id_categorie INT NOT NULL,
  CONSTRAINT produits_PK PRIMARY KEY (id_produit),
  CONSTRAINT produits_id_categorie_FK FOREIGN KEY (id_categorie) REFERENCES categorie_produit (id_categorie)
)ENGINE=InnoDB;


-- ----------------------------
-- Table: commandes
-- ----------------------------
CREATE TABLE commandes (
  id_commande INT NOT NULL,
  libelle_commande VARCHAR(50) NOT NULL,
  date_commande TIME NOT NULL,
  id_client INT NOT NULL,
  CONSTRAINT commandes_PK PRIMARY KEY (id_commande),
  CONSTRAINT id_commande_UNQ UNIQUE (id_commande),
  CONSTRAINT id_client_UNQ UNIQUE (id_client),
  CONSTRAINT commandes_id_client_FK FOREIGN KEY (id_client) REFERENCES clients (id_client)
)ENGINE=InnoDB;


-- ----------------------------
-- Table: ajouter
-- ----------------------------
CREATE TABLE ajouter (
  id_panier INT NOT NULL,
  id_client INT NOT NULL,
  CONSTRAINT ajouter_PK PRIMARY KEY (id_panier, id_client),
  CONSTRAINT id_client_UNQ UNIQUE (id_client),
  CONSTRAINT ajouter_id_panier_FK FOREIGN KEY (id_panier) REFERENCES Paniers (id_panier),
  CONSTRAINT ajouter_id_client_FK FOREIGN KEY (id_client) REFERENCES clients (id_client)
)ENGINE=InnoDB;


-- ----------------------------
-- Table: posseder
-- ----------------------------
CREATE TABLE posseder (
  id_mode_paiement INT NOT NULL,
  id_commande INT NOT NULL,
  CONSTRAINT posseder_PK PRIMARY KEY (id_mode_paiement, id_commande),
  CONSTRAINT id_commande_UNQ UNIQUE (id_commande),

/******************************************************************************************************
*                                                                                                     *
*      -->    Désolé, il faut activer cette version pour voir la suite du script !                    *
*                                                                                                     *
*******************************************************************************************************/