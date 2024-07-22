package org.dinosauri.dinosauri.model;

import org.apache.tomcat.jdbc.pool.*;

import java.sql.*;
import java.util.*;

/**
 * This class handles the database connection setup and management.
 * It uses a connection pool to optimize performance and resource utilization.
 * The database connection details are retrieved from environment variables to enhance security.
 */
public class ConnectionService {
    private static DataSource datasource;

    /**
     * Retrieves a connection to the database.
     * It uses environment variables for the database username and password.
     * If the environment variables are not set, default values are used.
     *
     * @return a connection to the database.
     * @throws SQLException if a database access error occurs.
     */
    public static Connection getConnection() throws SQLException {
        if (datasource == null) {
            // Retrieve database credentials from environment variables
            String envPassword = System.getenv("PASSWORD_DB");
            if (envPassword == null) envPassword = "12345678";

            String envUser = System.getenv("USER_DB");
            if (envUser == null) envUser = "root";

            // Establish connection using the retrieved credentials
            return getConnection("ecommerce", envUser, envPassword);
        }

        return datasource.getConnection();
    }

    /**
     * Establishes a connection to the specified database using the given username and password.
     * The connection details are configured to initialize a connection pool only once.
     *
     * @param server   the name of the database server.
     * @param username the username for the database.
     * @param password the password for the database.
     * @return a connection to the database.
     * @throws SQLException if a database access error occurs.
     */
    public static Connection getConnection(String server, String username, String password) throws SQLException {
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
        return datasource.getConnection();
    }
}
