<%Dim username, hashed_password
username = request.querystring("name")
hashed_password = request.querystring("password")
%>

<div class="header">
    <div class="h-logoname">
        <a href="homepage.asp?name=<%=username%>&password=<%=hashed_password%>"><svg class="gecko h-button" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 512 512"><path fill="currentColor" d="M439.313 23.094c-14.073-.124-34.5 9.153-60.25 28.875c-.54-.5-1.12-.986-1.72-1.44c-9.96-7.527-24.127-5.554-31.656 4.407c-7.408 9.803-5.613 23.7 3.938 31.313c-4.674 14.337-1.07 28.65 7.094 40.125c-.335 6.702-2.71 12.345-9.97 18c-9.175 7.148-18.937 16.258-28.688 26.97c-22.286-11.36-39.37-29.202-54-49.595l2.094-.875c36.75-15.54 22.554-40.264-11.03-26.063c-6.733-15.916-14.667-22.693-20.75-22.843c-8.893-.22-13.83 13.717-5.314 33.874c-41.17 17.408-28.02 42.575 11.032 26.062l1.812-.78c14.265 27.902 33.188 47.988 57.5 62.81c-17.14 22.89-32.872 50.29-43.47 80.095c-14.762-11.55-29.08-16.705-43.467-16.624c-19.66.11-39.445 9.975-60.564 26.47l-.594-.938c-22.67-35.828-47.807-22.65-23.906 15.125c-31.142 19.703-20.793 46.652 15.156 23.906c19.496 30.818 45.243 18.597 23.907-15.126l-1.97-3.125c36.48-16.268 63.367-10.887 79.313 20.75a201.128 201.128 0 0 0-1.47 28.936c-31.58 54.99-83.526 108.47-139.905 74.72C56.43 400.583 31.08 290.24 86.03 264.812c-88.86 14-72.12 158.155-11.343 202.093c68.89 49.802 177.1 9.79 226.47-67.5c9.23-9.248 18.042-19.363 26.343-30.125c28.19 9.79 47.533 34.53 54.78 66.564l-1.842-.125c-39.833-2.513-38.174 25.95-1.782 28.25c-2.676 42.446 25.93 38.56 28.25 1.78c44.61 2.818 44.1-25.58 1.78-28.25l-3.436-.22c2.32-47.622-21.094-79.984-52.594-105.592c10.95-19.048 20.074-39.302 26.75-60.032c14.804 17.315 36.6 20.202 65.844 11.125c15.61 38.424 42.24 30.015 25.97-11.25c34.28-13.522 29.2-41.947-10.376-26.342c-13.374-33.928-40.953-26.72-26.313 10.406l1.97 4.97c-27.402 6.667-38.812-5.483-47.938-26.127c3.577-21.29 4.258-42.663 1.375-63.375c-1.377-9.886 5.03-15.268 11.875-20.437c8.062-.07 16.09-2.327 23.313-7.344c9.9 6.767 23.476 4.636 30.78-5.03c7.53-9.96 5.556-24.128-4.405-31.656a22.787 22.787 0 0 0-2.094-1.406C469.22 52.58 464.05 23.31 439.312 23.094z"/></svg></a> 
        <div class="homepage-title permanent-marker-regular">Gecko's Green Grotto of Books</div>
      </div>
      <div class="h-icons">
        <a href="cart.asp?name=<%=username%>&password=<%=hashed_password%>"><svg class="gecko h-button" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24"><path fill="currentColor" d="M7 18c-1.1 0-1.99.9-1.99 2S5.9 22 7 22s2-.9 2-2s-.9-2-2-2M1 2v2h2l3.6 7.59l-1.35 2.45c-.16.28-.25.61-.25.96c0 1.1.9 2 2 2h12v-2H7.42c-.14 0-.25-.11-.25-.25l.03-.12l.9-1.63h7.45c.75 0 1.41-.41 1.75-1.03l3.58-6.49A1.003 1.003 0 0 0 20 4H5.21l-.94-2zm16 16c-1.1 0-1.99.9-1.99 2s.89 2 1.99 2s2-.9 2-2s-.9-2-2-2"/></svg> </a>     
        <a href="profile.asp?name=<%=username%>&password=<%=hashed_password%>"><svg class="gecko h-button" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 48 48"><g fill="currentColor"><path d="M32 20a8 8 0 1 1-16 0a8 8 0 0 1 16 0"/><path fill-rule="evenodd" d="M23.184 43.984C12.517 43.556 4 34.772 4 24C4 12.954 12.954 4 24 4s20 8.954 20 20s-8.954 20-20 20a21.253 21.253 0 0 1-.274 0c-.181 0-.362-.006-.542-.016M11.166 36.62a3.028 3.028 0 0 1 2.523-4.005c7.796-.863 12.874-.785 20.632.018a2.99 2.99 0 0 1 2.498 4.002A17.942 17.942 0 0 0 42 24c0-9.941-8.059-18-18-18S6 14.059 6 24c0 4.916 1.971 9.373 5.166 12.621" clip-rule="evenodd"/></g></svg></a>   
      </div>
    </div>