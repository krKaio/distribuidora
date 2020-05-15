<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/xml" pageEncoding="UTF-8"%>
<%@include file="../conecta.jsp" %>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Pragma", "no-cache");
    out.println("<boletos>");
    String BLT = request.getParameter("NBoleto");
    Date d = new Date();
    SimpleDateFormat srtDate = new SimpleDateFormat("dd/MM/yyyy");
    try{
                
        if(BLT!=null){
            ResultSet rs = stm.executeQuery("select *,if(valor_pago=(select valor_pago from pagamento where valor_pago=29.99),'sim','nao') as pagou from pagamento p, boleto b where b.cpf= p.cpf and b.cpf="+BLT+" group by cod_boleto order by cod_boleto");
            //ResultSet rs = stm.executeQuery("select * from boleto where cpf='"+BLT+"'");
            while(rs.next()){
                out.println("<boleto><modelo>"+rs.getString("modelo")+"</modelo>"+
                        "<qntd>"+rs.getString("qntd")+"</qntd>"+
                        "<cod>"+rs.getString("cod")+"</cod>"+
                        "<cpf>"+rs.getString("cpf")+"</cpf>"+
                        "<valor>"+rs.getString("valor")+"</valor>"
                        +"<dt>"+rs.getString("dt")+"</dt>"+
                        "<pagou>"+rs.getString("pagou")+"</pagou>"+"</boleto>");
                session.setAttribute("cod", rs.getString("cod"));
            }
            rs.close();
       }
    }catch(Exception e){}
    
    
         String cpf = (String) session.getAttribute("cpf");
    if( d.getDate() == 12){
    SimpleDateFormat srtDateB = new SimpleDateFormat("yyyy/MM/dd");
        try{
            String sql = "INSERT INTO boleto(modelo, qntd, cpf, valor,dt) VALUES('Mensal',1,'"+BLT+"',29.99,'"+srtDateB.format(d) +"')";
            stm.executeUpdate(sql);
            String sql1= "INSERT INTO pagamento (cod_boleto, modelo, cod, cpf, valor, valor_pago) values(1114,'Mensal',(select max(cod) as cod from boleto),'"+cpf+"',29.99, 0.00)";
            stm.executeUpdate(sql1);
        }catch(SQLException e){}
    }
    
    
    stm.close();
    con.close();
    out.println("</boletos>");
%>