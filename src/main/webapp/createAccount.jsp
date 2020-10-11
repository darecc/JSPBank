<%--
  tworzenie nowego konta
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Tworzenie nowego konta</title>
  </head>
  <body>
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
    <input name = "haslo" type = "password"/>
    <input type = "submit" value="Dodaj"/>
  </form>
  </body>
</html>
