<%--
  tworzenie nowego konta
--%>
<%@ page contentType="text/html" pageEncoding="UTF-8" language="java" %>
<html>
  <head>
    <title>Tworzenie nowego konta</title>
    <meta charset="utf-8"/>
  </head>
  <body>
  <h3>Dzisiaj w promocji dostaniesz na start 500 zł</h3><br/>
  <form action="newClient.jsp" method="post">
    <label>Imię </label>
    <input name = "imie" type="text"/>
    <label>Nazwisko</label>
    <input name = "nazwisko" type = "text"/><br/>
    <label>PESEL: </label>
    <input name = "pesel" type="text"/><br/>
    <label>Adres: </label>
    <input name = "adres" type="text"/><br/>
    <label>Login: </label>
    <input name="login" type="text"/><br/>
    <label>Hasło: </label>
    <input name = "haslo" type = "password"/><br/>
    <input type = "submit" value="Dodaj"/>
  </form>
  </body>
</html>
