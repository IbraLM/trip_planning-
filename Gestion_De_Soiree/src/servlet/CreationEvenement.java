package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.Etudiant;
import beans.Evenement;

public class CreationEvenement extends HttpServlet {

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
	         * R?cup?ration des donn?es saisies, envoy?es en tant que param?tres de
	         * la requ?te GET g?n?r?e ? la validation du formulaire
	         */
		    String numeroE = request.getParameter( "numeroEtudiant" );
	        String nom = request.getParameter( "nomEtudiant" );
	        String prenom = request.getParameter( "prenomEtudiant" );
	        String telephone = request.getParameter( "telephoneEtudiant" );
	        String email = request.getParameter( "emailEtudiant" );
	        String nomEv = request.getParameter( "nomEvenement" );
	        String adresseDepart = request.getParameter( "adresseDepart" );
	        String adresseArrivee = request.getParameter("adresseEv");
	        String zone = request.getParameter( "zone" );
	        String date = request.getParameter( "date" );
	        String heure = request.getParameter("heure");
	        
	        String message;
	        /*
	         * Initialisation du message ? afficher : si un des champs obligatoires
	         * du formulaire n'est pas renseign?, alors on affiche un message
	         * d'erreur, sinon on affiche un message de succ?s
	         */
	        if ( nomEv.trim().isEmpty()   ){
	            message = "Erreur - Vous n'avez pas rempli tous les champs obligatoires. <br> <a href=\"creerevenement.jsp\">Cliquez ici</a> pour acc?der au formulaire de cr?ation d'une commande.";
	        } else {
	            message = "Evenement cr??e avec succ?s !";
	        }
	        
	         /* Cr?ation des beans  et initialisation avec les
	         * donn?es r?cup?r?es
	         */
	        Etudiant etudiant = new Etudiant();
	        etudiant.setNumeroE( numeroE );
	        etudiant.setNom( nom );
	        etudiant.setPrenom( prenom );
	        etudiant.setTelephone( telephone );
	        etudiant.setEmail( email ); 

	        Evenement evenement = new Evenement();
	        evenement.setEtudiant( etudiant );
	        evenement.setnomEv( nomEv );
	        evenement.setadDepart(adresseDepart);
	        evenement.setadArrivee(adresseArrivee);
	        evenement.setzone(zone);
	        evenement.setdate(date);
	        evenement.setheure(heure);
	        // JDBC driver name and database URL
		       
	 	      //STEP 2: Register JDBC driver
	 	      Class.forName("com.mysql.jdbc.Driver");

	 	      //STEP 3: Open a connection
	 	      System.out.println("Connecting to database...");
	 	      conn = DriverManager.getConnection(DB_URL,USER,PASS);
	 	     
	 	      //STEP 4: Execute a query
	 	      System.out.println("Creating statement...");
	 	      stmt = conn.createStatement();
	 	      int rs = stmt.executeUpdate("insert into ETUDIANT values ("+ numeroE +","+"'"+ nom +"'"+","+"'"+ prenom +"'" +"," + "'" + telephone+ "'" + ","+"'"+ email +"');");
	 	      int tz = stmt.executeUpdate("insert into LIEU values ("+1	+","+"'"+ adresseDepart+"'" +","+"'"+ adresseArrivee +"'"+");");
	 	      int ps = stmt.executeUpdate("insert into ZONE values ("+ 1 + ","+"'"+ zone +"'"+");");
	 	      int pz = stmt.executeUpdate("insert into EVENEMENT values ("+1+","+"'"+ nomEv +"'"+");");
	 	      int mz = stmt.executeUpdate("insert into TRAJET (NUMERO_TRAJET, DATE_DEPART, HEURE_DEPART) values ("+1+","+"'"+ date +"'"+ heure +"'"+");");


	 	      
	 	      System.out.println("valeurs ins?r?s");

	 	     
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

	        /* Ajout du bean et du message ? l'objet requ?te 
	        request.setAttribute( "evenement", evenement );
	        request.setAttribute( "message", message );
	        /* Transmission ? la page JSP en charge de l'affichage des donn?es */
	        
	        this.getServletContext().getRequestDispatcher( "/Restreintes/afficherevenement.jsp" ).forward( request, response );
	    }
	    
	        
	}