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
                background-color: #F5F5F5;
            }
            #conterner {
                margin: 0 auto;
                margin-top: 10px;
                width: 90%;
                padding: 20px;
                color: #000000;
            }

            #tabe {
                margin-top: 20px;
                font-family: arial, sans-serif;
                border-collapse: collapse;
                width: 100%;
            }
            td, th {
                border: 2px solid #dddddd;
                text-align: left;
                padding: 8px;
            }.botaoEnviar {
                margin-top: 2%;
                width: 30%;
                text-align: center;
                padding: 10px;
                border: 1px solid #eee;
                border-radius: 5px;
                background-color: #ADD8E6;
                font-size: 12px;
                font-weight: bold;
                border: 1px solid #000;
            }
            strong {
                font-family: arial, sans-serif;
                font-weight: bold;
            }
            .btn {
                margin-left: 14%;
                text-align: center;
                padding: 10px;
                border: 1px solid #eee;
                border-radius: 5px;
                background-color: #ADD8E6;
                font-size: 12px;
                font-weight: bold;
                color: #000;	
                text-decoration: none;
                border: 1px solid #000;
                font-size: 10.5pt;
            }
            .bt {
                text-align: center;
                padding: 10px;
                border: 1px solid #eee;
                border-radius: 5px;
                background-color: #ADD8E6;
                font-size: 12px;
                font-weight: bold;
                color: #000;	
                text-decoration: none;
                border: 1px solid #000;
                font-size: 10.5pt;
            }
            hr{
                margin-top: 20px;
                border: 1px solid #dddddd;
                border-radius: 5px;
            }

            section{
                margin: auto;
                margin-top: 5%;
                width: 70%;
                border: 3px solid #000;
                padding: 10px;
                padding-bottom: 15px;
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
            nav .btn{
                margin: 5px;
            }
            .btj{
                width: 35%;
                margin: 20px;
                margin-top: 50px;
                padding: 10px;
                border: 1px solid;
                border-radius: 10px;

            }
            .des{
                width: 50px;
                height: 60px;
            }
        </style>
    </head>
    <body>
        <section id="caixa"> 
            <h2 class="titulo">Distribuidora de Gás</h2>
            <hr>
            <div class="left">
                <%                   
                    request.setCharacterEncoding("UTF-8");
                    response.setCharacterEncoding("UTF-8");

                    String cpf = (String) session.getAttribute("cpf");
                    String codigo = (String) session.getAttribute("codigo");
                    String nome = (String) session.getAttribute("nome");
                    String email = (String) session.getAttribute("email");
                    String senha = (String) session.getAttribute("senha");

                    if (nome == null) {
                        response.sendRedirect("Login.jsp");
                    } else {
                        out.println("Bem vindo, " + nome + "<br>");
                    }

                %>
            </div>
            <div class="right">
                <a href="Deslogar.jsp">
                    <img src="imagens/deslogar.png" class="des">
                </a>
            </div>
            <nav>
                <a class="btn" href="Home.jsp">Home</a>
                <a class="btn" href="mailJSP.jsp">Enviar Boletos</a>
                <a class="btn" href="Pagar.jsp">Boletos</a>
                <a class="btn" href="MeuPagamento.jsp">Meus Pagamentos </a>
                <a class="btn" href="Cadastro.jsp">Se tornar mensalista</a>
                <a class="btn" href="Perfil.jsp">Minha conta</a>
            </nav>
            <hr>
            <div class="btj">
                <b>Compre seu botijão de gás</b><br>
                <img src="imagens/botijao.png">
                <form action="Venda.jsp" method="post">
                    <b>Valor: R$ 70.00</b>
                    <option value="quantidade">escolha a quantidade</option>
                    <input name="qtd" type="text" placeholder="quantdade">

                    <input type="submit" value="Compra" class="botaoEnviar">
                </form>
            </div>
        </section>
    </body>
</html>