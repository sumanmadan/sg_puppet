
package db;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


/**
 * Oracle DB Connection Singleton
 * @author suman
 *
 */
public class OracleDBConnection {

	/* ---------------- Connection Parameters for Oracle database (MFGSYSP1) -------------- */
	private static final String tns = "(DESCRIPTION = "
			      							+ " (FAILOVER=ON) "
			      							+ " (LOAD_BALANCE=OFF) "  
	      									+ " (ADDRESS = (PROTOCOL = TCP)(HOST = fc8racq5n1-vip)(PORT = 1521)) "
	      								
	      									+ "	(CONNECT_DATA = "
	      										+ " (SERVICE_NAME = wtestq1.fc8racq5.gfoundries.com) " 
	  										+ " ) "
	  									+ " ) ";
	/*private static final String src_url = "jdbc:oracle:thin:@fc8orad03.gfoundries.com:1521:f8tdd1";
	private static final String src_username = "f8tdtest";
	private static final String src_password = "f8tdtest"; */
	
	//private static final String src_url = "jdbc:oracle:thin:@fc8racq5n1-vip:1521:wtestq12";
	private static final String src_url = "jdbc:oracle:thin:@" + tns;
	private static final String src_username = "puppet_proj";
	private static final String src_password = "changeme";
    
    private volatile static Connection connection;			//Static DB connection Reference
    
    
    
    /**
     * Private Constructor
     */
    private OracleDBConnection () 	{ 	}
    
    
    /**
     * Static method to access Connection
     * @return Oracle DB Connection
     */
	public static Connection getConnection() {
		
		if (connection == null ) {		
			synchronized (OracleDBConnection.class) {
				try {
		    		Class.forName ("oracle.jdbc.driver.OracleDriver");			//oracle
					connection = DriverManager.getConnection(src_url, src_username, src_password);
				} 
		    	catch (SQLException e) 				{ e.printStackTrace(); }
		    	catch (ClassNotFoundException e)	{ e.printStackTrace(); }
			}
		}
		return connection;
	}

}
