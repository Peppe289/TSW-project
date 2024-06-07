package org.dinosauri.dinosauri.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.dinosauri.dinosauri.model.Product;
import org.dinosauri.dinosauri.model.ProductDAO;
import org.dinosauri.dinosauri.model.stats.MBeanStats;

import javax.management.*;
import java.io.IOException;
import java.lang.management.ManagementFactory;
import java.util.List;

/**
 * StatsServlet is a HttpServlet that handles requests to the "/stats" endpoint.
 * It provides server statistics in JSON format based on the 'reason' parameter
 * provided in the request.
 *
 * <p>The servlet supports the following operations:</p>
 * <ul>
 *   <li>serverstats: Returns various server statistics such as maxTime, bytesReceived,
 *       bytesSent, requestCount, errorCount, and processingTime in JSON format.</li>
 * </ul>
 *
 * <p>Example usage:</p>
 * <pre>
 *   GET /stats?reason=serverstats
 * </pre>
 *
 * <p>Response example:</p>
 * <pre>
 *   {
 *     "maxTime": "1234",
 *     "bytesReceived": "5678",
 *     "bytesSent": "91011",
 *     "requestCount": "12",
 *     "errorCount": "1",
 *     "processingTime": "3456"
 *   }
 * </pre>
 *
 * <p>The servlet uses JMX to retrieve the statistics from the Tomcat MBean server.
 * It handles various exceptions that might occur during this process and returns
 * the server statistics as a JSON string.</p>
 *
 * <p>Note: The servlet suppresses warnings related to potential null string issues.</p>
 *
 * @see javax.servlet.http.HttpServlet
 * @see com.fasterxml.jackson.databind.ObjectMapper
 */
@WebServlet("/adminControl")
@SuppressWarnings("DataFlowIssue") // ignore null string
public class DashBoardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String jsonArray;
        String reason = req.getParameter("reason");

        switch (reason) {
            case "serverstats" -> jsonArray = serverStats();
            case "products" -> jsonArray = products();
            default -> jsonArray = null;
        }

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(jsonArray);
    }

    /**
     * Retrieves server statistics in JSON format.
     *
     * <p>This method uses JMX to obtain various server statistics from the Tomcat
     * MBean server. It collects data such as maxTime, bytesReceived, bytesSent,
     * requestCount, errorCount, and processingTime.</p>
     *
     * @return a JSON string representing the server statistics
     * @throws RuntimeException if there is an error fetching the Tomcat info
     */
    protected String serverStats() {
        String jsonArray = null;

        try {
            MBeanServer mBeanServer = ManagementFactory.getPlatformMBeanServer();
            ObjectName name = new ObjectName("Catalina:type=GlobalRequestProcessor,name=\"http-nio-8080\"");
            String maxTime = mBeanServer.getAttribute(name, "maxTime").toString();
            String bytesReceived = mBeanServer.getAttribute(name, "bytesReceived").toString();
            String bytesSent = mBeanServer.getAttribute(name, "bytesSent").toString();
            String requestCount = mBeanServer.getAttribute(name, "requestCount").toString();
            String errorCount = mBeanServer.getAttribute(name, "errorCount").toString();
            String processingTime = mBeanServer.getAttribute(name, "processingTime").toString();

            MBeanStats tomcatStats = new MBeanStats(maxTime, bytesReceived, bytesSent, requestCount, errorCount, processingTime);
            ObjectMapper objectMapper = new ObjectMapper();

            jsonArray = objectMapper.writeValueAsString(tomcatStats);
        } catch (JsonProcessingException | ReflectionException | InstanceNotFoundException |
                 AttributeNotFoundException | MBeanException | MalformedObjectNameException e) {
            System.err.println("WARNING: failed to fetch server start information");
        }

        return jsonArray;
    }

    protected String products() throws JsonProcessingException {
        String result;
        List<Product> shelled;
        ObjectMapper objectMapper = new ObjectMapper();

        shelled = ProductDAO.doRetriveProducts();
        result = objectMapper.writeValueAsString(shelled);

        return result;
    }
}