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
            String email = request.getParameter("email");
            String senha = request.getParameter("senha");
            String telefone = request.getParameter("telefone");
            String cep = request.getParameter("cep");
            String log = request.getParameter("log");
            String bairro = request.getParameter("bairro");
            String city = request.getParameter("city");
            String uf = request.getParameter("uf");
            String comp = request.getParameter("complemento");
            String numero = request.getParameter("num");
            
            //verificação se os campos estão vazios
            if (nome.isEmpty()) {
                out.print("<script>alert('Preencha campo nome.');"
                        + "history.go(-1); </script>");
            } else if (cpf.isEmpty()) {
                out.print("<script>alert('Preencha campo cpf.');"
                        + "history.go(-1);</script>");
            } else if (email.isEmpty()) {
                out.print("<script>alert('Preencha campo email.');"
                        + "history.go(-1);</script>");
            } else if (senha.isEmpty()) {
                out.print("<script>alert('Preencha campo senha.');"
                        + "history.go(-1);</script>");

            } else if (telefone.isEmpty()) {
                out.print("<script>alert('Preencha campo telefone.');"
                        + "history.go(-1);</script>");
            } else if (cep.isEmpty()) {
                out.print("<script>alert('Preencha campo cep.');"
                        + "history.go(-1);</script>");
            } else if (numero.isEmpty()) {
                out.print("<script>alert('Preencha campo número.');"
                        + "history.go(-1);</script>");
            } else {
                if (ValidaCPF.isCPF(cpf) == true) {

                    try {
                        // metodo para cadastro de cliente comum 
                        int num = Integer.parseInt(request.getParameter("num"));
                        String sql = "INSERT INTO clientecomum (cpf, nome, email, senha, telefone, cep, logradouro, bairro, cidade, uf, numero, complemento) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ? ,?, ?);";

                        pstmt = con.prepareStatement(sql);
                        pstmt.setString(1, cpf);
                        pstmt.setString(2, nome);
                        pstmt.setString(3, email);
                        pstmt.setString(4, senha);
                        pstmt.setString(5, telefone);
                        pstmt.setString(6, cep);
                        pstmt.setString(7, log);
                        pstmt.setString(8, bairro);
                        pstmt.setString(9, city);
                        pstmt.setString(10, uf);
                        pstmt.setInt(11, num);
                        pstmt.setString(12, comp);

                        int executa = pstmt.executeUpdate();
                        if (executa > 0) {
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
                                message.setText(""+nome+" Bem Vindo  a distribuidoura de gás!");
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
                            out.print("<script>alert('Erro ao gravar os dados');"
                                    + "history.go(-1);</script>");
                        }
                    } catch (SQLException e) {
                        out.println("Erro" + e.getMessage());
                    }
                } else {
                    out.print("<script>alert('CPF informando não é valido.');"
                            + "history.go(-1);</script>");
                }
            }
        %>
        <form action="index.html" method="post">

            <input type="submit" value="OK">
        </form>

    </body>
</html>
