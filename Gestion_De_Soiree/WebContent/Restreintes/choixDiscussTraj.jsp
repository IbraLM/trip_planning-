<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ page import="java.sql.* , java.util.ArrayList" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Choisissez</title>
</head>
<body>
   <form  method="get" action="../discussionTraj" >

	</br>
	<h1 style="text-align:center; background-color:#cccccc;"> Quelle discussion souhaitez vous rejoindre </h1>
	</br>
	<center>
 <label for="chat">Discussion</label>

	        <select id="disc" name="disc">
            <option value="">--choisissez un trajet --</option>
                        <%ArrayList<String> trajet = new ArrayList<String>();
						  
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
							      Statement stmtD = conn.createStatement();
								  ResultSet ps = stmtD.executeQuery("select NUMERO_ETUDIANT from NEW where PSEUDO='"+ session.getAttribute("Pseudo") +"';");
								  ps.next();
								  String numEt = ps.getString("NUMERO_ETUDIANT");
							      String sql;
							      sql = "SELECT NUMERO_TRAJET from INSCRIPTION where NUMERO_ETUDIANT="+numEt+" ;";
							      ResultSet rs = stmt.executeQuery(sql);

							      //STEP 5: Extract data from result set
							      while(rs.next()){
							         //Retrieve by column name
							         String t = rs.getString("NUMERO_TRAJET");
							         trajet.add(t);}
							 	 
								  for(int i = 0; i<trajet.size(); i++){
								          out.println("<option value=\""+ trajet.get(i) +"\"> ID du TRAJET"+ trajet.get(i) + "</option>");
								      }
									  //out.print("<option>Autre</option>");
								      out.println("</select>");
								  
							      //STEP 6: Clean-up environment
					      rs.close();
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
                </div>
            </select>
            </br>
            </br>
		   <button type="submit" >Envoyer</button>
		   
</center>
</br>
 </br>
 <p> pour vérifier l'ID du trajet cliquez <a href = '/Gestion_De_soiree/Restreintes/mesEvenements.jsp'> <strong>ici</strong></a> section <strong>Trajets dans lesquels je suis inscrit </strong> </p>
 
</body>
</html>