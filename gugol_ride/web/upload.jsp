<%@include file="config.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("user_log") != null){
        try{
            if(request.getMethod().equals("POST")){
                String user = session.getAttribute("user_log").toString();
                Part filePart = request.getPart("caricamento_file");
                String nome  = filePart.getSubmittedFileName();
                String pathFromOriginFolder = session.getAttribute("CURRENT_PATH_FROM_ORIGIN_FOLDER").toString();
                
                File f = new File(USER_FILES_PATH + user + '/' + pathFromOriginFolder + "/" + nome);
                filePart.write(f.getAbsolutePath());
                result = statement.executeQuery("SELECT * FROM file WHERE Nome = '" + nome + "' AND Proprietario = '" + user + "' AND Path = '" + pathFromOriginFolder + "'");

                //Nel db viene inserito il file solo la prima volta che viene caricato, mentre nel file system viene sempre sovrascritto il file già presente
                if (!result.next()){
                    String sql = "INSERT INTO file(Path, Nome, Cartella, Proprietario) VALUES ('" + pathFromOriginFolder + "', '" + nome + "', false, '"  + user + "')";

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