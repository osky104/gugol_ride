<%@include file="config.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("user_log") != null){
        try{
            if(request.getMethod().equals("POST")){
                boolean check  = Boolean.valueOf(request.getParameter("prop"));
                String id = request.getParameter("idFile");
                
                if(check){
                    String sql = "DELETE FROM file WHERE Id = '" + id + "'";
                    statement.execute(sql);
                }else{
                    String sql = "DELETE FROM permesso WHERE IdFile = '" + id + "'";
                    statement.execute(sql);
                }
            }
        } catch(Exception e){
            out.println("<p class='error'>Errore: " + e.getMessage() + " </p>");
        } finally{
            closeConnection();
        }
    }
    response.sendRedirect("index.jsp");
%>