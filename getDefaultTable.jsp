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
<%@ page import="javax.*;" %>
<% 

java.sql.Connection con;
java.sql.Statement s;
java.sql.ResultSet rs;
java.sql.PreparedStatement pst;

con=null;
s=null;
pst=null;
rs=null;

// Remember to change the next line with your own environment 
//select str_to_date(sday,'%Y%m%d'), stime, tech product, lotid , waferid, testt, no, ttype, tool, mode, eday etime from TblTdDataLog where str_to_date(sday,'%Y%m%d') between '2013-03-17' and '2013-04-17';
/*String url=  "jdbc:oracle:thin:@fc8oras01.gfoundries.com:1521:yasst1";
String id= "tod_writer";
String pass = "Wr1ter_2013";*/


Map<String, String> hMap = new HashMap<String, String>();
Map<String, String> sMap = new HashMap<String, String>();
Map<String, String> serverMap = new HashMap<String, String>();
Map<String, String> factsMap = new HashMap<String, String>();
String b = "";
int counter = 0;
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
String sql = "ALTER SESSION SET CURRENT_SCHEMA=PUPPET_PROJ";               
int check = stmtSchema.executeUpdate(sql);




sql = "SELECT * FROM puppet_mast ORDER BY factname";
System.out.println("sql executing..." + sql + " <br>");

%>


<% 


String toPrintTable = "<table id = \"example\"  class=\"display compact\" cellspacing=\"0\" width=\"100%\" >" + "<thead><tr>";
toPrintAHref = "<ul id = \"tree1\"> <li><label> Toggle Column </label> <ul>";
toPrintAHref += "<a href=\"javascript:void(0);\" class=\"LinkButton\"" + "onclick=\"fnShowHide(0);\"" + ">Toggle Server<br></a>";
	try{
		System.out.println("1");
		s = con.createStatement();
		rs = s.executeQuery(sql);
      
		while( rs.next() ){
			
		      String server = rs.getString("nodename");
		      String fact = rs.getString("factname").toString();
		      String value = rs.getString("factvalue");
		      String key  = server + "____" + fact;
		      
		    
		      
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
			 
			 
		      
		   	  if ( sMap.containsKey(key)) {
		   		  
		   		  sMap.remove(key);
		   		  sMap.put(key,value);
		   		  
		   		  
		   	  }else {
		   		  sMap.put(key,value);
		   		  
		   	  }
		   	  
		   	  
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
	for (Map.Entry<String, String> entry : factsMap.entrySet()) {
	   String thead = entry.getKey().toString();
		
		toPrintTable += "<th>" + thead + "</th>";  
		System.out.println(thead);
	    

	}
	
	
	
	
	toPrintTable += "</tr>"  + "</thead>" + "<tbody>"  ;  
	System.out.println("3");

	
		for (Map.Entry<String, String> en : serverMap.entrySet()) {
			
			String tmpServer = en.getKey().toString();
			toPrintTable += "<tr><td>" + tmpServer + "</td>";
			for (Map.Entry<String, String> entry : factsMap.entrySet()) {
				
				String tdVal = "None";
				String tmpFact = entry.getKey().toString();
				
				String getVal = tmpServer + "____" + tmpFact;
				
				
				if ( sMap.containsKey(getVal)) {
					
				   tdVal = sMap.get(getVal);
					
				}  else {
					tdVal = "None";
				}
		
		   		toPrintTable += "<td>" + tdVal + "</td>";  
		   		//System.out.println("<td>" + tdVal + "</td>"  );
			}
			toPrintTable += "</tr>";
		}   
	
	
	toPrintTable += "</tbody>";  
	
	toPrintTable += "</table>";  
	
	for (Map.Entry<String, String> entry : factsMap.entrySet()) {
		String tmpFact = entry.getKey().toString();
		counter++;
		toPrintAHref += "<li><a href=\"javascript:void(0);\" class=\"LinkButton\" " + "onclick=\"fnShowHide(" + counter + ");\"" + ">Toggle " + tmpFact +"<br></a> - " ;  
	
	}
	toPrintAHref += "</ul></ul>";
	//out.println(toPrintAHref);
	System.out.println("4");
	out.println(toPrintTable);
	
%>






