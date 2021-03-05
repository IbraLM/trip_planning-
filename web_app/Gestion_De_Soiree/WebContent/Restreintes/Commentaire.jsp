<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.* , java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style type="text/css">
.commentaire{
  margin-top:20px;
  position:relative;
  
}

.commentaire:before{
  position:absolute;
  content:'';
  width:4px;
  height:calc(100% + 50px);
background: rgb(138,145,150);
background: -moz-linear-gradient(left, rgba(138,145,150,1) 0%, rgba(122,130,136,1) 60%, rgba(98,105,109,1) 100%);
background: -webkit-linear-gradient(left, rgba(138,145,150,1) 0%,rgba(122,130,136,1) 60%,rgba(98,105,109,1) 100%);
background: linear-gradient(to right, rgba(138,145,150,1) 0%,rgba(122,130,136,1) 60%,rgba(98,105,109,1) 100%);
filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#8a9196', endColorstr='#62696d',GradientType=1 );
  left:14px;
  top:5px;
  border-radius:4px;
}

.commentaire-NomEv{
  position:relative;
  padding:4px 15px 4px 35px;
  background-color:#a9b0ba;
  display:inline-block;
  width:auto;
  border-radius:40px;
  border:1px solid #17191B;
  border-right-color:black;
  margin-bottom:30px;
}

.commentaire-NomEv span{
  position:absolute;
  top:-1px;
  left:calc(100% - 10px);
  z-index:-1;
  white-space:nowrap;
  display:inline-block;
  background-color:#7d7d7d;
  padding:4px 10px 4px 20px;
  border-top-right-radius:40px;
  border-bottom-right-radius:40px;
  border:1px solid black;
  box-sizing:border-box;
}

.commentaire-NomEv:before{
  position:absolute;
  content:'';
  width:20px;
  height:20px;
background: rgb(138,145,150);
background: -moz-linear-gradient(top, rgba(138,145,150,1) 0%, rgba(122,130,136,1) 60%, rgba(112,120,125,1) 100%);
background: -webkit-linear-gradient(top, rgba(138,145,150,1) 0%,rgba(122,130,136,1) 60%,rgba(112,120,125,1) 100%);
background: linear-gradient(to bottom, rgba(138,145,150,1) 0%,rgba(122,130,136,1) 60%,rgba(112,120,125,1) 100%);
filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#8a9196', endColorstr='#70787d',GradientType=0 );
  border-radius:100%;
  border:1px solid #17191B;
  left:5px;
}

.commentaire-section{
  padding-left:35px;
  display:block;
  position:relative;
  margin-bottom:30px;
}

.commentaire-topev{
  margin-bottom:15px;
  padding:2px 15px;
  background:linear-gradient(#74cae3, #5bc0de 60%, #4ab9db);
  position:relative;
  display:inline-block;
  border-radius:20px;
  border:1px solid #17191B;
  color:#fff;
text-shadow:1px 1px 1px rgba(0,0,0,0.3);
}
.commentaire-section:before{
  content:'';
  position:absolute;
  width:30px;
  height:1px;
  background-color:#777ed4 ;
  top:12px;
  left:20px;
}

.commentaire-section:after{
  content:'';
  position:absolute;
  width:10px;
  height:10px;
  background:linear-gradient(to bottom, rgba(138,145,150,1) 0%,rgba(122,130,136,1) 60%,rgba(112,120,125,1) 100%);
  top:7px;
  left:11px;
  border:1px solid #777ed4 ;
  border-radius:100%;
}

.commentaire-section .col-sm-4{
  margin-bottom:15px;
}

.commentaire-box{
  position:relative;
  
 background-color:#E4DBD9;
  border-radius:15px;
  border-top-left-radius:0px;
  border-bottom-right-radius:0px;
  border:1px solid #17191B;
  transition:all 0.3s ease;
  overflow:hidden;
}

.box-icon{
  position:absolute;
  right:5px;
  top:0px;
}

.box-title{
  padding:5px 15px;
  border-bottom: 1px solid #17191B;
}

.box-title i{
  margin-right:5px;
}

.box-content{
  padding:5px 15px;
  background-color:#A69E9C ;
}

.box-content strong{
  color:#666;
  font-style:italic;
  margin-right:5px;
}

.box-item{
  margin-bottom:5px;
}

.box-footer{
 padding:5px 10px;
  border-top: 1px solid #17191B;
  background-color:#E4DBD9;
  text-align:right;
  font-style:italic;
}

</style>
</head>
<body>
    <%	 // JDBC driver name and database URL
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

							      //STEP 4: Execute a query
							      System.out.println("Creating statement...");
							      stmt = conn.createStatement();
							      String sql;
							      sql = "SELECT CONTENU_COMMENTAIRE, NUMERO_TRAJET,NOM_ETUDIANT, PRENOM_ETUDIANT FROM COMMENTAIRE inner join ETUDIANT where COMMENTAIRE.NUMERO_AUTEUR=ETUDIANT.NUMERO_ETUDIANT;";
							      ResultSet rs = stmt.executeQuery(sql);

							      //STEP 5: Extract data from result set
							      while(rs.next()){
							    	 out.print( "<div class='commentaire'>");
							         out.print("<div class='commentaire-NomEv'>");
									 out.print("Trajet: " +rs.getString("NUMERO_TRAJET"));
									 out.print("</div>");
								     out.print("<div class='commentaire-section'>");
								     out.print(" <div class='commentaire-topev'>");
									 out.println("*****");
								     out.print("  </div>");
									 out.print(" <div class='row'>");
									 out.print("     <div class='col-sm-4'>");
									 out.print("     <div class='commentaire-box'>");
									 out.print("         <div class='box-title'>");
									 out.print("</div>");
									 out.print("  <div class='box-content'>");
									 out.print("<div class='box-item'><strong>Contenu</strong>:"+rs.getString("CONTENU_COMMENTAIRE")+"</div>");
								     out.print(" </div>");
									 out.print("<div class='box-footer'>"+rs.getString("NOM_ETUDIANT")+ " " +rs.getString("PRENOM_ETUDIANT")+"</div>");
									 out.print("</div>");
									 out.print("</div>");
									 out.print("</div>");
									 out.print("</div>");
									 out.print("</div>");
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