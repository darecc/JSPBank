package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    public static Connection initializeDatabase(String base)
            throws SQLException, ClassNotFoundException
    {
        Connection conn = null;
        try {
            String dbDriver = "com.mysql.jdbc.Driver";
            String dbURL = "jdbc:mysql://localhost:3306/" + base + "?serverTimezone=UTC&allowPublicKeyRetrieval=true";
            System.out.println(dbURL);
            Class.forName(dbDriver);
            // webserwer.pl user: dceglarek_bank password: sdauser
            conn = DriverManager.getConnection(dbURL, "root", "admin");
        }
        catch(SQLException se) {
            System.out.println("Database connection:" + se.getMessage());
        }
        return conn;
    }
}