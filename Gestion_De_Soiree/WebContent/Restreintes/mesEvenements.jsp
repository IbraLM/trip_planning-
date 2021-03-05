<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.* , java.util.ArrayList" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Mes Trajets</title>
<style>

/* Bar Chart */
.barchart{
  font-size: 9px;
  line-height: 15px;
    table-layout: fixed;
    text-align:center; 
    width: 100%;
    height:226px;
}
.barchart tr:nth-child(1) td{
    vertical-align:bottom;
    height:200px;
  }
  
.barchart .bar{
    background: #0DA58E;
    padding: 10px 2px 0;
}
  
.barchart .label{
    background-color: #cccccc;
  margin-top: -25px;
  padding: 0 3px;
  color: black;
  border-radius: 4px;
}
.scroll
{
    background-color: aqua;
}
.scroll thead
{
    background-color: aqua;
    display:block;
}
 .scroll tbody
{
    display:block;
    max-height:8em;
    overflow-y:auto;
    background-color: white;
 
}
 

 
.scroll td, .scroll th
{
    width: 1000px;
    text-align: center;
}
</style>
</head>
<body>
<%
            String mes = (String) request.getAttribute("message");
                        if( mes != null && !mes.isEmpty())
                         out.println( mes);
            %>
<h1 style="text-align:center"> Trajets que j'ai créé </h1>
<table class="scroll">
	<thead>
	  <tr>
	    <th> ID du Trajet </th>
	    <th>Date de départ</th>
	    <th>Heure de départ</th>
	     <th>Lieu de départ</th>
	     <th>Adresse de départ</th>
	    <th>Lieu d'arrivée </th>
	     <th>Adresse d'arrivée </th>
	    
	  </tr>
	  </thead>
	  <tbody>
	  <%final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
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
			   stmt= conn.createStatement();
			   //Recuperer le NUMERO_ETUDIANT à partir du pseudo
			  Statement stmtD = conn.createStatement();
			  ResultSet ps = stmtD.executeQuery("select NUMERO_ETUDIANT from NEW where PSEUDO='"+ session.getAttribute("Pseudo") +"';");
			  ps.next();
			  String numEt = ps.getString("NUMERO_ETUDIANT");
			  String sql;
			  sql= "select TD.NUMERO_TRAJET, TD.DATE_DEPART, TD.HEURE_DEPART, TD.NUMERO_EVENEMENT, TD.LIEU_DEPART, LD.NOM_LIEU as NOM_LIEU_DEPART, LD.ADRESSE_LIEU as ADRESSE_DEPART, LD.NUMERO_ZONE as ZONE_DEPART, TA.LIEU_ARRIVEE, LA.NOM_LIEU as NOM_LIEU_ARRIVEE, LA.ADRESSE_LIEU as ADRESSE_ARRIVEE, LA.NUMERO_ZONE as ZONE_ARRIVEE from (TRAJET as TD inner join LIEU as LD on TD.LIEU_DEPART=LD.NUMERO_LIEU) inner join (TRAJET as TA inner join LIEU as LA on TA.LIEU_ARRIVEE=LA.NUMERO_LIEU) using(DATE_DEPART,HEURE_DEPART) where TD.NUMERO_CREATEUR = "+ numEt +";";	
			   ResultSet rs = stmt.executeQuery(sql);		
			   while(rs.next()){

								  out.print(" <tr>");
								  out.print("<td>"+rs.getString("TD.NUMERO_TRAJET")+"</td>");
								  out.print("<td>" +rs.getString("TD.DATE_DEPART")+"</td>");
								  out.print("<td>" +rs.getString("TD.HEURE_DEPART")+"</td>");
							      out.print("<td>" +rs.getString("NOM_LIEU_DEPART")+"</td>");
							      out.print("<td>" +rs.getString("ADRESSE_DEPART")+"</td>");
							      out.print("<td>" +rs.getString("NOM_LIEU_ARRIVEE")+"</td>");
							      out.print("<td>" +rs.getString("ADRESSE_ARRIVEE")+"</td>");

						          out.print("</tr>");}%>
							        		   
    </tbody>
	</table>
	</br>
	<h2 style='text-align:center'>Nombre d'inscris dans mes trajets</h2>
	
<br/>

  <%  
			   ResultSet stat = stmt.executeQuery(" select NUMERO_TRAJET, count(NUMERO_ETUDIANT)from INSCRIPTION where NUMERO_TRAJET in (select NUMERO_TRAJET from TRAJET where NUMERO_CREATEUR="+numEt+") group by NUMERO_TRAJET;");
			  out.println("<table class='barchart' cellpadding='1' cellspacing='0'><tr>");
 			 while(stat.next()){
							int i = stat.getInt("count(NUMERO_ETUDIANT)");
 				 			out.println("<td><span class='label'>"+stat.getInt("count(NUMERO_ETUDIANT)")+"</span>");
							out.println(" <div class='bar'style='height:"+i+"%'></div>");
							out.println(stat.getString("NUMERO_TRAJET")+"</td>");}
							out.println("  </tr>");
							out.println("	</table>");    
							out.println("	<br/>");
	%>
	
	<a href = '/Gestion_De_soiree/Restreintes/supprimerTrajet.jsp'>supprimer un trajet</a>
	</br>
	</br>
	<h1 style='text-align:center'> Trajets dans lesquels je suis inscrit </h1>
	<table class='scroll'>
			<thead>
			  <tr>
			  <th> ID du Trajet </th>
			  <th>Date de départ</th>
			  <th>Heure de départ</th>
			   <th>Lieu de départ</th>
			   <th>Adresse de départ</th>
			   <th>Lieu d'arrivée </th>
			   <th>Adresse d'arrivée </th>
			   </tr>
			 </thead>
	<tbody>
	 <% ResultSet papa = stmt.executeQuery("select TD.NUMERO_TRAJET, TD.DATE_DEPART, TD.HEURE_DEPART,  TD.NUMERO_EVENEMENT, TD.LIEU_DEPART, LD.NOM_LIEU as NOM_LIEU_DEPART, LD.ADRESSE_LIEU as ADRESSE_DEPART, TA.LIEU_ARRIVEE, LA.NOM_LIEU as NOM_LIEU_ARRIVEE, LA.ADRESSE_LIEU as ADRESSE_ARRIVEE from (TRAJET as TD inner join LIEU as LD on TD.LIEU_DEPART=LD.NUMERO_LIEU) inner join(TRAJET as TA inner join LIEU as LA on TA.LIEU_ARRIVEE=LA.NUMERO_LIEU) using(DATE_DEPART,HEURE_DEPART) where TD.NUMERO_TRAJET in (select NUMERO_TRAJET from INSCRIPTION WHERE NUMERO_ETUDIANT="+numEt+");");	
			  while(papa.next()){

						  out.print(" <tr>");
						  out.print("<td>"+papa.getString("TD.NUMERO_TRAJET")+"</td>");
						  out.print("<td>" +papa.getString("TD.DATE_DEPART")+"</td>");
						  out.print("<td>" +papa.getString("TD.HEURE_DEPART")+"</td>");
					      out.print("<td>" +papa.getString("NOM_LIEU_DEPART")+"</td>");
					      out.print("<td>" +papa.getString("ADRESSE_DEPART")+"</td>");
					      out.print("<td>" +papa.getString("NOM_LIEU_ARRIVEE")+"</td>");
					      out.print("<td>" +papa.getString("ADRESSE_ARRIVEE")+"</td>");

				          out.print("</tr>");
					  

						} 
						 rs.close();
						 ps.close();
						papa.close();
						stat.close();
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
						}%>
</tbody>
</table>
</br>
<li>  <a href = "/Gestion_De_soiree/Restreintes/desinscrire.jsp">se désinscrire d'un trajet</a> </li>
<li>  <a href = "/Gestion_De_soiree/Restreintes/choixDiscussTraj.jsp">Discuter avec les autres inscris </a> </li>

 </br>
 </br>

</body>

</html>