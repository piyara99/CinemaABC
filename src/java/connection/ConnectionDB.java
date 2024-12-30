package connection;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
public class ConnectionDB {
     private static final String JDBC_URL =  "jdbc:mysql://localhost:3306/cinemadb?zeroDateTimeBehavior=CONVERT_TO_NULL&useTimeZone=true&serverTimezone=UTC&autoReconnect=true&useSSL=false";
    private static final String JDBC_USER = "root"; 
private static final String JDBC_PASSWORD = "piyara";
    public static Connection getCon() throws ClassNotFoundException, SQLException{
        Class.forName("com.mysql.cj.jdbc.Driver");
         
            return DriverManager.getConnection(JDBC_URL,JDBC_USER ,JDBC_PASSWORD);
            
            
            
         
         
    }
    
    public int executeUpdate(String sql , Object[] values){
        int rowsAffected = 0;
        try(Connection conn = getCon();
                PreparedStatement ps = conn.prepareStatement(sql)){
            for(int i=0;i<values.length; i++){
                ps.setObject(i+1,values[i]);
                
            }
            rowsAffected = ps.executeUpdate();
        }
        catch(SQLException e){
            e.printStackTrace();
                    
                    } catch (ClassNotFoundException ex) {
             Logger.getLogger(ConnectionDB.class.getName()).log(Level.SEVERE, null, ex);
         }
        return rowsAffected;
                
    }
    
    
    

    
}

