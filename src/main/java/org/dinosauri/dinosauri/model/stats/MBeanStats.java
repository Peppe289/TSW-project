package org.dinosauri.dinosauri.model.stats;

/**
 * This model class is responsible for fetching statistics from the Tomcat server.
 * The data will then be displayed on a dedicated dashboard for the admin.
 */
public class MBeanStats {
    public String maxTime;
    public String bytesReceived;
    public String bytesSent;
    public String requestCount;
    public String errorCount;
    public String processingTime;

    /**
     * Constructs a new instance of MBeanStats with the provided statistics.
     *
     * @param maxTime        The maximum processing time.
     * @param bytesReceived  The total number of bytes received.
     * @param bytesSent      The total number of bytes sent.
     * @param requestCount   The total number of requests.
     * @param errorCount     The total number of errors.
     * @param processingTime The total processing time.
     */
    public MBeanStats(String maxTime, String bytesReceived, String bytesSent, String requestCount, String errorCount, String processingTime) {
        this.maxTime = maxTime;
        this.bytesReceived = bytesReceived;
        this.bytesSent = bytesSent;
        this.requestCount = requestCount;
        this.errorCount = errorCount;
        this.processingTime = processingTime;
    }
}
