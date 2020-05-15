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

            * {
                font-family: arial, sans-serif;
            }

            body {
                background-color: #F8F8FF;
            }


            input {
                border-radius: 5px;
                border: 1px solid #DEB887;
                height: 20px; 
                margin: 2%;
            }  

            hr {
                width: 50%;
                background-color: #000;
                height: 2px;
                margin-bottom: 2%;
            }

            h4 {
                text-align: center;
                margin-top: 1%;
            }

            #caixa {
                margin: auto;
                margin-top: 10%;
                width: 70%;
                border: 3px solid #000;
                padding: 10px;
                padding-bottom: 20px;
                background-color: #F5F5F5;
            }

            #cliente_mensal {
                width: 30%;
                margin-left: 17%;
                display: inline-block;
                border: 1px solid #000;
                padding: 10px;
                margin-top: 3%;
                border-radius: 5px;

            }

            #cliente_comum {
                width: 30%;
                margin-right: 17%;    
                display: inline-block;  
                border: 1px solid #000;
                padding: 10px;
                border-radius: 5px;
            }  

            #botao_comum { 
                text-align: center; 
            }

            #botao_mensal {
                text-align: center;
            }

            .botaoEnviar {
                margin-top: 2%;
                width: 200px;
                height: 25px;
                text-align: center;
                /* padding: 10px; */
                border: 1px solid #eee;
                border-radius: 5px;
                background-color: #ADD8E6;
                font-size: 12px;
                font-weight: bold;
                border: 1px solid #000;
            }

            .titulo {
                text-align: center;
            }

        </style>
    </head>
    <body>
        <section id="caixa">
            <h2 class="titulo">Distribuidora de Gás</h2>
            <hr>
            <div id="cliente_mensal">
                <h4>Mensalista</h4>
                <form action="RecuperarCodigo.jsp" method="post">
                    Email: <input type="text" name="email" placeholder="exempo@email.com"><br>
                    <div id="botao_mensal">
                        <input type="submit" value="Recuperar código" class="botaoEnviar">
                    </div>
                </form>
            </div>
            <div id="cliente_comum">
                <h4>Cliente comum</h4>
                <form action="RecuperarSenha.jsp" method="post">
                    Email: <input type="text" name="email" placeholder="exempo@email.com"><br>
                    <div id="botao_comum">
                        <input type="submit" value="Recuperar senha" class="botaoEnviar">
                    </div>
                </form>
            </div>
        </section>
    </body>
</html>
