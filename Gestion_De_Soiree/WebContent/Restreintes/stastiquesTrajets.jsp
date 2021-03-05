<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.* , java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Gestion De Soiree</title>
</head>
<body>
	<div>	

	<h1 style="text-align:center; background-color:powderblue;"> Statistiques : La liste des trajets avec le nombre de participants</h1>
  	<%ArrayList<String> lieux = new ArrayList<String>();
	  
	 // JDBC driver name and database URL
	   final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
	   //  Database credentials
	   Connection conn = null;
	   Statement stmt = null;
	   Statement stmtD = null;
	   try{
	      //STEP 2: Register JDBC driver
	      Class.forName("com.mysql.jdbc.Driver");

	      //STEP 3: Open a connection
	      System.out.println("Connecting to database...");
	      conn = DriverManager.getConnection("jdbc:mysql://localhost/soiree","user","user");

	      //STEP 4: Execute a query
	      System.out.println("Creating statement...");
	      stmt = conn.createStatement();
	      stmtD = conn.createStatement();
	      String sql;
	      sql = "select NUMERO_TRAJET, DATE_DEPART, HEURE_DEPART, count(NUMERO_ETUDIANT) as NB_PARTICIPANTS, ";
	      //sql+="	";
	      sql+="(case when NOM_EVENEMENT is null then 'Aucun' ";
	      sql+="else NOM_EVENEMENT ";
	      sql+="end) as NOM_EVENEMENT ";
	      sql+="from (TRAJET left outer join INSCRIPTION using(NUMERO_TRAJET)) ";
	      sql+="left outer join EVENEMENT using(NUMERO_EVENEMENT) ";
	      sql+="group by NUMERO_TRAJET; ";
	      ResultSet rs = stmt.executeQuery(sql);
	
	      //STEP 5: Extract data from result set
	      int counter = 1 ;
	      lieux.add("<table>");
	      lieux.add("<tr>");
	      lieux.add("<th>NUMERO_TRAJET</th>");
	      lieux.add("<th>DATE DU DEPART</th>");
	      lieux.add("<th>NOMBRE DE PARTICIPANTS</th>");
	      lieux.add("</tr>");
	      while(rs.next()){
		      lieux.add("<tr>");
		      lieux.add("<td>" +rs.getString("NUMERO_TRAJET") +"</th>");
		      lieux.add("<td>" +rs.getString("DATE_DEPART") +"</th>");
		      lieux.add("<td>" +rs.getString("Nb_PARTICIPANTS") +"</th>");
		      lieux.add("</tr>");
	      	counter++;
	         //System.out.println(" NOM_LIEU: " + lieu);
	      }
	      //STEP 6: Clean-up environment
	  	lieux.add("</table>");
	 	if(counter  == 1)
	 		lieux.add("<h1 ALIGN=CENTER> Aucun Paire Trajet Trouvé </h1>");
 		for(int i = 0; i<lieux.size(); i++){
     	 	  out.println( lieux.get(i));
  	 		}
		  //out.print("<option>Autre</option>");
   		  //out.println("</select>");
   		rs.close();
   		
    	  stmt.close();
    	  stmtD.close();
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
         	stmtD.close();
      }catch(SQLException se2){
      }// nothing we can do
      try{
         if(conn!=null)
            conn.close();
      }catch(SQLException se){
         se.printStackTrace();
      }//end finally try
   }//end try %>
</div>
	<a href = "/Gestion_De_Soiree/creerevenement.jsp">créer un évenement  </a> 
	<a href = "/Gestion_De_Soiree/sinscrire.jsp">s'inscrire à un évenement</a> <br>
	<a href = "/Gestion_De_Soiree/listeAuMoinsUnTrajet.jsp">Liste des paires d’étudiants qui ont fait au moins un trajet ensemble</a> 
</body>
</html>