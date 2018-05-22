
package db;
import db.OracleDBConnection;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.sql.*;


/**
 * Oracle DB Connection Singleton
 * @author suman
 *
 */
public class dataPartner {

static Connection conn;
static Connection conn1;
static PreparedStatement ps1;
static PreparedStatement ps;
static ResultSet rs1;
static ResultSet rs;

    
    /**
     * Private Constructor
     * @throws  
     */
 public dataPartner ()  	{ 
	 try {
		fnOpenCon();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
    	
   }
    
 public static void fnOpenCon() throws SQLException {
		try {
		conn = OracleDBConnection.getConnection();
		conn1 = OracleDBConnection.getConnection();
		} catch (Exception xx) {
			String info = "Exception @ dataPartner OpenCon  :" + xx.toString();
			xx.printStackTrace();
		}
		
	}

	public static void fnCloseCon() throws SQLException {
		
		try {
		
		if (conn != null) {
		
			conn.close();
		}
		
		if (conn1 != null) {
			
			conn1.close();
		}
		
		if (ps != null) {
			
			ps.close();
		}
		
		if (ps1 != null) {
			
			ps1.close();
		}
		

		if (rs != null) {
			
			rs.close();
		}
		} catch (Exception xx) {
			
			String info = "Exception @ Close Connection :" + xx.toString();
		
			
			
		}
	}
	

public static ArrayList<String> getServerList () throws SQLException  {
	ArrayList<String> servers = new ArrayList<String>();
	try {
		
	
	   	String serverQuery = "SELECT distinct (nodename) FROM puppet_mast ORDER BY nodename";
		Statement queryStmt = conn.createStatement();
		servers.clear();
		ResultSet rs1 = queryStmt.executeQuery(serverQuery);
		while (rs1.next()) {
				
				servers.add(rs1.getString(1));
		}
	
	 
	}catch(Exception xx) {xx.printStackTrace();}
	  return servers;
}
	
public static ArrayList<String> getFacts(String server) throws SQLException  {
	
	
	String tserver = "(" + server.trim().substring(0, server.length()-1) + ")" ;
	System.out.println("Server " + tserver);
	
	
	ArrayList<String> factvalues = new ArrayList<String>();

	String fvQuery = "SELECT distinct factname FROM puppet_mast where nodename  in " + tserver;
	System.out.println("Server " + fvQuery);
	Statement queryStmt2 = conn1.createStatement();
	//queryStmt2.executeQuery(queryStmt2)
		//queryStmt2.setString(1, tserver);
		factvalues.clear();
	
		ResultSet rs2 = queryStmt2.executeQuery(fvQuery);
		
		while (rs2.next()) {
			
			factvalues.add(rs2.getString(1));
		}

	
	
	return factvalues;
}


public static ArrayList<String> getFactValues (String server) throws SQLException  {
	
	
	String tserver = "(" + server.trim().substring(0, server.length()-1) + ")" ;
	System.out.println("Server " + tserver);
	
	
	ArrayList<String> factvalues = new ArrayList<String>();

	String fvQuery = "SELECT distinct factname||'_'||factvalue FROM puppet_mast where nodename  in " + tserver;
	System.out.println("Server " + fvQuery);
	Statement queryStmt2 = conn1.createStatement();
	//queryStmt2.executeQuery(queryStmt2)
		//queryStmt2.setString(1, tserver);
		factvalues.clear();
	
		ResultSet rs2 = queryStmt2.executeQuery(fvQuery);
		
		while (rs2.next()) {
			
			factvalues.add(rs2.getString(1));
		}


	
	return factvalues;
}


   
}