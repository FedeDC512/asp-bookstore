<%@LANGUAGE = VBScript%>
<!--#include file="connection.asp"-->
<%
Dim db_connection, db_recordset
Set db_connection = Server.CreateObject("ADODB.Connection")
Set db_recordset = Server.CreateObject("ADODB.Recordset")
db_connection.Open str_cn
Dim SQL

SQL = "SELECT COUNT(*) FROM books"
Set get_all_books = db_connection.Execute(SQL)
Dim all_books, last_book_page
all_books = get_all_books("COUNT(*)")
last_book_page = Fix(CInt(all_books) / 7)
If (CInt(all_books) Mod 7) <> 0 Then last_book_page = last_book_page + 1 End If
%>

<html>
  <head>
    <title>Gecko's Green Grotto</title>
    <link rel="stylesheet" href="styles.css" type="text/css" >
    <link rel="icon" type="image/svg" href="gecko.svg">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Crimson+Pro:ital,wght@0,200..900;1,200..900&family=Permanent+Marker&display=swap" rel="stylesheet">

    <script>

    let currentPage = 1;
    let lastPage = <%= last_book_page %>;

    // Funzione per caricare una pagina di libri specifica senza ricaricare la pagina
    function loadBooks(page) {
      currentPage = page;
      console.log(currentPage);
      updateButtons();
      let xhr = new XMLHttpRequest();
      xhr.onreadystatechange = function() {
        if (xhr.readyState == 4 && xhr.status == 200) {
          document.getElementById("card-list").innerHTML = xhr.responseText;
        }
      };
      xhr.open("GET", "get_books.asp?username=<%=username%>&password=<%=hashed_password%>&page=" + page, true);
      xhr.send();
    }

      // Funzione per caricare i prossimi 7 libri senza ricaricare la pagina
      function nextPage() {
        if (currentPage < lastPage) {
          currentPage++;
          loadBooks(currentPage);
        }
      }

      // Funzione per caricare i precedenti 7 libri senza ricaricare la pagina
      function prevPage() {
        if (currentPage > 1) {
          currentPage--;
          loadBooks(currentPage);
        }
      }

      function hideButtons(){
        let firstNumberButton = document.querySelector('#page-selector-prev');
        let lastNumberButton = document.querySelector('#page-selector-next');
        let prevDots = document.querySelector('#prev-dots');
        let nextDots = document.querySelector('#next-dots');
        if(currentPage <= 1){
          prevDots.style.display = "none";
          firstNumberButton.style.display = "none";
          lastNumberButton.style.display = "block";
          nextDots.style.display = "block";
        } else if(currentPage = 2){
          prevDots.style.display = "none";
          firstNumberButton.style.display = "block";
          lastNumberButton.style.display = "block";
          nextDots.style.display = "block";
        } else if (currentPage = <%= last_book_page %>-1){
          prevDots.style.display = "block";
          firstNumberButton.style.display = "block";
          lastNumberButton.style.display = "block";
          nextDots.style.display = "none";
        } else if (currentPage >= <%= last_book_page %>+0){
          prevDots.style.display = "block";
          firstNumberButton.style.display = "block";
          lastNumberButton.style.display = "none";
          nextDots.style.display = "none";
        } else {
          prevDots.style.display = "block";
          firstNumberButton.style.display = "block";
          lastNumberButton.style.display = "block";
          nextDots.style.display = "block";
        }
      }

    function updateButtons() {
      let buttonNext = document.querySelector('#page-selector-next');
      let buttonPrev = document.querySelector('#page-selector-prev');
      let buttonCurr = document.querySelector('#page-selector-curr');
      
      buttonCurr.textContent = currentPage;
      buttonPrev.textContent = currentPage-1;
      buttonPrev.setAttribute('onclick', 'loadBooks(' + (currentPage - 1) + ')')
      buttonNext.textContent = currentPage+1;
      buttonNext.setAttribute('onclick', 'loadBooks(' + (currentPage + 1) + ')')

      hideButtons();
    }
    </script>

  </head>

<body class="homepage-body">
  
  <!--#include file="header.asp"-->
    
  <div class="middle-page">
    <div class="card-list" id="card-list">

<%
  SQL = "SELECT * FROM books LIMIT 0, 7"
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
      <a href="#" onclick="loadBooks(1)" class="button">First (1)</a>
      <div id="prev-dots" style="display: none;" >...</div>
      <a href="#" onclick="prevPage()" style="display: none;" class="button" id="page-selector-prev">0</a>
      <div class="button pressed-button" id="page-selector-curr">1</div>
      <a href="#" onclick="nextPage()" class="button" id="page-selector-next">2</a>
      <div id="next-dots">...</div>
      <a href="#" onclick="loadBooks(<%= last_book_page %>)" class="button">Last (<%=last_book_page%>)</a>
    </div>
    
  </body>
</html>
<%

db_recordset.Close
Set db_recordset = Nothing

db_connection.Close
Set db_connection = Nothing
%>