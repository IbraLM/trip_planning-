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



public class ConsultationTrajetZones extends HttpServlet {

	public void doGet( HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException {
	    final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
 	    final String DB_URL = "jdbc:mysql://localhost/soiree";
 	   
 	   //  Database credentials
 	   final String USER = "user";
 	   final String PASS = "user";
 	   int EtatAvancement = 1;
 	   Connection conn = null;
 	   Statement stmt = null;
 	  Statement stmtD = null;
 	   String message= "";
 	   String depart = "";
 	   String arrivee="";
 	   String dateTrajet="";
 	   
 	   //this.getServletContext().getRequestDispatcher( "/afficheretudiant.jsp?message="+message).forward( request, response );
 	   
   try{
	  /*
         * Récupération des données saisies, envoyées en tant que paramètres de
         * la requête GET générée à la validation du formulaire
         */
	   depart = request.getParameter("depart");
        arrivee = request.getParameter( "arrivee" );
       dateTrajet = request.getParameter( "dateTrajet" );
        System.out.println("wa haahoumaa  " + depart +"   walo " + arrivee + "  " + dateTrajet);

        /*
         * Initialisation du message à afficher : si un des champs obligatoires
         * du formulaire n'est pas renseigné, alors on affiche un message
         * d'erreur, sinon on affiche un message de succès
         */
        if ( depart.isEmpty() || arrivee.isEmpty() || dateTrajet.isEmpty()){
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
 	      stmtD = conn.createStatement();
 	   

 	     
 	     String nn = "select TD.NUMERO_TRAJET, TD.DATE_DEPART, TD.HEURE_DEPART, TD.NUMERO_CREATEUR, TD."
	    	  		+ "NUMERO_EVENEMENT,"
	    	  		+ "        TD.LIEU_DEPART, LD.NOM_LIEU as NOM_LIEU_DEPART, LD.ADRESSE_LIEU as ADRESS"
	    	  		+ "E_DEPART, LD.NUMERO_ZONE as ZONE_DEPART,\n"
	    	  		+ "        TA.LIEU_ARRIVEE, LA.NOM_LIEU as NOM_LIEU_ARRIVEE, LA.ADRESSE_LIEU as ADRE"
	    	  		+ "SSE_ARRIVEE, LA.NUMERO_ZONE as ZONE_ARRIVEE\n"
	    	  		+ "        from (TRAJET as TD inner join LIEU as LD on TD.LIEU_DEPART=LD.NUMERO_LIEU"
	    	  		+ ") inner join\n"
	    	  		+ "        (TRAJET as TA inner join LIEU as LA on TA.LIEU_ARRIVEE=LA.NUMERO_LIEU) us"
	    	  		+ "ing(DATE_DEPART,HEURE_DEPART)\n"
	    	  		+ "        where DATE_DEPART = \"" + dateTrajet+ "\" and (LD.NUMERO_ZONE=+" + depart + " or LD.NUMERO_ZONE=" + arrivee
	    	  		+ "1 or LA.NUMERO_ZONE="+ arrivee +" or LA.NUMERO_ZONE=" + depart+ ");\n";
 	     System.out.println("valeurs insérés");
 	     ResultSet rs = stmt.executeQuery(nn);   
 	    PrintWriter out = response.getWriter();
 	    out.println( "<HTML> \n<HEAD> \n <TITLE>Consultation des trajets existants</TITLE> \n</HEAD> \n<BODY>\n"); 
 	   out.println("<h1 style=\"text-align:center; background-color:powderblue;\">Resultats de recherche des trajets</h1>");
   	  	int num=1;
 	     while(rs.next()) {
 	    	 message="<h1> Trajet Trouvé" + num + ":</h1> \n <p>NUMERO_TRAJET " ;
 	    	 message+=rs.getString("NUMERO_TRAJET") + "</p>";
 	    	 message+="<p>Heure de depart: " + rs.getString("HEURE_DEPART") + "</p>";
 	    	 message+="<p>Adresse de depart: " + rs.getString("ADRESSE_DEPART") + "</p>";
 	    	 message+="<p>Adresse d'arrivee: " + rs.getString("ADRESSE_ARRIVEE") + "</p>";
 	    	 ResultSet rss = stmtD.executeQuery("select * from ETUDIANT where NUMERO_ETUDIANT = " + rs.getString("NUMERO_CREATEUR") + ";");
 	    	 rss.next();
 	    	 String a = rss.getString("PRENOM_ETUDIANT");
 	    	 String b = rss.getString("NOM_ETUDIANT");
 	    	 message+="<p> Createur Trajet: " + a + " "+ b+ "</p>";
 	    	 out.println(message);
 	    	 num++;
 	     }
 	     out.println( "</BODY>\n</HTML>\n" );
 	     out.close();
 	     this.getServletContext().getRequestDispatcher( "/Restreintes/afficheretudiant.jsp" ).forward( request, response );
 	       //return;
 	     
 	      //STEP 6: Clean-up environment
 	      stmt.close();
 	      conn.close();
 	   }catch(SQLException se){
 	      //Handle errors for JDBC
 		  //int rss = stmt.executeUpdate("insert into ETUDIANT values ("+ numeroE +","+"'"+ nom +"'"+","+"'"+ prenom +"'" +"," + "'" + telephone+ "'" + ","+"'"+ email +"');");
 		  //System.out.println("qpres l excecution de requete etudiant");
 		  //int ps = stmt.executeUpdate("insert into NEW values ('"+pseudo+"','"+nom+"','"+pass+"'); ");
 		  //message = "Bienvenue! Votre compte a été créé";
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
	
        System.out.println("COUCOUC JE suis KAAAAAA \n");
	    /* Transmission à la page JSP en charge de l'affichage des données */
        //this.getServletContext().getRequestDispatcher( "/afficheretudiant.jsp" ).forward( request, response );

  
}
	
}

