<%@LANGUAGE = VBScript%>
<!--#include file="connection.asp"-->

<%
Dim username, book_id, userCurrentPage
username = request.querystring("username")
book_id = request.querystring("book")
'userCurrentPage = "homepage.asp?username=" & username & "&page=" & userPage
userCurrentPage = "index.asp"

Dim db_connection, SQL
Set db_connection = Server.CreateObject("ADODB.Connection")
db_connection.Open str_cn 

SQL = "SELECT * FROM b_users WHERE name = '" & username &"'"
Set get_user_id = db_connection.Execute(SQL)
Dim user_id
user_id = get_user_id("id")
SQL = "SELECT * FROM b_cart WHERE user_id = '" & user_id &"' AND book_id = '" & book_id &"'"
Set book_in_cart = db_connection.Execute(SQL)

If not book_in_cart.EOF Then

'Response.Write "<script>alert('You have already placed this book in your cart!');</script>"
'Response.Write "<script>setTimeout(function(){ window.location.href = '"&userCurrentPage&"'; }, 9000);</script>"


Else
    SQL = "INSERT INTO b_cart (`user_id`, `book_id`) VALUES ('" & user_id &"', '" & book_id &"')"
    db_connection.Execute(SQL)
End If

db_connection.Close
Set db_connection = Nothing

Response.Write "<p>Record added</p>"
Response.Redirect userCurrentPage
%>