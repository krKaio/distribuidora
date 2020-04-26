<%-- 
    Document   : Cadastro
    Created on : 16/04/2020, 15:03:50
    Author     : KRGUI
--%>

<%@page import="java.math.BigInteger"%>
<%@page import="java.security.SecureRandom"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro</title>
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
            <h1>Distribuidoura de Gás</h1>
            <form action="Cadastrar.jsp" method="post">
                Nome:<input type="text" name="name" placeholder="Nome"><br>
                Email:<input type="text" name="email" placeholder="E-mail"><br>
                CPF:<input type="text" name="cpf" placeholder="CPF"><br>
                Idade:<input type="text" name="idade" placeholder="Idade"><br>
                Telefone:<input type="text" name="telefone" placeholder="Telefone"><br>
                Logradouro:<input type="text" name="log" placeholder="Logradouro"><br>
                Número:<input type="text" name="num" placeholder="Número da residência"><br>
                CEP<input type="text" name="cep" placeholder="CEP"><br>
                Bairro:<input type="text" name="bairro" placeholder="Bairro"><br>
                Cidade:<input type="text" name="city" placeholder="Cidade"><br>
                UF:<input type="text" name="uf" placeholder="UF"><br>
                Complemento:<input type="text" name="complemento" placeholder="Complemento"><br>
                <input type="submit" value="Cadastrar">
            </form>
             
        </section>
    </body>
</html>
