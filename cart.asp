<%@LANGUAGE = VBScript%>
<!--#include file="connection.asp"-->
<%
Dim db_connection, db_recordset
Set db_connection = Server.CreateObject("ADODB.Connection")
Set db_recordset = Server.CreateObject("ADODB.Recordset")
db_connection.Open str_cn
Dim SQL

If ((request.querystring("name") = "") Or (request.querystring("password") = "")) Then
Response.Redirect "index.asp"
End If
%>

<html>
  <head>
    <title>Gecko's Green Grotto</title>
    <link rel="stylesheet" href="styles.css" type="text/css" >
    <link rel="icon" type="image/svg" href="gecko.svg">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Crimson+Pro:ital,wght@0,200..900;1,200..900&family=Permanent+Marker&display=swap" rel="stylesheet">
  </head>

  <body class="homepage-body">

  <!--#include file="header.asp"-->
  
  <div class="small-page-title permanent-marker-regular">Books that are now in your shopping cart:</div>
    <div class="middle-page">
    <div class="card-list">

<%
  SQL = "SELECT * FROM b_users WHERE name='"& username &"' AND password='"& hashed_password &"'"
  db_recordset.Open SQL, db_connection
    If db_recordset.EOF = True Then
    Response.Redirect "index.asp"
    End If
    db_recordset.Close

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
      <div class="button-line">
        <a href="remove_book.asp?username=<%=username%>&password=<%=hashed_password%>&book=<%=db_recordset("id")%>" class="button red-button"><b>Remove </b>
        <svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24"><path fill="currentColor" d="M22.73 22.73L1.27 1.27L0 2.54l4.39 4.39l2.21 4.66l-1.35 2.45c-.16.28-.25.61-.25.96a2 2 0 0 0 2 2h7.46l1.38 1.38c-.5.36-.84.95-.84 1.62a2 2 0 0 0 2 2c.67 0 1.26-.33 1.62-.84L21.46 24zM7.42 15a.25.25 0 0 1-.25-.25l.03-.12l.9-1.63h2.36l2 2zm8.13-2c.75 0 1.41-.41 1.75-1.03l3.58-6.47c.08-.16.12-.33.12-.5a1 1 0 0 0-1-1H6.54zM7 18a2 2 0 0 0-2 2a2 2 0 0 0 2 2a2 2 0 0 0 2-2a2 2 0 0 0-2-2"/></svg>
        </a>
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