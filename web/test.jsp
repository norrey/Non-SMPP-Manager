<%-- 
    Document   : test
    Created on : Jul 15, 2015, 12:33:32 PM
    Author     : Norrey Osako
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
            function reflect(){
                document.getElementById("reflect").innerHTML = document.getElementById("name").value;
            }
            function echo(){
                alert("Hello");
            }
        </script>
    </head>
    <body>
        <h1>Hello World!</h1>
        
        <input id="name" type="text" name="name"/>
        <input type="submit" value="Submit" onclick="reflect()"/>
        
        <p id="reflect"></p>
    </body>
</html>
