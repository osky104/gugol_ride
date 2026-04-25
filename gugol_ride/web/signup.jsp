
<%@page import="java.io.File"%>
<%@include file="config.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SIGN UP</title>
        <link rel="stylesheet" href="style.css">
    </head>
    <body>
        <section class="form-section">
            <form action="" method="post" class="form-box">
                <h2>Sign up</h2>

                <input type="text" name="username" placeholder="Username">
                <input type="password" name="password" placeholder="Password">

                <br><br>
                <div class="btn"><button type="submit" class="top-btn">Registrati</button></div>

                <p>Hai già un account? <a href="login.jsp">Login</a></p>
            </form>
        </section>

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
