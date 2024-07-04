package org.dinosauri.dinosauri.model;

import javax.crypto.*;
import javax.crypto.spec.*;
import org.apache.commons.codec.binary.*;

import java.security.spec.*;


/**
 * We save a string in the cookie consisting of the
 * access date encrypted with a random string. The string (encryption key)
 * will be saved in the database. Every time the user logs in from the cookies,
 * the encrypted string is taken, time checked from the resulting string and
 * checked whether the token has expired or not.
 */
public class AccessToken {
    public static final String DESEDE_ENCRYPTION_SCHEME = "DESede";
    private static final String UNICODE_FORMAT = "UTF8";
    private final Cipher cipher;
    byte[] arrayBytes;
    SecretKey key;
    String randomKey;

    public AccessToken(String db_key) throws Exception {
        String myEncryptionScheme = DESEDE_ENCRYPTION_SCHEME;
        randomKey = db_key;
        arrayBytes = db_key.getBytes(UNICODE_FORMAT);
        KeySpec ks = new DESedeKeySpec(arrayBytes);
        SecretKeyFactory skf = SecretKeyFactory.getInstance(myEncryptionScheme);
        cipher = Cipher.getInstance(myEncryptionScheme);
        key = skf.generateSecret(ks);
    }

    public String encrypt(String unencryptedString) {
        String encryptedString = null;
        try {
            cipher.init(Cipher.ENCRYPT_MODE, key);
            byte[] plainText = unencryptedString.getBytes(UNICODE_FORMAT);
            byte[] encryptedText = cipher.doFinal(plainText);
            encryptedString = new String(Base64.encodeBase64(encryptedText));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return encryptedString;
    }

    public String decrypt(String encryptedString) {
        String decryptedText = null;
        try {
            cipher.init(Cipher.DECRYPT_MODE, key);
            byte[] encryptedText = Base64.decodeBase64(encryptedString);
            byte[] plainText = cipher.doFinal(encryptedText);
            decryptedText = new String(plainText);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return decryptedText;
    }

    public String getRandomKey() {
        return randomKey;
    }
}
