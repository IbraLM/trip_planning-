-- Liste des trajets, par numéro, avec leur nombre de participants, et leur événement le cas échéant.
-- Le case provoque un problème par volonté d'auto-complétion du bash si utilisé dans l'interface terminal de MySQL mais la requête est correcte.

select NUMERO_TRAJET, DATE_DEPART, HEURE_DEPART, count(NUMERO_ETUDIANT) as NB_PARTICIPANTS,
	case
		when NOM_EVENEMENT is null then 'Aucun'
		else NOM_EVENEMENT
	end as NOM_EVENEMENT
	from (TRAJET left outer join INSCRIPTION using(NUMERO_TRAJET))
	left outer join EVENEMENT using(NUMERO_EVENEMENT)
	group by NUMERO_TRAJET;

-- Liste des zones avec leur nombre de lieux.
-- On notera qu'il est légal en MySQL de sélectionner une colonne non listée dans group by.

select NUMERO_ZONE, NOM_ZONE, count(NUMERO_LIEU) as NB_LIEUX
	from LIEU natural join ZONE
	group by NUMERO_ZONE;

-- Liste des étudiants avec le nombre de trajets effectués par eux et l'évaluation moyenne qu'ils donnent.

select NUMERO_ETUDIANT, NOM_ETUDIANT, PRENOM_ETUDIANT, count(distinct INSCRIPTION.NUMERO_TRAJET) as NB_TRAJETS_EFFECTUES, avg(NOTE)
	from ((ETUDIANT natural join INSCRIPTION) inner join COMMENTAIRE on ETUDIANT.NUMERO_ETUDIANT=COMMENTAIRE.NUMERO_AUTEUR) natural join EVALUATION
	group by INSCRIPTION.NUMERO_ETUDIANT;

-- Liste des zones avec le numéro et nom du lieu le plus utilisé dans des trajets, indifféremment comme arrivée ou départ.
-- Requêtes non fonctionnelles.

/*select NUMERO_ZONE, NOM_ZONE, NUMERO_LIEU as LIEU_PLUS_POPULAIRE, NOM_LIEU as NOM_LIEU_PLUS_POPULAIRE, count(NUMERO_LIEU)
	where NUMERO_LIEU in
	(select(NUMERO_LIEU, max(card) from
	(select count(NUMERO_LIEU) as card from
	(ZONE inner join LIEU using(NUMERO_ZONE)) inner join TRAJET on (NUMERO_LIEU=LIEU_DEPART or NUMERO_LIEU=LIEU_ARRIVEE) group by NUMERO_ZONE))
	group by NUMERO_ZONE;*/

/*select max(card) as NB_UTILS, NUMERO_ZONE, NUMERO_LIEU from
		(select count(NUMERO_LIEU) as card,NUMERO_ZONE, NUMERO_LIEU
			from (TRAJET inner join LIEU on (LIEU.NUMERO_LIEU=TRAJET.LIEU_DEPART or LIEU.NUMERO_LIEU=TRAJET.LIEU_ARRIVEE))
			inner join ZONE using(NUMERO_ZONE) group by NUMERO_LIEU) as T
		having max(card)=1 group by NUMERO_ZONE;*/
