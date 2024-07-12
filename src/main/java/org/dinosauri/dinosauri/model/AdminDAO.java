package org.dinosauri.dinosauri.model;

import java.sql.*;
import java.util.*;

public class AdminDAO {

    /**
     * Try to authenticate
     *
     * @param id       - Admin id
     * @param password - Admin password
     * @return - boolean if id and password matched.
     */
    public static boolean authenticate(String id, String password) {
        boolean result = false;
        try (Connection con = ConnectionService.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT identificativo FROM amministratore WHERE password = SHA1(?)");
            ps.setString(1, password);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                if (rs.getInt("identificativo") == Integer.parseInt(id)) result = true;
            }
        } catch (SQLException ignore) {
        }

        return result;
    }

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
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Admin admin = new Admin();
            admin.setId(rs.getString("identificativo"));
            admins.add(admin);
        }

        return admins;
    }

    /**
     * Delete admin from id
     *
     * @param id - admin ID
     */
    public static boolean deleteAdmin(int id) {
        if (id <= 1)
            return false;

        try (Connection con = ConnectionService.getConnection()) {
            PreparedStatement ps = con.prepareStatement("DELETE FROM amministratore WHERE identificativo = ?");
            ps.setInt(1, id);
            ps.execute();
        } catch (SQLException e) {
            return false;
        }
        return true;
    }

    /**
     * Helper function used in this class for get id of new admin using password.
     *
     * @param password - password SHA1 to find.
     * @return - id of admin with this password
     * @throws SQLException - sql error.
     */
    private static int doRetrieveIDfromPassword(String password) throws SQLException {
        int id = 0;
        Connection con = ConnectionService.getConnection();
        PreparedStatement ps = con.prepareStatement("SELECT identificativo FROM amministratore WHERE password = SHA1(?)");
        ps.setString(1, password);
        ResultSet rs =ps.executeQuery();
        if (rs.next())
            id = rs.getInt("identificativo");

        return id;
    }

    /**
     * Create new admin using only password.
     * Then retrieve id from password to see id for this new admin.
     *
     * @param password - string random password
     * @return - admin id
     * @throws SQLException - sql error.
     */
    public static int insertInDatabase(String password) throws SQLException {
        Connection con = ConnectionService.getConnection();
        PreparedStatement ps = con.prepareStatement("INSERT INTO amministratore(password) VALUES (SHA1(?))");
        ps.setString(1, password);
        ps.execute();
        return doRetrieveIDfromPassword(password);
    }
}
