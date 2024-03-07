<%@LANGUAGE = VBScript%>
<!--#include file="connection.asp"-->

<%
Dim username, book_id, userCurrentPage, hashed_password

If request.querystring("username") = "" Then
Response.Redirect "index.asp"
End If

username = request.querystring("username")
book_id = request.querystring("book")
hashed_password = request.querystring("password")
userCurrentPage = "cart.asp?name="& username & "&password="& hashed_password

Dim db_connection, SQL
Set db_connection = Server.CreateObject("ADODB.Connection")
db_connection.Open str_cn 

SQL = "DELETE FROM b_cart WHERE book_id = '" & book_id &"' AND user_id = (SELECT id FROM b_users WHERE name = '"& username &"' AND password='"& hashed_password &"')"
db_connection.Execute(SQL)
db_connection.Close
Set db_connection = Nothing

Response.Write "<p>Book deleted</p>"
Response.Redirect userCurrentPage
%>