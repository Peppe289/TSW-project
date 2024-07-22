package org.dinosauri.dinosauri.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.*;

/**
 * The ProductDAO class provides methods to interact with the product database.
 */
@SuppressWarnings("SpellCheckingInspection")
public class ProductDAO {

    /**
     * Insert of new product into database.
     *
     * @param product - product data.
     */
    public static void doInsertProduct(Product product) throws SQLException {
        Connection con = ConnectionService.getConnection();
        synchronized (ProductDAO.class) {
            PreparedStatement ps = con.prepareStatement("INSERT INTO prodotto (id_prodotto, nome, descrizione, alimentazione, categoria, prezzo) VALUES (?, ?, ?, ?, ?, ?)");
            ps.setString(1, product.getId());
            ps.setString(2, product.getName());
            ps.setString(3, product.getDescription());
            ps.setString(4, product.getAlimentazione());
            ps.setString(5, product.getCategoria());
            ps.setDouble(6, product.getPrice());
            ps.executeUpdate();
        }
    }

    /**
     * insert into elemento_prodotto new element.
     *
     * @param id - id for product to add.
     */
    public static void doAddQuantityByID(String id) {
        try(Connection con = ConnectionService.getConnection()) {
            synchronized (ProductDAO.class) {
                PreparedStatement ps = con.prepareStatement("INSERT INTO elemento_prodotto(id_prodotto, disponibilita) VALUES (?, ?)");
                ps.setString(1, id);
                /* new product should be true by default. */
                ps.setBoolean(2, true);
                ps.executeUpdate();
            }
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * remove element from elemento_prodotto
     *
     * @param id - id product.
     */
    public static void doRemoveQuantityByID(String id) {
        /* get a list of all elements with this id. */
        ArrayList<Integer> list = (ArrayList<Integer>) doRetrieveProductByID(id,true);
        try (Connection con = ConnectionService.getConnection()) {
            synchronized (ProductDAO.class) {
                PreparedStatement ps = con.prepareStatement("DELETE FROM elemento_prodotto WHERE id_elemento = ?");
                /* remove one element. */
                ps.setInt(1, list.getFirst());
                ps.executeUpdate();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * This method need for update database information
     *
     * @param product - Product object.
     */
    public static void doUpdateByID(Product product) {
        try (Connection con = ConnectionService.getConnection()) {
            synchronized (ProductDAO.class) {
                PreparedStatement ps = con.prepareStatement("UPDATE prodotto SET nome = ? , descrizione = ? , alimentazione = ? , categoria = ? , prezzo = ? WHERE id_prodotto = ?");
                ps.setString(1, product.getName());
                ps.setString(2, product.getDescription());
                ps.setString(3, product.getAlimentazione());
                ps.setString(4, product.getCategoria());
                ps.setDouble(5, product.getPrice());
                ps.setString(6, product.getId());
                ps.executeUpdate();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

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
    public static List<Product> doRetrieveProducts(String keyword) {
        List<Product> products = new ArrayList<>();
        HashMap<String, Integer> offerte = getOfferte();

        try (Connection con = ConnectionService.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM prodotto WHERE descrizione LIKE ?");
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product prod = new Product();
                LoadFromResult(prod, offerte, rs);

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
    public static List<Product> doRetrieveProducts() {
        List<Product> products = new ArrayList<>();
        HashMap<String, Integer> offerte = getOfferte();

        try (Connection con = ConnectionService.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM prodotto");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product prod = new Product();
                LoadFromResult(prod, offerte, rs);

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
                LoadFromResult(prod, offerte, rs);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return prod;
    }

    /**
     * Populates a Product object with data obtained from a ResultSet and sets any applicable discounts.
     * <p>
     * This method performs the following operations:
     * - Sets the product ID using the value from the "id_prodotto" column of the ResultSet.
     * - Sets the product name using the value from the "nome" column of the ResultSet.
     * - Sets the product price using the value from the "prezzo" column of the ResultSet.
     * - Sets the product description using the value from the "descrizione" column of the ResultSet.
     * - Sets the product alimentation using the value from the "alimentazione" column of the ResultSet.
     * - Sets the product photo path using the value from the "photo_path" column of the ResultSet.
     * - Sets the product category using the value from the "categoria" column of the ResultSet.
     * - Checks if the product ID is present in the discounts map:
     * - If present, sets the product discount to the corresponding value from the map.
     * - If not present, sets the product discount to 0.
     *
     * @param prod    The product to be populated with data.
     * @param offerte A map containing discounts for products, where the key is the product ID and the value is the discount.
     * @param rs      The ResultSet containing the product data.
     * @throws SQLException If an error occurs while accessing the ResultSet data.
     */
    private static void LoadFromResult(Product prod, HashMap<String, Integer> offerte, ResultSet rs) throws SQLException {
        prod.setId(rs.getString("id_prodotto"));
        prod.setName(rs.getString("nome"));
        prod.setPrice(rs.getDouble("prezzo"));
        prod.setDescription(rs.getString("descrizione"));
        prod.setAlimentazione(rs.getString("alimentazione"));
        prod.setCategoria(rs.getString("categoria"));

        Integer off = offerte.get(prod.getId());
        if (off != null) prod.setSconto(off);
        else prod.setSconto(0);
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

    /**
     * Retrieve all categories.
     *
     * @return - list of categories.
     */
    public static List<String> doRetrieveCategories() {
        List<String> category = new ArrayList<>();

        try (Connection con = ConnectionService.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT categoria FROM prodotto");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                category.add(rs.getString("categoria"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return new ArrayList<>(new HashSet<>(category));
    }

    /**
     * Retrieve all nutrition.
     *
     * @return - list of nutrition.
     */
    public static List<String> doRetrieveNutrition() {
        List<String> nutritions = new ArrayList<>();

        try (Connection con = ConnectionService.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT alimentazione FROM prodotto");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String nut = rs.getString("alimentazione");
                /* check if nut is not null or not empty string. */
                if (nut != null && !nut.matches("^\\s+$") && !nut.isBlank())
                    nutritions.add(rs.getString("alimentazione"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return new ArrayList<>(new HashSet<>(nutritions));
    }

    /**
     * Check if this category has extra filtered (nutrition).
     *
     * @param category - category to check in database.
     * @return - boolean. have extra filtered or not.
     */
    public static boolean doRetrieveNIFutritionByCategory(String category) {
        boolean hasNutrition = false;
        try (Connection con = ConnectionService.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT alimentazione FROM prodotto WHERE categoria = ?");
            ps.setString(1, category);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                /* ignore row if value is null. */
                try {
                    if (!rs.getString("alimentazione").equals("null"))
                        hasNutrition = true;
                } catch (Exception ignore) {}
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return hasNutrition;
    }
}
