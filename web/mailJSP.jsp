<%-- 
    Document   : mailJSP
    Created on : 29/04/2020, 10:58:49
    Author     : wilson
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
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
    <%    String cpf = (String) session.getAttribute("cpf");
        String codigo = (String) session.getAttribute("codigo");
        String nome = (String) session.getAttribute("nome");

        if (nome == null) {
            response.sendRedirect("Login.jsp");
        } else {
            out.println("Bem vindo, " + nome + "<br>");
            out.println("<h3>Em desenvolvimento</h3>");
        }
        String result;
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
                            message.setSubject("Segunda Via de Boleto");
                            // Now set the actual message
                            message.setContent(
                                    "<div style='margin: 0 auto;"
                                    + "width: 80%;"
                                    + "padding: 20px;"
                                    + "colo: #000;"
                                    + "border: 2px solid #000;'>"
                                    + "<ul>"
                                    + "<li style='font-family: arial, sans-serif;"
                                    + "font-weight: bold;'>SUAS INFORMAÇÕES</li>"
                                    + "</ul>"
                                    + "<table style='font-family: arial, sans-serif;"
                                    + "border-collapse: collapse;"
                                    + "width: 70%;'>"
                                    + "<tr>"
                                    + "<th style='border: 2px solid #dddddd;"
                                    + "text-align: left;"
                                    + "padding: 8px;'><strong>CPF</strong></th>"
                                    + "<th style='border: 2px solid #dddddd;"
                                    + "text-align: left;"
                                    + "padding: 8px;'><strong>Nome</strong></th>"
                                    + "<th style='border: 2px solid #dddddd;"
                                    + "text-align: left;"
                                    + "padding: 8px;'><strong>E-mail</strong></th>"
                                    + "</tr>"
                                    + "<tr>"
                                    + "<td style='border: 2px solid #dddddd;"
                                    + "text-align: left;"
                                    + "padding: 8px;'>" + v_cpf + "</td>"
                                    + "<td style='border: 2px solid #dddddd;"
                                    + "text-align: left;"
                                    + "padding: 8px;'>" + v_nome + "</td>"
                                    + "<td style='border: 2px solid #dddddd;"
                                    + "text-align: left;"
                                    + "padding: 8px;'>" + email + "</td>"
                                    + "</tr>"
                                    + "</table>"
                                    + "<ul>"
                                    + "<li style='font-family: arial, sans-serif;"
                                    + "font-weight: bold;'>ENDEREÇO</li>"
                                    + "</ul>"
                                    + "<table style='font-family: arial, sans-serif;"
                                    + "border-collapse: collapse;"
                                    + "width: 80%;'>"
                                    + "<tr>"
                                    + "<th style='border: 2px solid #dddddd;"
                                    + "text-align: left;"
                                    + "padding: 8px;'><strong>CEP</strong></th>"
                                    + "<th style='border: 2px solid #dddddd;"
                                    + "text-align: left;"
                                    + "padding: 8px;'><strong>Logradouro</strong></th>"
                                    + "<th style='border: 2px solid #dddddd;"
                                    + "text-align: left;"
                                    + "padding: 8px;'><strong>Bairro</strong></th>"
                                    + "<th style='border: 2px solid #dddddd;"
                                    + "text-align: left;"
                                    + "padding: 8px;'><strong>Cidade</strong></th>"
                                    + "<th style='border: 2px solid #dddddd;"
                                    + "text-align: left;"
                                    + "padding: 8px;'><strong>UF</strong></th>"
                                    + "<th style='border: 2px solid #dddddd;"
                                    + "text-align: left;"
                                    + "padding: 8px;'><strong>Número</strong></th>"
                                    + "<th style='border: 2px solid #dddddd;"
                                    + "text-align: left;"
                                    + "padding: 8px;'><strong>Complemento</strong></th>"
                                    + "</tr>"
                                    + "<tr>"
                                    + "<td style='border: 2px solid #dddddd;"
                                    + "text-align: left;"
                                    + "padding: 8px;'>" + cep + "</td>"
                                    + "<td style='border: 2px solid #dddddd;"
                                    + "text-align: left;"
                                    + "padding: 8px;'>" + log + "</td>"
                                    + "<td style='border: 2px solid #dddddd;"
                                    + "text-align: left;"
                                    + "padding: 8px;'>" + bairro + "</td>"
                                    + "<td style='border: 2px solid #dddddd;"
                                    + "text-align: left;"
                                    + "padding: 8px;'>" + cidade + "</td>"
                                    + "<td style='border: 2px solid #dddddd;"
                                    + "text-align: left;"
                                    + "padding: 8px;'>" + uf + "</td>"
                                    + "<td style='border: 2px solid #dddddd;"
                                    + "text-align: left;"
                                    + "padding: 8px;'>" + num + "</td>"
                                    + "<td style='border: 2px solid #dddddd;"
                                    + "text-align: left;"
                                    + "padding: 8px;'>" + cmpt + "</td>"
                                    + "</tr>"
                                    + "</table>"
                                    + "<ul>"
                                    + "<li style='font-family: arial, sans-serif;"
                                    + "font-weight: bold;'>PAGAMENTO</li>"
                                    + "</ul>"
                                    + "<table style='font-family: arial, sans-serif;"
                                    + "border-collapse: collapse;"
                                    + "width: 80%;'>"
                                    + "<tr>"
                                    + "<th style='border: 2px solid #dddddd;"
                                    + "text-align: left;"
                                    + "padding: 8px;'><strong>Descrição</strong></th>"
                                    + "<th style='border: 2px solid #dddddd;"
                                    + "text-align: left;"
                                    + "padding: 8px;'><strong>Quantidade</strong></th>"
                                    + "<th style='border: 2px solid #dddddd;"
                                    + "text-align: left;"
                                    + "padding: 8px;'><strong>Valor</strong></th>"
                                    + "<th style='border: 2px solid #dddddd;"
                                    + "text-align: left;"
                                    + "padding: 8px;'><strong>Total</strong></th>"
                                    + "<th style='border: 2px solid #dddddd;"
                                    + "text-align: left;"
                                    + "padding: 8px;'><strong>Data vencimento</strong></th>"
                                    + "</tr>"
                                    + "<tr>"
                                    + "<td style='border: 2px solid #dddddd;"
                                    + "text-align: left;"
                                    + "padding: 8px;'>" + desc + "</td>"
                                    + "<td style='border: 2px solid #dddddd;"
                                    + "text-align: left;"
                                    + "padding: 8px;'>" + qtd + "</td>"
                                    + "<td style='border: 2px solid #dddddd;"
                                    + "text-align: left;"
                                    + "padding: 8px;'>" + valor + "</td>"
                                    + "<td style='border: 2px solid #dddddd;"
                                    + "text-align: left;"
                                    + "padding: 8px;'>" + total + "</td>"
                                    + "<td style='border: 2px solid #dddddd;"
                                    + "text-align: left;"
                                    + "padding: 8px;'>" + dt + "</td>"
                                    + "</tr>"
                                    + "</table>"
                                    + "<br><br>"
                                    + "<img src='https://corregofundo.mg.gov.br/wp-content/uploads/2018/03/CodigoDeBarras.jpg' style=' height: 10px; width; 70%;'>"
                                    + " </div>",
                                    "text/html"
                            );
                            // Send message
                            Transport.send(message);
                            result = "Your mail sent successfully....";
                            out.print("<script>alert('Segunda Via enviada com sucesso.');"
                                    + "window.location.href ='SegundaVia.jsp'; </script>");
                        } catch (MessagingException mex) {
                            mex.printStackTrace();
                            result = "Error: unable to send mail....\n" + mex;
                            out.print("<script>alert('Não foi possivel envia segunda via.');"
                                    + "window.location.href ='SegundaVia.jsp'; </script>");
                        }
                        //            response.sendRedirect("Home.jsp");
    %>
    <h1><center><font color="blue">Sending Mail Using JSP</font></</h1>
    <b><center><font color="red"><% out.println(result);%></b>
            <%
                        }
                    }
                    rs.close();
                    stm.close();
                    con.close();
                } catch (Exception ex) {
                    out.print("<br/><br/>Desculpe, mas algo errado aconteceu abrindo este BD...<br/>" + ex + "<br/>");
                }
            } else {
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
                        sql = "SELECT * FROM client WHERE cpf = ?";
                        pstmt = con.prepareStatement(sql);
                        pstmt.setString(1, v_cpf);
                        results = pstmt.executeQuery();
                        while (results.next()) {
                            String cod = results.getString("codigo");
                            String email = results.getString("email");
                            String log = results.getString("logradouro");
                            String num = results.getString("numero");
                            String cep = results.getString("cep");
                            String bairro = results.getString("bairro");
                            String cidade = results.getString("cidade");
                            String uf = results.getString("uf");
                            String cmpt = results.getString("complemento");

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
                                message.setSubject("Segunda Via de Boleto");
                                // Now set the actual message
                                message.setContent(
                                        "<div style='margin: 0 auto;"
                                        + "width: 50%;"
                                        + "padding: 20px;"
                                        + "colo: #000;"
                                        + "border: 2px solid #000;'>"
                                        + "<ul>"
                                        + "<li style='font-family: arial, sans-serif;"
                                        + "font-weight: bold;'>SUAS INFORMAÇÕES</li>"
                                        + "</ul>"
                                        + "<table style='font-family: arial, sans-serif;"
                                        + "border-collapse: collapse;"
                                        + "width: 70%;'>"
                                        + "<tr>"
                                        + "<th style='border: 2px solid #dddddd;"
                                        + "text-align: left;"
                                        + "padding: 8px;'><strong>CPF</strong></th>"
                                        + "<th style='border: 2px solid #dddddd;"
                                        + "text-align: left;"
                                        + "padding: 8px;'><strong>Nome</strong></th>"
                                        + "<th style='border: 2px solid #dddddd;"
                                        + "text-align: left;"
                                        + "padding: 8px;'><strong>E-mail</strong></th>"
                                        + "<th style='border: 2px solid #dddddd;"
                                        + "text-align: left;"
                                        + "padding: 8px;'><strong>Código de Usuário</strong></th>"
                                        + "</tr>"
                                        + "<tr>"
                                        + "<td style='border: 2px solid #dddddd;"
                                        + "text-align: left;"
                                        + "padding: 8px;'>" + v_cpf + "</td>"
                                        + "<td style='border: 2px solid #dddddd;"
                                        + "text-align: left;"
                                        + "padding: 8px;'>" + v_nome + "</td>"
                                        + "<td style='border: 2px solid #dddddd;"
                                        + "text-align: left;"
                                        + "padding: 8px;'>" + email + "</td>"
                                        + "<td style='border: 2px solid #dddddd;"
                                        + "text-align: left;"
                                        + "padding: 8px;'>" + cod + "</td>"
                                        + "</tr>"
                                        + "</table>"
                                        + "<ul>"
                                        + "<li style='font-family: arial, sans-serif;"
                                        + "font-weight: bold;'>ENDEREÇO</li>"
                                        + "</ul>"
                                        + "<table style='font-family: arial, sans-serif;"
                                        + "border-collapse: collapse;"
                                        + "width: 80%;'>"
                                        + "<tr>"
                                        + "<th style='border: 2px solid #dddddd;"
                                        + "text-align: left;"
                                        + "padding: 8px;'><strong>CEP</strong></th>"
                                        + "<th style='border: 2px solid #dddddd;"
                                        + "text-align: left;"
                                        + "padding: 8px;'><strong>Logradouro</strong></th>"
                                        + "<th style='border: 2px solid #dddddd;"
                                        + "text-align: left;"
                                        + "padding: 8px;'><strong>Bairro</strong></th>"
                                        + "<th style='border: 2px solid #dddddd;"
                                        + "text-align: left;"
                                        + "padding: 8px;'><strong>Cidade</strong></th>"
                                        + "<th style='border: 2px solid #dddddd;"
                                        + "text-align: left;"
                                        + "padding: 8px;'><strong>UF</strong></th>"
                                        + "<th style='border: 2px solid #dddddd;"
                                        + "text-align: left;"
                                        + "padding: 8px;'><strong>Número</strong></th>"
                                        + "<th style='border: 2px solid #dddddd;"
                                        + "text-align: left;"
                                        + "padding: 8px;'><strong>Complemento</strong></th>"
                                        + "</tr>"
                                        + "<tr>"
                                        + "<td style='border: 2px solid #dddddd;"
                                        + "text-align: left;"
                                        + "padding: 8px;'>" + cep + "</td>"
                                        + "<td style='border: 2px solid #dddddd;"
                                        + "text-align: left;"
                                        + "padding: 8px;'>" + log + "</td>"
                                        + "<td style='border: 2px solid #dddddd;"
                                        + "text-align: left;"
                                        + "padding: 8px;'>" + bairro + "</td>"
                                        + "<td style='border: 2px solid #dddddd;"
                                        + "text-align: left;"
                                        + "padding: 8px;'>" + cidade + "</td>"
                                        + "<td style='border: 2px solid #dddddd;"
                                        + "text-align: left;"
                                        + "padding: 8px;'>" + uf + "</td>"
                                        + "<td style='border: 2px solid #dddddd;"
                                        + "text-align: left;"
                                        + "padding: 8px;'>" + num + "</td>"
                                        + "<td style='border: 2px solid #dddddd;"
                                        + "text-align: left;"
                                        + "padding: 8px;'>" + cmpt + "</td>"
                                        + "</tr>"
                                        + "</table>"
                                        + "<ul>"
                                        + "<li style='font-family: arial, sans-serif;"
                                        + "font-weight: bold;'>PAGAMENTO</li>"
                                        + "</ul>"
                                        + "<table style='font-family: arial, sans-serif;"
                                        + "border-collapse: collapse;"
                                        + "width: 80%;'>"
                                        + "<tr>"
                                        + "<th style='border: 2px solid #dddddd;"
                                        + "text-align: left;"
                                        + "padding: 8px;'><strong>Descrição</strong></th>"
                                        + "<th style='border: 2px solid #dddddd;"
                                        + "text-align: left;"
                                        + "padding: 8px;'><strong>Quantidade</strong></th>"
                                        + "<th style='border: 2px solid #dddddd;"
                                        + "text-align: left;"
                                        + "padding: 8px;'><strong>Valor</strong></th>"
                                        + "<th style='border: 2px solid #dddddd;"
                                        + "text-align: left;"
                                        + "padding: 8px;'><strong>Total</strong></th>"
                                        + "<th style='border: 2px solid #dddddd;"
                                        + "text-align: left;"
                                        + "padding: 8px;'><strong>Data vencimento</strong></th>"
                                        + "</tr>"
                                        + "<tr>"
                                        + "<td style='border: 2px solid #dddddd;"
                                        + "text-align: left;"
                                        + "padding: 8px;'>" + desc + "</td>"
                                        + "<td style='border: 2px solid #dddddd;"
                                        + "text-align: left;"
                                        + "padding: 8px;'>" + qtd + "</td>"
                                        + "<td style='border: 2px solid #dddddd;"
                                        + "text-align: left;"
                                        + "padding: 8px;'>" + valor + "</td>"
                                        + "<td style='border: 2px solid #dddddd;"
                                        + "text-align: left;"
                                        + "padding: 8px;'>" + total + "</td>"
                                        + "<td style='border: 2px solid #dddddd;"
                                        + "text-align: left;"
                                        + "padding: 8px;'>" + dt + "</td>"
                                        + "</tr>"
                                        + "</table>"
                                        + "<br><br>"
                                        + "<img src='https://corregofundo.mg.gov.br/wp-content/uploads/2018/03/CodigoDeBarras.jpg' style=' height: 10px; width; 70%;'>"
                                        + " </div>",
                                        "text/html"
                                );
                                // Send message
                                Transport.send(message);
                                result = "Your mail sent successfully....";
                                out.print("<script>alert('Segunda Via enviada com sucesso.');"
                                        + "window.location.href ='SegundaVia.jsp'; </script>");
                            } catch (MessagingException mex) {
                                mex.printStackTrace();
                                result = "Error: unable to send mail....\n" + mex;
                                out.print("<script>alert('Não foi possivel envia segunda via.');"
                                        + "window.location.href ='SegundaVia.jsp'; </script>");
                            }
                            //            response.sendRedirect("Home.jsp");
            %>
            <h1><center><font color="blue">Sending Mail Using JSP</font></</h1>
            <b><center><font color="red"><% out.println(result);%></b>
                    <%
                                    }
                                }
                                rs.close();
                                stm.close();
                                con.close();
                            } catch (Exception ex) {
                                out.print("<br/><br/>Desculpe, mas algo errado aconteceu abrindo este BD...<br/>" + ex + "<br/>");
                            }
                        }

                    %>


                    </html>