<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../conecta.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>pagaboleto</title>
        <script src="../lib/jquery-1.11.1.js"></script>
    </head>
    <script>
        function processar(codigo, acao){
            
            var endereco="", saida="", cod="";
            $("#tbpagamento").empty(); 
                 if(acao=="B") endereco = "PagaBoleto.jsp?Pagar="+$("#text").val();       
                 
                $.ajax({ 
                    url : endereco,
                    success : function(xml){
                        saida += "<table border='1'><tr><td>Cód Boleto</td><td>Código</td><td>cpf</td><td>valor</td></tr>";
                        $(xml).find("boleto").each(function(){                            
                                saida += "<tr class='linha'><td>"+ $(this).find("cod_boleto").text()+"</td>";
                                saida += "<td>"+$(this).find("cod").text()+"</td>";
                                saida += "<td>"+ $(this).find("cpf").text()+"</td>";
                                saida += "<td > "+ $(this).find("valor").text()+"</td>";
                                saida += "<td> <a href='#bg1'><input type='button' value='PAGAR' name='pagando'></a>"+"</td>";
                            });
                            saida += "</table>";
                            $("#tbpagamento").append(saida);                    
                },
                            
                    error: function(){	alert("Processo não concluído");  }
            });
        }
        
        $(function (){
            $("#text").ready(function(){
                processar(this.value,"B");
                });
        });
    </script>
    <script>
         function pagamento(acao){
             
                parametros = "?codB="+ $("#codB").val();
                parametros += "&pagamento="+ $("#pagamento").val();
                
                
                
                $.ajax({ 
                        url : "BoletoPago.jsp"+ parametros,
                        success : function(){ alert("Registrou."); history.go(-3); },
                        error: function(){	alert("Vai falhar");	}
                });
            
        }
        $(function (){
            $("#btn").click(pagamento);
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
                height: 420px;
                position: absolute;
                margin-left: 35%;
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
                background-color: red;
                width: 50px;
                height: 40px;
                text-align: center;
                top: 0;
                margin-top: 0%;
                margin-left: 82%
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
                    String usuario = (String) request.getParameter("boleto");
                    if (Integer.parseInt(usuario) == 0) {
                        response.sendRedirect("Boleto.jsp");
                    } else {
                        out.println("CODIGO DO BOLETO, " + "<input type='text' name='Pagar' id='text' value='"+usuario+"' size='5' readonly>"
                        + "<br>");
                    }
            %>
        </div>
        <br><br>
        <div id="tbpagamento"></div>
        <div id="bg1"></div>
        <div class="box1">
            <div id="Consulta">
                <h3>BOLETO</h3>
                    <div id="valor"><% 
                            ResultSet rs = stm.executeQuery("SELECT valor, cod_boleto FROM pagamento where cod='"+usuario+"'");
                            while(rs.next()){
                                out.println("Valor a pagar é: R$"+rs.getString("valor")+"<input name='codB' id='codB'  value='"+rs.getString("cod_boleto")+"' readonly>");
                            }    
                            rs.close();
                    %>
                    </div>
                    Nome de Cliente: <% String nome = (String) session.getAttribute("nome"); out.println(nome+"<br>");%>
                    <div>Valor a pagar:<input type='text' name='pagamento' id='pagamento' value="29.99" readonly></div>
                    <input type="button" value="Pagar" id="btn" name="btn">
                    
                <a href="" id="close1">x</a>
                </div>
                </div>
    </body>
</html>