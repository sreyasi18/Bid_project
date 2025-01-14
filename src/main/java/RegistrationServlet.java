import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegistrationServlet")
public class RegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public RegistrationServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        
        String userName = request.getParameter("user_name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");
     

        // Validate password and confirm password
        if (!password.equals(confirmPassword)) {
            response.sendRedirect("registration.jsp?error=Passwords do not match");
            return;
        }

        String jdbcURL = "jdbc:mysql://localhost:3306/bid";
        String dbUser = "root";
        String dbPassword = "";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            String sql = "INSERT INTO user (name,  user_name, email, password ) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
           
            pstmt.setString(2, userName);
            pstmt.setString(3, email);
            pstmt.setString(4, password);
           

            pstmt.executeUpdate();

            // Redirect to a success page
            response.sendRedirect("success.jsp");
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
            response.sendRedirect("error.jsp");
        } catch (SQLException ex) {
            ex.printStackTrace();
            response.sendRedirect("registration.jsp?error=Database error occurred");
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}
