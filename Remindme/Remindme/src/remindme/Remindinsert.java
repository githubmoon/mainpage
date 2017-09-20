package remindme;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class Remindinsert extends HttpServlet{
	

	private static final long serialVersionUID = 2341L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException  {
		
		 response.setContentType("text/html;charset=UTF-8");        
		 RequestDispatcher d = request.getRequestDispatcher("RemindInsert.jsp");
		 d.forward(request,response);
				
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws IOException, ServletException{	 
		doGet(request, response);
	}
	
}
