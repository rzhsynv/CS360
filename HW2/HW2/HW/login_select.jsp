<%@ include file="header.jsp" %>
<%@ page import="java.sql.*" %>
<%
    String user_id = request.getParameter("id");
    String user_password = request.getParameter("password");

    if (user_id.equals("") || user_password.equals("")) {
        response.sendRedirect("/login.jsp");
    }
    else {
        String jdbcURL = "jdbc:mysql://db:3306/HW?characterEncoding=UTF-8&serverTimezone=UTC";
        String dbID = "dbuser";
        String dbPASS = "dbuser1234";

        Connection conn = DriverManager.getConnection(jdbcURL, dbID, dbPASS);
        PreparedStatement pStmt = conn.prepareStatement("SELECT COUNT(*) FROM user WHERE user_id = ? AND user_password = SHA1(?)");
        pStmt.setString(1, user_id);
        pStmt.setString(2, user_password);
        ResultSet rs = pStmt.executeQuery();
        int dupl_num = 0;
        while (rs.next()) {
            dupl_num = rs.getInt(1);
        }
        if (dupl_num == 0) {
            response.sendRedirect("/login.jsp");
        }
        else {
            session.setAttribute("userID", user_id);
            response.sendRedirect("/index.jsp");
        }
        conn.close();
    }

    // your codes here

    // check db
    // not found in db -> login.jsp
    // successful -> create new session, go to index.jsp


    // if access index.jsp not logged in, redirect to login.jsp -> getAttribute("userID")

%>
<%@ include file="footer.jsp" %>