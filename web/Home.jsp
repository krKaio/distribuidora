<%-- 
    Document   : DadosLogin
    Created on : 24/03/2020, 08:06:13
    Author     : KRGUI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
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
            .left{
                width: 40%;
                text-align: left;
                margin-right: 50px;
                display: inline-block;
            }
            .right{
                width: 40%;
                text-align: right;
                margin-left: 50px;
                display: inline-block;   
            }
            nav{
                text-align: center;
                margin-top: 50px;
                display: block;
            }
            nav a{
                margin: 5px;
            }
        </style>
    </head>
    <body>
        <section>
            <h1>Distituidora de Gás</h1>
            <div class="left">
                <%
                    String cpf = (String) session.getAttribute("cpf");
                    String codigo = (String) session.getAttribute("codigo");
                    String nome = (String) session.getAttribute("nome");
                    
                    if (nome == null) {
                        response.sendRedirect("Login.jsp");
                    } else {
                        out.println("Bem vindo, " + nome + "<br>");
                    }
                %>
            </div>
            <div class="right">
                <a href="Deslogar.jsp">Deslogar</a>
            </div>
            <nav>
                <a href="#">Meus Débitos</a>
                <a href="lista.jsp">Meus Pagamentos </a>
                <a href="#">Meu Plano de gás</a>
                <a href="#">Cadastrar gás encanado</a>
                <a href="#">Comprar botijão</a>
                
            </nav>
        </section>
</html>