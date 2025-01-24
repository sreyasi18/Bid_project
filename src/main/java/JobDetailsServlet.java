import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
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

import Configuration.DBConnection;

@WebServlet("/JobDetailsServlet")
public class JobDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public JobDetailsServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String jobId = request.getParameter("job_id");

        if (jobId == null || jobId.isEmpty()) {
            response.sendRedirect("FindJobServlet");
            return;
        }
        int jobIdParam = Integer.parseInt(request.getParameter("job_id"));
        Map<String, Object> jobDetails = fetchJobDetails(jobIdParam); // Method to fetch job details from DB
        request.setAttribute("job_details", jobDetails);
        
        List<Map<String, Object>> bidList = fetchbidListFromDatabase(jobIdParam);
        request.setAttribute("bid_list", bidList);
        request.getRequestDispatcher("/job_details.jsp").forward(request, response);

    }

    private Map<String, Object> fetchJobDetails(int jobIdParam) {
        String jdbcURL = "jdbc:mysql://localhost:3306/bid";
        String dbUser = "root";
        String dbPassword = "";
        Map<String, Object> jobDetails = new HashMap<>();

        try (Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword)) {
            String sql = "SELECT id,job_title, description, created_at, status, created_by FROM job WHERE id = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, jobIdParam);
                try (ResultSet result = pstmt.executeQuery()) {
                    if (result.next()) {
                    	jobDetails.put("job_id", result.getString("id"));
                        jobDetails.put("job_title", result.getString("job_title"));
                        jobDetails.put("description", result.getString("description"));
                        jobDetails.put("created_at", result.getTimestamp("created_at"));
                        jobDetails.put("status", result.getString("status"));
                        jobDetails.put("created_by", result.getInt("created_by")); 
                    }
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return jobDetails;
    }
    private List<Map<String, Object>> fetchbidListFromDatabase(int jobId) {
        List<Map<String, Object>> bidList = new ArrayList<>();
		/*
		 * String jdbcURL = "jdbc:mysql://localhost:3306/bid"; String dbUser = "root";
		 * String dbPassword = "";
		 */
        //try (Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword)) {
        try (Connection conn = DBConnection.getConnection()){
            String sql = "SELECT b.*, u.name  FROM job_bid b, user u WHERE  b.user_id=u.id and job_id = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, jobId);
                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        Map<String, Object> bid = new HashMap<>();
                       
                        bid.put("job_id", rs.getInt("job_id"));
                        bid.put("bid_amount", rs.getDouble("bid_amount"));
                        bid.put("added_on", rs.getTimestamp("added_on"));
                        bid.put("bidder", rs.getString("name"));
                        bidList.add(bid);
                    }
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return bidList;
    }
}

