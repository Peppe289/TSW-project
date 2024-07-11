package org.dinosauri.dinosauri.model;

import java.sql.*;
import java.util.*;

public class AdminDAO {

    /**
     * Retrieve all id of admin.
     *
     * @return - List of ID
     * @throws SQLException - catch exception in called method.
     */
    public static List<Admin> doRetrieveAllAdmin() throws SQLException {
        List<Admin> admins = new ArrayList<>();
        Connection con = ConnectionService.getConnection();
        PreparedStatement ps = con.prepareStatement("SELECT identificativo FROM amministratore");
        ResultSet rs =ps.executeQuery();
        while (rs.next()) {
            Admin admin = new Admin();
            admin.setId(rs.getString("identificativo"));
            admins.add(admin);
        }

        return admins;
    }

    /* TODO: implement insert */
    public static Admin insertInDatabase(String password) throws SQLException {
        Connection con = ConnectionService.getConnection();
        PreparedStatement ps = con.prepareStatement("insert into amministratore(password) values (SHA1(?))");
        ps.setString(1, password);
        ps.execute();

        return new Admin();
    }
}
