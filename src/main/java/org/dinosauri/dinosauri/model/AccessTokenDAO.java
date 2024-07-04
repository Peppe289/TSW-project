package org.dinosauri.dinosauri.model;

import java.sql.*;

public class AccessTokenDAO {
    /**
     * Update token for this specific user. We will save random string using as a key for encrypt/decrypt
     * cookie string.
     *
     * @param id - Need for set a key in the right row.
     * @param token - Class contains key
     */
    public static void doInsertUserToken(String id, AccessToken token) {
        try (Connection con = ConnectionService.getConnection()) {
            PreparedStatement ps = con.prepareStatement("DELETE FROM token WHERE id_utente = ?");
            ps.setString(1, id);
            ps.executeUpdate();

            ps = con.prepareStatement("INSERT INTO token (id_utente, token) VALUES (?, ?)");
            ps.setString(1, id);
            ps.setString(2, token.getRandomKey());
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * This method is used for allowed user to access directly from cookie.
     * Retrieve key string used for encrypt/decrypt token in cookie.
     *
     * @param user_id - id user.
     * @return - object configured for decrypt cookie token using database random string.
     */
    public static AccessToken doRetrieveUserToken(String user_id) {
        AccessToken token = null;
        try (Connection con = ConnectionService.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT token FROM token WHERE id_utente = ?");
            ps.setString(1, user_id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                token = new AccessToken(rs.getString("token"));
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return token;
    }
}
