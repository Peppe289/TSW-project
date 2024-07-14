package org.dinosauri.dinosauri.model;

import java.sql.*;

public class Offerta {
    public String id_offerta;
    public String id_prodotto;
    public Date startDate;
    public Date endDate;
    public String description;
    public int percentage;

    public String getId_offerta() {
        return id_offerta;
    }

    public void setId_offerta(String id_offerta) {
        this.id_offerta = id_offerta;
    }

    public String getId_prodotto() {
        return id_prodotto;
    }

    public void setId_prodotto(String id_prodotto) {
        this.id_prodotto = id_prodotto;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getPercentage() {
        return percentage;
    }

    public void setPercentage(int percentage) {
        this.percentage = percentage;
    }
}
