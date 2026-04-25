<%@include file="config.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%!
private void condividiFile(String username, String id, boolean isCartella) throws Exception{
    Statement localStatement = null;
    ResultSet localResult = null;
    Statement fileStatement = null;
    ResultSet files = null;

    try {
        localStatement = connect.createStatement();
        localResult = localStatement.executeQuery("SELECT * FROM permesso WHERE Username = '" + username + "' AND IdFile = '" + id + "'");

        if(!localResult.next()){
            localStatement.execute("INSERT INTO permesso VALUES ('" + username + "', '" + id + "')");
            if (isCartella){
                fileStatement = connect.createStatement();
                //Seleziona gli id di tutti i file nel cui percorso è contenuto il nome della cartella.
                //Il nome viene trovato tramite subquery
                files = fileStatement.executeQuery("SELECT Id FROM `file` WHERE Path LIKE CONCAT('%',(SELECT Nome FROM file where id='" + id + "'),'%')");

                while(files.next()){
                    localStatement.execute("INSERT INTO permesso VALUES ('" + username + "', '" + files.getString("Id") + "')");
                }

                fileStatement.close();
                files.close();
            }
        }
    } catch (Exception e){
        throw new Exception(e);
    } finally{
        if (localStatement != null){
            localStatement.close();
        }
        if (localResult != null){
            localResult.close();
        }
        if (fileStatement != null){
            fileStatement.close();
        }
        if (files != null){
            files.close();
        }
    }
}    
%>

<%
    if (session.getAttribute("user_log") != null){
        try{
            if(request.getMethod().equals("POST")){
                String username  = request.getParameter("username").toLowerCase();
                String id = request.getParameter("idFile");
                boolean isCartella = Boolean.valueOf(request.getParameter("cartella"));
               
                condividiFile(username, id, isCartella);
            }
        } catch(Exception e){
            out.println("<p class='error'>Errore: " + e.getMessage() + " </p>");
        } finally{
            closeConnection();
        }
    }
    response.sendRedirect("index.jsp");
%>