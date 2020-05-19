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
<jsp:useBean id="men" class="meuBeans.ClienteMensal" />
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

            //verificação se os campos estão vazios
        %>
        <jsp:setProperty name="men" property="cpf" value="${param.cpf}" />
        <jsp:setProperty name="men" property="nome" value="${param.nome}" />
        <jsp:setProperty name="men" property="email" value="${param.email}" />
        <jsp:setProperty name="men" property="idade" value="${param.idade}" />
        <jsp:setProperty name="men" property="telefone" value="${param.telefone}" />
        <jsp:setProperty name="men" property="cep" value="${param.cep}" />
        <jsp:setProperty name="men" property="logradouro" value="${param.log}" />
        <jsp:setProperty name="men" property="bairro" value="${param.bairro}" />
        <jsp:setProperty name="men" property="cidade" value="${param.city}" />
        <jsp:setProperty name="men" property="uf" value="${param.uf}" />
        <jsp:setProperty name="men" property="numero" value="${param.num}" />
        <jsp:setProperty name="men" property="complemento" value="${param.complemento}" />
        <%                //vereficando disponibilidade de endereço para serviço mensal
            int num = Integer.parseInt(request.getParameter("num"));
            rs = men.consultar("SELECT * FROM client WHERE cep = '" + cep + "'");

            if (!rs.isBeforeFirst()) {
                if (ValidaCPF.isCPF(cpf) == true) {

                    String resp = men.incluir();
                    if (resp.equals("ok")) {
                        //envia um e-mail de bem vindo
                        results = men.consultar("SELECT * FROM client WHERE cpf = '" + cpf + "'");
                        while (results.next()) {
                            out.println("Dados gravados com sucesso");
                            out.println("seu código de usuário é: " + "<h3>" + results.getString("codigo") + "</h3>");
                            out.println("<p>Agora o seu login será a partir do cpf e código de usuario! </p>");

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
                                        + "\nVocê utilizará o seu CPF e o seguinte código para entrar: " + results.getString("codigo"));
                                // Send message
                                Transport.send(message);
                                result = "Enviamos para você com o seu código de usuário!";
                                out.println(result);
                            } catch (MessagingException mex) {
                                mex.printStackTrace();
                                result = "Error: unable to send mail....\n" + mex;
                                out.println(result);
                            }
                        }
                    } else {
                        out.println(resp);
//                        out.print("<script>alert('Erro ao gravar os dados');"
//                                + "history.go(-1);</script>" + resp);
                    }

                } else {
                    out.print("<script>alert('CPF informando não é valido.');"
                            + "history.go(-1);</script>");
                }
            } else {
                while (rs.next()) {
                    if (cep.equals(rs.getString("cep")) && num == Integer.parseInt(rs.getString("numero"))) {
                        out.println("<h3>Desculpe, mas já tem um serviço mensal cadastrdo no endereço informado!</h3>");
                        // usando os metodos isCPF() e imprimeCPF() da classe "ValidaCPF"

                    } else {
                        if (ValidaCPF.isCPF(cpf) == true) {
                            SecureRandom random = new SecureRandom();
                            String token = new BigInteger(40, random).toString(32);
                            String codigo = token;
                            /**/

                            String resul = men.incluir();
                            if (resul.equals("ok")) {
                                //envia um e-mail de bem vindo
                                ResultSet res = men.consultar("SELECT * FROM client WHERE cpf = '" + cpf + "'");
                                while (res.next()) {
                                    out.println("Dados gravados com sucesso");
                                    out.println("seu código de usuário é: " + "<h3>" + res.getString("codigo") + "</h3>");
                                    out.println("<p>Agora o seu login será a partir do cpf e código de usuario! </p>");

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
                                                + "\nVocê utilizará o seu CPF e o seguinte código para entrar: " + res.getString("codigo"));
                                        // Send message
                                        Transport.send(message);
                                        result = "Enviamos para você com o seu código de usuário!";
                                        out.println(result);
                                    } catch (MessagingException mex) {
                                        mex.printStackTrace();
                                        result = "Error: unable to send mail....\n" + mex;
                                        out.println(result);
                                    }
                                }

                            } else {
                                out.println("Erro ao gravar" + resul);
//                                out.print("<script>alert('Erro ao gravar os dados');"
//                                        + "history.go(-1);</script>" + resul);
                            }

                        } else {
                            out.print("<script>alert('CPF informando não é valido.');"
                                    + "history.go(-1);</script>");
                        }
                    }
                }
            }


        %>
        <form action="Home.jsp" method="post">

            <input type="submit" value="OK">
        </form>
    </body>
</html>
