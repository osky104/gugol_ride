
<%@page import="java.io.File"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%! 
    // Costanti per il Database
    private final String DRIVER = "com.mysql.cj.jdbc.Driver";
    private final String NAME = "gugolRide";
    private final String URL_mioDB = "jdbc:mysql://localhost:3306/";
    private final String userName = "root";
    private final String password = "";
    private boolean ready = false;
    
    final String USER_FILES_PATH = "../user_files/";
    final int TEMPO_MASSIMO_INATTIVITA = 3600;
    Connection connect = null;
    Statement statement = null;
    ResultSet result = null;

    public void closeConnection() throws SQLException{
        if (result != null) result.close();
        if (statement != null) statement.close();
        if (connect != null) connect.close();
    }
%>
<%
    out.println("<h1>TODO: cookie logout per inattività</h1>");
    try {
        Class.forName(DRIVER);
        connect = DriverManager.getConnection(URL_mioDB, userName, password);
        statement = connect.createStatement();
        //creazione database
        statement.execute("CREATE DATABASE IF NOT EXISTS " + NAME);
        statement.execute("USE " + NAME);

        //Creazione tabelle
        if (!ready){
            statement.execute("CREATE TABLE IF NOT EXISTS Utente ("
                + "Username VARCHAR(20) PRIMARY KEY,"
                + "Password VARCHAR(20) NOT NULL"
            + ")");

            statement.execute("CREATE TABLE IF NOT EXISTS File ("
                + "Id INT AUTO_INCREMENT PRIMARY KEY,"
                + "Path VARCHAR(267) NOT NULL,"
                + "Nome VARCHAR(50) NOT NULL,"
                + "Cartella BOOLEAN NOT NULL,"
                + "Proprietario VARCHAR(20) NOT NULL,"
                + "FOREIGN KEY (Proprietario) REFERENCES Utente(Username)"
            + ")");

            statement.execute("CREATE TABLE IF NOT EXISTS Permesso ("
                + "Username VARCHAR(20),"
                + "IdFile INT,"
                + "PRIMARY KEY (Username, IdFile),"
                + "FOREIGN KEY(Username) REFERENCES Utente(Username),"
                + "FOREIGN KEY(IdFile) REFERENCES File(Id)"
            + ")");

            File userFilesFolder = new File(USER_FILES_PATH);
            if (!userFilesFolder.exists()){
                userFilesFolder.mkdir();
            }
            
            result = statement.executeQuery("SELECT username FROM utente");
            while(result.next()){
                File userDir = new File(USER_FILES_PATH + result.getString(1));
                if (!userDir.exists()){
                    userDir.mkdir();
                }
            }
            
            ready = true;
        }
    } catch (ClassNotFoundException e) {
        out.println("<p class='error'>Errore: Driver non trovato</p>");
    } catch (SQLException e) {
        out.println("<p class='error'>Errore database: " + e.getMessage() + " </p>");
    }
%>