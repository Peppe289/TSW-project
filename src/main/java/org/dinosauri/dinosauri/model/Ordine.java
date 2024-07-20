package org.dinosauri.dinosauri.model;

import java.time.*;
import java.util.*;

public class Ordine {
    public Address address;
    public Double total_price;
    public LocalDate date;
    /* ID generale - Name */
    public HashMap<String, String> name;
    /* ID generale - Quantity */
    public HashMap<String, Integer> quantity;
    /* ID generale - Price */
    public HashMap<String, Double> price;

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public Double getTotal_price() {
        return total_price;
    }

    public void setTotal_price(Double total_price) {
        this.total_price = total_price;
    }

    public HashMap<String, String> getName() {
        return name;
    }

    public void setName(HashMap<String, String> name) {
        this.name = name;
    }

    public HashMap<String, Integer> getQuantity() {
        return quantity;
    }

    public void setQuantity(HashMap<String, Integer> quantity) {
        this.quantity = quantity;
    }

    public HashMap<String, Double> getPrice() {
        return price;
    }

    public void setPrice(HashMap<String, Double> price) {
        this.price = price;
    }
}
