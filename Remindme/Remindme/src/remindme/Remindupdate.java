package remindme;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class Remindupdate extends HttpServlet{


	private static final long serialVersionUID = 23423241L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException  {

		response.setContentType("text/html;charset=UTF-8");       
		PrintWriter out = response.getWriter();  

		String cc=request.getParameter("c");
		request.setAttribute("seqno",request.getParameter("a"));
		//String str = new String(request.getParameter("b").getBytes("iso-8859-1"), "utf-8");  
		String str = URLDecoder.decode(request.getParameter("b"), "UTF-8");
		request.setAttribute("remthing",str);
		request.setAttribute("remdate",cc.substring(0,10));
		request.setAttribute("remtime",cc.substring(11,16));
		request.setAttribute("reminder",request.getParameter("d"));
		request.setAttribute("remindper",request.getParameter("e"));
		request.setAttribute("remindfreq",request.getParameter("f"));
		request.setAttribute("remindway",request.getParameter("g"));

		RequestDispatcher d = request.getRequestDispatcher("RemindUpdate.jsp");
		d.forward(request,response);

	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws IOException, ServletException{	 
		doGet(request, response);

	}




}


