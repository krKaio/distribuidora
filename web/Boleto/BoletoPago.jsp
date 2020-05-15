<%@page contentType="text/xml" pageEncoding="UTF-8"%>
<%@include file="../conecta.jsp" %>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Pragma", "no-cache");
    
    try{
        String codB = request.getParameter("codB");
        String pagamento = request.getParameter("pagamento");
    
        String sql = "insert into BoletoPago (cod_boleto, modelo, valor) values ("+Integer.parseInt(codB)+",'Mensal',"+pagamento+")";
        stm.executeUpdate(sql);
        response.sendRedirect("Boleto.jsp");
    }catch(Exception e){    }
     
    stm.close();
    con.close();
%>
 