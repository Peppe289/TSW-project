package org.dinosauri.dinosauri.model.utils;

import java.util.*;

public class RandomString {
    /**
     * Max char for random string.
     * <p>But this string will be decrypted/encrypted</p>
     */
    static final int length = 50;

    public static int randomIntRange(int origin, int bound) {
        return new Random().nextInt((bound - origin) + 1) + origin;
    }

    /**
     * Generate random string using 8-bit ascii table.
     *
     * @return - pseudo-random string.
     */
    public static String generate() {
        StringBuilder randomString = new StringBuilder();

        for (int i = 0; i < length; ++i) {
            int cod = randomIntRange(0, 127);
            char ascii = (char) cod;
            randomString.append(ascii);
        }

        return randomString.toString();

    }
}
