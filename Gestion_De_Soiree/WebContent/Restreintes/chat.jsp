<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ page import="java.sql.* , java.util.ArrayList" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Chat</title>
<style>
.container {
  border: 2px solid #dedede;
  background-color: #f1f1f1;
  border-radius: 5px;
  padding: 10px;
  margin: 10px 0;
}

/* Darker chat container */
.darker {
  border-color: #ccc;
  background-color: #ddd;
}

/* Clear floats */
.container::after {
  content: "";
  clear: both;
  display: table;
}
/* Style pseudo text */
.name-left {
  float: left;
  color: #999;
}
</style>
</head>
<body>
	 <form  method="get" action="message" >

 						<% String numT = (String) request.getAttribute("numT");
					      request.setAttribute("numTrajet", numT);	
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
						         
							      ResultSet rs = stmt.executeQuery("select CONTENU_MESSAGE, PSEUDO from MESSAGE inner join NEW  where MESSAGE.NUMERO_AUTEUR=NEW.NUMERO_ETUDIANT and NUMERO_TRAJET="+ numT+" order by NUMERO_MESSAGE;");
							      //STEP 5: Extract data from result set
							      while(rs.next()){
							    	  //Retrieve by column name
						          out.println("<div class='container'>");	
							      out.println("<span class='name-left'>"+ rs.getString("Pseudo")+" a dit: </span>");
								  out.println("<p>"+rs.getString("CONTENU_MESSAGE")+"</p>"); 
							      out.println("</div>");
							        }

								 
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
              		   }//end try
              		   %>
				<TEXTAREA name='message' id= 'message' rows=6 cols=90 class='container'></TEXTAREA>

				<span class='name-left' > ${ sessionScope.Pseudo} écris : </span>
				<button type='submit' >Envoyer</button>
							 	      		   
 
</form>
</body>
</html>