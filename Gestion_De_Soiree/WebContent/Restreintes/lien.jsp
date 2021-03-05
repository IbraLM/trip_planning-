<%@ page language="java" contentType="text/html"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
 <head>
	<meta charset="ISO-8859-1">
	<title>Gestion de soirée</title>
    <style>
    .list-type5{
width:410px;
margin:0 auto;
}
.list-type5 ol {
list-style-type: none;
list-style-type: decimal !ie; /*IE 7- hack*/
margin: 0;
margin-left: 1em;
padding: 0;
counter-reset: li-counter;
}
.list-type5 ol li{
position: relative;
margin-bottom: 1.5em;
padding: 0.5em;
background-color: #F0D756;
padding-left: 58px;
}

.list-type5 a{
text-decoration:none;
color:black;
font-size:15px;
font-family: 'Raleway', sans-serif;
}

.list-type5 li:hover{
box-shadow:inset -1em 0 #6CD6CC;
-webkit-transition: box-shadow 0.5s; /* For Safari 3.1 to 6.0 */
transition: box-shadow 0.5s;
}

.list-type5 ol li:before {
position: absolute;
top: -0.3em;
left: -0.5em;
width: 1.8em;
height: 1.2em;
font-size: 2em;
line-height: 1.2;
font-weight: bold;
text-align: center;
color: white;
background-color: #6CD6CC;
transform: rotate(-20deg);
-ms-transform: rotate(-20deg);
-webkit-transform: rotate(-20deg);
z-index: 99;
overflow: hidden;
content: counter(li-counter);
counter-increment: li-counter;
}
    
    </style>
 </head>
 <body>
 	<img 
    src="https://cdn.deguisetoi.fr/media/blog_left_content/fra/5d1e14bd89ba0_comment-organiser-une-soiree-a-theme-disco.jpg" 
    alt=""
    height="300px" 
    width="900px" />
 	<h1 style="text-align:center; background-color:powderblue;"> Bienvenue </h1>
 	<p style = "text-align:center" > Découvrez un service de gestion de soirées </p>
 	<div class="list-type5">
	<ol>
			<li>  <a href = "/Gestion_De_soiree/Restreintes/mesEvenements.jsp">Mes trajets</a> </li>
			<li> <a href = "/Gestion_De_soiree/Restreintes/evenementsPlannifie.jsp">Consultez tous les évenements programmées </a> </li>
			<li> <a href = "/Gestion_De_soiree/Restreintes/creerTrajet.jsp"> Créez votre trajet </a> </li>
			<li>  <a href = "/Gestion_De_soiree/Restreintes/sinscrire.jsp">s'inscrire à un trajet</a> </li>
			<li>  <a href = "/Gestion_De_soiree/Restreintes/choixDiscussTraj.jsp">Chat</a> </li>
			<li>  <a href = "/Gestion_De_soiree/Restreintes/creerCommentaire.jsp">Commenter et Evaluer</a> </li>
			<li>  <a href = "/Gestion_De_soiree/Restreintes/listeAuMoinsUnTrajet.jsp">Liste des paires d’étudiants qui ont fait au moins un trajet ensemble</a> </li>

	</ol>
	</div>
	
	
 </body>
</html>