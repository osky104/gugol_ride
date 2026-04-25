
<%@page import="java.io.File"%>
<%@include file="config.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SIGN UP</title>
    </head>
    <body>
        <h1 style="text-align: center; color: red ">SIGN UP</h1>
        <div>
            <form style="text-align: center" method="POST">
                Name: <input type="text" name="username" id="username" placeholder="Inserisci username" ><br>
                Password: <input type="password" name="password" id="password" placeholder="Inserisci password" ><br>
                <input type="submit" value="Invia">
            </form>
        </div>
       

        <%
            try{
                if(request.getMethod().equals("POST")){
                    String user = request.getParameter("username").toLowerCase();
                    String password = request.getParameter("password");
                    String path = "";

                    result = statement.executeQuery("SELECT * FROM utente WHERE username = '" + user + "'");
                    //True se il risultato è vuoto
                    if(!result.next()){
                        statement.execute("INSERT INTO utente(Username, Password) VALUES('"+ user + "', SHA2('"+ password + "',256))");
                        
                        File userFolder = new File(USER_FILES_PATH + user);
                        userFolder.mkdir();
                        
                        response.sendRedirect("index.jsp");
                    } else {
                        out.println("<p class='error'>Utente già esistente</p>");
                    }
                }
            } catch(Exception e){
                out.println("<p class='error'>Errore database: " + e.getMessage() + " </p>");
            } finally{
                closeConnection();
            }
        %>
        
    </body>
</html>
