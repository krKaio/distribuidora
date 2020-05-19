<%@page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@include file="conecta.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>Untitled Document</title>   
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

            <%    String sql, SQL;
                ResultSet rs = null;
                int id = Integer.parseInt(request.getParameter("id"));
                float vl = Float.parseFloat(request.getParameter("vl"));

                SQL = "SELECT * FROM venda WHERE id_venda = ?  and total = ?";
                pstmt = con.prepareStatement(SQL);
                pstmt.setInt(1, id);
                pstmt.setFloat(2, vl);
                rs = pstmt.executeQuery();
                if (rs.next() == true) {
                    //atualiza a quantidade do estoque
                    sql = "UPDATE venda SET pago = 'sim' WHERE id_venda = " + id + " and total = " + vl;
                    stm.executeUpdate(sql);

                    SQL = "SELECT * FROM venda WHERE pago = ? and id_venda = ?";
                    pstmt = con.prepareStatement(SQL);
                    pstmt.setString(1, "sim");
                    pstmt.setInt(2, id);
                    rs = pstmt.executeQuery();
                    if (rs.next() == true) {
                        int qtd = Integer.parseInt(rs.getString("qtd"));
                        String query = "UPDATE estoque SET qntd_estoque = qntd_estoque - " + qtd + " WHERE modelo = 'botijao'";
                        pstmt.executeUpdate(query);
                        out.println("Pagamento realizado ");
                    }
                } else {
                    out.print("<script>alert('Por favor, informe o mesmo valor que o total!');"
                            + "history.go(-1);</script>");
                }

            %>
            <form action="Pagar.jsp" method="post">
                <input type="submit" value="VOLTAR" class="botaoEnviar">
            </form>
        </section>
    </body>
</html>