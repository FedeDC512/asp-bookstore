<%@LANGUAGE = VBScript%>
<!--#include file="connection.asp"-->

<%
Dim db_connection 
Set db_connection = Server.CreateObject("ADODB.Connection")
db_connection.Open str_cn

Dim SQL
SQL = "UPDATE b_users SET favourite_genre = '"&request.querystring("genre")&"' WHERE name = '"& request.querystring("name") &"'"
db_connection.Execute(SQL)

db_connection.Close
Set db_connection = Nothing
Response.Redirect "profile.asp?name="&request.querystring("name")
%>