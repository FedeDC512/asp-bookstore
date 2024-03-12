<%@LANGUAGE = VBScript%>
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

<div class="big-login-container">
    <div class="small-login-container">
        <div class="login-title">Login: </div>
        <form method="get" action="login.asp" class="big-form-container">
            <div class="form-container">
                <div> Username: <input type="text" name="username" required></div> 
                <div> Password: <input type="text" name="password" required></div> 
            </div>
            <input type="submit" value="Login">
        </form>
    </div>

    <div class="small-login-container">
        <div class="login-title">Sign in:</div>
        <form method="get" action="registration.asp" class="big-form-container">
            <div class="form-container">
                <div> Username: <input type="text" name="username" required></div> 
                <div> Password: <input type="text" name="password" required></div> 
                <div> Favourite Genre: 
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
            </div>
            <input type="submit" value="Sign in">
        </form>
    </div>
</div>


</body>
</html>
