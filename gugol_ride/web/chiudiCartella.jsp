<%@include file="config.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String path = session.getAttribute("CURRENT_PATH_FROM_ORIGIN_FOLDER").toString();
    if (path.length() > 0){
        String[] names = path.split("/");
        StringBuilder newPath = new StringBuilder("");
        for (int i = 0; i < names.length - 1; i++){
           newPath.append(names[i]).append("/");
        }
        if (newPath.length() == 1){
        newPath.deleteCharAt(newPath.length() - 1);
        }
        session.setAttribute("CURRENT_PATH_FROM_ORIGIN_FOLDER", newPath.toString());
    }
    
    response.sendRedirect("index.jsp");
%>