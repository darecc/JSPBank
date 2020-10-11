<%--
 Strona główna klienta banku
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Strona klienta banku</title>
  </head>
  <body>
  <%
    String dbUSER = (String)session.getAttribute("dbUSER");
    String dbPASS = (String)session.getAttribute("dbPASS");
    String base = (String)application.getAttribute("base");
  %>
  <p>Twój numer rachunku: </p>
  <p>Stan rachunku: </p>
  <p>Twoje lokaty:</p>
  <p>Twoje zlecenia stałe</p>
  </body>
</html>
