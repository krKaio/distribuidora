<%@page import="java.sql.*"%>
<%@page import="javax.mail.internet.*"%>
<%@page import="javax.mail.*"%>
<%@page import="java.util.Properties"%>
<%@page import="java.net.URL"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="conecta.jsp" %>

<%    String result;
    String mail = request.getParameter("email");
    ResultSet rs; //objeto que irá guardar o retorno da consulta
    String sql;
    if (mail.isEmpty()) {
        out.print("<script>alert('Por favor, informe o e-mail.');"
                + "history.go(-1);</script>");
    } else {
        try {
            sql = "SELECT * FROM clienteComum WHERE email = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, mail);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String senha = rs.getString("senha");

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
                    message.setSubject("Recuperando Sua Senha");
                    // Now set the actual message
                    message.setText("A sua senha é : " + senha);
                    // Send message
                    Transport.send(message);
                    result = "Your mail sent successfully....";
                    out.println(result);
                    out.print("<script>alert('Sua senha é: " + senha + ".Também envamos a sua para o e-mail informado.');"
                            + "history.go(-2);</script>");
                } catch (MessagingException mex) {
                    mex.printStackTrace();
                    result = "Error: unable to send mail....\n" + mex;
                    out.println(result);
                    out.print("<script>alert('Não foi possivel enviar o e-mail de recuperação para o e-mail informado.');"
                            + "history.go(-1);</script>");
                }
            }

            rs.close();
            pstmt.close();
            con.close();
        } catch (Exception ex) {
            out.print("<br/><br/>Desculpe, mas algo errado aconteceu abrindo este BD...<br/>" + ex + "<br/>");
        }
    }
%>