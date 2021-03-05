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

public class Commentaire extends HttpServlet {
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
	   String Nom = request.getParameter("pseudoConcerne");
	   //String Prenom = request.getParameter("PrenomConcerne");
	   String comment = request.getParameter("commentaire");
	   String eval = request.getParameter("eval");
        
 	      //STEP 2: Register JDBC driver
 	      Class.forName("com.mysql.jdbc.Driver");

 	      //STEP 3: Open a connection
 	      System.out.println("Connecting to database...");
 	      conn = DriverManager.getConnection(DB_URL,USER,PASS);

 	      //STEP 4: Execute a query
 	      System.out.println("Creating statement...");
 	      stmt = conn.createStatement();
 	      // Recuperer NUMERO_ETUDIANT correspondant au PSEUDO
		  HttpSession session = request.getSession();
 	      String sql = "select NUMERO_ETUDIANT from NEW where PSEUDO='"+session.getAttribute("Pseudo")+"';";
 	      System.out.println(session.getAttribute("Pseudo"));
 	      ResultSet ps = stmt.executeQuery(sql);
		  ps.next();		 
		  String numEt = ps.getString("NUMERO_ETUDIANT");
		  
		  // Recuperer l'ID du trajet
		  String sqli = "select ID from COMMTRAJ;";
 	      ResultSet ii = stmt.executeQuery(sqli);
 	      String id = null;
 	      if(!ii.next())
 	    	 EtatAvancement =0;
 	      else {
 	      	 id= ii.getString("ID");
 	      }
  	      	//
 	      
		  if (id !=null && !id.isEmpty() && numEt != null && !numEt.isEmpty() && comment != null && !comment.isEmpty() && EtatAvancement ==1 ) {
			  System.out.println("select * from INSCRIPTION where NUMERO_ETUDIANT="+numEt+" and NUMERO_TRAJET="+id+";");
			  String sqlreq = "select * from INSCRIPTION where NUMERO_ETUDIANT="+numEt+" and NUMERO_TRAJET="+id+";"; 
			  ResultSet imi = stmt.executeQuery(sqlreq);
			  //System.out.println();
			  if (imi.next() && EtatAvancement==1) {
				 
				  String sqlC = "select NUMERO_ETUDIANT from NEW where PSEUDO='"+ Nom+"';";
		 	      ResultSet c = stmt.executeQuery(sqlC);
		 	     String req ;
		 	      if(c.next()) {
		 	    	 String idC = c.getString("NUMERO_ETUDIANT");
		 	    	 req = "	insert into COMMENTAIRE (CONTENU_COMMENTAIRE, NUMERO_AUTEUR,NUMERO_CONCERNE, NUMERO_TRAJET) values ('"+comment+"',"+numEt+","+idC +" ,"+id+" );";
		 	      }
		 	      else {	
		 	    	 req = "insert into COMMENTAIRE (CONTENU_COMMENTAIRE, NUMERO_AUTEUR, NUMERO_TRAJET) values ('"+comment+"',"+numEt+","+id+" );";  
		 	      }
		 	      int rs = stmt.executeUpdate(req);
				  if(eval!=null && !eval.isEmpty()) {
					  System.out.println("h------ dans eval  ");
					  String sttt = "select NUMERO_COMMENTAIRE from COMMENTAIRE where NUMERO_AUTEUR='"+numEt+"'order by NUMERO_COMMENTAIRE desc;";
					  ResultSet ccc = stmt.executeQuery(sttt);
					  if(ccc.next()) {
						  
						  String stt="insert into EVALUATION(NUMERO_COMMENTAIRE,NOTE) values("+ ccc.getString("NUMERO_COMMENTAIRE")+"," + eval+");";
						  
						  boolean cncc = stmt.execute(stt);
						  //System.out.println("insert into EVALUATION(NUMERO_COMMENTAIRE,NOTE) values("+ ccc.getString("NUMERO_COMMENTAIRE")+"," + eval+");");
					  }
				  }
				  this.getServletContext().getRequestDispatcher(  "/Restreintes/Commentaire.jsp").forward( request, response );
			  }
			  else {
				  EtatAvancement = 0;
			  }
		  }
		 else {
			  EtatAvancement = 0;
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
 	   if ( EtatAvancement == 0)
 		   this.getServletContext().getRequestDispatcher(  "/commenterTraj").forward( request, response );
}
}
