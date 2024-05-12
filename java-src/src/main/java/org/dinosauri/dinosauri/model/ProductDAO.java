package org.dinosauri.dinosauri.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
    public Product doRetrieveProductByID(String id) {
        Product prod = null;
        try (Connection con = ConnectionService.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM prodotto WHERE id_prodotto = ?");
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                prod = new Product();
                prod.setId(rs.getString("id_prodotto"));
                prod.setName(rs.getString("nome"));
                prod.setPrice(rs.getDouble("prezzo"));
                prod.setDescription(rs.getString("descrizione"));
                prod.setAlimentazione(rs.getString("alimentazione"));
                prod.setPhoto_path(rs.getString("photo_path"));
                prod.setCategoria(rs.getString("categoria"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return prod;
    }
}
