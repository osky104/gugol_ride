
<%@include file="config.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>gugol_ride</title>
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>

        <a href="signup.jsp">SIGN UP</a>
        <a href="login.jsp">LOG IN</a>
        
        <%
            /*
            // --- 1. LOGICA SESSIONE E COOKIE ---
            // Gestione Sessione
            LocalDate ld = LocalDate.now();
            if (session.getAttribute("data_corrente") == null) {
                session.setAttribute("data_corrente", ld);
            }
            String dataSessione = String.valueOf(session.getAttribute("data_corrente"));

            // Gestione Cookie
            Cookie c = new Cookie("ultima_data", ld.toString());
            c.setMaxAge(3600); // Scadenza 1 ora
            response.addCookie(c);

            String dataDaCookie = "Nessun cookie trovato (è la tua prima visita o sono scaduti)";
            Cookie[] elencoCookie = request.getCookies();
            if (elencoCookie != null) {
                for (Cookie temp : elencoCookie) {
                    if (temp.getName().equals("ultima_data")) {
                        dataDaCookie = temp.getValue();
                    }
                }
            }
            */

            
            if(session.getAttribute("user_log") != null){
                result = statement.executeQuery("SELECT f.* FROM utente u, permesso p, file f WHERE u.Username = p.Username AND p.IdFile = f.Id AND u.Username = '" + session.getAttribute("user_log") + "'");
                %>
                <table>
                    <thead>
                        <tr>
                            <th>Id</th>
                            <th>Path</th>
                            <th>Nome</th>
                            <th>Cartella</th>
                            <th>Proprietario</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% while (result.next()) { %>
                        <tr>
                            <td><%= result.getInt("Id") %></td>
                            <td><%= result.getString("Path") %></td>
                            <td><%= result.getString("Nome") %></td>
                            <td><%= result.getBoolean("Cartella") %></td>
                            <td><%= result.getString("Proprietario") %></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                    
                    <hr>
                    
                <a href="logout.jsp">LOG OUT</a>
                <%
                    
            }   
        %>
    </body>
    
</html>


