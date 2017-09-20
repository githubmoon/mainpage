package remindme;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
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

import javax.servlet.http.HttpServlet;

import tools.UtilTools;

public class Sendmsg  extends HttpServlet{



	private static final long serialVersionUID = 1L;

	@Override
	public void init() {

		System.out.println("测试中。。。");
		new Thread(new Runnable() {
			
			@Override
			public void run() {
				while(true){
					List<Map<String, Object>> remindres =  new ArrayList<Map<String, Object>>();
					remindres = (List<Map<String, Object>>) query();
					int count = 0;
					int remindressize = remindres.size();
					System.out.println("共有"+remindressize+"条待提醒消息：");
					
					for (Map<String, Object> m : remindres) {

						Date now = new Date(); 
						SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
						String date1 = df.format(now);
						String date2 = (String) m.get("NEXTREMTIME");
						System.out.println("第"+(count+1)+"条：");
						System.out.println("系统时间："+date1);
						System.out.println("待提醒时间："+date2);
						
						if(date1.compareTo(date2)>0){
							System.out.println("提醒时间已过，该条提醒消息置为无效！");
							Object sqlno =  m.get("SEQNO");
							long seqno = Integer.parseInt(sqlno.toString());
							try {
								update(seqno);
							} catch (ClassNotFoundException e) {
								e.printStackTrace();
							} catch (Exception e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
						}
							
						
						else if( date1.equals(date2)){
							System.out.println("提醒时间到啦！");
							List<String> mylist = new ArrayList<String>();
							List<String> parainfo = new ArrayList<String>();
							String output = "";
							Object sqlno =  m.get("SEQNO");
							long seqno = Integer.parseInt(sqlno.toString());

							String remthing = (String) m.get("REMTHING");
							String reminder = (String) m.get("REMINDER");
							String remper = (String) m.get("REMPER");
							String nextremtime = (String) m.get("NEXTREMTIME");
							String remfreq = (String) m.get("REMFREQ");
							String remway = (String) m.get("REMWAY");

							SimpleDateFormat df1 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
							Date dd = null; 
							try {
								dd = df1.parse((String)(nextremtime));
							} catch (ParseException e1) {
								e1.printStackTrace();
							}

							if( remway.equals("MSG") ){ //发送至短信平台							
							   parainfo = null;
								try {
									parainfo = queryinfo(reminder, remper);
								} catch (ClassNotFoundException e1) {
									e1.printStackTrace();
								} catch (Exception e) {
									// TODO Auto-generated catch block
									e.printStackTrace();
								}
								output="9998|"+parainfo.get(0)+"提醒你: "+remthing+"|1|"+parainfo.get(1)+"|";
								mylist.add(output);

								for(Iterator i=mylist.iterator();i.hasNext();){
									String sendresult = "";
									String sendmsg = (String)i.next();
									sendresult = sendMessage(sendmsg);  
									System.out.println(sendresult);
									if( sendresult.equals("1") ){ //如果发送失败
										if(remfreq.equals("O")){
											try {
												update(seqno);
											} catch (ClassNotFoundException e) {
												e.printStackTrace();
											} catch (Exception e) {
												// TODO Auto-generated catch block
												e.printStackTrace();
											}
										}else if(remfreq.equals("D")){ 
											try {
												updatetime(dd, 1, seqno);
											} catch (ClassNotFoundException e) {
												e.printStackTrace();
											} catch (Exception e) {
												// TODO Auto-generated catch block
												e.printStackTrace();
											}
										}else if(remfreq.equals("W")){ 
											try {
												updatetime(dd, 7, seqno);
											} catch (ClassNotFoundException e) {
												e.printStackTrace();
											} catch (Exception e) {
												// TODO Auto-generated catch block
												e.printStackTrace();
											}
										}else if(remfreq.equals("M")){ 
											try {
												int currentMonDays = getDayOfMonth();
												updatetime(dd, currentMonDays, seqno);
											} catch (ClassNotFoundException e) {
												e.printStackTrace();
											} catch (Exception e) {
												// TODO Auto-generated catch block
												e.printStackTrace();
											}
										}

									}
								}
							}				
						}
						count = count+1;
						
//						try {
//							Thread.sleep(30000);
//						} catch (InterruptedException ignored) {
//						}
						
						
					}
					if (count == remindressize)
					{
						System.out.println("提醒时间未到，30s后开始新一轮轮询！");
						try {
							Thread.sleep(30000);
						} catch (InterruptedException ignored) {
						}

					}


				}
			}

			private String parainfo(int i) {
				// TODO Auto-generated method stub
				return null;
			}

			private String phoneno(int i) {
				// TODO Auto-generated method stub
				return null;
			}
		},"scheduler").start();

	}



	private List<?> query(){

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try{
			conn = UtilTools.getConnection();
			String sql = "select * from warm_reminder where valflag='Y' order by nextremtime asc";
			ps = conn.prepareStatement(sql);
		    rs = ps.executeQuery();
			List<?> list=UtilTools.extractData(rs);
			return list;
		}catch (ClassNotFoundException e){
			e.printStackTrace();
		}catch (SQLException e){
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
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

	public String sendMessage(String message){
		Socket socket = null;
		try {
			socket = new Socket("111.111.240.193", 1024);//测试
	    	//socket = new Socket("192.168.8.3", 1024);//生产
			OutputStream outputStream = socket.getOutputStream();
			StringBuffer str = new StringBuffer();
			if (!"".equals(message)) {
				outputStream.write(message.getBytes("GBK"));
				outputStream.flush();
				BufferedReader br = new BufferedReader(
						new InputStreamReader(socket.getInputStream()));
				str.append(br.readLine());
				System.out.println("=====短信平台返回码：" + str.toString().trim());
				if ("1".equals(str.toString().trim())) {
					System.out.println("=====短信发送成功====\n短信内容" + message);
					return str.toString().trim();
				} else {
					System.out.println("=====短信处理失败====\n短信平台返回码："
							+ str.toString().trim());
					return str.toString().trim();
				}
			} else {
				System.out.println("=====没有数据=====");
				return "0";
			}

			//outputStream.close();
		} catch (Exception e) {
			System.out.println("=========短信发送失败=========" + e);
		} finally {
			if (socket != null && socket.isConnected()) {
				try {
					socket.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return "0";
	}

	private void update(long seqno) throws Exception{

		Connection conn = null;
		PreparedStatement ps =null;			

		try{
			conn = UtilTools.getConnection();
			String sql = "update warm_reminder set valflag = 'N' where seqno=?";
			ps = conn.prepareStatement(sql);
			ps.setLong(1,seqno);
			ps.executeUpdate();
			ps.close();
			conn.close();		     
		}catch (SQLException e){
			e.printStackTrace();
		}
	}

	private void updatetime(Date dd, int i, long seqno) throws Exception{

		Connection conn = null;
		PreparedStatement ps =null;			

		try{
			conn = UtilTools.getConnection();
			String sql = "update warm_reminder set remtime = ?, nextremtime = ? where seqno=? ";
			ps = conn.prepareStatement(sql);
			ps.setTimestamp(1, new Timestamp(dd.getTime()));
			long days = i*24*60*60;
			ps.setTimestamp(2, new Timestamp(((dd.getTime()/1000)+ days)*1000));
			ps.setLong(3,seqno);
			ps.executeUpdate();
			ps.close();
			conn.close();
			System.out.println("check result!");
		}catch (SQLException e){
			e.printStackTrace();
		}
	}
	
	private List<String> queryinfo (String reminder, String remper )throws Exception{

		Connection conn = null;
		PreparedStatement ps =null;		
		PreparedStatement ps1 =null;	
		String remper_nm= "";
		String phoneno = "";
		List<String> mylist = new ArrayList<String>();
		try{
			conn = UtilTools.getConnection();
			String sql = "select remper_nm from remper_para where remper =? ";
			ps = conn.prepareStatement(sql);
			ps.setString(1,reminder);
			ResultSet rs = ps.executeQuery();
			String sql1 = "select phoneno from remper_para where remper =? ";
			ps1 = conn.prepareStatement(sql1);
			ps1.setString(1,remper);
			ResultSet rs1 = ps1.executeQuery();
		    while(rs.next()) {	
		    	    remper_nm = rs.getString(1);
				    mylist.add(remper_nm);
			     }
		    while(rs1.next()) {	
		    	phoneno = rs1.getString(1);
			    mylist.add(phoneno);
		     }
			return mylist;
		}catch (SQLException e){
			e.printStackTrace();
		}
		return mylist;
	}

	public static int getDayOfMonth(){
		Calendar aCalendar = Calendar.getInstance(Locale.CHINA);
		int day=aCalendar.getActualMaximum(Calendar.DATE);
		return day;
	}

}
