<%@LANGUAGE = VBScript%>
<!--#include file="connection.asp"-->
<%
Dim db_connection, db_recordset
Set db_connection = Server.CreateObject("ADODB.Connection")
Set db_recordset = Server.CreateObject("ADODB.Recordset")
db_connection.Open str_cn
Dim SQL, currentPage 
currentPage = CInt(request.querystring("page"))
If request.querystring("page") = "" Then currentPage = 1 End If

SQL = "SELECT COUNT(*) FROM books"
Set get_all_books = db_connection.Execute(SQL)
Dim all_books, last_book_page
all_books = get_all_books("COUNT(*)")
last_book_page = Fix(CInt(all_books) / 7)
If (CInt(all_books) Mod 7) <> 0 Then last_book_page = last_book_page + 1 End If
%>

<html>
  <head>

  <!--#include file="header.asp"-->
    
  <div class="middle-page">
    <div class="card-list">

<%
  SQL = "SELECT * FROM books LIMIT "& 7*(currentPage-1) &", "& 7
  'SQL= "SELECT * FROM books OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY"
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
    </div>

    <div class="buttons-pages">
      <a href="homepage.asp?name=<%=username%>&password=<%=hashed_password%>&page=1" class="button">First (1)</a>

      <% If currentPage > 2 Then %><div>...</div><%End If%>

      <% If currentPage > 1 Then %>
      <a href="homepage.asp?name=<%=username%>&password=<%=hashed_password%>&page=<%=currentPage-1%>" class="button"><%= currentPage-1%></a>
      <%End If%>

      <div class="button pressed-button"><%= currentPage%></div>

      <% If currentPage < last_book_page Then %>
      <a href="homepage.asp?name=<%=username%>&password=<%=hashed_password%>&page=<%=currentPage+1%>" class="button"><%= currentPage+1%></a>
      <%End If%>

      <% If currentPage < last_book_page-1 Then %><div>...</div><%End If%>
      <a href="homepage.asp?name=<%=username%>&password=<%=hashed_password%>&page=<%=last_book_page%>" class="button">Last (<%=last_book_page%>)</a>
    </div>
  </body>
</html>
<%

db_recordset.Close
Set db_recordset = Nothing

db_connection.Close
Set db_connection = Nothing
%>