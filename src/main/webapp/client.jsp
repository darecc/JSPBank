<%@ page import="model.DatabaseConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Lokata" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Date" %><%--
 Strona główna klienta banku
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Strona klienta banku</title>
    <meta charset="utf-8"/>
  </head>
  <body>
  <%
    String user = (String)session.getAttribute("user");
    String dbPASS = (String)session.getAttribute("dbPASS");
    String base = (String)application.getAttribute("base");
    Connection conn = DatabaseConnection.initializeDatabase(base);
    Statement stmt = conn.createStatement();
    String sql = "SELECT * FROM klienci where login = '" + user + "';";
    ResultSet rs = stmt.executeQuery(sql);
    System.out.println("result set: " + rs.first());
    String konto = rs.getString("konto");
    double stan = rs.getDouble("stanKonta");
    String imie = rs.getString("imie");
    String nazwisko = rs.getString("nazwisko");
    String adres = rs.getString("adres");
    int idKlienta = rs.getInt("idKlienta");
    sql = "SELECT * FROM lokaty WHERE IDKlienta = " + idKlienta + ";";
    rs = stmt.executeQuery(sql);
    List<Lokata> lokaty = new ArrayList<>();
    while(rs.next()) {
      int id = rs.getInt("ID");
      int idK = rs.getInt("IDKlienta");
      double kwota = rs.getDouble("kwota");
      double procent = rs.getDouble("oprocentowanie");
      int czasTrwania = rs.getInt("czasTrwania");
      Date dataPocz = rs.getDate("dataPoczatkowa");
      Lokata lokata = new Lokata(id, idK, kwota, czasTrwania, dataPocz, procent);
      lokaty.add(lokata);
    }
  %>
  <table border="1">
    <tr><td><%=imie%></td><td><%=nazwisko%></td><td><%=adres%></td></tr>
    <tr><td>Twój numer rachunku</td><td><b><%=konto%></b><td></tr>
    <tr><td>Stan rachunku</td><td><b><%=stan%></b></td></tr>
  </table>
  <p>Twoje lokaty:
    <table border="1">
    <%
      if (lokaty.size() > 0) {
        out.print("<thead><tr>");
        out.print("<th>ID</th><th>Data założenia</th><th>Kwota</th><th>Oprocentowanie</th><th>Czas</th>");
        out.print("</tr></thead>");
      }
      for(Lokata lok : lokaty) {
        out.print("<tr><td>" + lok.getID() + "</td><td>" + lok.getDataPoczatkowa().toString() + "</td><td>" + lok.getKwota() + "</td><td>" + lok.getOprocentowanie() + "</td><td>" + lok.getCzasTrwania() + "</td>");
        out.print("</tr>");
      }
    %>
    </table>
  </p>
  <p>Twoje zlecenia stałe</p>
  </body>
</html>
