package org.dinosauri.dinosauri.model;

/**
 * The User class represents a user with an ID, first name, last name, and email.
 */
@SuppressWarnings({"SpellCheckingInspection", "unused"})
public class User {
    public String id;
    public String nome;
    public String cognome;
    public String email;
    public boolean cookieAccess;

    /**
     * Return true if user is logged with cookie.
     * This is needed for security reason.
     * The user logged from cookie can't be bought or edit user settings.
     */
    public boolean isCookieAccess() {
        return cookieAccess;
    }

    /**
     * Set at login cookieAccess:
     *
     * @param cookieAccess - true if is logged from cookie, false otherwise.
     */
    public void setCookieAccess(boolean cookieAccess) {
        this.cookieAccess = cookieAccess;
    }

    /**
     * Gets the user's ID.
     *
     * @return the user's ID.
     */
    public String getId() {
        return id;
    }

    /**
     * Sets the user's ID.
     *
     * @param id the new ID to set.
     */
    public void setId(String id) {
        this.id = id;
    }

    /**
     * Gets the user's first name.
     *
     * @return the user's first name.
     */
    public String getNome() {
        return nome;
    }

    /**
     * Sets the user's first name.
     *
     * @param nome the new first name to set.
     */
    public void setNome(String nome) {
        this.nome = nome;
    }

    /**
     * Gets the user's last name.
     *
     * @return the user's last name.
     */
    public String getCognome() {
        return cognome;
    }

    /**
     * Sets the user's last name.
     *
     * @param cognome the new last name to set.
     */
    public void setCognome(String cognome) {
        this.cognome = cognome;
    }

    /**
     * Gets the user's email.
     *
     * @return the user's email.
     */
    public String getEmail() {
        return email;
    }

    /**
     * Sets the user's email.
     *
     * @param email the new email to set.
     */
    public void setEmail(String email) {
        this.email = email;
    }
}
