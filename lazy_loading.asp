<%@LANGUAGE = VBScript%>
<!--#include file="connection.asp"-->
<%
Dim db_connection, db_recordset
Set db_connection = Server.CreateObject("ADODB.Connection")
Set db_recordset = Server.CreateObject("ADODB.Recordset")
db_connection.Open str_cn

Dim currentPage
currentPage = CInt(Request.QueryString("page"))
If Request.QueryString("page") = "" Then currentPage = 1

Dim SQL
SQL = "SELECT * FROM books LIMIT "& 7*(currentPage-1) &", "& 7
db_recordset.Open SQL, db_connection

Dim bookData
bookData = ""
If Not db_recordset.EOF Then
    bookData = "["
    Do While Not db_recordset.EOF
        bookData = bookData & "{"
        bookData = bookData & """id"":""" & db_recordset("id") & ""","
        bookData = bookData & """name"":""" & db_recordset("name") & ""","
        bookData = bookData & """author"":""" & db_recordset("author") & ""","
        bookData = bookData & """genre"":""" & db_recordset("genre") & ""","
        bookData = bookData & """description"":""" & db_recordset("description") & """"
        bookData = bookData & "},"
        db_recordset.MoveNext
    Loop
    bookData = Left(bookData, Len(bookData) - 1) ' Rimuovi l'ultima virgola
    bookData = bookData & "]"
End If

Response.ContentType = "application/json"
Response.Write bookData

db_recordset.Close
Set db_recordset = Nothing

db_connection.Close
Set db_connection = Nothing
%>