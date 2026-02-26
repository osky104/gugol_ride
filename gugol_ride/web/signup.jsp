<%-- 
    Document   : signup
    Created on : 26 feb 2026, 12:05:11
    Author     : oscar.farina
--%>

<%@include file="connessioneDatabase.jsp" %>
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
            if(request.getMethod().equals("POST")){
                String user = request.getParameter("username");
                String password = request.getParameter("password");

                result = statement.executeQuery("SELECT * FROM utente WHERE username = " + user);
                if(!result.wasNull()){ //nn va un cazzo
                    statement.execute("INSERT INTO utente(Username, Password, PathCartella) VALUES("+ user + ", "+ password + ")");
                }
            
            }
            
            
        %>
        
    </body>
</html>
