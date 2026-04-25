
<%@page import="java.time.LocalTime"%>
<%@include file="config.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style.css">
        <title>LOGIN</title>
    </head>
    <body>
        <section class="form-section">
            <form action="" class="form-box" method="POST">
                <h2>Login</h2>

                <input type="text" name="username" placeholder="Username">
                <input type="password" name="password" placeholder="Password">


                <div class="btn"><button type="submit" class="top-btn">Accedi</button></div>

                <p>Non hai un account? <a href="signup.jsp">Registrati</a></p>
            </form>
        </section>
       

        <%
            if (session.getAttribute("user_log") == null){
                try{
                    if(request.getMethod().equals("POST")){
                        String user = request.getParameter("username").toLowerCase();
                        String password = request.getParameter("password");

                        result = statement.executeQuery("SELECT * FROM utente WHERE username = '" + user + "' AND password = SHA2('" + password + "', 256)");
                        if(!result.next()){ //se è vuoto
                            out.println("<p class='error'>Username o password errati! </p>"); 
                        } else {
                            session.setAttribute("user_log", user);
                            
                            Cookie c = new Cookie("ora_ultima_azione", "");
                            c.setMaxAge(TEMPO_MASSIMO_INATTIVITA);
                            response.addCookie(c);
                            
                            response.sendRedirect("index.jsp");
                        }
                    }
                } catch(Exception e){
                    out.println("<p class='error'>Errore database: " + e.getMessage() + " </p>");
                } finally{
                    closeConnection();
                }
            } else {
                response.sendRedirect("index.jsp");
            }
        %>
        
    </body>
</html>
