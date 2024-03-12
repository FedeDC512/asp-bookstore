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
  
    <div class="card-list-profile">
        <div class="card-profile">
    <!-- <img src="https://picsum.photos/200" alt="Random Profile Image" width="200" height="200"> -->
    <h2><%=username%>'s Profile</h2>
    <div><b>Books in your shopping cart: </b>
        <%SQL = "SELECT b.id, b.name, b.author, b.genre, b.description FROM books b INNER JOIN b_cart c ON b.id = c.book_id INNER JOIN b_users u ON c.user_id = u.id WHERE u.name = '"& username &"' AND u.password='"& hashed_password &"'"
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
        SQL = "SELECT favourite_genre FROM b_users WHERE name = '"& username &"' AND password='"& hashed_password &"'"
         db_recordset.Open SQL%>
        <b>Favourite Genre: </b><%=db_recordset("favourite_genre")%><br>
        <br>

        <form method="get" action="change_genre.asp" class="change-genre">
                <div> <b>Change Favourite Genre to: </b>
                  <select name="genre" id="genre-selected">
                    <option value="Adventure">Adventure</option>
                    <option value="Classics">Classics</option>
                    <option value="Fantasy">Fantasy</option>
                    <option value="Fiction">Fiction</option>
                    <option value="Historical Fiction">Historical Fiction</option>
                    <option value="Horror">Horror</option>
                    <option value="Mystery">Mystery</option>
                    <option value="Philosophical Fiction">Philosophical Fiction</option>
                    <option value="Romance">Romance</option>
                    <option value="Satire">Satire</option>
                    <option value="Science Fiction">Science Fiction</option>
                    <option value="Thriller">Thriller</option>
                  </select>
                 </div> 
            <input type="hidden" id="name" name="name" value="<%=username%>"/>
            <input type="hidden" id="password" name="password" value="<%=hashed_password%>"/>
            <input type="submit" value="Change genre">
        </form>
    </div>
        <a href="index.asp" class="button red-button"><b>Logout</b>
        <svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24"><g fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"><path d="M14 8V6a2 2 0 0 0-2-2H5a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h7a2 2 0 0 0 2-2v-2"/><path d="M9 12h12l-3-3m0 6l3-3"/></g></svg>
        </a>
</div>
      </div>
      <div class="small-page-title permanent-marker-regular">Since you like <%=db_recordset("favourite_genre")%> Books, you might be interested in...</div>

    <div class="profile-card-list">
    <%
    SQL = "SELECT * FROM books WHERE genre = '"& db_recordset("favourite_genre") &"' LIMIT 7"
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
        <a href="buy_book.asp?username=<%=username%>&password=<%=hashed_password%>&book=<%=db_recordset("id")%>" class="button"><b>Buy </b>
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