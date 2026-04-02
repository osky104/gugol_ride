
<%@include file="config.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>LOGIN</title>
    </head>
    <body>
        <h1 style="text-align: center; color: red ">LOGIN</h1>
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
                    String user = request.getParameter("username");
                    String password = request.getParameter("password");

                    result = statement.executeQuery("SELECT * FROM utente WHERE username = '" + user + "' AND password = '" + password + "'");
                    if(!result.next()){ //se è vuoto
                        out.println("<p class='error'>Username o password errati! </p>"); 
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
