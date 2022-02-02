package modele;

import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;

import connector.My_MySQL;

public class Modele {
		
	private My_MySQL conn = new My_MySQL();
	private String table = "";
	
	public Modele() throws ClassNotFoundException, SQLException {}
	
	public ResultSet selectAll() throws SQLException, ClassNotFoundException {
	      // create JDBC statement object
		Statement st = this.conn.Connexion().createStatement();

	    // prepare SQL query
	    String query = "SELECT * from "+this.table;
	    ResultSet rs = st.executeQuery(query);
	    
	    this.conn.Connexion().close();
	      
  		return rs;
	}
	
	public ResultSet selectWhere(String[][] values) throws SQLException, ClassNotFoundException {
	      // create JDBC statement object
		Statement st = this.conn.Connexion().createStatement();
		
        String str = "";
        String str_final = "";
        for (String[] q : values){
            if (!q[1].contains("\"")) {
            	q[1] = "\""+q[1]+"\"";
            }
            str += String.join("",q) + " and ";        
        }
        str_final = str.substring( 0, str.length()-5);
        
	    // prepare SQL query
	    String query = "SELECT * from "+this.table + " where "+str_final+ ";" ;
	    System.out.println("query : " + query);
	    ResultSet rs = st.executeQuery(query);
	    this.conn.Connexion().close();
	      
		return rs;
	}
	
	public ResultSet selectWhere(String[][] values, String order_by) throws SQLException, ClassNotFoundException {
		// create JDBC statement object
		Statement st = this.conn.Connexion().createStatement();
		
		String str = "";
		String str_final = "";
		for (String[] q : values){
			if (!q[1].contains("\"")) {
				q[1] = "\""+q[1]+"\"";
			}
			str += String.join("",q) + " and ";        
		}
		str_final = str.substring( 0, str.length()-5);
		
		// prepare SQL query
		String query = "SELECT * from "+this.table + " where "+str_final+ " order by " + order_by ;
		System.out.println("query : " + query);
		ResultSet rs = st.executeQuery(query);
		this.conn.Connexion().close();
		
		return rs;
	}

	
	public void insert(String[] values) throws SQLException, ClassNotFoundException {
	      // create JDBC statement object
		Statement st = this.conn.Connexion().createStatement();
		String str = "";
		String str_final = "";
		for (String v : values) {
			str += "\"" + String.join(",",v) + "\"," ;
		}
		str_final = str.substring(0, str.length()-1);
		
	    // prepare SQL query
	    String query = "call ajout_"+this.table+"("+str_final+");" ;
	    System.out.println(query);
	    st.executeUpdate(query);
	    
	    this.conn.Connexion().close();
	}

	public void update(String[][] values, String id) throws SQLException, ClassNotFoundException {
	      // create JDBC statement object
		Statement st = this.conn.Connexion().createStatement();

        String str = "";
        String str_final = "";
        for (String[] q : values){
        	q[0] = q[0] + "=";
            if (!q[1].contains("\"")) {
            	q[1] = "\""+q[1]+"\"";
            }
            str += String.join("",q) + " , ";        
        }
        str_final = str.substring( 0, str.length()-2 );
        
	    // prepare SQL query
	    String query = "update "+this.table+" set "+ str_final +" where id = "+id+";" ;
	    System.out.println(query);
	    st.executeUpdate(query);
	    
	    this.conn.Connexion().close();
	}
	
	public void delete(String id) throws SQLException, ClassNotFoundException {
		// create JDBC statement object
		Statement st = this.conn.Connexion().createStatement();
		
		// prepare SQL query
		String query = "delete from "+this.table+" where id = "+id+";" ;
		st.executeUpdate(query);
		
		this.conn.Connexion().close();
	}
	
	public String getTable(){
		return this.table;
	}
	
	public void setTable(String table) {
		this.table = table;
	}
	
}
