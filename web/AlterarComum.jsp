<%-- 
    Document   : Fora
    Created on : 30/04/2020, 20:20:15
    Author     : Marcos
--%>

<%@page import="meuPacote.ValidaCPF"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="conecta.jsp" %>
<jsp:useBean id="cli" class="meuBeans.ClienteComum" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>


        <%            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");
            String cpf = (String) session.getAttribute("cpf");
            String email = (String) session.getAttribute("email");

            String nome = request.getParameter("nome");
            String semail = request.getParameter("semail");
          
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
        <%
                
                    if (cli.alterar(cpf)) {
                        session.setAttribute("email", semail);
                        session.setAttribute("nome", nome);
                        out.println("<script>alert('Seus dados foram alterados.');"
                                + "window.location.href ='DadosComum.jsp';</script>");
                    } else {
                        out.println("<script>alert('Não foi possivel alterar os dados.');"
                                + "window.location.href ='DadosComum.jsp';</script>");
                    }
        %>
    </body>
</html>
