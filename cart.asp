<%@LANGUAGE = VBScript%>
<!--#include file="connection.asp"-->
<%
Dim db_connection, db_recordset
Set db_connection = Server.CreateObject("ADODB.Connection")
Set db_recordset = Server.CreateObject("ADODB.Recordset")
db_connection.Open str_cn
Dim SQL, username
username = "fededc"
%>

<html>
  <!--#include file="header.asp"-->
    <div class="middle-page">
    <div class="card-list">

<%
  SQL = "SELECT b.id, b.name, b.author, b.genre, b.description FROM books b INNER JOIN b_cart c ON b.id = c.book_id INNER JOIN b_users u ON c.user_id = u.id WHERE u.name = '"& username &"'"
  db_recordset.Open SQL, db_connection
    If db_recordset.EOF = True Then
  %>
  <div class="card">No data found</div>
  <%Else
  While db_recordset.EOF = False%>
  <div class="card">
      <img src="./book_covers/<%=db_recordset("id")%>.jpg" alt="<%=db_recordset("name")%> Book Cover">
      <div>
        <b>ID:</b> <%=db_recordset("id")%> <br>
        <b>Book Name:</b> <%=db_recordset("name")%> <br>
        <b>Author:</b> <%=db_recordset("author")%> <br>
        <b>Genre:</b> <%=db_recordset("genre")%> <br>
        <b>Description:</b> <%=db_recordset("description")%> <br>
      </div>
  </div>
  
  <%
  db_recordset.MoveNext
  Wend
  End If %>
      </div>
    </div>
  </body>
</html>
<%

db_recordset.Close
Set db_recordset = Nothing

db_connection.Close
Set db_connection = Nothing
%>