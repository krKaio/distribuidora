<%-- 
    Document   : Redirecionamentos
    Created on : 10/05/2020, 17:36:45
    Author     : Marcos
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        String senha = (String) session.getAttribute("senha");
        String cod = (String) session.getAttribute("codigo");
        
        if(senha != null){
            response.sendRedirect("DadosComum.jsp");
        }else if(cod != null){
            response.sendRedirect("DadosMensal.jsp");
        }else{
            response.sendRedirect("index.html");
        }
        %>
    </body>
</html>
