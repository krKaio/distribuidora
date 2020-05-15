<%@page contentType="text/xml" pageEncoding="UTF-8"%>
<%@include file="../conecta.jsp" %>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Pragma", "no-cache");
    out.println("<boletos>");
    
    
    try{
        String BLT = request.getParameter("Pagar");
        
        if(BLT!=null){
            ResultSet rs = stm.executeQuery("SELECT * FROM pagamento WHERE cod='"+BLT+"'");
            while(rs.next()){
                out.println("<boleto>"+"<cod_boleto>"+rs.getString("cod_boleto")+"</cod_boleto>"+"<cod>"+rs.getString("cod")+"</cod><cpf>"+rs.getString("cpf")+"</cpf>"+"<valor>"+rs.getString("valor")+"</valor>"+"</boleto>");
            }
            rs.close();
       }
        
    } catch(Exception e){} 
    stm.close();
    con.close();
    out.println("</boletos>");
%>