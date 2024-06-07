package org.dinosauri.dinosauri.model;

import java.util.ArrayList;
import java.util.List;

/**
 * The Product class represents a product with various attributes such as id, name, description,
 * power source, price, quantity, photo path, category, and discount.
 */
@SuppressWarnings({"SpellCheckingInspection", "unused"})
public class Product {
    private String id;
    private String name;
    private String description;
    private String alimentazione;
    private double price;
    private int quantity;
    private final List<String> photo_path; // photo path
    private String categoria; // category
    private int sconto; // discount

    /**
     * Default constructor to create an instance of Product with the initial discount set to 0.
     */
    public Product() {
        super();
        sconto = 0;
        this.photo_path = new ArrayList<>();
    }

    /**
     * Checks if two Product objects are equal based on their id.
     *
     * @param o the object to be compared with the current Product.
     * @return true if the objects are equal, otherwise false.
     */
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Product product = (Product) o;
        return id.equals(product.id);
    }

    /**
     * Generates a hash code for the product based on its ID.
     * This method is consistent with the equals' method. If two products are equal
     * (according to the equals method), they will have the same hash code.
     *
     * @return the hash code value for this product
     */
    @Override
    public int hashCode() {
        return id.hashCode();
    }

    /**
     * Gets the discount of the product.
     *
     * @return the discount of the product.
     */
    public int getSconto() {
        return sconto;
    }

    /**
     * Sets the discount of the product.
     *
     * @param sconto the new discount value.
     */
    public void setSconto(int sconto) {
        this.sconto = sconto;
    }

    /**
     * Gets the category of the product.
     *
     * @return the category of the product.
     */
    public String getCategoria() {
        return categoria;
    }

    /**
     * Sets the category of the product.
     *
     * @param categoria the new category of the product.
     */
    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    /**
     * Gets the photo path of the product.
     *
     * @return the photo path of the product.
     */
    public List<String> getPhoto_path() {
        return photo_path;
    }

    /**
     * Sets the photo path of the product.
     *
     * @param photo_path the new photo path of the product.
     */
    public void setPhoto_path(String photo_path) {
        this.photo_path.add(photo_path);
    }

    /**
     * Gets the power source of the product.
     *
     * @return the power source of the product.
     */
    public String getAlimentazione() {
        return alimentazione;
    }

    /**
     * Sets the power source of the product.
     *
     * @param alimentazione the new power source of the product.
     */
    public void setAlimentazione(String alimentazione) {
        this.alimentazione = alimentazione;
    }

    /**
     * Gets the id of the product.
     *
     * @return the id of the product.
     */
    public String getId() {
        return id;
    }

    /**
     * Sets the id of the product.
     *
     * @param id the new id of the product.
     */
    public void setId(String id) {
        this.id = id;
    }

    /**
     * Gets the name of the product.
     *
     * @return the name of the product.
     */
    public String getName() {
        return name;
    }

    /**
     * Sets the name of the product.
     *
     * @param name the new name of the product.
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Gets the description of the product.
     *
     * @return the description of the product.
     */
    public String getDescription() {
        return description;
    }

    /**
     * Sets the description of the product.
     *
     * @param description the new description of the product.
     */
    public void setDescription(String description) {
        this.description = description;
    }

    /**
     * Gets the price of the product.
     *
     * @return the price of the product.
     */
    public double getPrice() {
        return price;
    }

    /**
     * Sets the price of the product.
     *
     * @param price the new price of the product.
     */
    public void setPrice(double price) {
        this.price = price;
    }

    /**
     * Gets the quantity of the product.
     *
     * @return the quantity of the product.
     */
    public int getQuantity() {
        return quantity;
    }

    /**
     * Sets the quantity of the product.
     *
     * @param quantity the new quantity of the product.
     */
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
