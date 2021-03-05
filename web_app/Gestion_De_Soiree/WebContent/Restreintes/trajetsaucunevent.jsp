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

	<h1 style="text-align:center; background-color:powderblue;"> Liste des trajets qui ne sont rattachés à aucun événement</h1>
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
	      sql = "select * from TRAJET where NUMERO_EVENEMENT is null;";
	      ResultSet rs = stmt.executeQuery(sql);
	
	      //STEP 5: Extract data from result set
	      int counter = 1 ;
	      while(rs.next()){
	         //Retrieve by column name
	         //String lieu =  + rs.getString("DATE_DEPART") ;
	         lieux.add("<h1 ALIGN=CENTER> Trajet trouvé " + counter + "</h1>");
	         ResultSet rss = stmtD.executeQuery("select * from ETUDIANT where NUMERO_ETUDIANT = " + rs.getString("NUMERO_CREATEUR") + ";");
	         rss.next();
	         lieux.add("<p ALIGN=CENTER> Nom Créateur: " + rss.getString("PRENOM_ETUDIANT") + " "+rss.getString("NOM_ETUDIANT") + "</p>");
	         lieux.add("<p ALIGN=CENTER> Numero Trajet: " + rs.getString("NUMERO_TRAJET") + "</p>");
	         lieux.add("<p ALIGN=CENTER> Date de Depart: " + rs.getString("DATE_DEPART") + "</p>");
	         lieux.add("<p ALIGN=CENTER> Heure de Depart: " + rs.getString("HEURE_DEPART") + "</p>");
	         rss.close();
	         counter++;
	         //System.out.println(" NOM_LIEU: " + lieu);
	      }
	      //STEP 6: Clean-up environment
	  	   
	 	if(counter  == 1)
	 		lieux.add("<h1 ALIGN=CENTER> Aucun Trajet Trouvé </h1>");
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
	<a href = "/Gestion_De_Soiree/sinscrire.jsp">s'inscrire à un évenement</a> 
</body>
</html>