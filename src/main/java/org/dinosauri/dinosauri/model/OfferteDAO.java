package org.dinosauri.dinosauri.model;

import java.sql.*;
import java.util.*;

public class OfferteDAO {

    /**
     * Remove offers from the database.
     *
     * @param id - id_offerta
     * @throws SQLException - error.
     */
    public static void removeOffer(String id) throws  SQLException{
        Connection con = ConnectionService.getConnection();
        PreparedStatement ps = con.prepareStatement("DELETE FROM offerte WHERE id_offerta = ?");
        ps.setString(1, id);
        ps.execute();
    }

    /**
     * Insert offer in the database.
     * Should be some check from the controller before this.
     *
     * @param offerta - offer data.
     */
    public static void InsertOffers(Offerta offerta) throws SQLException {
        Connection con = ConnectionService.getConnection();
        PreparedStatement ps = con.prepareStatement("INSERT INTO offerte (id_prodotto, descrizione, percentuale, data_inizio, data_fine) VALUES (?, ?, ?, ?, ?)");
        ps.setString(1, offerta.getId_prodotto());
        ps.setString(2, offerta.getDescription());
        ps.setInt(3, offerta.getPercentage());
        ps.setDate(4, offerta.getStartDate());
        ps.setDate(5, offerta.getEndDate());
        ps.execute();
    }

    /**
     * Retrieve as list all offerts.
     *
     * @return - all offerts from database.
     */
    public static List<Offerta> doRetrieveOffers() {
        List<Offerta> off = new ArrayList<>();

        try (Connection con = ConnectionService.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM offerte");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                off.add(loadOfferta(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return off;
    }

    /**
     * Get all info about all offert for specified id.
     *
     * @param id_product - id of product.
     * @return - all offer data about id.
     */
    public static List<Offerta> doRetrieveOffers(String id_product) {
        List<Offerta> off = new ArrayList<>();

        try (Connection con = ConnectionService.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM offerte WHERE id_prodotto = ?");
            ps.setString(1, id_product);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                off.add(loadOfferta(rs));
            }
        } catch (SQLException ignore) {
        }

        return off;
    }

    /**
     * Set offert from a result set.
     *
     * @param rs - object with resource which contains a database result.
     * @return - destination object
     * @throws SQLException - database error in case of wrong column.
     */
    private static Offerta loadOfferta(ResultSet rs) throws SQLException {
        Offerta off = new Offerta();

        off.setId_offerta(String.valueOf(rs.getInt("id_offerta")));
        off.setId_prodotto(rs.getString("id_prodotto"));
        off.setDescription(rs.getString("descrizione"));
        off.setStartDate(rs.getDate("data_inizio"));
        off.setEndDate(rs.getDate("data_fine"));
        off.setPercentage(rs.getInt("percentuale"));

        return off;
    }
}
