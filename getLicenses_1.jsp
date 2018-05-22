


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.*" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!--  Coded by Suman Bharadwaj 12 Feb 2014. -->

<%@ page import="java.util.*" %>
<%@ page import="javax.*" %>
<%@ page import="java.awt.Color" %>
<% 

java.sql.Connection con;
java.sql.Statement s,s1;
java.sql.ResultSet rs,rs1;
java.sql.PreparedStatement pst;


con=null;
s=null; s1= null;
pst=null;
rs=null; rs1=null;

// Remember to change the next line with your own environment 
//select str_to_date(sday,'%Y%m%d'), stime, tech product, lotid , waferid, testt, no, ttype, tool, mode, eday etime from TblTdDataLog where str_to_date(sday,'%Y%m%d') between '2013-03-17' and '2013-04-17';
/*String url=  "jdbc:oracle:thin:@fc8oras01.gfoundries.com:1521:yasst1";
String id= "tod_writer";
String pass = "Wr1ter_2013";*/


Map<String, String> hMap = new HashMap<String, String>();
Map<String, String> sMap = new HashMap<String, String>();
Map<String, String> serverMap = new HashMap<String, String>();
Map<String, String> factsMap = new HashMap<String, String>();
Map<String, Object> colorMap = new HashMap<String, Object>();
String toPrintTable = "";
String removeDotTmpServer = "";
String b = "";
int counter = 0;
Timestamp tdate=null;
String toPrintAHref = "";
String tns = "(DESCRIPTION = "
		+ " (FAILOVER=ON) "
		+ " (LOAD_BALANCE=OFF) "  
		+ " (ADDRESS = (PROTOCOL = TCP)(HOST = fc8racq4n1-vip)(PORT = 1521)) "
	
		+ "	(CONNECT_DATA = "
			+ " (SERVICE_NAME = wtestq1.gfoundries.com) " 
		+ " ) "
	+ " ) ";

String url = "jdbc:oracle:thin:@" + tns;
String id = "puppet_proj";
String pass = "changeme";





try{

	Class.forName("oracle.jdbc.driver.OracleDriver");
	con = DriverManager.getConnection(url, id, pass);

}catch(ClassNotFoundException cnfex){
cnfex.printStackTrace();

}

Statement stmtSchema = con.createStatement();          
String infoSql = "ALTER SESSION SET CURRENT_SCHEMA=PUPPET_PROJ";               
int check = stmtSchema.executeUpdate(infoSql);


/*
fc8tadmp03.gfoundries.com	lsbmajdistrelease	5
fc8tadmp03.gfoundries.com	blockdevices	fd0,hdc,sda,sdb,sdc,sdd,sde,sdf
fc8tadmp03.gfoundries.com	hostname	fc8tadmp03
fc8tadmp03.gfoundries.com	productname	VMware Virtual Platform
fc8tadmp03.gfoundries.com	swapsize	2.00 GB
fc8tadmp03.gfoundries.com	pe_patch_version	1
fc8tadmp03.gfoundries.com	boardmanufacturer	Intel Corporation

*/

String lastLoadDateSql = "select max(load_date) as load_date from puppet_mast where lower(factname) like 'license%' ";
infoSql = "select nodename,factname,factvalue from puppet_mast where lower(factname) like 'license%'   ";

try{
	System.out.println("2");
	s1 = con.createStatement();
	rs1 = s1.executeQuery(lastLoadDateSql);
  
	while( rs1.next() ){
		
		  tdate = rs1.getTimestamp(1);
	}

	System.out.println("----------------" + tdate);
	toPrintTable = "<p>" + " Last Updated for Licenses : " + tdate + "</p>";
   
	System.out.println("infoSql executing..." + infoSql + " <br>");



}catch(Exception xx) {}

toPrintTable += "<table id = \"licenses\"  class=\"display compact\" cellspacing=\"0\" width=\"100%\" >" + "<thead><tr>";

	try{
		System.out.println("2");
		s = con.createStatement();
		rs = s.executeQuery(infoSql);
      
		while( rs.next() ){
			
		      String server = rs.getString("nodename");
		      String fact = rs.getString("factname");
		      String value = rs.getString("factvalue");
		      String tmpvalue="";
		      String key  = server + "____" + fact;
		      String colorKey = fact + "____" + value;
		      String toColorFlag = "Yes";
		      Object a =null;
		      
		      if ( fact.equalsIgnoreCase("ipaddress")  || fact.equalsIgnoreCase("prober_ip_nic1") || fact.equalsIgnoreCase("prober_ip_nic2") || fact.equalsIgnoreCase("serialnumber")) {
		    	 toColorFlag = "No";
		      } else {
		    	 toColorFlag = "Yes";
		      }
		      
		      if ( value.contains("found:")) {
		    	  tmpvalue = value.replaceAll("found:", "");
		    	  value = tmpvalue.trim();
		      }
		    /* 
		       fc8tadmp03.gfoundries.com	lsbmajdistrelease	5
		      fc8tadmp03.gfoundries.com	blockdevices	fd0,hdc,sda,sdb,sdc,sdd,sde,sdf
		      fc8tadmp03.gfoundries.com	hostname	fc8tadmp03
		      fc8tadmp03.gfoundries.com	productname	VMware Virtual Platform
		      fc8tadmp03.gfoundries.com	swapsize	2.00 GB
		      fc8tadmp03.gfoundries.com	pe_patch_version	1
		      fc8tadmp03.gfoundries.com	boardmanufacturer	Intel Corporation */
		      
		     
		      
			 if ( serverMap.containsKey(server)) {
		   		  
		   		  serverMap.remove(server);
		   		  serverMap.put(server,server);
		   		  
		   		  
		   	  }else {
		   		serverMap.put(server,server);
		   		  
		   	  }
			 
			 if ( factsMap.containsKey(fact)) {
		   		  
				 factsMap.remove(fact);
				 factsMap.put(fact,fact);
		   		  
		   		  
		   	  }else {
		   		factsMap.put(fact,fact);
		   	   
		   	  }
			 
			 System.out.println(key + "BBBBUUUGGG  " + value);
		      
		   	  if ( sMap.containsKey(key)) {
		   		  
		   		  sMap.remove(key);
		   		  sMap.put(key,value);
		   		  
		   		  
		   	  }else {
		   		  sMap.put(key,value);
		   		  
		   	  }
		   	  
		  	if ( colorMap.containsKey(colorKey)) {
		
		
		  		//Color a = new Color((int)(Math.random() * 0x1000000));
		  		//System.out.println("Testing 1 : " + a.getRGB());
		  		if ( toColorFlag.equalsIgnoreCase("Yes")) {
		  		int rgb = (int)(Math.random() * 16777215);
		  		
		  		 if ( rgb > 0xFFFFFF )
		  		      rgb = 0xFFFFFF;
		  		 if ( rgb < 0 )
		  		      rgb = 0;

		  		 String str = "000000" + Integer.toHexString( rgb ); //$NON-NLS-1$ 
		  		  a =  "#" + str.substring( str.length( ) - 6 ); //$NON-NLS-1$ 
		  		  a = returnColor();
		  		} else {
		  		  a= "";
		  			
		  		}
		  		
		  		String tmpCompare = colorKey.toLowerCase();
		  		if (tmpCompare.contains("permanent")) {
		  			colorMap.remove(colorKey);
			  		colorMap.put(colorKey,"#FFFFFD");
		  		} else {
		  			colorMap.remove(colorKey);
			  		colorMap.put(colorKey,a);
		  		}
		  		
		  		
		  		
		   		  
		   		  
		   	  }else {
		   		//Color a = new Color((int)(Math.random() * 0x1000000));
			  		//System.out.println("Testing 1 : " + a.getRGB());
			  		if ( toColorFlag.equalsIgnoreCase("Yes")) {
			  			int rgb = (int)(Math.random() * 16777215);
			  		
			  			 if ( rgb > 0xFFFFFF )
			  		      rgb = 0xFFFFFF;
			  			 if ( rgb < 0 )
			  		      rgb = 0;

			  			 String str = "000000" + Integer.toHexString( rgb ); //$NON-NLS-1$ 
			  			 a =  "#" + str.substring( str.length( ) - 6 ); //$NON-NLS-1$ 
			  			 a = returnColor();
			  		} else {
			  			  a= "";
			  			
			  		}
		  		  
		  		
			  		String tmpCompare = colorKey.toLowerCase();
			  		if (tmpCompare.contains("permanent")) {
			  			colorMap.remove(colorKey);
				  		colorMap.put(colorKey,"#FFFFFD");
			  		} else {
			  			colorMap.remove(colorKey);
				  		colorMap.put(colorKey,a);
			  		}
			  		
		   	
		   		//colorMap.put(colorKey,a);
		   		  
		   	  }
		  		
		  		
		  /* hMap is unused hashMap for now */
	
  			if ( hMap.containsKey(key)) {
		   		  
  				hMap.remove(key);
  				hMap.put(key,key);
		   		  
		   		  
		   	  }else {
		   		hMap.put(key,key);
		   		  
		   	  }
		     
	
		}
	}
	catch(Exception e){e.printStackTrace();}
	finally{
		if(rs!=null) rs.close();
		if(s!=null) s.close();
		if(con!=null) con.close();
	}

	System.out.println("2");
	toPrintTable += "<th>" + "Server " + "</th>";  
	toPrintTable += "<th>" + "License " + "</th>";  
	toPrintTable += "<th>" + "Expiration " + "</th>";  
		
	toPrintTable += "</tr>"  + "</thead>" + "<tbody>"  ;  
	System.out.println("3");

	
		for (Map.Entry<String, String> en : sMap.entrySet()) {
			String rowClass="";
			String tmpServer = en.getKey().toString().split("____")[0];
			String tdVal = "";
			String bgcolor = "";
			//wts2101.gfoundries.com - print till the first dot.
			if ( tmpServer.indexOf(".") > 0 ) {
				int dotIndex = tmpServer.indexOf(".");
				removeDotTmpServer = tmpServer.substring(0, dotIndex);
				
			} else {
				removeDotTmpServer = tmpServer;
			}
			
			toPrintTable += "<tr><td>" + removeDotTmpServer + "</td>";
						
		
				String tmpFact = en.getKey().toString().split("____")[1];
				
				String getVal = en.getValue().toString();
				String colorKey = "";
				tdVal = getVal;
				colorKey = tmpFact +  "____"  + tdVal;
				
		
				if ( colorMap.containsKey(colorKey) ) {
					
					bgcolor = colorMap.get(colorKey).toString();
					//System.out.println("Bug ..." + colorMap.get(colorKey));
				}
				toPrintTable += "<td>" + tmpFact + "</td>" + "<td style='background-color:"  +  colorMap.get(colorKey) +  "'>" + tdVal + "</td>";  

		   		
		   		System.out.println(tdVal + "----bbbbbbuuuugggg---- " + tmpFact);
		   		//toPrintTable += "<td>" + tdVal + "</td>";  
		   		//System.out.println("<td>" + tdVal + "</td>"  );
			}
			toPrintTable += "</tr>";

	
	
	toPrintTable += "</tbody>";  
	
	toPrintTable += "</table>";  
	
	
	//out.println(toPrintAHref);
	System.out.println("4");
	out.println(toPrintTable);
	
%>


<%!
public String returnColor_1()
{
	Random rand = new Random();
	int r = rand.nextInt(256);
	int g = rand.nextInt(256) ;
	int b = rand.nextInt(256) ;
	 String colorBackToString = "#" + Integer.toHexString(r) +
		        Integer.toHexString(g) +
		        Integer.toHexString(b);
				System.out.println("color changed to " + colorBackToString);
	return colorBackToString;
	
}

public String returnColor() 
{
	
	//to get rainbow, pastel colors
	Random random = new Random();
	final float hue = random.nextFloat();
	final float saturation = 0.5f;//1.0 for brilliant, 0.0 for dull //0.9 was the original
	final float luminance = 1.0f; //1.0 for brighter, 0.0 for black
	Color color = Color.getHSBColor(hue, saturation, luminance);
	int rgb = Color.HSBtoRGB(hue, saturation, luminance);
    int r = (rgb >> 16) & 0xFF;
    int g = (rgb >> 8) & 0xFF;
    int b = rgb & 0xFF;
    String colorBackToString = "#" + Integer.toHexString(r) +
	        Integer.toHexString(g) +
	        Integer.toHexString(b);
			System.out.println("color changed to " + colorBackToString);
return colorBackToString;
			
			
			
}


%>




