<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="conecta.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>Untitled Document</title>
        <style>

        div {
          margin: 0 auto;
          width: 80%;
          padding: 20px;
          color: #000000;
          border: 2px solid #000;
        }

        #cliente {
          font-family: arial, sans-serif;
          border-collapse: collapse;
          width: 70%;
        }

        #endereco{
          font-family: arial, sans-serif;
          border-collapse: collapse;
          width: 80%;
        }
        #pagamento{
          font-family: arial, sans-serif;
          border-collapse: collapse;
          width: 80%;
        }

        td, th {
          border: 2px solid #dddddd;
          text-align: left;
          padding: 8px;
        }
        img {
            height: 70px;
            width: 70%; 
        }

        li {
            font-family: arial, sans-serif;
            font-weight: bold;
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
                    out.println("Bem vindo, " + nome + "<br>" + codigo);
                }
            %>
        </div>
        <%
            Date d = new Date();
            SimpleDateFormat srtDate = new SimpleDateFormat("yyy/MM/dd");
            if (codigo == null) {
                String Sql = "UPDATE venda SET dt_venda = '" + srtDate.format(d) + "' WHERE id_venda = " + request.getParameter("id");
                stm.executeUpdate(Sql);
        
                ResultSet rs; //objeto que irá guardar o retorno da consulta
                String sql;
                try {
                    sql = "SELECT * FROM venda WHERE id_venda = ?";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, request.getParameter("id"));

                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                        String pago = rs.getString("pago");
                        String v_nome = rs.getString("nome");
                        String v_cpf = rs.getString("cpf");
                        String desc = rs.getString("descricao");
                        int qtd = rs.getInt("qtd");
                        float valor = rs.getFloat("valor");
                        float total = rs.getFloat("total");
                        String dt = rs.getString("dt_venda");
                        sql = "SELECT * FROM clientecomum WHERE cpf = ?";
                        pstmt = con.prepareStatement(sql);
                        pstmt.setString(1, v_cpf);
                        results = pstmt.executeQuery();
                        while (results.next()) {
                            String email = results.getString("email");
                            String log = results.getString("logradouro");
                            String num = results.getString("numero");
                            String cep = results.getString("cep");
                            String bairro = results.getString("bairro");
                            String cidade = results.getString("cidade");
                            String uf = results.getString("uf");
                            String cmpt = results.getString("complemento");

            %>
        <div>
        <table id="cliente">
            <ul>
                <li>SUAS INFORMAÇÕES</li>
            </ul>
            <tr>
                <th width="200"><strong>Cpf</strong></th>
                <th width="200"><strong>nome</strong></th>
                <th width="200"><strong>email</strong></th>
            </tr>
            <tr>            
                <td><%= v_cpf%></td>
                <td><%= v_nome%></td>
                <td><%= email%></td>
            </tr>

        </table>

        <table id="endereco">
            <ul>
                <li>ENDEREÇO</li>
            </ul>
            <tr>
                <th width="200"><strong>cep</strong></th>
                <th width="200"><strong>logadouro</strong></th>
                <th width="200"><strong>bairro</strong></th>
                <th width="200"><strong>cidade</strong></th>
                <th width="50"><strong>uf</strong></th>
                <th width="200"><strong>número</strong></th>
                <th width="200"><strong>complemento</strong></th>
            </tr>

            <tr>
                <td><%= cep%></td>
                <td><%= log%></td>
                <td><%= bairro%></td>
                <td><%= cidade%></td>
                <td><%= uf%></td>
                <td><%= num%></td>
                <td><%= cmpt%></td>
            </tr>
        </table>

        <table id="pagamento">
            <ul>
                <li>PAGAMENTO</li>
            </ul>
            <tr>
                <th><strong>descrição</strong></th>
                <th width="200"><strong>quantidade</strong></th>
                <th width="200"><strong>valor</strong></th>
                <th width="200"><strong>total</strong></th>
                <th width="200"><strong>Data vencimento</strong></th>
            </tr>
            <tr>
                <td><%= desc%></td>
                <td><%= qtd%></td>
                <td><%= valor%></td>
                <td><%= total%></td>
                <td><%= dt%></td>
            </tr>
        </table>
        <br><br>
    <img src="https://corregofundo.mg.gov.br/wp-content/uploads/2018/03/CodigoDeBarras.jpg">
  </div> 
            <%
                        }
                    }
                    rs.close();
                    stm.close();
                    con.close();
                } catch (Exception ex) {
                    out.print("<br/><br/>Desculpe, mas algo errado aconteceu abrindo este BD...<br/><br/>");
                }
            %> 

        <%
            }else{
String Sql = "UPDATE venda SET dt_venda = '" + srtDate.format(d) + "' WHERE id_venda = " + request.getParameter("id");
                stm.executeUpdate(Sql);
        %>
            <%
                ResultSet rs; //objeto que irá guardar o retorno da consulta
                String sql;
                try {
                    sql = "SELECT * FROM venda WHERE id_venda = ?";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, request.getParameter("id"));

                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                        String pago = rs.getString("pago");
                        String v_nome = rs.getString("nome");
                        String v_cpf = rs.getString("cpf");
                        String desc = rs.getString("descricao");
                        int qtd = rs.getInt("qtd");
                        float valor = rs.getFloat("valor");
                        float total = rs.getFloat("total");
                        String dt = rs.getString("dt_venda");
                        sql = "SELECT * FROM client WHERE cpf = ?";
                        pstmt = con.prepareStatement(sql);
                        pstmt.setString(1, v_cpf);
                        results = pstmt.executeQuery();
                        while (results.next()) {
                            String email = results.getString("email");
                            String cod = results.getString("codigo");
                            String log = results.getString("logradouro");
                            String num = results.getString("numero");
                            String cep = results.getString("cep");
                            String bairro = results.getString("bairro");
                            String cidade = results.getString("cidade");
                            String uf = results.getString("uf");
                            String cmpt = results.getString("complemento");

            %>
        <div>
        <table id="cliente">
            <ul>
                <li>SUAS INFORMAÇÕES</li>
            </ul>
            <tr>
                <th width="200"><strong>Cpf</strong></th>
                <th width="200"><strong>Nome</strong></th>
                <th width="200"><strong>E-mail</strong></th>
                <th width="200"><strong>Código</strong></th>
            </tr>
            <tr>            
                <td><%= v_cpf%></td>
                <td><%= v_nome%></td>
                <td><%= email%></td>
                <td><%= cod%></td>
            </tr>

        </table>

        <table id="endereco">
            <ul>
                <li>ENDEREÇO</li>
            </ul>
            <tr>
                <th width="200"><strong>cep</strong></th>
                <th width="200"><strong>logadouro</strong></th>
                <th width="200"><strong>bairro</strong></th>
                <th width="200"><strong>cidade</strong></th>
                <th width="50"><strong>uf</strong></th>
                <th width="200"><strong>número</strong></th>
                <th width="200"><strong>complemento</strong></th>
            </tr>

            <tr>
                <td><%= cep%></td>
                <td><%= log%></td>
                <td><%= bairro%></td>
                <td><%= cidade%></td>
                <td><%= uf%></td>
                <td><%= num%></td>
                <td><%= cmpt%></td>
            </tr>
        </table>

        <table id="pagamento">
            <ul>
                <li>PAGAMENTO</li>
            </ul>
            <tr>
                <th width="200"><strong>descrição</strong></th>
                <th width="200"><strong>quantidade</strong></th>
                <th width="200"><strong>valor</strong></th>
                <th width="200"><strong>total</strong></th>
                <th width="200"><strong>Data vencimento</strong></th>
            </tr>
            <tr>
                <td ><%= desc%></td>
                <td><%= qtd%></td>
                <td><%= valor%></td>
                <td><%= total%></td>
                <td><%= dt%></td>
            </tr>
        </table>
        <br><br>
        <img src="imagens/CodigoDeBarras.jpg">
  </div> 
            <%
                        }
                    }
                    rs.close();
                    stm.close();
                    con.close();
                } catch (Exception ex) {
                    out.print("<br/><br/>Desculpe, mas algo errado aconteceu abrindo este BD...<br/><br/>");
                }
            %> 
            <%
}

        %> 

    </body>
</html>