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
import javax.servlet.http.HttpSession;

import servlet.DiscussionTraj;

import beans.Etudiant;

public class Message extends HttpServlet {
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
	    String message = request.getParameter("message");
        
 	      //STEP 2: Register JDBC driver
 	      Class.forName("com.mysql.jdbc.Driver");

 	      //STEP 3: Open a connection
 	      System.out.println("Connecting to database...");
 	      conn = DriverManager.getConnection(DB_URL,USER,PASS);

 	      //STEP 4: Execute a query
 	      System.out.println("Creating statement...");
 	      stmt = conn.createStatement();
		  HttpSession session = request.getSession();
 	      String sql = "select NUMERO_ETUDIANT from NEW where PSEUDO='"+session.getAttribute("Pseudo")+"';";
 	      System.out.println(session.getAttribute("Pseudo"));
 	      ResultSet ps = stmt.executeQuery(sql);
		  ps.next();		 
		  String numEt = ps.getString("NUMERO_ETUDIANT");

		  String sqli = "select ID from DISCTRAJ;";
 	      ResultSet ii = stmt.executeQuery(sqli);
		  ii.next();
		  String id = ii.getString("ID");
		  System.out.println("hhhhhhhhhhhhhhhhhhh"+ id);
		  String req = "insert into MESSAGE (CONTENU_MESSAGE, NUMERO_AUTEUR, NUMERO_TRAJET) values ('"+message+"',"+numEt+" ,"+id+" );";
 	      int rs = stmt.executeUpdate(req);
 		  this.getServletContext().getRequestDispatcher(  "/discussionTraj?disc="+ id ).forward( request, response );

 	     
 	      
		
		  
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

  
}
}
