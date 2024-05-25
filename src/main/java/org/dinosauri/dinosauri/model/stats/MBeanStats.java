package org.dinosauri.dinosauri.model.stats;

/**
 * Questo model si occupa di prendere le statistiche del server tomcat.
 * I dati saranno poi mostrati in una apposita dashboard per l'admin.
 */
public class MBeanStats {
    public String maxTime;
    public String bytesReceived;
    public String bytesSent;
    public String requestCount;
    public String errorCount;
    public String processingTime;

    public MBeanStats(String maxTime, String bytesReceived, String bytesSent, String requestCount, String errorCount, String processingTime) {
        this.maxTime = maxTime;
        this.bytesReceived = bytesReceived;
        this.bytesSent = bytesSent;
        this.requestCount = requestCount;
        this.errorCount = errorCount;
        this.processingTime = processingTime;
    }
}
