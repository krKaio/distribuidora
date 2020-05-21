<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@include file="../conecta.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="../lib/jquery-1.11.1.js"></script>
        <title>Boletos</title>
    </head>
    <script>
        function processar(codigo, acao){
            
            var endereco="", saida="", cod="";
            $("#tabelaBoleto").empty(); 
                 if(acao=="B") endereco = "../Pagando.jsp?id="+$("#text").val();
                 
                 
                $.ajax({ 
                    url : endereco,
                    success : function(xml){
                        
                        saida +=  "<table border='1'><tr><td>cpf</td><td>nome</td><td>descricao</td><td>quantidade</td><td>valor</td><td>total</td><td>data</td><td>pago</td></tr>";
                        $(xml).find("venda").each(function(){                            
                                saida += "<tr class='linha'><td> "+ $(this).find("modelo").text()+"</td>"; 
                                saida += "<td>"+ $(this).find("cpf").text()+"</td>";
                                saida += "<td>"+ $(this).find("nome").text()+"</td>";
                                saida += "<td>"+ $(this).find("cpf").text()+"</td>";
                                saida += "<td>"+ $(this).find("descricao").text()+"</td>";
                                saida += "<td>"+ $(this).find("valor").text()+"</td>";
                                saida += "<td>"+ $(this).find("total").text()+"</td>";
                                saida += "<td>"+ $(this).find("dt_venda").text()+"</td>";
                                saida += "<td>"+ $(this).find("pago").text()+"</td>";
                                saida += "<td><a href='#' onclick='processar("+$(this).find("id_venda").text()+">Excluir</a></td></tr>"; 
                            });
                            saida += "</table>";
                            $("#tabelaBoleto").append(saida);       
                },
                            
                    error: function(){	alert("Processo não concluído");  }
            });
            
            
        }
        
        $(function(){
            $("#text").ready(function(){
                processar(this.value,"B");
                });                 
        });
        
        
    </script>
    <style>
            #bg1{
                width: 100%;
                height: 100%;
                top: 0;
                left: 0;
                background-color: rgba(0,0,0,.8);
                position: fixed;
                display: none;

            }
            #bg1:target{
                display: block;
            }
            .box1{
                background-color: rgba(146, 146, 146, 0.45);
                width: 600px;
                height: 210px;
                position: absolute;
                margin-left: 37%;
                left: 1%;
                margin-top: 100px;
                top: -800px;
                border: 2px solid #fff;
            }
            #bg1:target ~.box1{
                top: 50px;
                transition: all .3s;
                transition-delay: .2s;
            }
            .box1 img{
                position: absolute;
            }
            #close1{
                color: #fff;
                font-family: 'Arial';
                text-decoration: none;
                font-size: 35px;
                position: absolute;
                background-color: #000;
                width: 120px;
                height: 40px;
                text-align: center;
                top: 0;
                margin-top: 30%;
                margin-left: -13%
            }
            #close1:hover{
                opacity: .6;
            }
            #Consulta{
                font-size: 1.5em;
                display: inline-block;
                width: 300px;
                margin: 1.2%;

            }
        </style>
    <body>
        <div>
            <%
                    String usuario = (String) session.getAttribute("cpf");
                    
                    if (usuario == null) {
                        response.sendRedirect("../Login.jsp");
                    } else {
                        out.println("Bem vindo, " + "<input type='text' name='cpf' id='text' value='"+usuario+"' size='5' readonly>"
                        + "<br>");
                    }
            %>
        </div>
        <br><br>
        <form action='../Pagando.jsp' method='post'>
        <div id="tabelaBoleto"></div>
         vai puxar o cod para pagamento <select name="boleto" >
            <option value="0">Boleto A Pagar</option>
            <%
               String resp = "";
                try{
                    ResultSet rs = stm.executeQuery("SELECT * FROM venda where pago= 'nao' and cpf ='"+usuario+"'");
                    while(rs.next()){
                        resp+="<option value='"+rs.getInt("id_venda")+"'>";
                        resp+=rs.getString("id_venda")+"</option>";
                    }
                    rs.close();
                }catch(Exception ex){
                    resp = "<option>Erro ao carregar os boleto" + ex.toString() + "</option>";
                }
                stm.close();
                con.close();                
                out.println(resp);
            %></select>
            <a href='../Pagando.jsp'> <input type='submit' value='PAGAR' name='pagando'></a>
        </form>
        
    </body>
</html>
