package org.dinosauri.dinosauri.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * The ProductDAO class provides methods to interact with the product database.
 */
@SuppressWarnings("SpellCheckingInspection")
public class ProductDAO {

    /**
     * Retrieves a key-value pair of product discounts where:
     * key > product ID to identify which product is involved
     * value > the integer percentage of the discount
     * <p>
     * Only currently valid discounts are returned, so a check with the current date is also performed.
     *
     * @return a HashMap containing the product ID and the discount percentage.
     */
    public static HashMap<String, Integer> getOfferte() {
        HashMap<String, Integer> offerte = new HashMap<>();

        try (Connection con = ConnectionService.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT id_prodotto, percentuale, data_inizio, data_fine FROM offerte");
            ps.executeQuery();
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                LocalDate start = rs.getDate("data_inizio").toLocalDate();
                LocalDate stop = rs.getDate("data_fine").toLocalDate();
                LocalDate today = LocalDate.now();

                if ((today.isEqual(start) || today.isAfter(start)) && today.isBefore(stop)) {
                    offerte.put(rs.getString("id_prodotto"), rs.getInt("percentuale"));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return offerte;
    }

    /**
     * Retrieves a list of products that match the given keyword in their description.
     *
     * @param keyword the keyword to search for in the product description.
     * @return a list of products that match the keyword.
     */
    public static List<Product> doRetriveProducts(String keyword) {
        List<Product> products = new ArrayList<>();
        HashMap<String, Integer> offerte = getOfferte();

        try (Connection con = ConnectionService.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM prodotto WHERE descrizione LIKE ?");
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product prod = new Product();
                prod.setId(rs.getString("id_prodotto"));
                prod.setName(rs.getString("nome"));
                prod.setPrice(rs.getDouble("prezzo"));
                prod.setDescription(rs.getString("descrizione"));
                prod.setAlimentazione(rs.getString("alimentazione"));
                prod.setPhoto_path(rs.getString("photo_path"));
                prod.setCategoria(rs.getString("categoria"));

                Integer off = offerte.get(prod.getId());
                if (off != null) prod.setSconto(off);
                else prod.setSconto(0);

                products.add(prod);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return products;
    }

    /**
     * Retrieves a list of all products.
     *
     * @return a list of all products.
     */
    public static List<Product> doRetriveProducts() {
        List<Product> products = new ArrayList<>();
        HashMap<String, Integer> offerte = getOfferte();

        try (Connection con = ConnectionService.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM prodotto");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product prod = new Product();
                prod.setId(rs.getString("id_prodotto"));
                prod.setName(rs.getString("nome"));
                prod.setPrice(rs.getDouble("prezzo"));
                prod.setDescription(rs.getString("descrizione"));
                prod.setAlimentazione(rs.getString("alimentazione"));
                prod.setPhoto_path(rs.getString("photo_path"));
                prod.setCategoria(rs.getString("categoria"));

                Integer off = offerte.get(prod.getId());
                if (off != null) prod.setSconto(off);
                else prod.setSconto(0);

                products.add(prod);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return products;
    }

    /**
     * Retrieves a product by its ID.
     *
     * @param id the ID of the product.
     * @return the product with the given ID, or null if no such product exists.
     */
    public static Product doRetrieveProductByID(String id) {
        Product prod = null;
        HashMap<String, Integer> offerte = getOfferte();
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

                Integer off = offerte.get(prod.getId());
                if (off != null) prod.setSconto(off);
                else prod.setSconto(0);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return prod;
    }

    /**
     * Retrieves the IDs of product items based on their availability status.
     * <p>
     * This method allows counting how many products are available and how many are not available
     * (i.e., the number of sold products) in a given category. The list of product item IDs is returned.
     * </p>
     *
     * @param id   the ID of the product.
     * @param disp the availability status (true for available, false for unavailable).
     * @return a list of product item IDs.
     */
    public static List<Integer> doRetrieveProductByID(String id, boolean disp) {
        List<Integer> counter = new ArrayList<>();
        try (Connection con = ConnectionService.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT id_elemento FROM elemento_prodotto WHERE id_prodotto = ? AND disponibilita = ?");
            ps.setString(1, id);
            ps.setBoolean(2, disp);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                counter.add(rs.getInt("id_elemento"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return counter;
    }
}
