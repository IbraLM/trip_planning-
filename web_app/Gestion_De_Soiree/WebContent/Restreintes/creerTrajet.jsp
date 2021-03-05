<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.* , java.util.ArrayList" %>


<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>Créer Trajet</title>
    </head>
    <body>
    	<h1 style="text-align:center; background-color:powderblue;"> Créer Trajet </h1>
        <div>
            <form method="get" action="../creationTrajet">
                <fieldset>
                    <legend>Informations Trajet</legend>
    
                    <label for="nomEvenement">Nom Évènement</label>
                    <select id="nomEvenement" name="nomEvenement">
                     <option value="">--choisissez un lieu de départ--</option>
						  <%ArrayList<String> event = new ArrayList<String>();
						  
							 // JDBC driver name and database URL
							   final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
							   //  Database credentials
							   Connection conn = null;
							   Statement stmt = null;
							   try{
							      //STEP 2: Register JDBC driver
							      Class.forName("com.mysql.jdbc.Driver");

							      //STEP 3: Open a connection
							      System.out.println("Connecting to database...");
							      conn = DriverManager.getConnection("jdbc:mysql://localhost/soiree","user","user");

							      //STEP 4: Execute a query
							      System.out.println("Creating statement...");
							      stmt = conn.createStatement();
							      String sql;
							      sql = "SELECT NOM_EVENEMENT from EVENEMENT;";
							      ResultSet rsE = stmt.executeQuery(sql);

							      //STEP 5: Extract data from result set
							      while(rsE.next()){
							         //Retrieve by column name
							         String lieu = rsE.getString("NOM_EVENEMENT");
							         event.add(lieu);
							         //Display values
							         System.out.println(" EVENEMENT: " + lieu);
							      }
							      //STEP 6: Clean-up environment
							     
							 
						  for(int i = 0; i<event.size(); i++){
						          out.println("<option value=\""+ event.get(i) +"\">"+ event.get(i) + "</option>");
						      }
							  //out.print("<option>Autre</option>");
						      out.println("</select>");
						  
						    %>					

                   <input type="text" id="autre" style="display:none">
                   <a href = "/Gestion_De_Soiree/creerEvenement.jsp">créer évènement?</a>
          			</select>
                    <br />   
                    <br />
                    <label for="selectD">Lieu de depart<span class="requis">*</span></label>
                    <select name="selectD" id="selectD" >
					    <option value="">--choisissez un lieu--</option>
						  <%ArrayList<String> lieux = new ArrayList<String>();
							      stmt = conn.createStatement();
							      sql="";
							      sql = "SELECT NOM_LIEU FROM LIEU order by NOM_LIEU;";
							      ResultSet rs = stmt.executeQuery(sql);

							      //STEP 5: Extract data from result set
							      while(rs.next()){
							         //Retrieve by column name
							         String lieu = rs.getString("NOM_LIEU");
							         lieux.add(lieu);
							         //Display values
							         System.out.println(" NOM_LIEU: " + lieu);
							      }
							      //STEP 6: Clean-up environment
							     
							 
						  for(int i = 0; i<lieux.size(); i++){
						          out.println("<option value=\""+ lieux.get(i) +"\">"+ lieux.get(i) + "</option>");
						      }
							  out.print("<option>Autre</option>");
						      out.println("</select>");
						  
						    %>					

                   <a href = "/Gestion_De_Soiree/creerLieu.jsp">ajouter un lieu?</a>
                   
                    <br />
                    

                    <label for="selectA">Lieu d'Arrivée<span class="requis">*</span></label>	    	
 				      <select name="selectA" id="selectA">
					    <option value="">--choisissez un lieu--</option>
						  <%
						  for(int i = 0; i<lieux.size(); i++){
					          out.println("<option value=\""+ lieux.get(i) +"\">"+ lieux.get(i) + "</option>");
					      }
						      out.println("</select>");
						  
						    %>					
					<a href = "/Gestion_De_Soiree/creerLieu.jsp">ajouter un lieu?</a>	    	
                    <br />

                    <!-- %
                      
                      String depart = request.getParameter("departD");
                      String zone;
				      zone = "SELECT NOM_ZONE FROM ZONE where NUMERO_ZONE in (select NUMERO_ZONE from LIEU where NOM_LIEU ="+depart+");";
				      ResultSet ps = stmt.executeQuery(zone);
					  out.print("<input type='text' value='"+ ps.getString("NOM_ZONE")  +"' size='20' maxlength='20'/>");
                  %> -->
                    <br />
                    
                    <label for="date">Date du Trajet<span class="requis">*</span></label>
                    <input type="text" id="date" name="date" value="AAAA-JJ-MM" size="20" maxlength="20" />
                    <br />
                    
                    <label for="heure">Heure Du Départ<span class="requis">*</span></label>
                    <input type="text" id="heure" name="heure" value="" size="20" maxlength="20" />
                    <br />
                    <%  rs.close();
              		      stmt.close();
              		      conn.close();
              		   }catch(SQLException se){
              		      //Handle errors for JDBC
              		      se.printStackTrace();
              		   }catch(Exception e){
              		      //Handle errors for Class.forName
              		      e.printStackTrace();
              		   }finally{
              		      //finally block used to close resources
              		      try{
              		         if(stmt!=null)
              		            stmt.close();
              		      }catch(SQLException se2){
              		      }// nothing we can do
              		      try{
              		         if(conn!=null)
              		            conn.close();
              		      }catch(SQLException se){
              		         se.printStackTrace();
              		      }//end finally try
              		   }//end try %>
                </fieldset>
                <input type="submit" value="Valider"  />
                <input type="reset" value="Remettre à zéro" /> <br />
            </form>
        </div>
        <a href = "/Gestion_De_Soiree/creerevenement.jsp">créer un évenement</a> 	
 	<a href = "/Gestion_De_Soiree/sinscrire.jsp">s'inscrire à un évenement</a> 	 <br>
	<a href = "/Gestion_De_Soiree/Restreintes/listeAuMoinsUnTrajet.jsp">Liste des paires d’étudiants qui ont fait au moins un trajet ensemble</a>
    </body>
</html>