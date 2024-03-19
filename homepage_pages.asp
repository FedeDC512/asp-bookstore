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

Dim ajaxUsername, ajaxPassword
ajaxUsername = request.querystring("name")
ajaxPassword = request.querystring("password")
%>

<html>
  <head>
    <title>Gecko's Green Grotto</title>
    <link rel="stylesheet" href="styles.css" type="text/css" >
    <link rel="icon" type="image/svg" href="gecko.svg">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Crimson+Pro:ital,wght@0,200..900;1,200..900&family=Permanent+Marker&display=swap" rel="stylesheet">

    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
    let currentPage = 1;
    let lastPage = <%= last_book_page %>;

    $(document).ready(function() {
      loadBooks(currentPage);

      $('#page-selector-prev').click(function() {
        if (currentPage > 1) {
          currentPage--;
          loadBooks(currentPage);
        }
      });

      $('#page-selector-next').click(function() {
        if (currentPage < lastPage) {
          currentPage++;
          loadBooks(currentPage);
        }
      });
    });

    function loadBooks(page) {
      currentPage = page;
      console.log("Page "+currentPage);
      updateButtons();
      $.ajax({
        url: 'get_books.asp',
        type: 'GET',
        data: {
          username: "<%=ajaxUsername%>",
          password: "<%=ajaxPassword%>",
          page: page
        },
        success: function(response) {
          $('#card-list').html(response);
        },
        error: function(xhr, status, error) {
          console.error(xhr.responseText);
        }
      });
    }

    function updateButtons() {
      $('#page-selector-prev').text(currentPage - 1);
      $('#page-selector-curr').text(currentPage);
      $('#page-selector-next').text(currentPage + 1);

      if (currentPage <= 1) {
        $('#prev-dots, #page-selector-prev').hide();
        $('#next-dots, #page-selector-next').show();
      } else if(currentPage == 2){
        $('#prev-dots').hide();
        $('#page-selector-prev, #next-dots, #page-selector-next').show();
      } else if (currentPage == lastPage-1) {
        $('#next-dots').hide();
        $('#page-selector-prev, #prev-dots, #page-selector-next').show();
      } else if (currentPage >= lastPage) {
        $('#prev-dots, #page-selector-prev').show();
        $('#next-dots, #page-selector-next').hide();
      } else {
        $('#prev-dots, #page-selector-prev, #next-dots, #page-selector-next').show();
      }
    }
    </script>

  </head>

<body class="homepage-body">
  
  <!--#include file="header.asp"-->
    
  <div class="middle-page">
    <div class="card-list" id="card-list">

    </div>
  </div>

    <div class="buttons-pages">
      <a href="#" onclick="loadBooks(1)" class="button">First (1)</a>
      <div id="prev-dots" style="display: none;" >...</div>
      <a href="#" style="display: none;" class="button" id="page-selector-prev">0</a>
      <div class="button pressed-button" id="page-selector-curr">1</div>
      <a href="#" class="button" id="page-selector-next">2</a>
      <div id="next-dots">...</div>
      <a href="#" onclick="loadBooks(<%= last_book_page %>)" class="button">Last (<%=last_book_page%>)</a>
    </div>
    
  </body>
</html>