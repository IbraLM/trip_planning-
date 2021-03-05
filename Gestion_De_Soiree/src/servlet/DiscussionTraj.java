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

public class DiscussionTraj extends HttpServlet {
	public void doGet( HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException {
		
		    String numeroT = request.getParameter( "disc" );    
	        request.setAttribute("numT", numeroT);
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
				  stmt = conn.createStatement();

			      //STEP 4: Execute a query
			      System.out.println("Creating statement...");
			      String supp = "truncate table DISCTRAJ;";
				  int sp = stmt.executeUpdate(supp);
				  Statement stmtD = conn.createStatement();

		          String sql = "insert into DISCTRAJ values ("+numeroT+", now());";
			      int rs = stmtD.executeUpdate(sql);
			      
			        

				 
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
		this.getServletContext().getRequestDispatcher( "/Restreintes/chat.jsp" ).forward( request, response );
	    //this.getServletContext().getRequestDispatcher( "/Restreintes/chat.jsp" ).forward( request, response );
	}
}
