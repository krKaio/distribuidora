<%-- 
    Document   : Esqueceu
    Created on : 20/04/2020, 13:34:38
    Author     : KRGUI
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            body {
                text-align: center;
                background-color: #F5F5F5
            }
            section{
                margin: auto;
                margin-top: 5%;
                width: 50%;
                border: 3px solid green;
                padding: 10px;
            }
            input{
                margin: 5px; 
            }   
        </style>
    </head>
    <body>
        <section>
            <div>
                <h3>Cliente comum</h3>
                <form action="RecuperarSenha.jsp" method="post">
                    Email: <input type="text" name="email" placeholder="exempo@email.com"><br>
                    <input type="submit" value="Recuperar senha">
                </form>
            </div>
            <div>
                <h3>Cliente mensal</h3>
                <form action="RecuperarCodigo.jsp" method="post">
                    Email: <input type="text" name="email" placeholder="exempo@email.com"><br>
                    <input type="submit" value="Recuperar código">
                </form>
            </div>
        </section>
    </body>
</html>
