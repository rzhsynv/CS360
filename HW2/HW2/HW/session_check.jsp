<%
    String user_id = (String) session.getAttribute("userID");
    if(user_id == null)
        response.sendRedirect("/login.jsp");
%>