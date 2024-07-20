package org.dinosauri.dinosauri.model;

import java.sql.Date;
import java.sql.*;
import java.time.*;
import java.util.*;

public class OrdineDAO {

    /**
     * Retrieve total price from id elements list.
     *
     * @param id_elements list of product for this order.
     * @return total price for this order.
     */
    private static double doRetrieveTotalPrice(List<Integer> id_elements) {
        double total = 0;

        try (Connection con = ConnectionService.getConnection()) {
            for (Integer id : id_elements) {
                PreparedStatement ps = con.prepareStatement("SELECT * FROM elemento_prodotto WHERE id_elemento = ?");
                ps.setInt(1, id);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    total += rs.getDouble("prezzo");
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return total;
    }

    /**
     * Do retrieve name from protto table using id prodotto.
     *
     * @param products_id list of product id.
     * @return HashMap with product id and product name.
     */
    private static HashMap<String, String> doRetrieveProductName(List<String> products_id) {
        HashMap<String, String> map = new HashMap<>();

        try (Connection con = ConnectionService.getConnection()) {
            for (String id : products_id) {
                PreparedStatement ps = con.prepareStatement("SELECT * FROM prodotto WHERE id_prodotto = ?");
                ps.setString(1, id);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    map.put(id, rs.getString("nome"));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return map;
    }

    /**
     * Retrieve how much time is present this element.
     *
     * @param id_elements list of element id.
     * @return hashmap with product id and quantity.
     */
    private static HashMap<String, Integer> doRetrieveQuantityFromID(List<Integer> id_elements) {
        HashMap<String, Integer> map = new HashMap<>();

        try (Connection con = ConnectionService.getConnection()) {
            for (Integer id : id_elements) {
                PreparedStatement ps = con.prepareStatement("SELECT * FROM elemento_prodotto WHERE id_elemento = ?");
                ps.setInt(1, id);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    String key = rs.getString("id_prodotto");
                    if (map.get(key) == null) {
                        map.put(key, 1);
                    } else {
                        int quantity = map.get(key) + 1;
                        map.put(key, quantity);
                    }
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return map;
    }

    /**
     * Retrieve hashmap with price and id element.
     *
     * @param id_elements list with product id.
     * @return hashmap with id product and price.
     */
    private static HashMap<String, Double> doRetrieveAllPriceFromID(List<Integer> id_elements) {
        HashMap<String, Double> map = new HashMap<>();

        try (Connection con = ConnectionService.getConnection()) {
            for (Integer id : id_elements) {
                PreparedStatement ps = con.prepareStatement("SELECT * FROM elemento_prodotto WHERE id_elemento = ?");
                ps.setInt(1, id);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    map.put(rs.getString("id_prodotto"), rs.getDouble("prezzo"));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return map;
    }

    /**
     * Using order_id retrieve all elements in this order.
     *
     * @param order_number order id.
     * @return ID list of all elements.
     */
    private static List<Integer> doRetrieveElementID(int order_number) {
        List<Integer> id_elements = new ArrayList<>();
        try (Connection con = ConnectionService.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM prodotto_ordine WHERE numero_ordine = ?");
            ps.setInt(1, order_number);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                id_elements.add(rs.getInt("id_elemento"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return id_elements;
    }

    /**
     * Get address info using order_numer.
     *
     * @param order_number order id.
     * @return address object.
     */
    private static Address getAddressFromOrderID(int order_number) {
        Address address = null;
        try (Connection con = ConnectionService.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM dati_spedizione WHERE id_spedizione = ?");
            ps.setInt(1, order_number);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                address = new Address();
                address.setName(rs.getString("nome"));
                address.setCognome(rs.getString("cognome"));
                address.setCap(rs.getInt("cap"));
                address.setVia(rs.getString("via"));
                address.setProvincia(rs.getString("provincia"));
                address.setComune(rs.getString("comune"));
                address.setNumero_civico(rs.getString("numero_civico"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return address;
    }

    /**
     * Retrieve all information about all order for this user.
     *
     * @param user_id user id
     * @return list with order info.
     */
    public static List<Ordine> doRetrieveOrderListInfo(int user_id) {
        List<Ordine> orders = new ArrayList<>();

        try (Connection con = ConnectionService.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM ordini WHERE data_acquisto IS NOT NULL AND id_utente = ?");
            ps.setInt(1, user_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Ordine tmp = new Ordine();
                int order_number = rs.getInt("numero_ordine");
                tmp.address = getAddressFromOrderID(order_number);
                tmp.date = rs.getDate("data_acquisto").toLocalDate();
                /* retrieve the element in this order. */
                List<Integer> id_elements = doRetrieveElementID(order_number);
                /* from this we have product id not element id. */
                tmp.price = doRetrieveAllPriceFromID(id_elements);
                /* just a foolish counter when scroll element id. */
                tmp.quantity = doRetrieveQuantityFromID(id_elements);
                List<String> keys = new ArrayList<>(tmp.quantity.keySet());
                tmp.name = doRetrieveProductName(keys);
                tmp.total_price = doRetrieveTotalPrice(id_elements);
                orders.add(tmp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }

    /**
     * Convalidate order. Put id_elemento into prodotto order, block price in elemento_prodotto and make disponibility to false.
     *
     * @param user_id     user id.
     * @param id_elemento hashmap with id elemento and price (included offer)
     * @throws SQLException sql error.
     */
    public static void convalidateOrder(int user_id, HashMap<Integer, Double> id_elemento, Address address) throws SQLException {
        int key;
        Connection con = ConnectionService.getConnection();
        PreparedStatement ps = con.prepareStatement("INSERT INTO ordini(id_utente, data_acquisto) VALUES (?, ?)", PreparedStatement.RETURN_GENERATED_KEYS);
        ps.setInt(1, user_id);
        ps.setDate(2, Date.valueOf(LocalDate.now()));
        ps.executeUpdate();
        ResultSet rs = ps.getGeneratedKeys();

        if (rs.next()) {
            key = rs.getInt(1);
        } else {
            throw new SQLException();
        }

        for (Map.Entry<Integer, Double> entry : id_elemento.entrySet()) {
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

        ps = con.prepareStatement("INSERT INTO dati_spedizione(id_spedizione, nome, cognome, via, cap, provincia, comune, numero_civico) VALUE (?, ?, ?, ?, ?, ?, ?, ?)");
        ps.setInt(1, key);
        ps.setString(2, address.getName());
        ps.setString(3, address.getCognome());
        ps.setString(4, address.getVia());
        ps.setInt(5, address.getCap());
        ps.setString(6, address.getProvincia());
        ps.setString(7, address.getComune());
        ps.setString(8, address.getNumero_civico());
        ps.executeUpdate();
    }
}
