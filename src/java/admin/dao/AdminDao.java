package admin.dao;
import admin.model.Admin;
import admin.services.AdminService;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AdminDao implements AdminService{
    private final Connection conn;
    private String query;
    private PreparedStatement pst;
    private ResultSet rs;

    public AdminDao(Connection conn) {
        this.conn = conn;
    }
    
    @Override
    public Admin logAdmin(String email , String password){
        
        Admin admin = null;
             
        try {
            query = "SELECT * FROM admin WHERE email=? and password=?";
            pst = this.conn.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, password);
            rs = pst.executeQuery();  
            if(rs.next()){
                admin = new Admin();
                admin.setId(rs.getInt("id"));
                admin.setPassword(rs.getString("password"));
                admin.setEmail(rs.getString("email"));
                 
            }
        } catch (SQLException ex) {
            Logger.getLogger(AdminDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return admin;
        
    }
    
}
