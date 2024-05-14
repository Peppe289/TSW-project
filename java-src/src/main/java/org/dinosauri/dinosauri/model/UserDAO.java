package org.dinosauri.dinosauri.model;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    /**
     * create table utente (
     * id_utente varchar(255) primary key,
     * password_utente varchar(255) not null,
     * nome varchar(255) not null,
     * cognome varchar(255) not null,
     * email varchar(255) not null
     * );
     */
    public User doRetrieveUser(String email, String password) {
        User utente = null;
        try (Connection con = ConnectionService.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT id_utente, nome, cognome, email FROM utente WHERE email=? AND password_utente=SHA1(?)");
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                utente = new User();
                utente.setId(rs.getString("id_utente"));
                utente.setNome(rs.getString("nome"));
                utente.setCognome(rs.getString("cognome"));
                utente.setEmail(rs.getString("email"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return utente;
    }

    public User insertInDatabase(String nome, String cognome, String password, String email) throws SQLException {
        User user = null;
        Connection con = ConnectionService.getConnection();
        PreparedStatement ps = con.prepareStatement("insert into utente(nome, cognome, email, password_utente) values (?, ?, ?, SHA1(?))");
        ps.setString(1, nome);
        ps.setString(2, cognome);
        ps.setString(3, email);
        ps.setString(4, password);
        ps.execute();

        user = doRetrieveUser(email, password);

        return user;
    }
}

