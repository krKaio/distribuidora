<%-- 
    Document   : mailJSP
    Created on : 29/04/2020, 10:58:49
    Author     : wilson
--%>

<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*" %>
<%@ include file="conecta.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Envio de Fatura</title>
    </head>
       <h1>Hello World!</h1>
<%    
    String cpf = (String) session.getAttribute("cpf");
    String codigo = (String) session.getAttribute("codigo");
    String nome = (String) session.getAttribute("nome");
    String email = (String) session.getAttribute("email");

    if (nome == null) {
        response.sendRedirect("Login.jsp");
    } else {
        out.println("Bem vindo, " + nome + "<br>");
        out.println("<h3>Em desenvolvimento</h3>");
    }
    String result;
    ResultSet rs; //objeto que irá guardar o retorno da consulta
    String sql;
    try {
        sql = "SELECT * FROM fatura WHERE f_cpf = ?";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, cpf);
        rs = pstmt.executeQuery();
        while (rs.next()) {
            String Fcpf = rs.getString("f_cpf");
            String Fnome = rs.getString("f_nome");
            String Femail = rs.getString("f_email");
            String Fcodigo = rs.getString("f_codigo");
            String Flog = rs.getString("f_logadouro");
            String Fnum = rs.getString("f_numero");
            String Fcep = rs.getString("f_cep");
            String Fbairro = rs.getString("f_bairro");
            String Fcidade = rs.getString("f_cidade");
            String Fuf = rs.getString("f_uf");
            String Fcmpt = rs.getString("f_complemento");
            String Fplano = rs.getString("f_tp_plano");
            String Fdesc = rs.getString("f_descricao");
            String Fvalor = rs.getString("f_valor");
            String Fdt_emissao = rs.getString("f_dt_emissao");
            String Fdt_vencimento = rs.getString("f_dt_vencimento");

            //#########################################################################################
            
            //final String to = request.getParameter("mail");
            final String to = email;

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
                message.setSubject("Envio de email html");
                // Now set the actual message
                message.setContent(
                        "<style>"
                        + "body {"
                        + "text-align: center;"
                        + "background-color: #F5F5F5;"
                        + "}"
                        + "th{"
                        + "text-align: center;"
                        + "background-color: #6699FF;}"
                        + "table{margin: 10px;"
                        + "text-align: center;"
                        + "margin-left: 18%;}"
                        + "</style>"
                        + "<table border='1' cellspacing='0' cellpadding='2'>"
                            + "<tr>"
                                + "<th width='200'><strong>Cpf</strong></th>"
                                + "<th width='200'><strong>nome</strong></th>"
                                + "<th width='200'><strong>email</strong></th>"
                                + "<th width='80'><strong>codigo do usuario</strong></th>"
                            + "</tr>"
                            + "<tr>"
                                + "<td>" + Fcpf + "</td>"
                                + "<td>" + Fnome + "</td>"
                                + "<td>" + Femail + "</td>"
                                + "<td>" + Fcodigo + "</td>"
                            + "</tr>"
                        + "</table>"
                                        
                        + "<table border='1' cellspacing='0' cellpadding='2'>"
                            + "<tr>"
                                + "<th width='200'><strong>logadouro</strong></th>"
                                + "<th width='200'><strong>número</strong></th>"
                                + "<th width='200'><strong>cep</strong></th>"
                                + "<th width='200'><strong>bairro</strong></th>"
                                + "<th width='200'><strong>cidade</strong></th>"
                                + "<th width='50'><strong>uf</strong></th>"
                                + "<th width='200'><strong>complemento</strong></th>"
                            + "</tr>"
                            + "<tr>"
                                + "<td>" + Flog+ "</td>"
                                + "<td>" + Fnum + "</td>"
                                + "<td>" + Fcep + "</td>"
                                + "<td>" + Fbairro + "</td>"
                                + "<td>" + Fcidade + "</td>"
                                + "<td>" + Fuf + "</td>"
                                + "<td>" + Fcmpt + "</td>"
                            + "</tr>"
                        + "</table>"
                        + "<table border='1' cellspacing='0' cellpadding='2'>"
                            + "<tr>"
                                + "<th width='200'><strong>tipo de plano</strong></th>"
                                + "<th width='200'><strong>descrição</strong></th>"
                                + "<th width='200'><strong>valor</strong></th>"
                                + "<th width='200'><strong>data emissão</strong></th>"
                                + "<th width='200'><strong>data vencimento</strong></th>"
                            + "</tr>"
                            + "<tr>"
                                + "<td>" + Fplano + "</td>"
                                + "<td>" + Fdesc + "</td>"
                                + "<td>" + Fvalor + "</td>"
                                + "<td>" + Fdt_emissao + "</td>"
                                + "<td>" + Fdt_vencimento + "</td>"
                            + "</tr>"
                        + "</table>",
                        "text/html"
                );
                // Send message
                Transport.send(message);
                result = "Your mail sent successfully....";
            } catch (MessagingException mex) {
                mex.printStackTrace();
                result = "Error: unable to send mail....\n" + mex;
            }
            response.sendRedirect("Home.jsp");
%>
        <h1><center><font color="blue">Sending Mail Using JSP</font></</h1>
        <b><center><font color="red"><% out.println(result);%></b>
<%
        }
        rs.close();
        stm.close();
        con.close();
    } catch (Exception ex) {
        out.print("<br/><br/>Desculpe, mas algo errado aconteceu abrindo este BD...<br/>"+ex+"<br/>" );
    }
 
 %>
        
    
</html>