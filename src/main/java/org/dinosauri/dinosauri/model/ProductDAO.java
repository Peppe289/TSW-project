package org.dinosauri.dinosauri.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class ProductDAO {

    /**
     * Questa funzione si occupa di prendere la coppia chiave valore delle offerte dove:
     * chiave > id_prodotto per capire quale prodotto è coinvolto
     * valore > il numero intero della percentuale
     * <p>
     * Vengono restituiti solo gli sconti attualmente validi, quindi viene anche effettuato
     * il controllo con la data attuale.
     */
    public static HashMap<String, Integer> getOfferte() {
        HashMap<String, Integer> offerte = new HashMap<String, Integer>();

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
     * Puoi contare quanti prodotti sono disponibili e quanti prodotti
     * non sono disponibili (= numero di prodotti venduti) di una determinata categoria.
     * Qui viene ritornata la lista degli id_elemento (singolo prodotto).
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
