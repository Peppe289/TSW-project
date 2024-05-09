package org.dinosauri.dinosauri.model;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.apache.tomcat.jdbc.pool.PoolProperties;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.TimeZone;

/**
 * Serve soltanto per la connessione al database. Dopo di che abbiamo nella variabile statica.
 * Dovrebbe avviarsi solo una volta.
 */
public class ConnectionService {
    private static DataSource datasource;

    public static Connection getConnection() throws SQLException {

        /**
         * Prendi la variabile d'ambiente per recuperare la password e il nome del database.
         * In questo modo non dobbiamo esporre la password nel progetto (la variabile di ambiente è locale).
         * Se la variabile di ambiente non è presente allora metti una password di default.
         *
         * Possiamo avere password e username differenti senza concorrenza sulla history di git.
         */
        String env_password = System.getenv("PASSWORD_DB");
        if (env_password == null)
            env_password = "12345678";

        String env_user = System.getenv("USER_DB");
        if (env_user == null)
            env_user = "root";

        return getConnection("ecommerce", env_user, env_password);
    }

    /**
     * Stabilisci la connessione con il database. i dati sono statici per inizializzarli una sola volta
     */
    public static Connection getConnection(String server, String username, String password) throws SQLException {
        if (datasource == null) {
            PoolProperties p = new PoolProperties();
            p.setUrl("jdbc:mysql://localhost:3306/" + server + "?serverTimezone=" + TimeZone.getDefault().getID());
            p.setDriverClassName("com.mysql.cj.jdbc.Driver");
            p.setUsername(username);
            p.setPassword(password);
            p.setMaxActive(100);
            p.setInitialSize(10);
            p.setMinIdle(10);
            p.setRemoveAbandonedTimeout(60);
            p.setRemoveAbandoned(true);
            datasource = new DataSource();
            datasource.setPoolProperties(p);
        }
        return datasource.getConnection();
    }
}
