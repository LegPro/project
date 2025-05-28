<%@ page import="java.sql.*" %>
<%
    String userName = request.getParameter("uname");    
    String password = request.getParameter("password");

    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    // Read DB credentials from environment variables
    String dbUrl = System.getenv("DB_URL");
    String dbUser = System.getenv("DB_USER");
    String dbPass = System.getenv("DB_PASS");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(dbUrl, dbUser, dbPass);

        String sql = "SELECT * FROM user WHERE username = ? AND password = ?";
        pst = con.prepareStatement(sql);
        pst.setString(1, userName);
        pst.setString(2, password);
        rs = pst.executeQuery();

        if (rs.next()) {
            session.setAttribute("userid", userName);
            response.sendRedirect("success.jsp");
        } else {
            out.println("Invalid password <a href='index.jsp'>Try again</a>");
        }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (pst != null) pst.close(); } catch (Exception e) {}
        try { if (con != null) con.close(); } catch (Exception e) {}
    }
%>
