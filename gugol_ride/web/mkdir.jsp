<%@include file="config.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("user_log") != null){
        try{
            if(request.getMethod().equals("POST")){
                String user = session.getAttribute("user_log").toString();
                String nome = request.getParameter("nomeCartella");
                String pathFromOriginFolder = session.getAttribute("CURRENT_PATH_FROM_ORIGIN_FOLDER").toString();
                
                File dir = new File(USER_FILES_PATH + user + '/' + pathFromOriginFolder + '/' + nome);
                if(!dir.isDirectory()){
                    dir.mkdir();
                }

                result = statement.executeQuery("SELECT * FROM file WHERE Nome = '" + nome + "' AND Proprietario = '" + user + "' AND Path = '" + pathFromOriginFolder + "'");

                if (!result.next()){
                    String sql = "INSERT INTO file(Path, Nome, Cartella, Proprietario) VALUES ('" + pathFromOriginFolder + "', '" + nome + "', true, '"  + user + "')";

                    PreparedStatement query = connect.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                    query.executeUpdate();
                    ResultSet keys = query.getGeneratedKeys();
                    keys.next();
                    long id = keys.getLong(1);

                    statement.execute("INSERT INTO permesso(Username, IdFile) VALUES ('" + user + "', '" + id + "')");
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
