<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Consultation Trajets</title>
</head>
<body>
		<div>
		<form method="get" action="consultationTrajetZones">
	
		<h1 style="text-align:center; background-color:powderblue;">Consultation Trajets Entre deux Zones</h1>
				<fieldset>
				 <label for="depart"> Zone Trajet depart<span class="requis">*</span></label>
		  	   <input type="text" id="depart" name="depart" value="" size="13" maxlength="13" />
		  	   <br />
		  	   <label for="arrivee"> Zone Trajet d'arrivee<span class="requis">*</span></label>
		  	   <input type="text" id="arrivee" name="arrivee" value="" size="13" maxlength="13" />
		  	   <br />
		  	   <label for="dateTrajet"> Date du trajet [jj/mm/aaaa]<span class="requis">*</span></label>
		  	   <input type="text" id="dateTrajet" name="dateTrajet" value="" size="13" maxlength="13" />
		  	   <br />
		  	 </fieldset>
	  		<input type="submit" value="Valider"  />
		  	<input type="reset" value="Remettre à zéro" /> 		
		  </form>
	    </div>
		<a href = "/Gestion_De_Soiree/creerevenement.jsp">créer un évenement  </a> 
		<a href = "/Gestion_De_Soiree/sinscrire.jsp">s'inscrire à un évenement</a> <br>
		<a href = "/Gestion_De_Soiree/listeAuMoinsUnTrajet.jsp">Liste des paires d’étudiants qui ont fait au moins un trajet ensemble</a> 
</body>
</html>