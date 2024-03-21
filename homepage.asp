<%@LANGUAGE = VBScript%>
<!--#include file="connection.asp"-->
<%
Dim db_connection, db_recordset
Set db_connection = Server.CreateObject("ADODB.Connection")
Set db_recordset = Server.CreateObject("ADODB.Recordset")
db_connection.Open str_cn

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
    $(document).ready(function() {
        var currentPage = 1;

        // Funzione per caricare i dati dei libri dal server
        function loadBooks() {
            $.ajax({
                url: 'lazy_loading.asp',
                method: 'GET',
                data: { page: currentPage },
                dataType: 'json',
                success: function(data) {
                    if (data.length > 0) {
                        $.each(data, function(index, book) {
                            $('#card-list').append(`
                              <div class="card">
                                <img src="./book_covers/${book.id}.jpg" alt="${book.name} Book Cover">
                                <div>
                                  <b>ID:</b> ${book.id}<br>
                                  <b>Book Name:</b> ${book.name}<br>
                                  <b>Author:</b> ${book.author}<br>
                                  <b>Genre:</b> ${book.genre}<br>
                                  <b>Description:</b> ${book.description}<br>
                                </div>
                                <div class="button-line">
                                  <a href="buy_book.asp?username=<%=ajaxUsername%>&password=<%=ajaxPassword%>&book=${book.id}" class="button"><b>Buy</b> 
                                    <svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 48 48">
                                      <g fill="none" stroke="currentColor" stroke-width="4">
                                        <path stroke-linejoin="round" d="M6 15h36l-2 27H8z" clip-rule="evenodd"/>
                                        <path stroke-linecap="round" stroke-linejoin="round" d="M16 19V6h16v13"/>
                                        <path stroke-linecap="round" d="M16 34h16"/>
                                      </g>
                                    </svg>
                                  </a>
                                </div>
                              </div>`);
                        });
                        currentPage++;
                        console.log("CurrentPage: " + (currentPage-1) +" ("+ data.length +" books)");
                    } 

                    if (currentPage > <%=last_book_page%>) {
                        $('#loadMoreBtn').hide();
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Errore durante il recupero dei dati dei libri:', error);
                }
            });
        }

        // Carica i libri iniziali
        loadBooks();

        // Carica ulteriori libri quando si fa clic sul pulsante "Load More"
        $('#loadMoreBtn').click(function() {
            loadBooks();
        });
    });
    </script>

  </head>

<body class="homepage-body">
  
  <!--#include file="header.asp"-->
    
  <div class="middle-page">
    <div class="card-list" id="card-list">

    </div>
  </div>
  <div class="button-line">
    <button class="load-more-button" id="loadMoreBtn">Load More</button>
  </div>
    
  </body>
</html>