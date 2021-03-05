package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.Etudiant;

public class CreationEtudiant extends HttpServlet {
	
	  
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
		    String pseudo = request.getParameter("pseudo");
	        String numeroE = request.getParameter( "numeroEtudiant" );
	        String nom = request.getParameter( "nomEtudiant" );
	        String prenom = request.getParameter( "prenomEtudiant" );
	        String telephone = request.getParameter( "telephoneEtudiant" );
	        String email = request.getParameter( "emailEtudiant" );
	        String pass = request.getParameter( "pass" );
	        String walo = request.getParameter( "walo" );

	        /*
	         * Création du bean Etudiant et initialisation avec les données récupérées
	         */
	        Etudiant etudiant = new Etudiant();
	        etudiant.setpseudo(pseudo);
	        etudiant.setNumeroE( numeroE );
	        etudiant.setNom( nom );
	        etudiant.setPrenom( prenom );
	        etudiant.setTelephone( telephone );
	        etudiant.setEmail( email );
	        etudiant.setpass(pass);
	        etudiant.setwalo(walo);
	        etudiant.setwalo(walo);
	        String message = "Gestion De Soiree\n";
	        /*
	         * Initialisation du message à afficher : si un des champs obligatoires
	         * du formulaire n'est pas renseigné, alors on affiche un message
	         * d'erreur, sinon on affiche un message de succès
	         */
	        if ( pseudo.trim().isEmpty() || pass.trim().isEmpty() || walo.trim().isEmpty()){
	            message = "Erreur - Vous n'avez pas rempli tous les champs obligatoires. <br> <a href=\"creerevenement.jsp\">Cliquez ici</a> pour accéder au formulaire de création d'un etudiant.";
	            EtatAvancement=0;
	        } 
	       
	       
	       
	 	      //STEP 2: Register JDBC driver
	 	      Class.forName("com.mysql.jdbc.Driver");

	 	      //STEP 3: Open a connection
	 	      System.out.println("Connecting to database...");
	 	      conn = DriverManager.getConnection(DB_URL,USER,PASS);

	 	      //STEP 4: Execute a query
	 	      System.out.println("Creating statement...");
	 	      stmt = conn.createStatement();
	 	   

	        	   if ( pseudo != null ) {
	        		  
				      ResultSet rs = stmt.executeQuery("select PSEUDO from NEW where PSEUDO = '"+pseudo+"';");
				      System.out.println("wqqq zaaaab   " + pseudo + "  "+rs );
				      String chp;
				      if ( rs.next() != false ){
				      
				    	 // chp= rs.getString("PSEUDO");
				    	  System.out.println("pseudo exists");
				    	  message = "Pseudo déjà pris";
				    	  EtatAvancement=0;
				      }
				      else { 
				    	  System.out.println(" succes");
			          }
	   	            	   } 
	        	   //walo.intern();
	        	   if (! pass.equals(walo)) {
	        		   System.out.println("wa haahouma  vc wiss " + pass +" "+ walo);
	        		   message = "<H1>les mots de passes ne sont pas identiques <br> <a href=\"/Gestion_De_Soiree/creeretudiant.jsp\">Cliquez ici</a> pour accéder au formulaire de création d'un etudiant</H1>";
	        		   EtatAvancement=0;
	        		   
	        	   }
	        	   
	 	      if ( EtatAvancement==1) {
	 	    	  int rss = stmt.executeUpdate("insert into ETUDIANT(NOM_ETUDIANT,PRENOM_ETUDIANT,TELEPHONE,MAIL) values ('" +nom +"'"+","+"'"+ prenom +"'" +"," + "'" + telephone+ "'" + ","+"'"+ email +"');");
	 	    	  System.out.println("qpres l excecution de requete etudiant");
	 	    	  ResultSet rse = stmt.executeQuery("select NUMERO_ETUDIANT from ETUDIANT where NOM_ETUDIANT = '"+nom+"' and PRENOM_ETUDIANT ='"+prenom+"';");
	 	    	  rse.next();
	 	    	  String numeroEtudiant = (String) rse.getString("NUMERO_ETUDIANT");
	 	    	  int ps = stmt.executeUpdate("insert into NEW values ('"+pseudo+"','"+numeroEtudiant+"','"+pass+"'); ");
	 	    	  message = "Bienvenue! Votre compte a été créé";
	 	    	  System.out.println("valeurs insérés   HEre");
	 	    	 this.getServletContext().getRequestDispatcher( "/login.jsp" ).forward( request, response );
	 	    	 return;
	 	      }
	 	      else {
	 	    	 PrintWriter out = response.getWriter();
	 	    	 out.println( "<HTML> \n<HEAD> \n <TITLE>Page generee par une servlet</TITLE> \n</HEAD> \n<BODY>\n" + message + "</BODY>\n</HTML>\n" );
	 	    	 out.close();
	 	       this.getServletContext().getRequestDispatcher( "/login.jsp" ).forward( request, response );
	 	       //return;
	 	      }
	 	     
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
