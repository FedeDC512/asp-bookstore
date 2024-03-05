<%@LANGUAGE = VBScript%>
<!--#include file="connection.asp"-->

<%
Dim db_connection 
Set db_connection = Server.CreateObject("ADODB.Connection")
db_connection.Open str_cn

Dim SQL
SQL = "INSERT INTO b_users (name, password, favourite_genre) VALUES ('"&request.querystring("fusername")&"', '"&request.querystring("fpassword")&"', '"&request.querystring("fgenre")&"')"

db_connection.Execute(SQL)

db_connection.Close
Set db_connection = Nothing
Response.Redirect "homepage.asp?name="&request.querystring("fusername")
%>