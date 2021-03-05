<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.* , java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
* {
  box-sizing: border-box;
}

/* Set a background color */
body {
  background-color: Tomato;
  font-family: Helvetica, sans-serif;
}

/* The actual timeline (the vertical ruler) */
.timeline {
  position: relative;
  max-width: 1200px;
  margin: 0 auto;
}

/* The actual timeline (the vertical ruler) */
.timeline::after {
  content: '';
  position: absolute;
  width: 6px;
  background-color: white;
  top: 0;
  bottom: 0;
  left: 50%;
  margin-left: -3px;
}

/* Container around content */
.container {
  padding: 10px 40px;
  position: relative;
  background-color: inherit;
  width: 50%;
}

/* The circles on the timeline */
.container::after {
  content: '';
  position: absolute;
  width: 25px;
  height: 25px;
  right: -17px;
  background-color: white;
  border: 4px solid #FF9F55;
  top: 15px;
  border-radius: 50%;
  z-index: 1;
}

/* Place the container to the left */
.left {
  left: 0;
}

/* Place the container to the right */
.right {
  left: 50%;
}

/* Add arrows to the left container (pointing right) */
.left::before {
  content: " ";
  height: 0;
  position: absolute;
  top: 22px;
  width: 0;
  z-index: 1;
  right: 30px;
  border: medium solid white;
  border-width: 10px 0 10px 10px;
  border-color: transparent transparent transparent white;
}

/* Add arrows to the right container (pointing left) */
.right::before {
  content: " ";
  height: 0;
  position: absolute;
  top: 22px;
  width: 0;
  z-index: 1;
  left: 30px;
  border: medium solid white;
  border-width: 10px 10px 10px 0;
  border-color: transparent white transparent transparent;
}

/* Fix the circle for containers on the right side */
.right::after {
  left: -16px;
}

/* The actual content */
.content {
  padding: 20px 30px;
  background-color: white;
  position: relative;
  border-radius: 6px;
}

/* Media queries - Responsive timeline on screens less than 600px wide */
@media screen and (max-width: 600px) {
/* Place the timelime to the left */
  .timeline::after {
    left: 31px;
  }

/* Full-width containers */
  .container {
    width: 100%;
    padding-left: 70px;
    padding-right: 25px;
  }

/* Make sure that all arrows are pointing leftwards */
  .container::before {
    left: 60px;
    border: medium solid white;
    border-width: 10px 10px 10px 0;
    border-color: transparent white transparent transparent;
  }

/* Make sure all circles are at the same spot */
  .left::after, .right::after {
    left: 15px;
  }

/* Make all right containers behave like the left ones */
  .right {
    left: 0%;
  }
}
</style>
</head>
<body>
		<p style="font-size:50px; color:#FECEFE ; text-align:center"> Evenements prochains </p>
		<%final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
			//  Database credentials
			Connection conn = null;
			Statement stmt = null;
		   try{
			   //STEP 2: Register JDBC driver
			   Class.forName("com.mysql.jdbc.Driver");
		       //STEP 3: Open a connection
			   System.out.println("Connecting to database...");
			   conn = DriverManager.getConnection("jdbc:mysql://localhost/soiree","user","user");
               //STEP 4: Execute a query
			   System.out.println("Creating statement...");
			   stmt = conn.createStatement();
				String sql;
			    //sql = "SELECT NOM_EVENEMENT, NUMERO_TRAJET, DATE_DEPART FROM EVENEMENT natural join TRAJET where DATE_DEPART >= CURDATE() group by DATE_DEPART order by DATE_DEPART ASC;";
			    sql = "select NOM_EVENEMENT, NUMERO_TRAJET,DATE_DEPART from TRAJET inner join EVENEMENT where TRAJET.NUMERO_EVENEMENT = EVENEMENT.NUMERO_EVENEMENT and DATE_DEPART >= curdate() order by DATE_DEPART;";
			    ResultSet rs = stmt.executeQuery(sql);
			    ArrayList ev = new ArrayList();
			    ArrayList dt = new ArrayList();
			    ArrayList tj = new ArrayList();
				//STEP 5: Extract data from result set
				while(rs.next()){
							 //Retrieve by column name
							 String id = rs.getString("NUMERO_TRAJET");
							 tj.add(id);
							  String evenement = rs.getString("NOM_EVENEMENT");
							   ev.add(evenement);
							   String date = rs.getString("DATE_DEPART");	
							   dt.add(date);
							         //Display values
							    }
							      //STEP 6: Clean-up environment 
						  for(int i = 0; i<ev.size(); i=i+2){				    					
							out.print(" <div class='timeline'> ");
							 out.print(" <div class='container left'>");
							   out.print(" <div class='content'>");
							   out.print("  <h2>"+dt.get(i)+"</h2>");
							    out.print("  <p>"+ev.get(i)+" </p>");
							    out.print("  <p> ID du Trajet: "+tj.get(i)+" </p>");
								out.print("  </div>");
								 out.print(" </div>");
								 out.print("    </div>");
								out.print(" <div class='timeline'> ");
								 out.print("  <div class='container right'>");
								 out.print("   <div class='content'>");	
								 if (i+1<dt.size()){
							     out.print("   <h2>"+dt.get(i+1)+"</h2>");
							    out.print("  <p>"+ev.get(i+1)+"</p>");
							    out.print("  <p> ID du Trajet: "+tj.get(i+1)+" </p>"); }	 
							    out.print("    </div>");
							    out.print("    </div>");
							    out.print("    </div>");

						  }	  
		   				  rs.close();
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
              		   }//end try %>

</body>
</html>
