
<%@include file="config.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>LOG OUT</title>
    </head>
    <body>
        <%
            if(session.getAttribute("user_log") != null){
                session.setAttribute("user_log", null);
            }
            response.sendRedirect("index.jsp");
        %>
    </body>
</html>