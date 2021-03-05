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

	<h1 style="text-align:center; background-color:powderblue;"> Liste des paires d’étudiants qui ont fait au moins un trajet ensemble</h1>
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
	      sql = "select distinct E1.NUMERO_ETUDIANT as NO_ETUDIANT_1, E1.NOM_ETUDIANT as NOM_ETUDIANT_1, E1.PRENOM_ETUDIANT as PRENOM_ETUDIANT_1,";
	      sql+=" E2.PRENOM_ETUDIANT as PRENOM_ETUDIANT_2, E2.NOM_ETUDIANT as NOM_ETUDIANT_2, E2.NUMERO_ETUDIANT as NO_ETUDIANT_2";
	      sql+=" from (ETUDIANT as E1,ETUDIANT as E2) left outer join (INSCRIPTION as I1, INSCRIPTION as I2)";
	      sql+=" on (E1.NUMERO_ETUDIANT=I1.NUMERO_ETUDIANT and E2.NUMERO_ETUDIANT=I2.NUMERO_ETUDIANT";
	      sql+=" and E1.NUMERO_ETUDIANT<E2.NUMERO_ETUDIANT)";
	      sql+=" where (I1.NUMERO_TRAJET=I2.NUMERO_TRAJET)";
	      sql+=" group by E1.NUMERO_ETUDIANT,E2.NUMERO_ETUDIANT;";
	      ResultSet rs = stmt.executeQuery(sql);
	
	      //STEP 5: Extract data from result set
	      int counter = 1 ;
	      while(rs.next()){
	         //Retrieve by column name
	         //String lieu =  + rs.getString("DATE_DEPART") ;
	         lieux.add("<h1 ALIGN=CENTER>  Paire Trouvé :" + counter + "</h1>");
	         lieux.add("<p ALIGN=CENTER> " + rs.getString("PRENOM_ETUDIANT_1") + " "+rs.getString("NOM_ETUDIANT_1") + "</p>");
	         lieux.add("<p ALIGN=CENTER> " + rs.getString("PRENOM_ETUDIANT_2") + " "+rs.getString("NOM_ETUDIANT_2") + "</p>");
	         counter++;
	         //System.out.println(" NOM_LIEU: " + lieu);
	      }
	      //STEP 6: Clean-up environment
	  	   
	 	if(counter  == 1)
	 		lieux.add("<h1 ALIGN=CENTER> Aucun Paire D'Étudiants Trouvé </h1>");
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
	<a href = "/Gestion_De_Soiree/Restreintes/creerTrajet.jsp">créer un évenement  </a> 
</body>
</html>