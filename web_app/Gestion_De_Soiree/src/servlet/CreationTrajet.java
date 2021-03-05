package servlet;

import java.io.IOException;
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
import beans.Evenement;

public class CreationTrajet extends HttpServlet {

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

	        String nomEv = request.getParameter( "nomEvenement" );
	        
	        String adresseDepart = request.getParameter( "selectD" );
	        String adresseArrivee = request.getParameter("selectA");
	        String date = request.getParameter( "date" );
	        String heure = request.getParameter("heure");
	        String message;
	        /*
	         * Initialisation du message à afficher : si un des champs obligatoires
	         * du formulaire n'est pas renseigné, alors on affiche un message
	         * d'erreur, sinon on affiche un message de succès
	         */
	        /*if ( nomEv.trim().isEmpty()   ){
	            message = "Erreur - Vous n'avez pas rempli tous les champs obligatoires. <br> <a href=\"creerevenement.jsp\">Cliquez ici</a> pour accéder au formulaire de création d'une commande.";
	        } else {
	            message = "Evenement créée avec succès !";
	        }*/
	        
	         /* Création des beans  et initialisation avec les
	         * données récupérées
	         */

	        // JDBC driver name and database URL
		       
	 	      //STEP 2: Register JDBC driver
	 	      Class.forName("com.mysql.jdbc.Driver");

	 	      //STEP 3: Open a connection
	 	      System.out.println("Connecting to database...");
	 	      conn = DriverManager.getConnection(DB_URL,USER,PASS);
	 	     
	 	      //STEP 4: Execute a query
	 	      System.out.println("Creating statement...");
	 	      stmt = conn.createStatement();
	 	      Statement stmD = conn.createStatement();
	 	      if(nomEv != null && !nomEv.isEmpty()) {
	 	    	  ResultSet rdds = stmD.executeQuery("select NUMERO_EVENEMENT from EVENEMENT where NOM_EVENEMENT = '"+ nomEv+"';");
	 	    	  rdds.next();
	 	    	  nomEv=rdds.getString("NUMERO_EVENEMENT");
	 	    	  
	 	      }
	 	   //Supposant ici que les ID sont stocke dans NEW.
	 	     HttpSession session = request.getSession();
	 	     String pseudo = (String)  session.getAttribute("Pseudo");	
	 	     ResultSet rdds = stmD.executeQuery("select NUMERO_ETUDIANT from NEW where PSEUDO = '"+pseudo+"';");
	 	     rdds.next();
	 	     System.out.println("HAHOUMA " + adresseDepart + "  arrive : "+adresseArrivee+ "NOMEV  " + nomEv);
	 	     String IdEt = rdds.getString("NUMERO_ETUDIANT");
	 	     rdds = stmD.executeQuery("select NUMERO_LIEU from LIEU where NOM_LIEU = '"+adresseDepart+"';");
	 	    rdds.next();
	 	     adresseDepart=rdds.getString("NUMERO_LIEU");
	 	    System.out.println("\nNOM EVENMENT : " + nomEv + "\nADRESSE arrive: "+ adresseArrivee);
	 	     rdds = stmD.executeQuery("select NUMERO_LIEU from LIEU where NOM_LIEU = '"+adresseArrivee+"';");
	 	     rdds.next();
	 	     adresseArrivee=rdds.getString("NUMERO_LIEU");
	 	     
	 	      if(nomEv != null && !nomEv.isEmpty()) {
	 	    	  System.out.println("\nNOM EVENMENT : " + nomEv);
	 	    	 int mz = stmt.executeUpdate("insert into TRAJET (DATE_DEPART, HEURE_DEPART,NUMERO_CREATEUR,NUMERO_EVENEMENT,LIEU_DEPART,LIEU_ARRIVEE ) values ("+"'"+ date +"'"+ ",'"+heure +"', '"+ IdEt+"','" +nomEv +"','" + adresseDepart+ "','" +adresseArrivee+"');");
	 	      }
	 	      else {
	 	    	  int m = stmt.executeUpdate("insert into TRAJET (DATE_DEPART, HEURE_DEPART,NUMERO_CREATEUR,LIEU_DEPART,LIEU_ARRIVEE ) values ("+"'"+ date +"'"+ ",'"+heure +"', '"+ IdEt+"','" + adresseDepart+ "','" +adresseArrivee+"');");
	 	      }

	 	      
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

	        /* Ajout du bean et du message à l'objet requête 
	        request.setAttribute( "evenement", evenement );
	        request.setAttribute( "message", message );
	        /* Transmission à la page JSP en charge de l'affichage des données */
	        
	        this.getServletContext().getRequestDispatcher( "/Restreintes/lien.jsp" ).forward( request, response );
	    }
	    
	        
	}