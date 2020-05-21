<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/xml" pageEncoding="UTF-8"%>
<%@include file="../conecta.jsp" %>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Pragma", "no-cache");
    out.println("<boletos>");
    String cpf = request.getParameter("cpf");
    Date d = new Date();
    SimpleDateFormat srtDate = new SimpleDateFormat("dd/MM/yyyy");
    try{
                
        if(cpf!=null){
           String sql = "SELECT * FROM venda WHERE cpf = ? and pago = ?";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, cpf);
                    pstmt.setString(2, "nao");
                 ResultSet  rs = pstmt.executeQuery();
            //ResultSet rs = stm.executeQuery("select * from boleto where cpf='"+BLT+"'");
            while(rs.next()){
                out.println("<boleto><cpf>"+rs.getString("cpf")+"</cpf>"+
                        "<nome>"+rs.getString("nome")+"</nome>"+
                        "<desc>"+rs.getString("descricao")+"</desc>"+
                        "<quant>"+rs.getString("qtd")+"</quant>"+
                        "<valor>"+rs.getString("valor")+"</valor>"+
                        "<total>"+rs.getString("total")+"</total>"+
                        "<dt>"+rs.getString("dt_venda")+"</dt>"+
                        "<pago>"+rs.getString("pago")+"</pago>"+"</boleto>");
            }
            rs.close();
       }
    }catch(Exception e){}
    
    
         
    if( d.getDate() == 20){
    SimpleDateFormat srtDateB = new SimpleDateFormat("yyyy/MM/dd");
        try{
            String sql = "INSERT INTO boleto(modelo, qntd, cpf, valor,dt) VALUES('Mensal',1,'"+cpf+"',29.99,'"+srtDateB.format(d) +"')";
            stm.executeUpdate(sql);
        }catch(SQLException e){}
    }
    
    
    stm.close();
    con.close();
    out.println("</boletos>");
%>