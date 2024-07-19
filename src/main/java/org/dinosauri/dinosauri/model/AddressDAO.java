package org.dinosauri.dinosauri.model;

import java.sql.*;

public class AddressDAO {

    /**
     * Retrieve address object from database.
     *
     * @param user_id userID
     * @return Address object or null.
     */
    public static Address doRetrieveAddress(int user_id) {
        try (Connection con = ConnectionService.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM address WHERE id_utente = ?");
            ps.setInt(1, user_id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Address(rs.getString("nome"), rs.getString("cognome"), rs.getString("via"),
                        rs.getInt("cap"), rs.getString("provincia"), rs.getString("comune"),
                        rs.getString("numero_civico"));
            }
        } catch (SQLException ignore) {}
        return null;
    }

    /**
     * Update address for user in database. If exist already one address update, otherwise add new address.
     *
     * @param user_id user id
     * @param address address beans.
     */
    public static void doUpdateAddress(Integer user_id, Address address) {
        Address database_addr = doRetrieveAddress(user_id);
        try(Connection con = ConnectionService.getConnection()) {
            PreparedStatement ps;
            if (database_addr == null) {
                ps = con.prepareStatement("INSERT INTO address(id_utente, nome, cognome, via, cap, provincia, comune, numero_civico) VALUE (?, ?, ?, ?, ?, ?, ?, ?)");
                ps.setInt(1, user_id);
                ps.setString(2, address.getName());
                ps.setString(3, address.getCognome());
                ps.setString(4, address.getVia());
                ps.setInt(5, address.getCap());
                ps.setString(6, address.getProvincia());
                ps.setString(7, address.getComune());
                ps.setString(8, address.getNumero_civico());
                ps.executeUpdate();
            } else {
                ps = con.prepareStatement("UPDATE address SET nome = ?, cognome = ?, via = ?, cap = ?, provincia = ?, comune = ?, numero_civico = ? WHERE id_utente = ?");
                ps.setInt(8, user_id);
                ps.setString(1, address.getName());
                ps.setString(2, address.getCognome());
                ps.setString(3, address.getVia());
                ps.setInt(4, address.getCap());
                ps.setString(5, address.getProvincia());
                ps.setString(6, address.getComune());
                ps.setString(7, address.getNumero_civico());
                ps.executeUpdate();
            }
        } catch (SQLException ignore) {}
    }
}
