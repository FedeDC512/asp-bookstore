<%@LANGUAGE = VBScript%>
<!--#include file="connection.asp"-->
<%
Dim db_connection, db_recordset 
Set db_connection = Server.CreateObject("ADODB.Connection")
Set db_recordset = Server.CreateObject("ADODB.Recordset")

db_connection.Open str_cn

Dim SQL
SQL = "SELECT * FROM b_users WHERE name = '"&request.querystring("lusername")&"' AND password = '"&request.querystring("lpassword")&"'"

db_recordset.Open SQL, db_connection
%>

<html>
<head>
    <title>Login Page</title>
    <link rel="stylesheet" href="styles.css" type="text/css" >
</head>
<body>
<div class="big-login-container">
<div class = "login-page-container"> 

<%
If db_recordset.EOF = True Then
%>
<p>The entered data does not match any registered user, please sign in!</p>
<a href="index.asp">
  <button>Sign in</button>
</a>

<%
Else
%>
<div>The user is correctly registered!</div>
<div>
    <b>ID:</b> <%=db_recordset("id")%> <br>
    <b>Username:</b> <%=db_recordset("name")%> <br>
    <b>Favourite Genre:</b> <%=db_recordset("favourite_genre")%> <br>
</div>

<%
Dim username, userHomepage
username = db_recordset("name")
userHomepage = "homepage.asp?name=" & Server.URLEncode(username)
%>

<a href= "<%= userHomepage%>">
  <button>Homepage</button>
</a>

<%
End If
%>
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
