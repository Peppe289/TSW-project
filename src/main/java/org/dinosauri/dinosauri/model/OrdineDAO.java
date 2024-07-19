package org.dinosauri.dinosauri.model;

import java.sql.*;
import java.sql.Date;
import java.time.*;
import java.util.*;

public class OrdineDAO {

    /**
     * Convalidate order. Put id_elemento into prodotto order, block price in elemento_prodotto and make disponibility to false.
     *
     * @param user_id user id.
     * @param id_elemento hashmap with id elemento and price (included offer)
     * @throws SQLException sql error.
     */
    public static void convalidateOrder(int user_id, HashMap<Integer, Double> id_elemento) throws SQLException {
        int key;
        Connection con = ConnectionService.getConnection();
        PreparedStatement ps = con.prepareStatement("INSERT INTO ordini(id_utente, data_acquisto) VALUES (?, ?)", PreparedStatement.RETURN_GENERATED_KEYS);
        ps.setInt(1, user_id);
        ps.setDate(2, Date.valueOf(LocalDate.now()));
        ps.executeUpdate();
        ResultSet rs =  ps.getGeneratedKeys();

        if (rs.next()) {
            key = rs.getInt(1);
        } else {
            throw new SQLException();
        }

        for(Map.Entry<Integer, Double> entry : id_elemento.entrySet()) {
            ps = con.prepareStatement("INSERT INTO prodotto_ordine (id_elemento, numero_ordine) VALUES(?, ?)");
            ps.setInt(1, entry.getKey());
            ps.setInt(2, key);
            ps.executeUpdate();

            ps = con.prepareStatement("UPDATE elemento_prodotto SET prezzo = ?, disponibilita = ? WHERE id_elemento = ?");
            ps.setFloat(1, Float.parseFloat(entry.getValue().toString()));
            ps.setBoolean(2, false);
            ps.setInt(3, entry.getKey());
            ps.executeUpdate();
        }
    }
}
