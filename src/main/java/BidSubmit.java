import java.io.IOException;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Configuration.DBConnection;

@WebServlet("/BidSubmit")
public class BidSubmit extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");
        String jobId = request.getParameter("job_id");
        String bidAmountStr = request.getParameter("bid_amount");
        
        System.out.println("Received job_id: " + jobId);
        System.out.println("Received bid_amount: " + bidAmountStr);

        
  
        if (userId == null|| jobId.isEmpty()) {
            response.sendRedirect("login.jsp?error=User not logged in");
            return;
        }
        
        
        double bidAmount = 0.0;
        if (bidAmountStr != null && !bidAmountStr.isEmpty() && !bidAmountStr.equals("null")) {
            try {
                bidAmount = Double.valueOf(bidAmountStr);
            } catch (NumberFormatException e) {
                e.printStackTrace();
                response.sendRedirect("job_details.jsp?job_id=" + jobId + "&error=Invalid bid amount");
                return;
            }
        } else {
            response.sendRedirect("job_details.jsp?job_id=" + jobId + "&error=Missing bid amount");
            return;
        }
       /* String jdbcURL = "jdbc:mysql://localhost:3306/bid";
        String dbUser = "root";
        String dbPassword = "";

        try (Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword)) {
        */
        try (Connection conn = DBConnection.getConnection()){
        String sql = "INSERT INTO job_bid(user_id, job_id, bid_amount) VALUES (?, ?, ?) " +
                    "ON DUPLICATE KEY UPDATE bid_amount = VALUES(bid_amount)";
        	try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, userId);
                pstmt.setInt(2, Integer.parseInt(jobId));
                pstmt.setDouble(3, bidAmount);
                int rowsInserted = pstmt.executeUpdate();

                if (rowsInserted > 0) {
//                    response.sendRedirect("FindJobServlet");
                	 String fetchJobSql = "SELECT * FROM job WHERE id = ?";
                     Map<String, Object> jobDetails = new HashMap<>();
                     try (PreparedStatement fetchStmt = conn.prepareStatement(fetchJobSql)) {
                         fetchStmt.setInt(1, Integer.parseInt(jobId));
                         try (ResultSet rs = fetchStmt.executeQuery()) {
                             if (rs.next()) {
                                 jobDetails.put("id", rs.getInt("id"));
                                 jobDetails.put("job_title", rs.getString("job_title"));
                                 jobDetails.put("description", rs.getString("description"));
                                 jobDetails.put("created_at", rs.getTimestamp("created_at"));
                                 jobDetails.put("status", rs.getString("status"));
                                 jobDetails.put("final_bid_amount", rs.getDouble("final_bid_amount"));
                             }
                         }
                     }

                     request.setAttribute("job_details", jobDetails);
                     request.setAttribute("message", "Bid submitted successfully!");
                     request.setAttribute("messageType", "success");
                     request.getRequestDispatcher("job_details.jsp").forward(request, response);
                 } else {
                    response.sendRedirect("job_details.jsp?job_id=" + jobId + "&error=Bid submission failed");
                }
            }
        } catch (SQLException ex) {
			ex.printStackTrace();
			//response.sendRedirect("postJob.jsp?error=sql_exception");
			
			request.setAttribute("message", "Error in form submission due to some sql error.");
			request.setAttribute("messageType", "error");
			request.getRequestDispatcher("postJob.jsp").forward(request, response);
		} 
        
	}
}