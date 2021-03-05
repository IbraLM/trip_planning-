-- ==================================
-- Peuplement des étudiants
-- ==================================

insert into ETUDIANT(NOM_ETUDIANT,PRENOM_ETUDIANT,TELEPHONE,MAIL) values
	('Belkebir','Omar','0625765472','obelkebir@gad.ma'),
	('Blard','Raphaël','0692456291','rblard@joker.re'),
	('Lebdaoui','Selmane','0725364950','slebdaoui@super.ma'),
	('Lmourid','Ibrahim','0746279402','ilmourid@ibra.ma'),
	('Burroughs','Sylvain','0714567864','sburroughs@nemo.uk'),
	('Tesi','Eric','0639251019','etesi@the.fr'),
	('Wong-Fang','Anette','0639475328','awf@que.en'),
	('Tyenn','Mary','0732195113','marty@rick.as'),
	('Knaven','Anne','0677880077','aknaven@u-bordeaux.fr'),
	('Dabrowski','Pieris','0722460751','thebroski@notik.la'),
	('Dorrid','Marine','0602471029','miradorr@hi.fi'),
	('Lonavem','Lisa','0682316203','lysl@maca.br');

-- ==================================
-- Peuplement des zones
-- ==================================

insert into ZONE(NOM_ZONE) values
	('Campus de Talence'),
	('Quartier de Victoire'),
	('Centre-ville'),
	('Bordeaux-Lac'),
	('Nansouty-Sud'),
	('La Bastide'),
	('Saint-Michel');

-- ==================================
-- Peuplement des lieux
-- ==================================

insert into LIEU(NOM_LIEU,ADRESSE_LIEU,NUMERO_ZONE) values
	('ENSEIRB','1 rue du Docteur Albert Schweitzer',1),
	('L\'Ours Brun','11 place de la Victoire',2),
	('Hôtel de Ville','Palais Rohan place Pey-Berland',3),
	('C. Commercial Saint-Christophe','17 rue des Embruns',3),
	('Burger Bar','68 rue du Pays Gourmet',2),
	('Workspace Comfoon','53 Place Jules Ferry',4),
	('Lion Bleu','Place Stalingrad',6),
	('Flèche de Saint-Michel','Place Meynard',7),
	('Gare Saint-Jean','Rue Charles Domercq',5),
	('L\'étoile gastronomique','42 avenue Stéphane David',3),
	('Cinéma de France','3 rue Montesquieu',3),
	('Bibliothèque des Lumières','7 cours de la République',7),
	('Edward Steel','2 place Alcana de Hénarès',1);

-- ==================================
-- Peuplement des évènements
-- ==================================

insert into EVENEMENT(NOM_EVENEMENT) values
	('Examens'),
	('Soirée inexistante'),
	('Burger time'),
	('Cinéma 20h'),
	('Fête diplôme'),
	('Sortie Bouquin\'eirb'),
	('RDV Planning Examens'),
	('Découverte Rive Droite'),
	('Dîner de famille'),
	('Planning JDR'),
	('Sortie réalité virtuelle');

-- ==================================
-- Peuplement des trajets
-- ==================================

insert into TRAJET(DATE_DEPART, HEURE_DEPART,NUMERO_CREATEUR,NUMERO_EVENEMENT, LIEU_DEPART, LIEU_ARRIVEE) values
	('2020-12-09','13:00:00',2,1,3,1),
	('2021-01-01','00:00:00',1,2,1,2),
	('2021-01-01','05:30:40',2,NULL,2,1),
	('2021-02-07','07:08:09',3,NULL,3,2),
	('2022-04-04','05:40:37',4,NULL,4,2),
	('2021-02-06','19:30:00',5,3,1,5),
	('2020-12-25','18:20:00',7,NULL,9,13),
	('2021-05-22','19:00:00',8,4,3,11),
	('2021-11-28','14:10:00',5,7,1,5),
	('2022-09-20','20:00:00',10,5,13,10),
	('2024-09-10','16:00:00',11,6,1,12),
	('2021-03-06','13:00:00',2,11,7,4),
	('2020-05-07','20:00:00',2,10,5,2);

-- ==================================
-- Peuplement des inscriptions
-- ==================================

insert into INSCRIPTION values
	(1,1,true),
	(2,1,true),
	(3,1,true),
	(4,1,true),
	(1,2,true),
	(3,2,true),
	(4,2,true),
	-- Notons qu'aucun des trajets de 3 à 5 ne voit son créateur inscrit.
	-- Le trigger devrait pouvoir permettre de le corriger, s'il fonctionnait.
	(5,6,true),
	(2,6,true),
	(6,5,true),
	(3,8,true),
	(12,8,true),
	(8,8,true),
	(7,7,true),
	(10,7,true),
	(5,9,true),
	(9,9,true),
	(2,9,true),
	(10,10,true),
	(1,10,true),
	(3,10,true),
	(8,10,true),
	(7,10,true),
	(6,10,true),
	(9,11,true),
	(12,11,false),
	(11,11,true),
	(6,12,true),
	(9,12,true),
	(4,12,true),
	(2,12,true),
	(2,13,true),
	(9,13,true),
	(12,13,true),
	(10,13,true);

-- ==================================
-- Peuplement des messages
-- ==================================

insert into MESSAGE(CONTENU_MESSAGE,NUMERO_AUTEUR, NUMERO_TRAJET) values
	('Salut, tout le monde est bon ?',2,1),
	('On est prets',1,1),
	('Bonjour, moi',5,6),
	('Oh ben tiens',2,6),
	('Situation curieuse',5,6),
	('Tu l\'as dit',2,6),
	('Bon je suis là ça va',5,6),
	('...attends quoi',2,6),
	('Salut, Lisa c\'est quoi le film déjà',3,8),
	('Lisa est pas co je sais pas si elle vient',8,8),
	('Elle doit déjà être là bas en fait',3,8),
	('Oui et je vous attends',12,8),
	('Bonjour...où est le point de rendez-vous ?',9,9),
	('ENSEIRB, station Arts et Métiers',5,9),
	('Merci ! J\'arrive !',9,9),
	('Sérieux Sylvain t\'aurais pu choisir plus près par contre',2,9),
	(':)))))))',5,9),
	('Euh, on est...deux ?',11,11),
	('Apparemment...',9,11),
	('Bon, pas grave...',11,11),
	('Pourquoi le centre commercial du coup ?',4,12),
	('Oh mais tu verras',2,12),
	('Ca m\'a l\'air un peu bizarre',6,12),
	('Si si te jure',2,12),
	('Je crois voir de quoi tu parles.',9,12),
	('Bonjour !',2,13),
	('Je suis déjà sur place perso',10,13),
	('Tiens donc ?',12,13),
	('Ouais j\'ai pris une table',10,13),
	('Parfait !',2,13);


-- ==================================
-- Peuplement des commentaires
-- ==================================

insert into COMMENTAIRE(CONTENU_COMMENTAIRE,NUMERO_AUTEUR,NUMERO_CONCERNE,NUMERO_TRAJET) values
	('EZ',2,NULL,1),
	('Merci',3,1,2),
	('...il s\'est passé quoi ?!',2,5,6),
	('Deal with it',5,2,6),
	('Vraiment super',3,NULL,8),
	('Super choix',8,12,8),
	('J\'ai déjà vu mieux.',12,NULL,8),
	('Questions révisions zéro...mais on a bien ri sur le trajet.',2,5,9),
	('Tuuuu vooooooiiiis',5,2,9),
	('Tellement facile de se perdre, pas qu\'on s\'en plaigne.',11,NULL,11),
	('Un merveilleux endroit !',9,NULL,11),
	('Incroyable ! Merci pour la découverte !',6,2,12),
	('On aura vu mieux pour l\'opti, haha désolé',2,NULL,13),
	('On prévoiera à l\'avance la prochaine fois',10,NULl,13);
-- ==================================
-- Peuplement des évaluations
-- ==================================

insert into EVALUATION(NUMERO_COMMENTAIRE,NOTE) values
	(1,5),
	(2,4),
	(4,5),
	(5,5),
	(6,4),
	(7,2),
	(8,5),
	(9,5),
	(11,5),
	(12,4),
	(14,4),
	(13,3);
