<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title></title>
    </head>
    <body>
    	<h1 style="text-align:center; background-color:powderblue;">Gestion De Soiree</h1>
    	
        <%
        	String message = (String) request.getAttribute("message");
        	out.println(message);
        %>
      
    <a href = "/Gestion_De_Soiree/creerevenement.jsp">créer un évenement  </a> 
	<a href = "/Gestion_De_Soiree/sinscrire.jsp">s'inscrire à un évenement</a> <br>
	<a href = "/Gestion_De_Soiree/listeAuMoinsUnTrajet.jsp">Liste des paires d’étudiants qui ont fait au moins un trajet ensemble</a>   
    </body>
</html>