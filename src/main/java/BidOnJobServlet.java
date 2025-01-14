import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Configuration.DBConnection;

@WebServlet("/BidOnJobServlet")
public class BidOnJobServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Integer userId = (Integer) session.getAttribute("user_id");

        List<Map<String, Object>> jobList = fetchJobListFromDatabase(userId);
        request.setAttribute("job_list", jobList);
        request.getRequestDispatcher("finalBidList.jsp").forward(request, response);
    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("is_loggedin") == null || !session.getAttribute("is_loggedin").equals(1)) {
            response.sendRedirect("login.jsp");
            return;
        }

        Integer userId = (Integer) session.getAttribute("user_id");
        int jobId = Integer.parseInt(request.getParameter("job_id"));
        double bidAmount = Double.parseDouble(request.getParameter("bid_amount"));
        String message = request.getParameter("message");

        // Insert bid details into the database
        insertBidIntoDatabase(jobId, userId, bidAmount, message);

        // Retrieve and display updated bid list
        List<Map<String, Object>> jobList = fetchJobListFromDatabase(userId);
        request.setAttribute("job_list", jobList);
        request.getRequestDispatcher("finalBidList.jsp").forward(request, response);
    }

    // Method to insert a new bid into the job_bid table
    private void insertBidIntoDatabase(int jobId, int userId, double bidAmount, String message) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO job_bid (job_id, user_id, bid_amount, added_on, message) VALUES (?, ?, ?, NOW(), ?)";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, jobId);
                pstmt.setInt(2, userId);
                pstmt.setDouble(3, bidAmount);
                pstmt.setString(4, message);
                pstmt.executeUpdate();
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
           }

    // Method to retrieve a list of bids made by the user
    private List<Map<String, Object>> fetchJobListFromDatabase(int userId) {
        List<Map<String, Object>> jobList = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
        	String sql = "SELECT job_bid.job_id, job.job_title AS job_title, job_bid.bid_amount, job_bid.added_on AS bid_time, job_bid.message " +
                    "FROM job_bid " +
                    "JOIN job ON job_bid.job_id = job.id " +
                    "WHERE job_bid.user_id = ?";


                   
                   
    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, userId);
                try (ResultSet result = pstmt.executeQuery()) {
                    while (result.next()) {
                        Map<String, Object> job = new HashMap<>();
                        job.put("job_id", result.getInt("job_id"));
                        job.put("job_title", result.getString("job_title"));
                        job.put("bid_amount", result.getDouble("bid_amount"));
                        job.put("bid_time", result.getTimestamp("bid_time"));
                        job.put("message", result.getString("message"));
                        jobList.add(job);
                    }
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return jobList;
    }
}
