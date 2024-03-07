<%@LANGUAGE = VBScript%>
<!--#include file="connection.asp"-->
<!--#include file="aspmd5/class_md5.asp"-->

<%
Dim db_connection 
Set db_connection = Server.CreateObject("ADODB.Connection")
db_connection.Open str_cn


Dim objMD5, hashed_password
Set objMD5 = New MD5
objMD5.Text = request.querystring("password")
hashed_password = objMD5.HEXMD5

Dim SQL
SQL = "INSERT INTO b_users (name, password, favourite_genre) VALUES ('"&request.querystring("username")&"', '"& hashed_password &"', '"&request.querystring("genre")&"')"

db_connection.Execute(SQL)

db_connection.Close
Set db_connection = Nothing
Response.Redirect "homepage.asp?name=" & request.querystring("username") &"&password="& hashed_password
%>