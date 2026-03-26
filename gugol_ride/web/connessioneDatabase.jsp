<%-- 
    Document   : connessioneDatabase
    Created on : 26 feb 2026, 12:32:38
    Author     : oscar.farina
--%>

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
    

    try {
        Class.forName(DRIVER);
        connect = DriverManager.getConnection(URL_mioDB, userName, password);
        statement = connect.createStatement();

        //creazione database
        statement.execute("CREATE DATABASE IF NOT EXISTS " + NAME);
        statement.execute("USE " + NAME);

        statement.execute("CREATE TABLE IF NOT EXISTS Utente ("
            + "Username VARCHAR(20) PRIMARY KEY,"
            + "Password VARCHAR(20) NOT NULL,"
            + "PathCartella VARCHAR(267) NOT NULL"
        + ")");

        statement.execute("CREATE TABLE IF NOT EXISTS File ("
            + "Id INT AUTO_INCREMENT PRIMARY KEY,"
            + "Path VARCHAR(267) UNIQUE NOT NULL,"
            + "Nome VARCHAR(50) NOT NULL,"
            + "Tipo CHAR(1) NOT NULL,"
            + "Proprietario VARCHAR(20) NOT NULL,"
            + "FOREIGN KEY (Proprietario) REFERENCES Utente(Username)"
        + ")");

        statement.execute("CREATE TABLE IF NOT EXISTS Permesso ("
            + "Username VARCHAR(20),"
            + "Id INT,"
            + "PRIMARY KEY (Username, Id),"
            + "FOREIGN KEY(Username) REFERENCES Utente(Username),"
            + "FOREIGN KEY(Id) REFERENCES File(Id)"
        + ")");

    } catch (ClassNotFoundException e) {
        out.println("<p class='error'>Errore: Driver non trovato</p>");
    } catch (SQLException e) {
        out.println("<p class='error'>Errore database: " + e.getMessage() + " </p>");
    }
%>