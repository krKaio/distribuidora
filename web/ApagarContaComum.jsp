<%-- 
    Document   : ApagarContaComum
    Created on : 10/05/2020, 18:35:29
    Author     : Marcos
--%>

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
        <%            
            String email = (String) session.getAttribute("email");
            String cpf = (String) session.getAttribute("cpf");

            if (cli.excluir(cpf)) {
                out.print("<script>alert('Dados excluídos');"
                        + "window.location.href ='Deslogar.jsp'; </script>");
            } else {
                out.print("Erro ao apagar dados");
            }
        %>
    </body>
</html>
