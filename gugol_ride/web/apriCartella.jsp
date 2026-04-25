<%@include file="config.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if(request.getMethod().equals("POST")){
        String path = session.getAttribute("CURRENT_PATH_FROM_ORIGIN_FOLDER").toString();
        path += request.getParameter("folderName") + "/";
        session.setAttribute("CURRENT_PATH_FROM_ORIGIN_FOLDER", path);
    }
    response.sendRedirect("index.jsp");
%>