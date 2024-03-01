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
    <div class="card-list-profile">
        <div class="card-profile">
    <img src="https://picsum.photos/200" alt="Random Profile Image" width="200" height="200">
    <h2><%=username%>'s Profile</h2>
    <div><b>Your books: </b>
        <%SQL = "SELECT b.id, b.name, b.author, b.genre, b.description FROM books b INNER JOIN b_cart c ON b.id = c.book_id INNER JOIN b_users u ON c.user_id = u.id WHERE u.name = '"& username &"'"
        db_recordset.Open SQL, db_connection
        If db_recordset.EOF = True Then%>
        No books found
        <%Else
        While db_recordset.EOF = False%>
        <%=db_recordset("name")%>, 
        <%db_recordset.MoveNext
        Wend
        End If %><br>
        <%db_recordset.Close
        SQL = "SELECT favourite_genre FROM b_users WHERE name = '"& username &"'"
         db_recordset.Open SQL%>

        <b>Favourite Genre: </b><%=db_recordset("favourite_genre")%>
    </div>
</div>
      </div>
      <div class="small-page-title permanent-marker-regular">Since you like <%=db_recordset("favourite_genre")%>, you might be interested in...</div>

    <div class="profile-card-list">
    <%
    SQL = "SELECT * FROM books WHERE genre = '"& db_recordset("favourite_genre") &"'"
    db_recordset.Close
    db_recordset.Open SQL
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
        <a href="buy_book.asp?username=<%=username%>&book=<%=db_recordset("id")%>" class="button"><b>Buy </b>
        <svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 48 48"><g fill="none" stroke="currentColor" stroke-width="4"><path stroke-linejoin="round" d="M6 15h36l-2 27H8z" clip-rule="evenodd"/><path stroke-linecap="round" stroke-linejoin="round" d="M16 19V6h16v13"/><path stroke-linecap="round" d="M16 34h16"/></g></svg>
        </a>
      </div>
  </div>
    <%
    db_recordset.MoveNext
    Wend
    End If %>
    </div>
  </body>
</html>
<%

db_recordset.Close
Set db_recordset = Nothing

db_connection.Close
Set db_connection = Nothing
%>