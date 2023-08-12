<%@ include file="header.jsp" %>
<%@ include file="session_check.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%
    int code = Integer.parseInt(request.getParameter("code"));
    // your codes here

    String jdbcURL = "jdbc:mysql://db:3306/HW?characterEncoding=UTF-8&serverTimezone=UTC";
    String dbID = "dbuser";
    String dbPASS = "dbuser1234";

    Connection conn = DriverManager.getConnection(jdbcURL, dbID, dbPASS);
    PreparedStatement pStmt1 = conn.prepareStatement("DELETE FROM schedule WHERE code = ?");
    pStmt1.setInt(1, code);
    pStmt1.executeUpdate();
    conn.close();
%>
<%@ include file="footer.jsp" %>