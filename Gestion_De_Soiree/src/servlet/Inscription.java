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


public class Inscription extends HttpServlet {
	public void doGet( HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException {

    final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
	   final String DB_URL = "jdbc:mysql://localhost/soiree";

	   //  Database credentials
	   final String USER = "user";
	   final String PASS = "user";
	   int EtatAvancement = 1;
	   Connection conn = null;
	   Statement stmt = null;
try{
	  /*
      * Récupération des données saisies, envoyées en tant que paramètres de
      * la requête GET générée à la validation du formulaire
      */
	    String sinsc = request.getParameter("insc");
    

   
    
    
	      //STEP 2: Register JDBC driver
	      Class.forName("com.mysql.jdbc.Driver");

	      //STEP 3: Open a connection
	      System.out.println("Connecting to database...");
	      conn = DriverManager.getConnection(DB_URL,USER,PASS);

	      //STEP 4: Execute a query
	      System.out.println("Creating statement...");
	      stmt = conn.createStatement();
 	      int rs = stmt.executeUpdate("insert into INSCRIPTION values ("+ 2 +","+"'"+ sinsc +"'"+",1);");
 	      System.out.println("valeurs insérés");

 	      

     	
	     
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

	    /* Transmission à la page JSP en charge de l'affichage des données */
     //this.getServletContext().getRequestDispatcher( "/afficheretudiant.jsp" ).forward( request, response );
       this.getServletContext().getRequestDispatcher( "/Restreintes/mesEvenements.jsp" ).forward( request, response );


}
}

