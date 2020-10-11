<%@ page import="java.sql.Connection" %>
<%@ page import="model.DatabaseConnection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: 48605
  Date: 11.10.2020
  Time: 15:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Dodanie nowego klienta</title>
  </head>
  <body>
  <%
    String imie = request.getParameter("imie");
    String nazwisko = request.getParameter("nazwisko");
    String pesel = request.getParameter("pesel");
    String adres = request.getParameter("adres");
    String login = request.getParameter("login");
    String haslo = request.getParameter("haslo");
    Connection conn = DatabaseConnection.initializeDatabase("bank");
    Statement stmt = conn.createStatement();
    String md5 = DatabaseConnection.makeMD5(haslo);
    String sql = "INSERT INTO klienci " +
            "(imie, nazwisko, pesel, adres, login, password, role) " +
            "values ('" + imie + "','" + nazwisko + "','" + pesel + "','" +adres + "','" +login + "','" + md5 +"','client');";
    System.out.println("sql=@" + sql + "@");
    int rs = stmt.executeUpdate(sql);
    System.out.println("Wstawiono: " + rs + " rekord");
    if (rs > 0)
      response.sendRedirect("login.jsp?user=?" + login);
  %>
  </body>
</html>
