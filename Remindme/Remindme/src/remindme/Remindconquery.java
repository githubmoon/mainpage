package remindme;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.Socket;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import oracle.sql.TIMESTAMP;
import tools.UtilTools;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


public class Remindconquery extends HttpServlet{


	private static final long serialVersionUID = 2341L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException  {

		response.setContentType("text/json;charset=UTF-8");   
		PrintWriter out = response.getWriter();  
		String inreminder = request.getParameter("reminder");    
		String inremindper = request.getParameter("remindper");

		List<Map<String, Object>> remindres =  new ArrayList<Map<String, Object>>();
		remindres = (List<Map<String, Object>>) query (inreminder, inremindper);
		response.getWriter().write(JSONArray.fromObject(remindres).toString());

       
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws IOException, ServletException{	 
		//doGet(request, response);
		response.setContentType("text/html;charset=UTF-8");   
		// PrintWriter out = response.getWriter();  
		RequestDispatcher d = request.getRequestDispatcher("RemindInsert.jsp");
		d.forward(request,response);
	}

	private List<?> query( String reminder, String remindper){

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
			String sql = "";
			if (!"".equals(reminder) && !"".equals(remindper)) {
				sql = "select * from warm_reminder where reminder= ? and remper = ? and "
						+ "valflag='Y' order by nextremtime asc";
				ps = conn.prepareStatement(sql);
				ps.setString(1,reminder);
				ps.setString(2,remindper);
			} else if (!"".equals(reminder) && "".equals(remindper)){
				sql = "select * from warm_reminder where reminder= ? and "
						+ "valflag='Y' order by nextremtime asc";
				ps = conn.prepareStatement(sql);
				ps.setString(1,reminder);
			}else if ("".equals(reminder) && !"".equals(remindper)){
				sql = "select * from warm_reminder where remper= ? and "
						+ "valflag='Y' order by nextremtime asc";
				ps = conn.prepareStatement(sql);
				ps.setString(1,remindper);
			}else{
				sql = "select * from warm_reminder where valflag='Y' order by nextremtime asc";	
				ps = conn.prepareStatement(sql);
			}
			System.out.println(reminder);
			System.out.println(remindper);
			System.out.println(sql);
			ResultSet rs1 = ps.executeQuery();
			List<?> list = UtilTools.extractData(rs1);
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


