<%@ include file="db_open.jsp" %>
<%@ include file="session_check.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%

    String name = request.getParameter("name");
    String end = request.getParameter("end");
    String start = request.getParameter("start");
    String dow = request.getParameter("dow");
    String userID = (String) session.getAttribute("userID");

    // your codes here

    if ((name != null) && !(name.equals("")) && (start != null) && !(start.equals("")) && (end != null) && !(end.equals("")) && (dow != null) && !(dow.equals("")) && (end.compareTo(start) > 0)) {

        // end += ":00";
        // start += ":00";

        int start_num = Integer.parseInt(start);
        int end_num = Integer.parseInt(end);

        String jdbcURL = "jdbc:mysql://db:3306/HW?characterEncoding=UTF-8&serverTimezone=UTC";
        String dbID = "dbuser";
        String dbPASS = "dbuser1234";

        Connection conn = DriverManager.getConnection(jdbcURL, dbID, dbPASS);
        PreparedStatement pStmt1 = conn.prepareStatement("SELECT COUNT(*) FROM schedule WHERE user_id = ? AND dow = ? AND end >= ? AND start <= ?");
        pStmt1.setString(1, userID);
        pStmt1.setString(2, dow);
        pStmt1.setInt(3, start_num);
        pStmt1.setInt(4, end_num);
        ResultSet rs = pStmt1.executeQuery();
        int overlap_num = 0;
        while (rs.next()) {
            overlap_num = rs.getInt(1);
        }
        if (overlap_num == 0) {
            PreparedStatement pStmt2 = conn.prepareStatement("INSERT INTO schedule (user_id, name, start, end, dow) VALUES(?, ?, ?, ?, ?)");
            pStmt2.setString(1, userID);
            pStmt2.setString(2, name);
            pStmt2.setInt(3, start_num);
            pStmt2.setInt(4, end_num);
            pStmt2.setString(5, dow);
            pStmt2.executeUpdate();

            PreparedStatement pStmt3 = conn.prepareStatement("SELECT * FROM schedule WHERE user_id = ? AND name = ? AND start = ? AND end = ? AND dow = ?");
            pStmt3.setString(1, userID);
            pStmt3.setString(2, name);
            pStmt3.setInt(3, start_num);
            pStmt3.setInt(4, end_num);
            pStmt3.setString(5, dow);
            rs = pStmt3.executeQuery();
            // JSONArray arr = new JSONArray();
            JSONObject obj = new JSONObject();
            while (rs.next()) {
                obj.put("valid", 1);
                obj.put("code", rs.getInt(1));
                obj.put("userID", rs.getString(2));
                obj.put("name", rs.getString(3));
                obj.put("start", rs.getInt(4));
                obj.put("end", rs.getInt(5));
                obj.put("dow", rs.getString(6));
            }
            // arr.add(obj);
            out.print(obj);
            conn.close();
        }
        else {
            JSONObject obj = new JSONObject();
            obj.put("valid", 0);
            out.print(obj);
        }
    }
    else {
        JSONObject obj = new JSONObject();
        obj.put("valid", 0);
        out.print(obj);
    }



    // overlap | start1 <= end2 and end1 >= start1
    // any of the values null
    // start time > end time
    // already existing code -> impossible due to auto-increment




    // insert to schedule table, successful -> display
    // ajax to comm w server 
%>
<%@ include file="db_close.jsp" %>