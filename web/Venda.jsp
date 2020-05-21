<%-- 
    Document   : Venda
    Created on : 12/05/2020, 10:08:48
    Author     : Kings family
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*" language="java"%>
<%@include file="conecta.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Venda</title>
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

                %>
            </div>
            <div class="right">
                <a href="Deslogar.jsp">
                    <img src="imagens/deslogar.png" class="des">
                </a>
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



            <%            ResultSet rs = null;
                Date d = new Date();
                SimpleDateFormat srtDate = new SimpleDateFormat("yyyy/MM/dd");
                SimpleDateFormat srtDateb = new SimpleDateFormat("dd/MM/yyyy");
                srtDate.format(d);

                String desc = "botijão de gás";
                String pago = "nao";

                String qntd = request.getParameter("qtd");
                if (qntd.isEmpty()) {
                    out.print("<script>alert('Preencha campo quantidade.');"
                            + "history.go(-1);</script>");
                } else {

                    int qtd = Integer.parseInt(request.getParameter("qtd"));
                    if (qtd <= 3) {

                        float valor = 70.00f;

                        float total = 0;
                        total = valor * qtd;
                        //verifica se tem botijão disponivel para venda
                        try {
                            String sq = "SELECT * FROM estoque WHERE modelo =?";
                            pstmt = con.prepareStatement(sq);
                            pstmt.setString(1, "botijao");
                            rs = pstmt.executeQuery();
                            while (rs.next()) {
                                int qtdMin = rs.getInt("qntd_min");
                                int qtdEstoque = rs.getInt("qntd_estoque");
                                if (qtdEstoque < qtdMin) {
                                    out.println("<h1>Desculpe, mas não temos gás para vender no momento</h1>");
                                } else {
                                    //regista na tabela venda que houve uma comprar
                                    try {
                                        String query = "INSERT INTO venda (nome, cpf, descricao, qtd, valor, total, dt_venda, pago) VALUES (?, ?, ?, ?, ?, ?, ?, ?);";

                                        pstmt = con.prepareStatement(query);
                                        pstmt.setString(1, nome);
                                        pstmt.setString(2, cpf);
                                        pstmt.setString(3, desc);
                                        pstmt.setInt(4, qtd);
                                        pstmt.setFloat(5, valor);
                                        pstmt.setFloat(6, total);
                                        pstmt.setString(7, srtDate.format(d));
                                        pstmt.setString(8, pago);

                                        int executa = pstmt.executeUpdate();
                                        if (executa > 0) {
                                            
                                            out.println("<h1> " + nome + " o total da sua compra é de R$" + total + " feita no dia " + srtDateb.format(d) + "</h1>");
                                            out.println("Pagamento pendente");

                                        } else {
                                            out.println("Não foi possivel realizar a pedido.");
                                        }
                                    } catch (Exception e) {
                                        out.println("<h1>" + e + "</h1>");
                                    }
                                }
                            }
                        } catch (Exception e) {
                            out.println("<h1>" + e + "</h1>");
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
                    } else {
                        out.print("<h1>Quantidade maior que o limite permitido</h1>");
                    }
                }
            %>
            <form action="Pagar.jsp" method="post">
                <input type="submit" value="Pagar" class="botaoEnviar">
            </form>
        </section>
    </body>
</html>
