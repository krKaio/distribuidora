<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="conecta.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>Untitled Document</title>
        <style>
            th{
                text-align: center;
                background-color: #6699FF;
            }
        </style>    

    </head>

    <body>
        <div>
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
        <table   border="1" cellspacing="0" cellpadding="2">
            <tr>
                <th width="100"><strong>Cpf</strong></th>
                <th width="300"><strong>nome</strong></th>
                <th width="80"><strong>codigo</strong></th>
            </tr>
            <%    ResultSet rs; //objeto que irá guardar o retorno da consulta
                String sql;
                try {
                    sql = "SELECT * FROM client WHERE cpf ='"+cpf+"'";
                    rs = stm.executeQuery(sql);
                    while (rs.next()) {
            %>
            <tr>            
                <td><%= rs.getString("cpf")%></td>
                <td><%= rs.getString("nome")%></td>
                <td><%= rs.getString("codigo")%></td>
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

        <br><a href="index.html">Voltar a página inicial</a>   

    </body>
</html>