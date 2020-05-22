<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/xml" pageEncoding="UTF-8"%>
<%@include file="conecta.jsp" %>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Pragma", "no-cache");
    out.println("<boletos>");
    String Cpf = (String) session.getAttribute("cpf");
    String cpf = request.getParameter("cpf");
    Date d = new Date();
    SimpleDateFormat srtDate = new SimpleDateFormat("dd/MM/yyyy");
    try{
                
        if(Cpf!=null){
           String sql = "SELECT * FROM venda WHERE cpf = ? and pago = ?";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, Cpf);
                    pstmt.setString(2, "nao");
                 ResultSet  rs = pstmt.executeQuery();
            //ResultSet rs = stm.executeQuery("select * from boleto where cpf='"+BLT+"'");
            while(rs.next()){
                out.println("<boleto>"+
                        "<cpf>"+rs.getString("cpf")+"</cpf>"+
                        "<nome>"+rs.getString("nome")+"</nome>"+
                        "<desc>"+rs.getString("descricao")+"</desc>"+
                        "<qtd>"+rs.getString("qtd")+"</qtd>"+
                        "<valor>"+rs.getString("valor")+"</valor>"+
                        "<total>"+rs.getString("total")+"</total>"+
                        "<dt>"+rs.getString("dt_venda").substring(8,10)+"/"+rs.getString("dt_venda").substring(5,7)+"/"+rs.getString("dt_venda").substring(0,4)+"</dt>"+
                        "<pago>"+rs.getString("pago")+"</pago>"+
                        "<bt>"+rs.getString("id_venda")+"</bt>"+"</boleto>");
            }
            rs.close();
       }
    }catch(Exception e){}
    
    stm.close();
    con.close();
    out.println("</boletos>");
%>