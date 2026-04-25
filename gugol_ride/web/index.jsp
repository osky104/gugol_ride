
<%@include file="config.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>gugol_ride</title>
        <link rel="stylesheet" href="css/style.css">
        <script src="jsForSend.js"></script>
        <link rel="stylesheet" href="style.css">
    </head>
    <body>        
        <%
            if(session.getAttribute("user_log") != null){
                String user = session.getAttribute("user_log").toString();
                Cookie[] elencoCookie = request.getCookies();
                boolean check = false;
                if (elencoCookie != null) {
                    for (Cookie temp : elencoCookie) {
                        if (temp.getName().equals("ora_ultima_azione")) {
                            check = true;
                        }
                    }
                }
                if(check){
                    %>
                    <header class="topbar">
                        
                        <div class="top-left">
                            <%
                            String currentPath = session.getAttribute("CURRENT_PATH_FROM_ORIGIN_FOLDER").toString();
                            if (currentPath.length() > 0){
                                %>
                                <a href="chiudiCartella.jsp" class="back">←</a>
                                <%
                                String[] splitPath = currentPath.split("/");
                                out.println("<h2>Cartella: " + splitPath[splitPath.length - 1] + "</h2>");
                            } else {
                                out.println("<h2>I Tuoi File</h2>");
                            }%>
                        </div>

                        <div class="top-right">
                            <form class="header-form" action="mkdir.jsp" method="post">
                                <input class="share-input" type="text" name="nomeCartella" required>
                                <button type="submit" class="top-btn">Crea Cartella</button>
                            </form>

                            <div class="divider"></div>

                            <form action="upload.jsp" method="post" enctype="multipart/form-data" class="header-form">
                                <input type="file" name="caricamento_file" required>
                                <button type="submit" class="top-btn">Carica File</button>
                            </form>

                            <div class="divider"></div>

                            <a href="logout.jsp" class="logout-btn">Logout</a>
                        </div>
                    </header>
                   
                    <section class="file-container">
                    <%
                    
                    
                    result = statement.executeQuery(
                        "SELECT f.* FROM utente u, permesso p, file f WHERE u.Username = p.Username AND p.IdFile = f.Id AND u.Username = '" +
                        session.getAttribute("user_log") +
                        "' AND f.path = '" +
                        session.getAttribute("CURRENT_PATH_FROM_ORIGIN_FOLDER") +
                        "'"
                    );

                    while (result.next()) { 
                        if(!result.getBoolean("Cartella")){
                            String path = USER_FILES_FOLDER_NAME + result.getString("proprietario") + "/" + result.getString("path") + result.getString("nome");
            %>
                            
                            <div class="card">
                                <a class="empty_anchor" href="<%=path%>" target="_blank"> <!--target="_blank" permette di aprire il file in un'altra schermata-->
                                    <div>
                                        <div class="icon">📄</div>
                                        <p class="filename"><%=result.getString("Nome")%></p>
                                        <p class="owner"><%=result.getString("Proprietario")%></p>
                                    </div>
                                </a>
                            <% 
                        }else{
                        %>
                            <div class="card">
                                <form class="empty_anchor" action="apriCartella.jsp" method="post">
                                    <button type="submit">
                                        <div class="icon">📁</div>
                                        <p class="filename"><%=result.getString("Nome")%></p>
                                        <p class="owner"><%=result.getString("Proprietario")%></p>
                                    </button>
                                    <input name="folderName" value="<%=result.getString("Nome")%>" hidden>
                                </form>
                    <%  } %>
                                <div class="actions">
                                    <form action="delete.jsp" method="POST">
                                        <button type="submit" class="danger">Elimina</button>
                                        <input type="text" name="idFile" value="<%=result.getInt("Id")%>" hidden>
                                        <input name="prop" value="<%= result.getString("Proprietario").equals(user)%>" hidden>
                                    </form>

                                    <form action="condivisione.jsp" method="POST">
                                        <input type="text" name="username" class="share-input" placeholder="Condividi con utente...">
                                        <input type="submit" value="condividi">
                                        <input type="text" name="idFile" value="<%=result.getInt("Id")%>" hidden>
                                        <input type="text" name="cartella" value="<%=result.getBoolean("Cartella")%>" hidden>
                                    </form>
                                </div>
                            </div>
                  <%} %>
                    </section>
                <%
                }else{
                    response.sendRedirect("logout.jsp");
                }
            } else {
                %>
                <section class="hero">
                    <h1>Gugol Ride</h1>
                    <p>Gestisci i tuoi file in modo semplice e veloce</p>

                    <div class="buttons">
                        <a href="login.jsp" class="btn">Login</a>
                        <a href="signup.jsp" class="btn secondary">Sign Up</a>
                    </div>
                </section>
                <%
            }
            %>
    </body>
    
</html>


