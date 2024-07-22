package org.dinosauri.dinosauri.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

/**
 * This class manages user data access operations in the database.
 */
@SuppressWarnings("SpellCheckingInspection")
public class UserDAO {

    /**
     * From email retrieve user data.
     *
     * @param id - user id.
     * @return - user data.
     */
    public static User doRetrieveUserFromID(String id) {
        User user = null;
        try (Connection con = ConnectionService.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM utente WHERE id_utente = ?");
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getString("id_utente"));
                user.setNome(rs.getString("nome"));
                user.setCognome(rs.getString("cognome"));
                user.setEmail(rs.getString("email"));
            }
        } catch(SQLException e) {
            throw new RuntimeException(e);
        }

        return user;
    }

    /**
     * Retrieve all user data (exception password for security reason).
     *
     * @return list of all data from all user.
     */
    public static List<User> doRetrieveAllUsers() {
        List<User> users = new ArrayList<>();
        try (Connection con = ConnectionService.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT id_utente, nome, cognome, email FROM utente");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getString("id_utente"));
                user.setNome(rs.getString("nome"));
                user.setCognome(rs.getString("cognome"));
                user.setEmail(rs.getString("email"));
                users.add(user);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return users;
    }

    /**
     * Retrieves a user from the database based on the provided email and password.
     *
     * @param email    The user's email.
     * @param password The user's password.
     * @return The corresponding User object if present in the database; otherwise null.
     */
    public static User doRetrieveUser(String email, String password) {
        User user = null;
        try (Connection con = ConnectionService.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT id_utente, nome, cognome, email FROM utente WHERE email=? AND password_utente=SHA1(?)");
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getString("id_utente"));
                user.setNome(rs.getString("nome"));
                user.setCognome(rs.getString("cognome"));
                user.setEmail(rs.getString("email"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return user;
    }

    /**
     * Inserts a new user into the database with the provided information.
     *
     * @param nome     The user's name.
     * @param cognome  The user's surname.
     * @param email    The user's email.
     * @param password The user's password.
     * @return The User object just inserted into the database.
     * @throws SQLException If an error occurs during the execution of the SQL query.
     */
    public static User insertInDatabase(String nome, String cognome, String email, String password) throws SQLException {
        User user;
        Connection con = ConnectionService.getConnection();
        synchronized (UserDAO.class) {
            PreparedStatement ps = con.prepareStatement("insert into utente(nome, cognome, email, password_utente) values (?, ?, ?, SHA1(?))");
            ps.setString(1, nome);
            ps.setString(2, cognome);
            ps.setString(3, email);
            ps.setString(4, password);
            ps.execute();
        }

        user = doRetrieveUser(email, password);

        return user;
    }

    /**
     * Update user info in database.
     *
     * @param user user beans.
     */
    public static void doUpdateUserByID(User user) {
        try (Connection con = ConnectionService.getConnection()) {
            synchronized (UserDAO.class) {
                PreparedStatement ps = con.prepareStatement("UPDATE utente SET nome = ? , cognome = ? , email = ? WHERE id_utente = ?");
                ps.setString(1, user.getNome());
                ps.setString(2, user.getCognome());
                ps.setString(3, user.getEmail());
                ps.setString(4, user.getId());
                ps.executeUpdate();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * Update user info with also password.
     *
     * @param user user beans.
     * @param password password.
     */
    public static void doUpdateUserByID(User user, String password) {
        try (Connection con = ConnectionService.getConnection()) {
            synchronized (UserDAO.class) {
                PreparedStatement ps = con.prepareStatement("UPDATE utente SET nome = ? , cognome = ? , email = ? , password_utente = SHA1(?) WHERE id_utente = ?");
                ps.setString(1, user.getNome());
                ps.setString(2, user.getCognome());
                ps.setString(3, user.getEmail());
                ps.setString(4, password);
                ps.setString(5, user.getId());
                ps.executeUpdate();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
