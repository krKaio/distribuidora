<%-- 
    Document   : Cadastrar
    Created on : 22/04/2020, 11:59:06
    Author     : KRGUI
--%>
<%@page import="meuPacote.ValidaCPF"%>
<%@page import="java.util.Scanner"%>
<%@page import="java.math.BigInteger"%>
<%@page import="java.security.SecureRandom"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*" language="java"%>
<%@include file="conecta.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            body {
                text-align: center;
                background-color: #F5F5F5
            }
        </style>
        
    </head>
    <body>

        <h1>Hello World!</h1>
        <% /**/
           // Scanner ler = new Scanner(System.in);

            String cpf = request.getParameter("cpf");

           // cpf = ler.next();

            // usando os metodos isCPF() e imprimeCPF() da classe "ValidaCPF"
            if (ValidaCPF.isCPF(cpf) == true) {
                SecureRandom random = new SecureRandom();
                String token = new BigInteger(40, random).toString(32);
                String codigo = token;
                /**/
                request.setCharacterEncoding("UTF-8");
                response.setCharacterEncoding("UTF-8");
                try {
                    String nome, email, logadouro, telefone, cep, cidade, uf, bairro, complemento;
                    int idade, num;

                    nome = request.getParameter("name");
                    email = request.getParameter("email");
                    idade = Integer.parseInt(request.getParameter("idade"));
                    cpf = request.getParameter("cpf");
                    num = Integer.parseInt(request.getParameter("num"));
                    logadouro = request.getParameter("log");
                    cep = request.getParameter("cep");
                    cidade = request.getParameter("city");
                    uf = request.getParameter("uf");
                    bairro = request.getParameter("bairro");
                    complemento = request.getParameter("complemento");
                    telefone = request.getParameter("telefone");

                    String query = "INSERT INTO client (cpf, nome, email, idade, telefone, logadouro, numero, cep, bairro, cidade, uf, complemento, codigo ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
                //  String query = "INSERT INTO client (cpf, nome, email, idade, telefone, logadouro, numero, cep, bairro, cidade, uf, complemento, codigo ) VALUES (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13)";
                    pstmt = con.prepareStatement(query);
                    pstmt.setString(1, cpf);
                    pstmt.setString(2, nome);
                    pstmt.setString(3, email);
                    pstmt.setInt(4, idade);
                    pstmt.setString(5, telefone);
                    pstmt.setString(6, logadouro);
                    pstmt.setInt(7, num);
                    pstmt.setString(8, cep);
                    pstmt.setString(9, bairro);
                    pstmt.setString(10, cidade);
                    pstmt.setString(11, uf);
                    pstmt.setString(12, complemento);
                    pstmt.setString(13, codigo);
                    
                    int executa = pstmt.executeUpdate();
                    if (executa > 0) {

                        out.println("Dados gravados com sucesso");
                        out.println("seu codido de usuario é: " + "<h3>" + codigo + "</h3>");

                    } else {
                        out.println("Erro ao gravar os dados");
                    }
                } catch (Exception e) {
                    out.println("<p>Algo errado com o banco de dados </p>" + e.getMessage());
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
                        out.println(e1);
                    }
                }
            } else {
                out.println("Erro, CPF invalido !!!\n");
            }
        %>
        <form action="index.html" method="post">
            <input type="submit" value="OK">
        </form>
    </body>
</html>
