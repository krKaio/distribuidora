<%-- 
    Document   : Cadastrar
    Created on : 22/04/2020, 11:59:06
    Author     : KRGUI
--%>
<%@page import="javax.mail.MessagingException"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.PasswordAuthentication"%>
<%@page import="java.util.Properties"%>
<%@page import="javax.mail.Session"%>
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
        <%            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");
            ResultSet rs = null;
            String cpf = request.getParameter("cpf");
            String cep = request.getParameter("cep");

            String nome, email, logadouro, telefone, cidade, uf, bairro, complemento;

            cpf = request.getParameter("cpf");
            nome = request.getParameter("name");
            email = request.getParameter("email");
            logadouro = request.getParameter("log");
            cep = request.getParameter("cep");
            cidade = request.getParameter("city");
            uf = request.getParameter("uf");
            bairro = request.getParameter("bairro");
            complemento = request.getParameter("complemento");
            telefone = request.getParameter("telefone");
            String numero = request.getParameter("num");
            String ida = request.getParameter("idade");

            //verificação se os campos estão vazios
            if (nome.isEmpty()) {
                out.print("<script>alert('Preencha campo nome.');"
                        + "history.go(-1); document.meuForm.nome.focus();</script>");
            } else if (cpf.isEmpty()) {
                out.print("<script>alert('Preencha campo cpf.');"
                        + "document.meuForm.cpf.focus();history.go(-1);</script>");
            } else if (email.isEmpty()) {
                out.print("<script>alert('Preencha campo email.');"
                        + "history.go(-1);document.meuForm.email.focus();</script>");
            } else if (telefone.isEmpty()) {
                out.print("<script>alert('Preencha campo telefone.');"
                        + "history.go(-1);</script>");
            } else if (ida.isEmpty()) {
                out.print("<script>alert('Preencha campo idade.');"
                        + "history.go(-1);document.meuForm.idade.focus();</script>");
            } else if (cep.isEmpty()) {
                out.print("<script>alert('Preencha campo cep.');"
                        + "history.go(-1);</script>");
            } else if (numero.isEmpty()) {
                out.print("<script>alert('Preencha campo número.');"
                        + "history.go(-1);document.meuForm.num.focus();</script>");
            } else {
                //vereficando disponibilidade de endereço para serviço mensal
                try {
                    int idade = Integer.parseInt(request.getParameter("idade"));
                    int num = Integer.parseInt(request.getParameter("num"));

                    String sql = "SELECT * FROM client WHERE cep = ?";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, cep);
                    rs = pstmt.executeQuery();
                    if (rs.next() != false) {
                        if (cep.equals(rs.getString("cep")) && num == Integer.parseInt(rs.getString("numero"))) {
                            out.println("<h3>Desculpe, mas já tem um serviço mensal cadastrdo no endereço informado!</h3>");
                        } else {
                            // usando os metodos isCPF() e imprimeCPF() da classe "ValidaCPF"
                            if (ValidaCPF.isCPF(cpf) == true) {
                                SecureRandom random = new SecureRandom();
                                String token = new BigInteger(40, random).toString(32);
                                String codigo = token;
                                /**/

                                try {

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
                                        //envia um e-mail de bem vindo
                                        out.println("Dados gravados com sucesso");
                                        out.println("seu código de usuário é: " + "<h3>" + codigo + "</h3>");
                                        out.println("<p>Agora o seu login será a partir do cpf e código de usuario! </p>");
                                        String cod = rs.getString("codigo");
                                        String result;
                                        final String to = request.getParameter("email");
                                        final String from = "shuruprojetos@gmail.com";
                                        final String pass = "shuruminos";

                                        String host = "smtp.gmail.com";
                                        Properties props = new Properties();

                                        props.put("mail.smtp.port", 587);
                                        props.put("mail.smtp.host", host);
                                        props.put("mail.transport.protocol", "smtp");
                                        props.put("mail.smtp.auth", "true");
                                        props.put("mail.smtp.starttls.enable", "true");
                                        props.put("mail.user", from);
                                        props.put("mail.password", pass);

                                        Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
                                            @Override
                                            protected PasswordAuthentication getPasswordAuthentication() {
                                                return new PasswordAuthentication(from, pass);
                                            }
                                        });

                                        try {
                                            MimeMessage message = new MimeMessage(mailSession);
                                            message.setFrom(new InternetAddress(from));
                                            message.addRecipient(Message.RecipientType.TO,
                                                    new InternetAddress(to));
                                            // Set Subject: header field
                                            message.setSubject("Mensalista");
                                            // Now set the actual message
                                            message.setText("Obigado por se tornar um mensalista!\n"
                                                    + "Como um mensalista o meio de entrar no sistema será diferente, a partir de agora será pelo meio de autenticação do mensalista. "
                                                    + "\nVocê utilizará o seu CPF e o seguinte código para entrar: " + codigo);
                                            // Send message
                                            Transport.send(message);
                                            result = "Enviamos para você com o seu código de usuário!";
                                            out.println(result);
                                        } catch (MessagingException mex) {
                                            mex.printStackTrace();
                                            result = "Error: unable to send mail....\n" + mex;
                                            out.println(result);
                                        }

                                    } else {
                                        out.print("<script>alert('Erro ao gravar os dados');"
                                                + "history.go(-1);</script>");
                                    }
                                } catch (Exception e) {
                                    out.println("<p>Algo errado com o banco de dados </p>" + e.getMessage());
                                }
                            } else {
                                out.print("<script>alert('CPF informando não é valido.');"
                                        + "history.go(-1);</script>");
                            }
                        }
                    } else {
                        response.sendRedirect("Home.jsp");
                    }
                } catch (Exception eX) {
                    out.println("<p>Algo errado com o banco de dados  </p>" + eX.getMessage());
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

            }
        %>
        <form action="Home.jsp" method="post">

            <input type="submit" value="OK">
        </form>
    </body>
</html>
