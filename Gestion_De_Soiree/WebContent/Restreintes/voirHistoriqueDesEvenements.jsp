<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.* , java.util.ArrayList" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>EVENEMENTS</title>
<style>
#evenement {
  font-family: Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

#evenement td, #evenement th {
  border: 1px solid #ddd;
  padding: 8px;
}

#evenement tr:nth-child(even){background-color: #f2f2f2;}

#evenement tr:hover {background-color: #ddd;}

#evenement th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: #5ad6c8;
  color: white;
}

</style>
</head>
<body>
<a href = "/Gestion_De_soiree/Restreintes/sinscrire.jsp">s'inscrire dans un trajet</a> 

<table id="evenement">
  <tr>
    <th> ID du Trajet </th>
    <th>Date de départ</th>
    <th>Heure de départ</th>
     <th>Lieu de départ</th>
     <th>Adresse de départ</th>
    <th>Lieu d'arrivée </th>
     <th>Adresse d'arrivée </th>
    
  </tr>
 
		<%final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
			//  Database credentials
			Connection conn = null;
			Statement stmt = null;
			Statement stmt1 = null;
			Statement stmt2 = null;
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
			   sql = " select TD.NUMERO_TRAJET, TD.DATE_DEPART, TD.HEURE_DEPART, TD.NUMERO_CREATEUR, TD.NUMERO_EVENEMENT, TD.LIEU_DEPART, LD.NOM_LIEU as NOM_LIEU_DEPART, LD.ADRESSE_LIEU as ADRESSE_DEPART, LD.NUMERO_ZONE as ZONE_DEPART, TA.LIEU_ARRIVEE, LA.NOM_LIEU as NOM_LIEU_ARRIVEE, LA.ADRESSE_LIEU as ADRESSE_ARRIVEE, LA.NUMERO_ZONE as ZONE_ARRIVEE from (TRAJET as TD inner join LIEU as LD on TD.LIEU_DEPART=LD.NUMERO_LIEU) inner join (TRAJET as TA inner join LIEU as LA on TA.LIEU_ARRIVEE=LA.NUMERO_LIEU) using(DATE_DEPART,HEURE_DEPART);";
			    ResultSet rs = stmt.executeQuery( sql);			
			   while(rs.next()){
					  
								  out.print(" <tr>");
								  out.print("<td>"+rs.getString("TD.NUMERO_TRAJET")+"</td>");
								  out.print("<td>" +rs.getString("TD.DATE_DEPART")+"</td>");
								  out.print("<td>" +rs.getString("TD.HEURE_DEPART")+"</td>");
							      out.print("<td>" +rs.getString("NOM_LIEU_DEPART")+"</td>");
							      out.print("<td>" +rs.getString("ADRESSE_DEPART")+"</td>");
							      out.print("<td>" +rs.getString("NOM_LIEU_ARRIVEE")+"</td>");
							      out.print("<td>" +rs.getString("ADRESSE_ARRIVEE")+"</td>");

						          out.print("</tr>");
							  
						 
				}
		   				  rs.close();
		   				
              		      stmt.close();
              		      stmt1.close();
              		      stmt2.close();

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

</body>
</html>