<%@ page import="model.DatabaseConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Lokata" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Date" %>
<%@ page import="model.Zlecenie" %><%--
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
    sql = "SELECT * FROM zlecenia WHERE IDKlienta = " + idKlienta + ";";
    rs = stmt.executeQuery(sql);
    List<Zlecenie> zlecenia = new ArrayList<>();
    while(rs.next()) {
      int id = rs.getInt("ID");
      int idK = rs.getInt("IDKlienta");
      double kwota = rs.getDouble("kwota");
      String odbiorca = rs.getString("odbiorca");
      int dzien = rs.getInt("dzien");
      Zlecenie zlecenie = new Zlecenie(id, idK, dzien, kwota, odbiorca);
      zlecenia.add(zlecenie);
    }
  %>
  <b>Twoje dane</b></br/>
  <table border="1">
    <tr><td><%=imie%> <%=nazwisko%></td><td><%=adres%></td></tr>
    <tr><td>Twój numer rachunku</td><td><b><%=konto%></b><td></tr>
    <tr><td>Stan rachunku</td><td><b><%=stan%></b></td></tr>
  </table>
  <p><b>Twoje lokaty</b>:
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
  <a href="addDeposit.jsp">Załóż nową lokatę</a>
  </p>
  <p><b>Twoje zlecenia stałe</b>
  <table border="1">
    <%
      if (zlecenia.size() > 0) {
        out.print("<thead><tr>");
        out.print("<th>ID</th><th>Dzień miesiąca</th><th>Kwota</th><th>Konto</th>");
        out.print("</tr></thead>");
      }
      for(Zlecenie zle : zlecenia) {
        out.print("<tr><td>" + zle.getID() + "</td><td>" + zle.getDzien() + "</td><td>" + zle.getKwota() + "</td><td>" + zle.getOdbiorca() + "</td>");
        out.print("</tr>");
      }
    %>
  </table>
  <p>Nowe zlecenie:</p>
  <form action="newStandingOrder.jsp" method="post">
    <label>Dzień: </label>
    <input name="dzien" type="number"/><br/>
    <label>Kwota: </label>
    <input name="kwota" type="number"/><br/>
    <label>Numer rachunku</label>
    <input name="konto" type="text"/>
    <input name="IDKlienta" id="IDKlienta" type="hidden" value="<%=idKlienta%>"/>
    <input type = "submit" value="Utwórz zlecenie"/>
  </form>
  <div>
  <p>Nowy przelew:</p>
  <form action="newTransfer.jsp" method="post">
    <label>Kwota: </label>
    <input name="kwota" type="number"/>
    <label>Numer rachunku</label>
    <input name="konto" type="text"/>
    <input name="IDKlient" id="IDKlient" type="hidden" value="<%=idKlienta%>"/>
    <input name="stan" id="stan" type="hidden" value="<%=stan%>"/>
    <input name="numerKonta" id="numerKonta" type="hidden" value="<%=konto%>"/>
    <input type = "submit" value="Utwórz przelew"/>
  </form>
  </p>
  </div>
  </body>
</html>
