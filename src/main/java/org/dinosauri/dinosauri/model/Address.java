package org.dinosauri.dinosauri.model;

public class Address {
    private String name;
    private String cognome;
    private String via;
    private Integer cap;
    private String provincia;
    private String comune;
    private String numero_civico;

    public Address(String name, String cognome, String via, Integer cap, String provincia, String comune, String numero_civico) {
        this.name = name;
        this.cognome = cognome;
        this.via = via;
        this.cap = cap;
        this.provincia = provincia;
        this.comune = comune;
        this.numero_civico = numero_civico;
    }

    public Address() {
        super();
        name = null;
        cognome = null;
        via = null;
        cap = null;
        provincia = null;
        comune = null;
        numero_civico = null;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCognome() {
        return cognome;
    }

    public void setCognome(String cognome) {
        this.cognome = cognome;
    }

    public String getVia() {
        return via;
    }

    public void setVia(String via) {
        this.via = via;
    }

    public Integer getCap() {
        return cap;
    }

    public void setCap(Integer cap) {
        this.cap = cap;
    }

    public String getProvincia() {
        return provincia;
    }

    public void setProvincia(String provincia) {
        this.provincia = provincia;
    }

    public String getComune() {
        return comune;
    }

    public void setComune(String comune) {
        this.comune = comune;
    }

    public String getNumero_civico() {
        return numero_civico;
    }

    public void setNumero_civico(String numero_civico) {
        this.numero_civico = numero_civico;
    }
}
