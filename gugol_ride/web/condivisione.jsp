<%@include file="config.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("user_log") != null){
        try{
            if(request.getMethod().equals("POST")){
                String nome  = request.getParameter("share");
                String id = request.getParameter("idFile");
                
               
                result = statement.executeQuery("SELECT * FROM permesso WHERE Username = '" + nome + "' AND IdFile = '" + id + "'");

                if (!result.next()){
                    String sql = "INSERT INTO permesso VALUES ('" + nome + "', '" + id + "')";
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