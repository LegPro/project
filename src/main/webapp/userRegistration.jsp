<%@ page import="java.sql.*" %>
<%
    String userName = request.getParameter("userName");    
    String password = request.getParameter("password");
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String email = request.getParameter("email");

    Connection con = null;
    PreparedStatement pst = null;

    // Load from environment variables
    String dbUrl = System.getenv("DB_URL");     // e.g. jdbc:mysql://localhost:3306/test
    String dbUser = System.getenv("DB_USER");   // e.g. root
    String dbPass = System.getenv("DB_PASS");   // e.g. root

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(dbUrl, dbUser, dbPass);

        String sql = "INSERT INTO USER(first_name, last_name, email, username, password, regdate) VALUES (?, ?, ?, ?, ?, CURDATE())";
        pst = con.prepareStatement(sql);
        pst.setString(1, firstName);
        pst.setString(2, lastName);
        pst.setString(3, email);
        pst.setString(4, userName);
        pst.setString(5, password);

        int rows = pst.executeUpdate();

        if (rows > 0) {
            response.sendRedirect("welcome.jsp");
        } else {
            response.sendRedirect("index.jsp");
        }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        try { if (pst != null) pst.close(); } catch (Exception e) {}
        try { if (con != null) con.close(); } catch (Exception e) {}
    }
%>
