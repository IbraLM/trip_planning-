<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
	</head>
	<body>
		<h2 style="text-align:center"> Login </h2>
		<c:if test="${empty sessionScope.Pseudo}">
                        <p>
                        <%
            String mes = (String) request.getAttribute("message");
                        if( mes != null && !mes.isEmpty())
                         out.println( mes);
            %>
                        </p>
			<p>Non Connecté</p>
        </c:if>
        <c:if test="${not empty sessionScope.Pseudo}">
        	<p> Connecté en tant que : ${ sessionScope.Pseudo}</p>
        </c:if>
		<form action="connexion" method="post">
			<center> 
		  		<div >
		    		<img src ="https://media1.giphy.com/media/d5Ea4WNLvEXI7sxl4v/giphy.gif" alt="" style="width:900px;height:300px">
		  		</div>
		<!-- https://cdn3.iconfinder.com/data/icons/business-avatar-1/512/10_avatar-512.png -->
		  		<div>
		  			</br>
		    		<label for="pseudo"> <b> Pseudo</b></label>
		    		   <input type="text" placeholder="Enter Votre Pseudo" name="pseudo" required>
					</br>
		
				    <label for="psw"><b>  Mot de passe    </b></label>
		    		  <input type="password" placeholder="Enter Password" name="psw" required>
		     		</br>
		        
				    <button type="submit" style="background-color:green">Login</button>
				    <button type="button">Cancel</button>
				    
				    <label>
				     </br>    	
				      <input type="checkbox" checked="checked" name="remember"> se souvenir de moi
				    </label>
		 		</div>
		
		 		
		  	</center>
		</form>
	<span > <a href="/Gestion_De_soiree/deconnexion">Déconnexion</a></span>
	<span > <a href="/Gestion_De_soiree/creeretudiant.jsp
	">S'inscrire</a></span>
	</body>
</html>
    