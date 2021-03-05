<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Ecrire un Commentaire</title>

</head>
<body>
      <form method="get" action="commentaire">
      <p> Si vous souhaitez écrire un commentaire sur un étudiant, tapez son Pseudo</p>
      <label for="pseudoConcerne"> Prénom du concerné </label>
       <input type="text" id="pseudoConcerne" name="pseudoConcerne" value="" size="13" maxlength="13" />
             <br />
                    
      	<h1 style="text-align:center; background-color:powderblue;"> Ecrivez votre Commentaire </h1>
		 
			<TEXTAREA name="commentaire" rows=4 cols=40></TEXTAREA>
			</br>
			</br>
			</br>
			<label for="eval">Evaluez</label>

<select name="eval" id="eval">
    <option></option>
    <option value="0">  - Non satisfait</option>
    <option value="1">* - Pas mal</option>
    <option value="2">* * - moyen</option>
    <option value="3">* * * - satisfait</option>
    <option value="4">* * * * - très satisfait</option>
    <option value="5">* * * * * - Excellent</option>
</select>
			</br>
			
			
	
    <input type="submit" value="Valider"  />
    <input type="reset" value="Remettre à zéro" /> <br />
				
  </form>
</body>
</html>