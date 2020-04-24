<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="conecta.jsp" %>
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
            th{
                text-align: center;
                background-color: #6699FF;
            }
            table{
                margin: 10px;
                text-align: center;
                margin-left: 18%;
            }
        </style>    

    </head>

    <body>
        <div>
            <%                String cpf = (String) session.getAttribute("cpf");
                String codigo = (String) session.getAttribute("codigo");
                String nome = (String) session.getAttribute("nome");

                if (nome == null) {
                    response.sendRedirect("Login.jsp");
                } else {
                    out.println("Bem vindo, " + nome + "<br>");
                }
            %>
        </div>
        <table   border="1" cellspacing="0" cellpadding="2">
            <tr>
                <th width="200"><strong>Cpf</strong></th>
                <th width="200"><strong>nome</strong></th>
                <th width="200"><strong>email</strong></th>
                <th width="80"><strong>codigo do usuario</strong></th>
            </tr>
            <%    ResultSet rs; //objeto que irá guardar o retorno da consulta
                String sql;
                try {
                    sql = "SELECT * FROM fatura WHERE f_cpf ='" + cpf + "'";
                    rs = stm.executeQuery(sql);
                    while (rs.next()) {
            %>
            <tr>            
                <td><%= rs.getString("f_cpf")%></td>
                <td><%= rs.getString("f_nome")%></td>
                <td><%= rs.getString("f_email")%></td>
                <td><%= rs.getString("f_codigo")%></td>
            </tr>

        </table>

        <table   border="1" cellspacing="0" cellpadding="2">
            <tr>
                <th width="200"><strong>logadouro</strong></th>
                <th width="200"><strong>número</strong></th>
                <th width="200"><strong>cep</strong></th>
                <th width="200"><strong>bairro</strong></th>
                <th width="200"><strong>cidade</strong></th>
                <th width="50"><strong>uf</strong></th>
                <th width="200"><strong>complemento</strong></th>
            </tr>

            <tr>
                <td><%= rs.getString("f_logadouro")%></td>
                <td><%= rs.getString("f_numero")%></td>
                <td><%= rs.getString("f_cep")%></td>
                <td><%= rs.getString("f_bairro")%></td>
                <td><%= rs.getString("f_cidade")%></td>
                <td><%= rs.getString("f_uf")%></td>
                <td><%= rs.getString("f_complemento")%></td>
            </tr>
        </table>

        <table   border="1" cellspacing="0" cellpadding="2">
            <tr>
                <th width="200"><strong>tipo de plano</strong></th>
                <th width="200"><strong>descrição do plano</strong></th>
                <th width="200"><strong>valor</strong></th>
                <th width="200"><strong>Data emissão</strong></th>
                <th width="200"><strong>Data vencimento</strong></th>
            </tr>

            <tr>
                <td><%= rs.getString("f_tp_plano")%></td>
                <td><%= rs.getString("f_descricao")%></td>
                <td><%= rs.getString("f_valor")%></td>
                <td><%= rs.getString("f_dt_emissao")%></td>
                <td><%= rs.getString("f_dt_vencimento")%></td>
            </tr>
            <%
                    }
                    rs.close();
                    stm.close();
                    con.close();
                } catch (Exception ex) {
                    out.print("<br/><br/>Desculpe, mas algo errado aconteceu abrindo este BD...<br/><br/>");
                }
            %> 
        </table>

        <br><a href="Home.jsp">Voltar a página inicial</a>   

    </body>
</html>