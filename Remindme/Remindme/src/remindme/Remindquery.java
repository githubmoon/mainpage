package remindme;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tools.UtilTools;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


public class Remindquery extends HttpServlet{


	private static final long serialVersionUID = 2341L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException  {

		response.setContentType("text/json;charset=UTF-8");   
		PrintWriter out = response.getWriter();  

		// RequestDispatcher d = request.getRequestDispatcher("RemindInsert.jsp");
		// d.forward(request,response);

		List<Map<String, Object>> remindres =  new ArrayList<Map<String, Object>>();
		remindres = (List<Map<String, Object>>) query();
		response.getWriter().write(JSONArray.fromObject(remindres).toString());

		System.out.println(JSONArray.fromObject(remindres).toString());



	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws IOException, ServletException{	 
		//doGet(request, response);
		response.setContentType("text/html;charset=UTF-8");   
		// PrintWriter out = response.getWriter();  
		//RequestDispatcher d = request.getRequestDispatcher("RemindInsert.jsp");
		//d.forward(request,response);
	}
	private List<?> query(){

		Connection conn = null;
		PreparedStatement ps =null;
		ResultSet rs =null;

		try{
			try {
				conn = UtilTools.getConnection();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String sql = "select seqno, reminder, remper, remthing, nextremtime, remfreq, "
					+ "remway, typeintime, modtime, valflag  "
					+ "from warm_reminder where valflag='Y' order by nextremtime asc";
			ps = conn.prepareStatement(sql);
			ResultSet rs1 = ps.executeQuery();
			List<?> list=UtilTools.extractData(rs1);
			return list;
		}catch (SQLException e){
			e.printStackTrace();
		}finally{
			try{  
				if(rs!=null){
					rs.close();
				}
				if(ps!=null){
					ps.close();
				}
				if(conn!=null){
					conn.close();
				}
			}catch (SQLException e){
				e.printStackTrace();
			}
		}
		return null;
	}


}


