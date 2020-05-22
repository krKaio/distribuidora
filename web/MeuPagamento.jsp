<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@include file="conecta.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="lib/jquery-1.11.1.js"></script>
        <title>Boletos</title>
    </head>
    <script>
        function processar(codigo, acao) {

            var endereco = "", saida = "", cod = "";
            $("#tabelaBoleto").empty();
            if (acao == "B")
                endereco = "BoletoGerado_1.jsp?cpf=" + $("#text").val();


            $.ajax({
                url: endereco,
                success: function (xml) {

                    saida += "<table id='tabe'><tr><th>cpf</th><th>nome</th><th>descricao</th><th>quantidade</th><th>valor</th><th>total</th><th>data</th><th>pago</th></tr>";
                    $(xml).find("boleto").each(function () {
                        saida += "<td>" + $(this).find("cpf").text() + "</td>";
                        saida += "<td>" + $(this).find("nome").text() + "</td>";
                        saida += "<td>" + $(this).find("desc").text() + "</td>";
                        saida += "<td>" + $(this).find("qtd").text() + "</td>";
                        saida += "<td>" + $(this).find("valor").text() + "</td>";
                        saida += "<td>" + $(this).find("total").text() + "</td>";
                        saida += "<td>" + $(this).find("dt").text() + "</td>";
                        saida += "<td>" + $(this).find("pago").text() + "</td></tr>";
                    });
                    saida += "</table>";
                    $("#tabelaBoleto").append(saida);
                },

                error: function () {
                    alert("Processo não concluído");
                }
            });


        }

        $(function () {
            $("#text").ready(function () {
                processar(this.value, "B");
            });
        });


    </script>
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
            width: 90%;
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
        #caixa {
            margin: auto;
            margin-top: 1%;
            width: 70%;
            border: 3px solid #000;
            padding: 10px;
            background-color: #F5F5F5;
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
    <body>
        <section id="caixa"> 
            <h2 class="titulo">Distribuidora de Gás</h2>
            <hr>
            <div class="left">
                <%                    request.setCharacterEncoding("UTF-8");
                    response.setCharacterEncoding("UTF-8");

                    String cpf = (String) session.getAttribute("cpf");
                    String codigo = (String) session.getAttribute("codigo");
                    String nome = (String) session.getAttribute("nome");

                    if (nome == null) {
                        response.sendRedirect("Login.jsp");
                    } else {
                        out.println("Bem vindo, " + nome + "<br>");
                    }
                    String ql;
                    String pag = "sim";


                %>
            </div>
            <div class="right">
                <a href="Deslogar.jsp">
                    <img src="imagens/deslogar.png" class="des">
                </a>
                <br>
            </div>
            <nav>
                <a class="btn" href="Home.jsp">Home</a>
                <a class="btn" href="SegundaVia.jsp">2° Via Boletos</a>
                <a class="btn" href="Pagar.jsp">Boletos</a>
                <a class="btn" href="MeuPagamento.jsp">Meus Pagamentos </a>
                <a class="btn" href="Cadastro.jsp">Se tornar mensalista</a>
                <a class="btn" href="Redirecionamentos.jsp">Minha conta</a>
            </nav>
            <hr>
            <div id="conterner">
                <strong>MEUS PAGAMENTOS</strong>
                <%                ResultSet rs; //objeto que irá guardar o retorno da consulta
                    String sql;
                    String pg = "nao";

                    try {
                        sql = "SELECT * FROM venda WHERE cpf = ? and pago = ?";
                        pstmt = con.prepareStatement(sql);
                        pstmt.setString(1, cpf);
                        pstmt.setString(2, pg);
                        rs = pstmt.executeQuery();
                        if (rs.isBeforeFirst()) {
                %>
                <div id="tabelaBoleto"></div>
                <%
                } else {
                %>
                <p><strong>Você ainda não realizou nenhum pagamento</strong></p>
                <%
                        }
                    } catch (Exception ex) {
                        out.print("<br/><br/>Desculpe, mas algo errado aconteceu abrindo este BD...<br/><br/>");
                    } finally {
                        try {
                            if (stm != null) {
                                stm.close();
                                stm = null;
                            }
                            if (con != null) {
                                con.close();
                                con = null;
                            }
                        } catch (Exception e1) {
                            out.println("<h3>" + e1 + "</h3>");
                        }
                    }
                %> 
                <br><a class="bt" href="Home.jsp">Voltar a página inicial</a> 
            </div>
        </section>
    </body>
</html>
