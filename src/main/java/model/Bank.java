package model;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Bank {
    private static String PREFIX = "52067";

    public static String getAccountNumber(String base, String login) {
        String result = "";
        try {
            Connection conn = DatabaseConnection.initializeDatabase(base);
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM klienci where login = '" + login + "';";
            ResultSet rs = stmt.executeQuery(sql);
            rs.next();
            int id = rs.getInt("idKlienta");
            System.out.println("ID = " + id);
            result = PREFIX + getString(id);
        }
        catch(ClassNotFoundException cnfe) {
            System.out.println("!!!" + cnfe.getMessage());
        }
        catch(SQLException se) {
            System.out.println("@@@"  +se.getMessage());
        }
        return result;
    }
    private static String getString(int id) {
        int dzielnik = 10000;
        String res = "";
        while (id > 0) {
            int x = id / dzielnik;
            id = id - x * dzielnik;
            res = res + x;
            dzielnik /=10;
        }
        return res;
    }
    public static int getBonus() {
        return 500;
    }
}
