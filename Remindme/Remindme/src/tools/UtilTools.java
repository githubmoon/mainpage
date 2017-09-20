package tools;


import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import oracle.sql.TIMESTAMP;
import net.sf.json.JSONObject;
@SuppressWarnings({"unchecked","rawtypes"})
public class UtilTools {
	 /**
	銆��* 閫氱敤鍙栫粨鏋滄柟妗�杩斿洖list
	銆��*
	銆��* @param rs
	銆��* @return
	銆��* @throws SQLException
	銆��*/
   public static List extractData(ResultSet rs) throws SQLException {

      ResultSetMetaData md = rs.getMetaData();
	  int num = md.getColumnCount();
	  List listOfRows = new ArrayList();
	  while (rs.next()) {
		  	Map mapOfColValues = new HashMap(num);
			for (int i = 1; i <= num; i++) {
				java.util.Date dd = null;
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				String ddnew = "";
				String ddxx = "";
				if(rs.getObject(i) instanceof java.sql.Date){
					dd = SqlDate2utilDate((Date) rs.getObject(i));
				    ddnew = df.format(dd);
					mapOfColValues.put(md.getColumnName(i), ddnew);
				}else if(rs.getObject(i) instanceof oracle.sql.TIMESTAMP){
					ddxx =  getDateBySqlTimestamp((TIMESTAMP)rs.getObject(i), null);
					mapOfColValues.put(md.getColumnName(i), ddxx);
				}else if((rs.getObject(i))== null){				
					mapOfColValues.put(md.getColumnName(i), "");
				}else{
					mapOfColValues.put(md.getColumnName(i), rs.getObject(i));
				}
			}
		   listOfRows.add(mapOfColValues);

	  }
	 return listOfRows;
   }

   /**
    * 灏唋ist灏佽鎴怞SONObject
    * @param list
    * @return JSONObject
    */
   public static JSONObject list2JsonObject(List<?> list)
   {
	   Map<String, Object> jsonmap = new HashMap<String, Object>();
	   jsonmap.put("TotalCount", list.size());
	   jsonmap.put("Head", list);
	   
	   return JSONObject.fromObject(jsonmap);
   }
   /**
    * 鍥涜垗浜斿叆鏁板瓧
    * @param f 鏍煎紡鍖栫殑鏁板瓧
    * @param num 淇濈暀鍑犱綅灏忔暟
    * @return
    * @throws Exception
    */
   public static double numberRounding(double f,int num)throws Exception{
	   BigDecimal   b   =   new   BigDecimal(f);
	   double   f1   =   b.setScale(num,BigDecimal.ROUND_HALF_UP).doubleValue();
	   return f1;
	   
   }
   /**
    * Double绫诲瀷鏁板瓧杞崲鎴怢ong绫诲瀷
    * @param d
    * @return
    * @throws Exception
    */
   public static long doubletolong(double d)throws Exception{
		long l =new Double(d).longValue();
		return l;
   }
	
	public static String round2TenThousandScale(String orig)
	{
		BigDecimal d = new BigDecimal(orig);
		return d.divide(new BigDecimal(10000), BigDecimal.ROUND_HALF_DOWN).toString();
	}
	
	private static java.util.Date SqlDate2utilDate(java.sql.Date sqlDate)
	{
		if (null == sqlDate) return null;
		return new java.util.Date(sqlDate.getTime());
	}
	
//	private static java.util.Date SqlTime2utilTime(java.sql.Timestamp sqlTime)
//	{
//		if (null == sqlTime) return null;
//		return new java.util.Date(sqlTime.getTime());
//	}
	
	 public static String getDateBySqlTimestamp(Object obj, String formatStr) {  
	        try {  
	            TIMESTAMP t = (TIMESTAMP)obj;  
	            if (formatStr == null || formatStr.equals("")) {  
	                formatStr = "yyyy-MM-dd HH:mm";  
	            }  
	            Timestamp tt;  
	            tt = t.timestampValue();  
	            java.util.Date date = new java.util.Date(tt.getTime());  
	            SimpleDateFormat sd = new SimpleDateFormat(formatStr);  
	            return sd.format(date);  
	        } catch (SQLException e) {  
	            e.printStackTrace();  
	        }  
	        return "";  
	    }  
	 
	 public static Connection getConnection() throws Exception {
		 
		    Connection conn = null;

	       String driverName = "oracle.jdbc.driver.OracleDriver";
			String url = "jdbc:oracle:thin:@111.111.240.160:1521:oadb";
			//String url = "jdbc:oracle:thin:@111.111.224.24:1521:oa";
			String username = "jiashitest";
			//String username = "jiashi";
			String password = "password";		
			
	    	Class.forName(driverName);
			conn = DriverManager.getConnection (url,username,password);
			return conn;			
		 
	 }
}
