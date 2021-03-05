<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        
        <title>Création d'un étudiant</title>
    </head>
    <body>
        <div>
            <form method="get" action="creationEtudiant">
                <fieldset>
                    <br />
                    <br />
                	<h1 style="text-align:center; background-color:powderblue;"> Inscription </h1>
                    <legend>Informations Etudiant</legend>
                    
                    <label for="pseudo"> Pseudo <span class="requis">*</span></label>
                    <input type="text" id="pseudo" name="pseudo" value="" size="13" maxlength="13" />
                    <br />
                    
    
                    <label for="nomEtudiant">Nom </label>
                    <input type="text" id="nomEtudiant" name="nomEtudiant" value="" size="20" maxlength="20" />
                    <br />
                    
                    <label for="prenomEtudiant">Prénom </label>
                    <input type="text" id="prenomEtudiant" name="prenomEtudiant" value="" size="20" maxlength="20" />
                    <br />
                    
                    
                    <label for="telephoneEtudiant">Numéro de téléphone </label>
                    <input type="text" id="telephoneEtudiant" name="telephoneEtudiant" value="" size="20" maxlength="20" />
                    <br />
                    
                    <label for="emailEtudiant">Email</label>
                    <input type="text" id="emailEtudiant" name="emailEtudiant" value="" size="20" maxlength="60" />
                    <br />
                    
                    <label for="pass">Mot de passe </label>
                    <input type="password" placeholder="Entrer mot de passe" name="pass" required>
                    <br />
                    
                    <label for="walo">Confirmer Mot de passe</label>
                    <input type="password" placeholder="Entrer walo" name="walo" required>
                    <br />

     
                </fieldset>
                <input type="submit" value="Valider"  />
                <input type="reset" value="Remettre à zéro" /> <br />
            </form>
        </div>
    </body>
</html>