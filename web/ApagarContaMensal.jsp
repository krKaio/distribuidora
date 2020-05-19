<%-- 
    Document   : ApagarContaComum
    Created on : 10/05/2020, 18:35:29
    Author     : Marcos
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="conecta.jsp" %>
<jsp:useBean id="men" class="meuBeans.ClienteMensal" />
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

            if (men.excluir(cpf)) {
                out.print("<script>alert('Cancelamento realizado com sucesso.');"
                        + "window.location.href ='Deslogar.jsp'; </script>");
            } else {
                out.print("<script>alert('Nãoo foi possivel realizar o cancelamento.');"
                        + "window.location.href ='DadosMensal.jsp'; </script>");
            }
        %>
    </body>
</html>
