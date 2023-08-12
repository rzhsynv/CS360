<%@ include file="header.jsp" %>
<%@ page import="java.sql.*" %>
<%

    String user_id = request.getParameter("id");
    String user_password = request.getParameter("password");

    if (user_id.equals("") || user_password.equals("")) {
        response.sendRedirect("/register.jsp");
    }
    else {
        String jdbcURL = "jdbc:mysql://db:3306/HW?characterEncoding=UTF-8&serverTimezone=UTC";
        String dbID = "dbuser";
        String dbPASS = "dbuser1234";

        // unsuccessful, if duplicate user id
        // connect to db, check if user id already exists
        // yes -> register
        // else -> login, add to db with encoded password

        Connection conn = DriverManager.getConnection(jdbcURL, dbID, dbPASS);
        PreparedStatement pStmt1 = conn.prepareStatement("SELECT COUNT(*) FROM user WHERE user_id = ?");
        pStmt1.setString(1, user_id);
        ResultSet rSet = pStmt1.executeQuery();
        int dupl_num = 0;
        while(rSet.next()) {
            dupl_num = rSet.getInt(1);
        }
        // rSet.first();
        // int dupl_num = rSet.getInt(1);
        if (dupl_num == 1)
            response.sendRedirect("/register.jsp");
        else
        {
            PreparedStatement pStmt2 = conn.prepareStatement("INSERT INTO user VALUES(?, SHA1(?))");
            pStmt2.setString(1, user_id);
            pStmt2.setString(2, user_password);
            pStmt2.executeUpdate();
            response.sendRedirect("/login.jsp");
        }
        conn.close();
    }

    // your codes here
%>
<%@ include file="footer.jsp" %>

