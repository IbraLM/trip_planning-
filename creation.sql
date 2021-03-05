-- =================================================
-- Table : ETUDIANT
-- =================================================
create table if not exists ETUDIANT(
       NUMERO_ETUDIANT int not null  AUTO_INCREMENT,
       NOM_ETUDIANT    char(20)      ,
       PRENOM_ETUDIANT char(20)      ,
       TELEPHONE       char(20)      ,
       MAIL            char(100)     ,
       primary key (NUMERO_ETUDIANT)
);
-- =================================================
-- Table : TRAJET
-- =================================================
create table if not exists TRAJET(
       NUMERO_TRAJET int not null AUTO_INCREMENT,
       DATE_DEPART date	         ,
       HEURE_DEPART time	 ,
       NUMERO_CREATEUR int not null,
       NUMERO_EVENEMENT int,
       LIEU_DEPART int    not null,
       LIEU_ARRIVEE int    not null,
       primary key (NUMERO_TRAJET)
);

-- =================================================
-- Table : EVENEMENT
-- =================================================
create table if not exists EVENEMENT(
       NUMERO_EVENEMENT int not null AUTO_INCREMENT,
       NOM_EVENEMENT char(40)       ,
       primary key (NUMERO_EVENEMENT)
);

-- =================================================
-- Table : LIEU
-- =================================================
create table if not exists LIEU(
       NUMERO_LIEU int    not null AUTO_INCREMENT,
       NOM_LIEU	   char(30)       ,
       ADRESSE_LIEU char(100)     ,
       NUMERO_ZONE int not null,
       primary key (NUMERO_LIEU)

);


-- =================================================
-- Table : ZONE
-- =================================================
create table if not exists ZONE(
       NUMERO_ZONE int not null AUTO_INCREMENT,
       NOM_ZONE	 char(30) ,
       primary key (NUMERO_ZONE)
);

-- =================================================
-- Table : MESSAGE
-- =================================================
create table if not exists MESSAGE(
       NUMERO_MESSAGE int not null AUTO_INCREMENT,
       CONTENU_MESSAGE  char(255)  ,
       NUMERO_AUTEUR int not null  ,
       NUMERO_TRAJET int not null,
       primary key (NUMERO_MESSAGE)
);

-- =================================================
-- Table : COMMENTAIRE
-- =================================================
create table if not exists COMMENTAIRE(
       NUMERO_COMMENTAIRE int not null AUTO_INCREMENT,
       CONTENU_COMMENTAIRE char(255) ,
       NUMERO_AUTEUR int not null  ,
       NUMERO_CONCERNE int ,
       NUMERO_TRAJET int not null,
       primary key (NUMERO_COMMENTAIRE)
);


-- =================================================
-- Table : EVALUATION
-- =================================================
create table if not exists EVALUATION(
       NUMERO_EVALUATION int not null AUTO_INCREMENT,
       NUMERO_COMMENTAIRE int unique not null,
       NOTE int	,
       primary key (NUMERO_EVALUATION)
);

-- =================================================
-- Table : INSCRIPTION
-- =================================================

create table if not exists INSCRIPTION(
       NUMERO_ETUDIANT int not null,
       NUMERO_TRAJET int not null,
       ACTIVE boolean,
       primary key (NUMERO_ETUDIANT, NUMERO_TRAJET)
);

-- =================================================
-- Création des contraintes de clés étrangères
-- =================================================

alter table TRAJET
      add constraint fk_trajet_createur foreign key (NUMERO_CREATEUR)
      references ETUDIANT (NUMERO_ETUDIANT) on delete cascade;


alter table TRAJET
      add constraint fk_trajet_evenement foreign key (NUMERO_EVENEMENT)
      references  EVENEMENT (NUMERO_EVENEMENT) on delete cascade;


alter table TRAJET
      add constraint fk_trajet_depart foreign key (LIEU_DEPART)
      references LIEU (NUMERO_LIEU) on delete cascade;


alter table TRAJET
      add constraint fk_trajet_arrivee foreign key (LIEU_ARRIVEE)
      references LIEU  (NUMERO_LIEU) on delete cascade;


alter table LIEU
      add constraint fk_lieu_zone foreign key (NUMERO_ZONE)
      references ZONE (NUMERO_ZONE) on delete cascade;


alter table EVALUATION
      add constraint fk_evaluation_commentaire foreign key (NUMERO_COMMENTAIRE)
      references COMMENTAIRE (NUMERO_COMMENTAIRE) on delete cascade;


alter table INSCRIPTION
      add constraint fk_inscription_etudiant foreign key (NUMERO_ETUDIANT)
      references ETUDIANT (NUMERO_ETUDIANT) on delete cascade;

alter table INSCRIPTION
      add constraint fk_inscription_trajet foreign key (NUMERO_TRAJET)
      references TRAJET (NUMERO_TRAJET) on delete cascade;


  -- Lier Message et Commentaire à Trajet et Etudiant n'est pas nécessaire, grâce à Inscription !

alter table MESSAGE
  add constraint fk_message_inscription foreign key (NUMERO_AUTEUR,NUMERO_TRAJET)
  references INSCRIPTION (NUMERO_ETUDIANT,NUMERO_TRAJET) on delete cascade;


alter table COMMENTAIRE
  add constraint fk_commentaire_inscription_auteur foreign key (NUMERO_AUTEUR,NUMERO_TRAJET)
  references INSCRIPTION (NUMERO_ETUDIANT,NUMERO_TRAJET) on delete cascade;

alter table COMMENTAIRE
  add constraint fk_commentaire_inscription_concerne foreign key (NUMERO_CONCERNE,NUMERO_TRAJET)
  references INSCRIPTION (NUMERO_ETUDIANT,NUMERO_TRAJET) on delete cascade;

-- =================================================
-- Création des contraintes de domaine
-- =================================================

alter table EVALUATION
    add constraint note_range
    check (NOTE>=0 and NOTE<=5);

-- Inexplicablement, create ... as ne fonctionne pas.

/*alter table COMMENTAIRE
    add constraint inscription_valide_auteur
    create table T (ACTIVE boolean) as
        select ACTIVE
        from INSCRIPTION
        where (COMMENTAIRE.NUMERO_AUTEUR=INSCRIPTION.NUMERO_ETUDIANT
            and COMMENTAIRE.NUMERO_TRAJET=INSCRIPTION.NUMERO_TRAJET);
    check (T.ACTIVE=true);
    drop T;*/

-- Ni check avec un select.

/*alter table COMMENTAIRE
    add constraint inscription_valide_auteur
    check (select ACTIVE from INSCRIPTION where (COMMENTAIRE.NUMERO_CONCERNE=INSCRIPTION.NUMERO_ETUDIANT and COMMENTAIRE.NUMERO_TRAJET=INSCRIPTION.NUMERO_TRAJET);)=true;*/

-- =================================================
-- Création des triggers
-- =================================================

-- Ni la création de trigger.

/*delimiter $$
create or replace trigger inscrire_createur
    after insert
    on TRAJET
    begin
        insert into INSCRIPTION values (new.NUMERO_CREATEUR,new.NUMERO_TRAJET,true);
    end$$
delimiter ;*/

-- =================================================
-- Création d'une table spéciale dédiée à l'application
-- =================================================

create table NEW( PSEUDO char(20) not null, NUMERO_ETUDIANT int,
             PASS char(200) not null, primary key (PSEUDO));
alter table NEW
  add constraint foreign key (NUMERO_ETUDIANT)
  references ETUDIANT(NUMERO_ETUDIANT)on delete cascade;
create table DISCTRAJ(ID int not null,DATE date);
create table COMMTRAJ(ID int not null);
