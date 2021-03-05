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

import beans.Etudiant;

public class Connexion extends HttpServlet {
	public void doGet( HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException {
		this.getServletContext().getRequestDispatcher( "/login.jsp" ).forward( request, response );
	}
	public void doPost( HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException {
		String nom = request.getParameter("uname");
		String mdp = request.getParameter("psw");
		
		String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
		String DB_URL = "jdbc:mysql://localhost/soiree";
		String message = "";
		final String USER = "user";
		final String PASS = "user";
		Connection conn = null;
		Statement stmt = null;
	   try{
		  /*
	         * Récupération des données saisies, envoyées en tant que paramètres de
	         * la requête GET générée à la validation du formulaire
	         */
		    String pseudo = request.getParameter("pseudo");
	        String pass = request.getParameter( "psw" );
	       
	 	      //STEP 2: Register JDBC driver
	 	      Class.forName("com.mysql.jdbc.Driver");

	 	      //STEP 3: Open a connection
	 	      System.out.println("Connecting to database...");
	 	      conn = DriverManager.getConnection(DB_URL,USER,PASS);

	 	      //STEP 4: Execute a query
	 	      System.out.println("Creating statement...");
	 	      stmt = conn.createStatement();
	 	   

	        	   if ( pseudo != null ) {
				      ResultSet rs = stmt.executeQuery("select * from NEW where PSEUDO = '"+pseudo+"';");
				      String chp;
				      if ( rs.next() != false ){//
				    	  String passConf = rs.getString("PASS");
				    	  if (! passConf.equals(pass)){
				    		  message = "Mot De Pass Erroné ";
				    		  System.out.println("Mot de passe Errone");
				    		  request.setAttribute("message", message);
				    		  this.getServletContext().getRequestDispatcher( "/login.jsp" ).forward( request, response );
				    	  }
				    	  else{
				    			HttpSession session = request.getSession();
				    			session.setAttribute("Pseudo", pseudo);
				    			System.out.println("Utilisateur trouvé ");
				    			this.getServletContext().getRequestDispatcher( "/Restreintes/lien.jsp" ).forward( request, response );
				    	  }
				      }
				      else { 
				    	  System.out.println("Utilisateur non trouvé ");
				    	  message = "Utilisateur non trouvé ";
				    	  System.out.println("Utilisateur non trouvé ");
				    	  request.setAttribute("message", message);
				    	  this.getServletContext().getRequestDispatcher( "/login.jsp" ).forward( request, response );
			          }
	   	           }
	        	   //PrintWriter out = response.getWriter();
	        	   //out.println( "<HTML> \n<HEAD> \n <TITLE>Page generee par une servlet</TITLE> \n</HEAD> \n<BODY>\n" + message + "</BODY>\n</HTML>\n" );
	        	   //out.close();
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
	}
}