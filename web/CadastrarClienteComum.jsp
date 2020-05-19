<%-- 
    Document   : CadastrarClienteComum
    Created on : 24/04/2020, 15:17:43
    Author     : Marcos
--%>
<%@page import="meuPacote.ValidaCPF"%>
<%@page import="javax.mail.MessagingException"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.PasswordAuthentication"%>
<%@page import="java.util.Properties"%>
<%@page import="javax.mail.Session"%>
<%@page import="java.util.Scanner"%>
<%@page import="java.math.BigInteger"%>
<%@page import="java.security.SecureRandom"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*" language="java"%>
<%@include file="conecta.jsp" %>
<jsp:useBean id="cli" class="meuBeans.ClienteComum" />
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

            String cpf = request.getParameter("cpf");
            String nome = request.getParameter("nome");

            
        %>
        <jsp:setProperty name="cli" property="cpf" value="${param.cpf}" />
        <jsp:setProperty name="cli" property="nome" value="${param.nome}" />
        <jsp:setProperty name="cli" property="email" value="${param.email}" />
        <jsp:setProperty name="cli" property="senha" value="${param.senha}" />
        <jsp:setProperty name="cli" property="telefone" value="${param.telefone}" />
        <jsp:setProperty name="cli" property="cep" value="${param.cep}" />
        <jsp:setProperty name="cli" property="logradouro" value="${param.log}" />
        <jsp:setProperty name="cli" property="bairro" value="${param.bairro}" />
        <jsp:setProperty name="cli" property="cidade" value="${param.city}" />
        <jsp:setProperty name="cli" property="uf" value="${param.uf}" />
        <jsp:setProperty name="cli" property="numero" value="${param.num}" />
        <jsp:setProperty name="cli" property="complemento" value="${param.complemento}" />
        <%            if (ValidaCPF.isCPF(cpf) == true) {

                // metodo para cadastro de cliente comum 
                String resp = cli.incluir();
                if (resp.equals("ok")) {
                    out.println("Dados gravados com sucesso");
                    //envia um e-mail de bem vindo
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
                        message.setSubject("Bem vindo");
                        // Now set the actual message
                        message.setText("" + nome + " Bem Vindo  a distribuidoura de gás!");
                        // Send message
                        Transport.send(message);
                        result = "Enviamos um e-mail de agradecimento";
                        out.println(result);
                        out.print("<script>alert('Enviamos um e-mail de agradecimento.');"
                                + "history.go(-2);</script>");

                    } catch (MessagingException mex) {
                        mex.printStackTrace();
                        result = "Não foi possivel enviar e-mail de confirmação para e-mail informado\n" + mex;
                        out.println(result);
                        out.print("<script>alert('Não foi possivel enviar e-mail de confirmação para e-mail informado.');"
                                + "history.go(-1);</script>");
                    }
                    //response.sendRedirect("index.html");
                } else {
//                            out.print("<script>alert('Erro ao gravar os dados');"
//                                    + "history.go(-1);</script>");
                    out.print("<script>alert('Erro ao gravar os dados');"
                            + "history.go(-1);</script>" + resp);
                }

            } else {
                out.print("<script>alert('CPF informando não é valido.');"
                        + "history.go(-1);</script>");
            }

        %>
        <form action="index.html" method="post">

            <input type="submit" value="OK">
        </form>

    </body>
</html>
