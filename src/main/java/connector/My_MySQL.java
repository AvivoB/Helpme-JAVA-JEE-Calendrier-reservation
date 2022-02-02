package connector;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class My_MySQL {
	
	public Connection Connexion() throws ClassNotFoundException, SQLException {
	    Class.forName("com.mysql.jdbc.Driver");

	    // variables
	    final String url = "jdbc:mysql://localhost:3306/dev3";
	    final String user = "root";
	    final String password = "";

	    // establish the connection
	    Connection conn = DriverManager.getConnection(url, user, password);

	    // display status message
	    if (conn == null) {
	       System.out.println("JDBC connection is not established");
	    } else
	       System.out.println("Congratulations," + 
	            " JDBC connection is established successfully.\n");

	    // close JDBC connection
	    
	    return conn;
	}
}
