package remindme;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tools.UtilTools;




public class Remindsave extends HttpServlet{


	private static final long serialVersionUID = 234442341L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException  {

		response.setContentType("text/html;charset=UTF-8");       
		PrintWriter out = response.getWriter();  

		String hidden = request.getParameter("h");
		String inreminder = request.getParameter("reminder");
		String inremper = request.getParameter("remindper");
		String inremthing = request.getParameter("remindthing");	
		String inremdate = request.getParameter("reminddate");
		String inremtime = request.getParameter("remindtime");
		String inremfreq = request.getParameter("remindfreq");
		String inremway = request.getParameter("remindway");	  
		String test = inremdate.toString()+" "+inremtime.toString();
        
		SimpleDateFormat df1 = new SimpleDateFormat("yyyy-MM-dd");
		Date dd1 = null; 
		try{		 
			dd1 = df1.parse((String)(inremdate));
		}
		catch(Exception e){
			out.println("请按照‘年年年年-月月-日日’格式输入提醒日期！<br/>");	
		} 
		
		SimpleDateFormat df2 = new SimpleDateFormat("HH:mm");
		Date dd2 = null; 
		try{		 
			dd2 = df2.parse((String)(inremtime));
		}
		catch(Exception e){
			out.println("请按照‘时时:分分’格式【英文格式的冒号】输入提醒时间！<br/>");	
		} 

		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date dd = null; 
		try{		 
			dd = df.parse((String)(test));
			System.out.println(dd);
		}
		catch(Exception e){
			//out.println("请按规定格式输入提醒日期和提醒时间！<br/>");	
		} 
		if("".equals(inreminder) || "".equals(inremper) ||"".equals(inremthing) 
				|| "".equals(inremfreq)|| "".equals(inremway)){
			out.println("提醒内容必须录入完整！<br/>");		
		}
		else{	 
			if (hidden.equals("baocun")){

				try {
					create(inreminder,inremper,inremthing,dd,inremfreq,inremway);
					RequestDispatcher d = request.getRequestDispatcher("RemindInfo.jsp");
					d.forward(request,response);
				} catch (Exception e) {
					e.printStackTrace();
					out.println("新增失败！<br/>");    
				}				  

			}else if (hidden.equals("xiugai")){
				String seqno = request.getParameter("seqno");
				System.out.println(seqno);

				try {
					update(seqno,inreminder,inremper,inremthing,dd,inremfreq,inremway);
				} catch (ClassNotFoundException e) {
					e.printStackTrace();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				RequestDispatcher d = request.getRequestDispatcher("RemindInfo.jsp");
				d.forward(request,response);

			}

		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws IOException, ServletException{	 
		doGet(request, response);

	}

	private void update(String seqno, String reminder, String remper,String remthing, Date dd, 
			String remfreq,  String remway ) 
					throws ClassNotFoundException,SQLException{

		Connection conn = null;
		PreparedStatement ps =null;			
		try {
			conn = UtilTools.getConnection();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String sql = "update warm_reminder set reminder=?, remper=?, remthing=?, remtime=?, nextremtime=?,"
				+ "remfreq=?, remway=?, modtime=? where seqno=? ";
		ps = conn.prepareStatement(sql);
		ps.setString(1,reminder);
		ps.setString(2,remper);
		ps.setString(3,remthing);
		ps.setTimestamp(4, new Timestamp(dd.getTime()));
		ps.setTimestamp(5, new Timestamp(dd.getTime()));
		ps.setString(6,remfreq);
		ps.setString(7,remway);
		ps.setDate(8, utilDate2SqlDate(new Date()));
		ps.setString(9,seqno);
		int i = ps.executeUpdate();
		if(i>0){
			System.out.println("修改成功！");
		}else{
			System.out.println("修改失败！");
		}
		ps.close();
		conn.close();		     
	}

	private void create(String reminder, String remper,String remthing, Date dd, 
			String remfreq,  String remway ) 
					throws ClassNotFoundException,SQLException{

		Connection conn = null;
		PreparedStatement ps =null;			
		int seqno = getNextSequenceQuery();
		try {
			conn = UtilTools.getConnection();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String sql = "insert into warm_reminder(seqno,reminder,remper,remthing,remtime,nextremtime,"
				+ "remfreq,remway,typeintime,valflag) "
				+ "values (" +seqno+ ", ?, ?, ?, ?, ?, ?, ?, ?, 'Y')";
		ps = conn.prepareStatement(sql);
		ps.setString(1,reminder);
		ps.setString(2,remper);
		ps.setString(3,remthing);
		ps.setTimestamp(4, new Timestamp(dd.getTime()));
		ps.setTimestamp(5, new Timestamp(dd.getTime()));
		ps.setString(6,remfreq);
		ps.setString(7,remway);
		ps.setDate(8, utilDate2SqlDate(new Date()));		    
		int i = ps.executeUpdate();
		if(i>0){
			System.out.println("哈哈，添加成功啦！");
		}else{
			System.out.println("添加失败！");
		}
		ps.close();
		conn.close();		     
	}

	private int getNextSequenceQuery() throws ClassNotFoundException{

		Connection conn = null;
		PreparedStatement ps =null;
		ResultSet rs =null;

		int seqno = 1;
		try{
			try {
				conn = UtilTools.getConnection();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String sql = "SELECT WARM_REMINDER_NO_S.nextval FROM DUAL";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {		    	 
				seqno= rs.getInt(1);			
			}
			return seqno;
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
		return seqno;
	}



	private java.sql.Date utilDate2SqlDate(java.util.Date utilDate)
	{
		if (null == utilDate) return null;
		return new java.sql.Date(utilDate.getTime());
	}


}


