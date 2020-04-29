<%-- 
    Document   : CadastrarClienteComum
    Created on : 24/04/2020, 15:17:43
    Author     : Marcos
--%>

<%@page import="java.util.Scanner"%>
<%@page import="java.math.BigInteger"%>
<%@page import="java.security.SecureRandom"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*" language="java"%>
<%@include file="conecta.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastrar</title>

    </head>
    <body>
        <% /**/
/**/
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");

            // metodo para cadastro de cliente comum 
            String nome = request.getParameter("nome");
            String email = request.getParameter("email");
            String senha = request.getParameter("senha");
            String telefone = request.getParameter("telefone");
            String cep = request.getParameter("cep");
            String log = request.getParameter("log");
            String bairro = request.getParameter("bairro");
            String city = request.getParameter("city");
            String uf = request.getParameter("uf");
            int num = Integer.parseInt(request.getParameter("num"));
            String comp = request.getParameter("complemento");
            try {
                String sql = "INSERT INTO clientecomum (nome, email, senha, telefone, cep, logradouro, bairro, cidade, uf, numero, complemento) values(?, ?, ?, ?, ?, ?, ?, ?, ? ,?, ?);";

                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, nome);
                pstmt.setString(2, email);
                pstmt.setString(3, senha);
                pstmt.setString(4, telefone);
                pstmt.setString(5, cep);
                pstmt.setString(6, log);
                pstmt.setString(7, bairro);
                pstmt.setString(8, city);
                pstmt.setString(9, uf);
                pstmt.setInt(10, num);
                pstmt.setString(11, comp);

                int executa = pstmt.executeUpdate();
                if (executa > 0) {
                    out.println("Dados gravados com sucesso" + nome);
                    response.sendRedirect("index.html");
                } else {
                    out.println("Erro ao gravar os dados");
                }
            } catch (SQLException e) {
                out.println("Erro" + e.getMessage());
            }


        %>


    </body>
</html>
