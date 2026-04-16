
<%@include file="config.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!<!--  
        mostrare cart + path
  eliminazione 

-->

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>gugol_ride</title>
        <link rel="stylesheet" href="css/style.css">
        <script src="jsForSend.js"></script>
    </head>
    <body>

        <a href="signup.jsp">SIGN UP</a>
        <a href="login.jsp">LOG IN</a>
        
        <br><br>
        
        
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
                    result = statement.executeQuery("SELECT f.* FROM utente u, permesso p, file f WHERE u.Username = p.Username AND p.IdFile = f.Id AND u.Username = '" + session.getAttribute("user_log") + "'");

                    while (result.next()) { 
                        if(!result.getBoolean("Cartella")){
                            String path = USER_FILES_FOLDER_NAME + result.getString("proprietario") + "/" + result.getString("path") + result.getString("nome");
                            
            %>
                            <div>
                                <a href="<%=path%>" target="_blank"> <!--target="_blank" permette di aprire il file in un'altra schermata-->
                                    <div >
                                        <img src="<%=path%>" width="100px" height="100px" title="<%=result.getString("Nome")%> - <%=result.getString("Proprietario")%>"   style="border: 1px solid #ccc">
                                     
                                    </div>
                                </a>
                                        <form action="condivisione.jsp" method="POST">
                                            <input type="text" name="share" placeholder="inserisci nome per condividere"> 
                                            <input type="submit" value="condividi">
                                            <input type="text" name="idFile" value="<%=result.getInt("Id")%>" hidden>
                                        </form>
                                        <form action="delete.jsp" method="POST">
                                            <input type="submit" value="elimina">
                                            <input type="text" name="idFile" value="<%=result.getInt("Id")%>" hidden>
                                            <input name="prop" value="<%= result.getString("Proprietario").equals(user)%>" hidden>
                                        </form>
                            </div>
            
                            <% 
                        }
                    } %>
                <hr>
                    
                <form action="upload.jsp" method="post" enctype="multipart/form-data">
                    <div>
                      <label for="file-upload">Seleziona un file:</label>
                      <input type="file" id="file-upload" name="caricamento_file" required>
                    </div>

                    <button type="submit">Carica File</button>
                </form>
                
                <br><br><br>
                
                <form action="mkdir.jsp" method="post">
                    <div>
                        <label for="folder-upload">Nome:</label>
                        <input type="text" id="folder-upload" name="nomeCartella" required>
                    </div>
                    <button type="submit">Crea Cartella</button>
                </form>
                
                <br><br><br>
                    
                <a href="logout.jsp">LOG OUT</a>
                <%
                }else{
                    response.sendRedirect("logout.jsp");
                }
            }
        %>
    </body>
    
</html>


