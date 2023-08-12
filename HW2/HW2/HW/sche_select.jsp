<%@ include file="db_open.jsp" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ include file="session_check.jsp" %>
<%
    String keyword = request.getParameter("search");
    // your codes here

    String userID = (String) session.getAttribute("userID");

    String jdbcURL = "jdbc:mysql://db:3306/HW?characterEncoding=UTF-8&serverTimezone=UTC";
    String dbID = "dbuser";
    String dbPASS = "dbuser1234";

    Connection conn = DriverManager.getConnection(jdbcURL, dbID, dbPASS);
    PreparedStatement pStmt1 = conn.prepareStatement("SELECT * FROM schedule WHERE name LIKE ? AND user_id = ? ORDER BY code");
    pStmt1.setString(1, keyword + "%");
    pStmt1.setString(2, userID);
    ResultSet rs = pStmt1.executeQuery();
    JSONArray arr = new JSONArray();
    if (rs.next()) {
        JSONObject obj1 = new JSONObject();
        obj1.put("valid", 1);
        arr.add(obj1);
        JSONObject obj2 = new JSONObject();
        obj2.put("code", rs.getInt(1));
        obj2.put("userID", rs.getString(2));
        obj2.put("name", rs.getString(3));
        obj2.put("start", rs.getInt(4));
        obj2.put("end", rs.getInt(5));
        obj2.put("dow", rs.getString(6));
        arr.add(obj2);
        while (rs.next()) {
            JSONObject obj = new JSONObject();
            obj.put("code", rs.getInt(1));
            obj.put("userID", rs.getString(2));
            obj.put("name", rs.getString(3));
            obj.put("start", rs.getInt(4));
            obj.put("end", rs.getInt(5));
            obj.put("dow", rs.getString(6));
            arr.add(obj);
        }
    }
    else {
        JSONObject obj2 = new JSONObject();
        obj2.put("valid", 0);
        arr.add(obj2);
    }
    out.print(arr);
    conn.close();
%>
<%@ include file="db_close.jsp" %>