package org.dinosauri.dinosauri.model;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;

import java.util.*;

public class Carrello extends HashMap<String, String> {

    public Carrello() {
        super();
    }

    public void setTotal(int total) {
        this.put("total", Integer.toString(total));
    }

    public void setAdded(int added) {
        this.put("added", Integer.toString(added));
    }

    public void setStatus() {
        setStatus(null);
    }

    public void setStatus(String status) {
        if (status == null) {
            status = "success";
        }

        this.put("status", status);
    }

    public String generateJson() throws JsonProcessingException {
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.writeValueAsString(this);
    }
}
