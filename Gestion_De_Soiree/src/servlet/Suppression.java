package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class Suppression extends HttpServlet {
	 public void doGet( HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException {

	  final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
	   final String DB_URL = "jdbc:mysql://localhost/soiree";

	   //  Database credentials
	   final String USER = "user";
	   final String PASS = "user";
	   Connection conn = null;
	   Statement stmt = null;
  try{
	  /*
        * Récupération des données saisies, envoyées en tant que paramètres de
        * la requête GET générée à la validation du formulaire
        */
	    String ID = request.getParameter("supp");
	    System.out.println(ID);
	      //STEP 2: Register JDBC driver
	      Class.forName("com.mysql.jdbc.Driver");

	      //STEP 3: Open a connection
	      System.out.println("Connecting to database...");
	      conn = DriverManager.getConnection(DB_URL,USER,PASS);

	      //STEP 4: Execute a query
	      System.out.println("Creating statement...");
	      stmt = conn.createStatement();
	      int rs = stmt.executeUpdate("delete from TRAJET where NUMERO_TRAJET="+ID+";");
		  System.out.println("Opération réussie");
		  String message = "Trajet supprimé";
		  request.setAttribute("message", message);

       	  
	      //STEP 6: Clean-up environment
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
	   System.out.println("Goodbye!");
       this.getServletContext().getRequestDispatcher( "/Restreintes/mesEvenements.jsp" ).forward( request, response );

	    
 
}
}

