package db;


import java.io.File;
import java.io.FileReader;
import java.io.LineNumberReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.FileHandler;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.logging.SimpleFormatter;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class DataLoaderPuppet {

	/**
	 * @param args
	 */
	private static Connection conn, conn1;
    
    private static PreparedStatement ps , ps1;
  
    static Logger logger;
    private static ResultSet rs = null;
    private static Statement st = null;
  
    static Map<String,String> JsonDataMap = new HashMap<String, String>();
	static Date date = new Date();
	
	static dataPartner dp = new dataPartner();
	static int version = 1;
	
	/* Running through command line.
	 * If the command line is empty, it runs as version 1
	 *  */
	public static void main(String[] args) throws Exception {
		
		try {
		 logger = Logger.getLogger(DataLoaderPuppet.class.getName()); 
		 FileHandler fh;  
		 String workingdirectory = System.getProperty("user.dir");
		 String FileName = workingdirectory + "//logs//" + "dataLoader" + ".csv";
		 
		//Start logging
		 fh = new FileHandler(FileName, true);  
	     logger.addHandler(fh);
	     SimpleFormatter formatter = new SimpleFormatter();  
	     fh.setFormatter(formatter);  
	     logger.setLevel(Level.INFO);   
		 System.out.println("Started Loading " + date);
         DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	     date = new Date();
	     String uploadLogStartDate = dateFormat.format(date).toString();
	     logger.info("Started" + uploadLogStartDate);
		 fnOpenCon();
	    
     	
	    
	  
	     
	    String folder = workingdirectory + "//data//";
	    System.out.println("Folder  " + folder);
	    File f = new File(folder); 
	    File subdir[] = f.listFiles();
	    for(File f_arr : subdir){
	       //  if(f_arr.isFile() && f_arr.getName().startsWith("14LPE_LPP_SRAM_DataTable") && f_arr.getName().endsWith("csv")){
	    	if(f_arr.isFile() && f_arr.getName().startsWith("facts") && f_arr.getName().endsWith("csv")){
	        
	        	 System.out.println("I am reading " + f_arr.getName());
	        	 logger.info("Reading File" + f_arr.getName());
	        	 fnReadFileLn(f_arr.getName());
	        	
	        	 
	         }
	             
	     }
	     
	    
         //End Logging
         date = new Date();
 	     String uploadLogEndDate = dateFormat.format(date).toString();
 	     String ClassName = new Object(){}.getClass().getEnclosingMethod().getName();
 	     logger.info("Ended" + uploadLogEndDate);
		 logger.info("End Program");  
		} catch(Exception xx) {
		    xx.printStackTrace();
			String info = xx.toString();
			String name = new Object(){}.getClass().getEnclosingMethod().getName();
			logger.info(info+name);
			
		}
		   System.out.println("Closing all connections");
		   fnCloseCon();
		   System.out.println(" Con closed for read");
}

private static void fnReadFileLn(String filename) throws Exception {
	
	
	
    FileReader fr = null;
    LineNumberReader lnr = null;
    int i;
    JsonDataMap=new HashMap<String, String>();
    String lineData  = "";
   
  
      try{
         // create new reader
    	  
    	  String workingdirectory = System.getProperty("user.dir") + "//data//";
	   
    	  String FileName = workingdirectory  + filename ;
    	  JSONParser parser = new JSONParser();
    	  JSONArray a = (JSONArray) parser.parse(new FileReader(FileName));

    	  for (Object o : a)
    	  {
    	    JSONObject person = (JSONObject) o;

    	    String name = ((String) person.get("name")).trim();
    	    //System.out.println(name);

    	    String certname = ((String) person.get("certname")).trim();
    	    //System.out.println(certname);

    	    String value = (String) person.get("value");
    	   // System.out.println(value);
    	    String newvalue = value.replaceAll("[\\t\\n\\r]"," ");
    	    value = newvalue.trim();
    	    
    	    lineData = certname + "____" + name + "____" + value;
    	    
    	    if ( JsonDataMap.containsKey(lineData)) {
    	    	
    	    	JsonDataMap.remove(lineData);
    	    	JsonDataMap.put(lineData, lineData);
    	    } else {
    	    	    	    	
    	    	JsonDataMap.put(lineData, lineData);
    	    }
    	     	 
    	} //End of Json Parser
    	  
    	 
    	
      System.out.println("Adding Records " );
      doInsert();
    	  
    
         
      }catch (Exception xx) {}
   
      
     
  
}


public static void doInsert() throws SQLException {
	try {
	  int puppet_pk = getMaxPK();
	  int rcounter = 0;
	  int maxRowsLoaded=0;
	  String SQL_INSERT = "INSERT INTO PUPPET_PROJ.PUPPET_MAST(NODENAME,FACTNAME,FACTVALUE ,PUPPET_PK,LOAD_DATE )" +
  					" values (?,?,?,?,TO_DATE(?,'dd/MM/yy hh24:mi:ss')) ";
	  
	  DateFormat dateFormat = new SimpleDateFormat("dd/MM/yy hh:mm:ss");
	  date = new Date();
	  String cdc_date = dateFormat.format(date).toString();
	  
  	System.out.println(cdc_date + " b1" + SQL_INSERT );
  	
  	ps1 = conn1.prepareStatement(SQL_INSERT);
  	System.out.println("b2" );
	  
	  for ( Map.Entry<String, String> dben : JsonDataMap.entrySet())
      {
		  puppet_pk = puppet_pk + 1;
		  String data = dben.getKey().toString();
		  String nodename = data.split("____",-1)[0];
   		  String factname = data.split("____",-1)[1];
   		  String factvalue = data.split("____",-1)[2];
   		  System.out.println("data " + nodename + "----" + factname + "----" + factvalue);
   		  ps1.setObject(1,nodename); //
          ps1.setObject(2,factname); //master pk
          ps1.setObject(3,factvalue); //
          ps1.setObject(4,puppet_pk); //
          ps1.setObject(5, cdc_date);
   		  rcounter++;
   		  
   		ps1.addBatch();
        
        if ((rcounter + 1) % 1000 == 0) {
           
        	System.out.println("Adding batch " + rcounter);
            ps1.executeBatch();
            ps1.clearBatch();
            maxRowsLoaded+=rcounter;
            rcounter=0;
            System.out.println("First Time : Loaded  " + maxRowsLoaded);
            
        }
		  
      } //end of for
	  
	  maxRowsLoaded+=rcounter;
      ps1.executeBatch();
 	  ps1.clearBatch();
  	 System.out.println("Reamining : Loaded  " + maxRowsLoaded);
	  
	} catch(Exception xx) {xx.printStackTrace();} 
}

	
	
public static int getMaxPK () {
	
	int maxpk  = 0;
	 try {
	    	
	    	int iVal;
	    	String SQL_CHECK = "SELECT max(puppet_pk) as maxpk from  PUPPET_PROJ.PUPPET_MAST";
	    	st = conn.createStatement();
	        rs = st.executeQuery(SQL_CHECK);
	        if (rs.next()) {
	        	maxpk = rs.getInt("maxpk");
	            if (rs.wasNull()) {
	                // handle NULL field value
	            	maxpk=0;
	            } 
	        } else {
	        	maxpk = 0;
	        	System.out.println("Max PK" + maxpk);
	        	
	        	
	        }
	    	
	 } catch(Exception xx) {}
	       
	 
	 maxpk = maxpk + 1;
	 return maxpk;
	
	
	
}



static void fnOpenCon() throws SQLException {
	try {
	conn = OracleDBConnection.getConnection();
	conn1 = OracleDBConnection.getConnection();
	} catch (Exception xx) {
		String info = "Exception  :" + xx.toString();
		String name = new Object(){}.getClass().getEnclosingMethod().getName();
		
		logger.info(info+name);
	}
	
}

static void fnCloseCon() throws SQLException {
	
	try {
	
	if (conn != null) {
	
		conn.close();
	}
	

	if (ps != null) {
		
		ps.close();
	}
	
	
	
	if (rs != null) {
		
		rs.close();
	}
	
	if (conn1 != null) {
		
		conn1.close();
	}
	

	if (ps1 != null) {
		
		ps1.close();
	}
	
	
	
	
	} catch (Exception xx) {
		
		String info = "Exception  :" + xx.toString();
		String name = new Object(){}.getClass().getEnclosingMethod().getName();
		logger.info(info+name);
		
	}
}


			
			
			
}

	
	
	
