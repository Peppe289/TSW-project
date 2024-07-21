package org.dinosauri.dinosauri.model;

import java.sql.*;
import java.util.*;

public class CarrelloDAO {

    /**
     * Delete all element from cart using id.
     *
     * @param user_id user id.
     * @param prodID id of product.
     * @throws SQLException sql error.
     */
    public static void doDeleteProdByID(int user_id, String prodID) throws SQLException {
        Connection con = ConnectionService.getConnection();
        int cartID = doCreateNewCart(user_id);
        PreparedStatement ps = con.prepareStatement("DELETE FROM prodotto_carrello WHERE numero_ordine = ? AND id_prodotto = ?");
        ps.setInt(1, cartID);
        ps.setString(2, prodID);
        ps.executeUpdate();
    }

    /**
     * Insert in database product id using user id.
     *
     * @param user_id user id.
     * @param productID product id.
     * @throws SQLException sql error.
     */
    public static void doInsertProdByID(int user_id, String productID, int quant) throws SQLException {
        int cartID = doCreateNewCart(user_id);
        Connection con = ConnectionService.getConnection();
        PreparedStatement ps = con.prepareStatement("SELECT * FROM prodotto_carrello WHERE id_prodotto = ? AND numero_ordine = ?");
        ps.setString(1, productID);
        ps.setInt(2, cartID);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            ps = con.prepareStatement("UPDATE prodotto_carrello SET quantita = ? WHERE id_prodotto = ? AND numero_ordine = ?");
            ps.setInt(1, quant);
            ps.setString(2, productID);
            ps.setInt(3, cartID);
            ps.executeUpdate();
        } else {
            ps = con.prepareStatement("INSERT INTO prodotto_carrello (id_prodotto, numero_ordine, quantita) VALUES (?, ?, ?)");
            ps.setString(1, productID);
            ps.setInt(2, cartID);
            ps.setInt(3, quant);
            ps.executeUpdate();
        }
    }

    /**
     * Compact use of function for faster coding.
     *
     * @param user_id user id
     * @return all lists of id in cart.
     */
    public static HashMap<String, Integer> doRetrieveAllIDFromUser(int user_id) {
        try {
            int cartID = doCreateNewCart(user_id);
            return doRetrieveAllID(cartID);
        } catch (SQLException e) {
            return null;
        }
    }

    /**
     * With card id retrieve all the row contains product id. Then add this in list and count for all elements.
     *
     * @param cart_id card id.
     * @return list of product id.
     */
    public static HashMap<String, Integer> doRetrieveAllID(int cart_id) {
        HashMap<String, Integer> id_prods = new HashMap<>();
        try (Connection con = ConnectionService.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM prodotto_carrello WHERE numero_ordine = ?");
            ps.setInt(1, cart_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next())
                id_prods.put(rs.getString("id_prodotto"), rs.getInt("quantita"));

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return id_prods;
    }

    /**
     * We use the same table as for ordini.
     * But if it isn't confirmed when use this table as the cart.
     * Retrieve orderID and then retrieve all products with this
     * id in other table.
     *
     * @param user_id user id.
     * @return order id for this user.
     */
    public static int doRetrieveCartID(int user_id) {
        try (Connection con = ConnectionService.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT numero_ordine FROM ordini WHERE data_acquisto IS NULL AND id_utente = ?");
                    ps.setInt(1, user_id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("numero_ordine");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return -1;
    }

    /**
     * If not exist cart create it. Generate the new ID and then retrieve it.
     *
     * @param userID user id
     * @return id of new cart
     * @throws SQLException sql error.
     */
    public static int doCreateNewCart(int userID) throws SQLException {
        int cartID = doRetrieveCartID(userID);
        if (cartID != -1) {
            return cartID;
        }
        Connection con = ConnectionService.getConnection();
        PreparedStatement ps = con.prepareStatement("INSERT INTO ordini(id_utente) VALUES (?)");
        ps.setInt(1, userID);
        ps.executeUpdate();
        /* retrieve new id. */
        return doRetrieveCartID(userID);
    }
}
