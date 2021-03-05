<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Ecrire un Commentaire</title>

</head>
<body>
      <form method="get" action="creationEvenement">
      	<h1 style="text-align:center; background-color:powderblue;"> Ecrivez votre Commentaire </h1>
  		 <br />  
  		 <br /> 
  					 <label for="commentaire">Quel Trajet souhaitez vous commenter?<span class="requis">*</span></label>	    	
 				      <select name="comm" id="select">
					    <option value="">--choisissez un évenement--</option>
  						<option value="">xxxxxxx</option>
  						<option value="">xxxxxxx</option>
  						<option value="">xxxxxxx</option>
  					 </select>
  					 <br /> 
  					 <br />  
  					 <br />  
  					 <br /> 
  					  					
  					 
          <FORM>
			<TEXTAREA name="comment" rows=4 cols=40> Votre commentaire</TEXTAREA>
		</FORM>

    <input type="submit" value="Valider"  />
    <input type="reset" value="Remettre à zéro" /> <br />
				
  </form>
</body>
</html>