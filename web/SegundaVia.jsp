<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="conecta.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>Boletos em aberto</title>
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

            <div id="conterner">

                <strong>SEGUNDA VIA DE BOLETO</strong>
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

                <table id="tabe">
                    <tr>
                        <th><strong>Cpf</strong></th>
                        <th><strong>nome</strong></th>
                        <th><strong>descrisção</strong></th>
                        <th><strong>quantidade</strong></th>
                        <th><strong>valor</strong></th>
                        <th><strong>total</strong></th>
                        <th><strong>Data</strong></th>
                        <th><strong>Pago</strong></th>
                    </tr>

                    <%
                        while (rs.next()) {
                            String pago = rs.getString("pago");
                            String v_nome = rs.getString("nome");
                            String v_cpf = rs.getString("cpf");
                            String desc = rs.getString("descricao");
                            int qtd = rs.getInt("qtd");
                            float valor = rs.getFloat("valor");
                            float total = rs.getFloat("total");
                            String dt = rs.getString("dt_venda").substring(8, 10) + "/" + rs.getString("dt_venda").substring(5, 7) + "/" + rs.getString("dt_venda").substring(0, 4);
                            if (pago.equals("nao")) {

                    %>
                    <tr>            
                        <td><%= v_cpf%></td>
                        <td><%= v_nome%></td>
                        <td><%= desc%></td>
                        <td><%= qtd%></td>
                        <td>R$ <%= valor%></td>
                        <td>R$ <%= total%></td>
                        <td><%= dt%></td>
                        <td><%= pago%></td>
                        <td><a href="mailJSP.jsp?id=<%= rs.getString("id_venda")%>"><input type="button" name="envia" value="ENVIAR" class="botaoEnviar"></a></td>
                    </tr>
                    <%
                            }
                        }
                        rs.close();
                        stm.close();
                        con.close();
                    } else {
                    %>
                    <p><strong>Você não possui pagamentos pendentes</strong></p>
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
                </table>
                <br><a class="bt" href="Home.jsp">Voltar a página inicial</a> 
            </div>
        </section>
    </body>
</html>