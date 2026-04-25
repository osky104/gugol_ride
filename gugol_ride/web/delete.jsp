<%@include file="config.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%! 
    private void deleteFile(String id, String user, String currentPathFromOriginFolder) throws Exception{
        Statement localStatement = null;
        ResultSet localResult = null;
        Statement fileStatement = null;
        ResultSet files = null;

        try {
            localStatement = connect.createStatement();
            localResult = localStatement.executeQuery("SELECT Id, Nome, Proprietario, Cartella FROM file WHERE Id = '" + id + "'");

            if(localResult.next()){
                boolean isProprietario = localResult.getString("Proprietario").equals(user);
                if(isProprietario){
                    String nome = localResult.getString("Nome");
                    String proprietario = localResult.getString("Proprietario");

                    if (localResult.getBoolean("Cartella")){
                        fileStatement = connect.createStatement();
                        files = fileStatement.executeQuery("SELECT Id FROM file WHERE path = '"+ currentPathFromOriginFolder + nome +"/'");

                        while(files.next()){
                            deleteFile(files.getString("Id"), user, currentPathFromOriginFolder + nome + "/");
                        }

                        fileStatement.close();
                        files.close();
                    }

                    localStatement.execute("DELETE FROM file WHERE Id = '" + id + "'");
                    File f = new File(USER_FILES_PATH + proprietario + '/' + currentPathFromOriginFolder + nome);
                    f.delete();
                }else{
                    boolean isCartella = localResult.getBoolean("Cartella");
                    String nomeFile = localResult.getString("nome");
                    localStatement.execute("DELETE FROM permesso WHERE IdFile = '" + id + "' AND Username = '" + user + "'");

                    if (isCartella){
                        fileStatement = connect.createStatement();
                        files = fileStatement.executeQuery("SELECT Id FROM `file` WHERE Path LIKE CONCAT('%','" + nomeFile + "','%')"); //Seleziona gli id di tutti i file nel cui percorso è contenuto il nome della cartella

                        while(files.next()){
                            localStatement.execute("DELETE FROM permesso WHERE Username = '" + user + "' AND IdFile = '" + files.getString("Id") + "'");
                        }

                        fileStatement.close();
                        files.close();
                    }
                }
            }
        } catch (Exception e){
            throw new Exception(e);
        } finally{
            if (localStatement != null){
                localStatement.close();
            }
            if (localResult != null){
                localResult.close();
            }
            if (fileStatement != null){
                fileStatement.close();
            }
            if (files != null){
                files.close();
            }
        }
    }
%>

<%
    String user = session.getAttribute("user_log").toString();
    if (user != null){
        try{
            if(request.getMethod().equals("POST")){
                String id = request.getParameter("idFile");
                String path = session.getAttribute("CURRENT_PATH_FROM_ORIGIN_FOLDER").toString();
                
                deleteFile(id, user, path);
            }
        } catch(Exception e){
            out.println("<p class='error'>Errore: " + e.getMessage() + " </p>");
        } finally{
            closeConnection();
        }
    }
    response.sendRedirect("index.jsp");
%>