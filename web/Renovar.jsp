<%-- 
    Document   : Renovar
    Created on : 21/05/2020, 17:04:07
    Author     : Kings family
--%>

<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Properties"%>
<%@page import="javax.mail.Session"%>
<%@page import="java.util.Date"%>
<%@include file="conecta.jsp" %>
<jsp:useBean id="men" class="meuBeans.ClienteMensal" />
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");

    String cpf = (String) session.getAttribute("cpf");
    String codigo = (String) session.getAttribute("codigo");
    String nome = (String) session.getAttribute("nome");
    String senha = (String) session.getAttribute("senha");

    if (nome == null) {
        response.sendRedirect("Login.jsp");
    } else {
        out.println("Bem vindo, " + nome + "<br>");
    }
%>
<form action="Renovar.jsp" method="post">
    Informe o dia do pagamento:<input type="number" name="num" class="botaoEnviar">
    <input type="submit"  value="ok" class="botaoEnviar">
</form>
<%
    String num = request.getParameter("num");
    if(num != null){
    int dia = Integer.parseInt(request.getParameter("num"));
    int qtd = 1;
    String desc = "mensal";
    String pago = "nao";
    float valor = 60.00f;
    float total = 60.00f;
    Date data2 = new Date();
    Calendar c = new GregorianCalendar();
    c.setTime(data2);
    int di = 30;
    int ano = c.get(Calendar.YEAR);

    for (int mes = c.get(Calendar.MONTH) + 2; mes < 13; mes++) {

        String query = "INSERT INTO venda (nome, cpf, descricao, qtd, valor, total, dt_venda, pago) "
                + "VALUES ('" + nome + "', '" + cpf + "','" + desc + "'," + qtd + ",'" + valor + "','" + total + "','" + ano + '/' + mes + '/' + dia + "', 'nao');";

        int executa = stm.executeUpdate(query);
        if (executa > 0) {

        }

    }
    }else{
     out.print("<script>alert('Nãoo foi possivel renovar.');"
                        + "window.location.href ='DadosMensal.jsp'; </script>");
    }
%>