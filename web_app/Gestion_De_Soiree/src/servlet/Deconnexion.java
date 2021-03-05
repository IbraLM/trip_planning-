package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Deconnexion extends HttpServlet {
	public void doGet( HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException {
		request.getSession().invalidate();
		this.getServletContext().getRequestDispatcher( "/login.jsp" ).forward( request, response );
	}	
}
