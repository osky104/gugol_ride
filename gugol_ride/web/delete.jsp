<%@include file="config.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("user_log") != null){
        try{
            if(request.getMethod().equals("POST")){
                boolean check  = Boolean.valueOf(request.getParameter("prop"));
                String id = request.getParameter("idFile");
                
                if(check){
                    result = statement.executeQuery("SELECT Nome, Proprietario FROM file WHERE Id = '" + id + "'");
                    
                    if(result.next()){
                        String nome = result.getString("Nome");
                        String proprietario = result.getString("Proprietario");
                        statement.execute("DELETE FROM file WHERE Id = '" + id + "'");
                        File f = new File(USER_FILES_PATH + proprietario + '/' + nome);
                        f.delete();
                    }
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