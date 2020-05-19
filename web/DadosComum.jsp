
<%@page import="java.lang.Integer"%>
<%@page import="java.util.Scanner"%>
<%@page import="java.math.BigInteger"%>
<%@page import="java.security.SecureRandom"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*" language="java"%>
<%@include file="conecta.jsp" %>
<jsp:useBean id="cli" class="meuBeans.ClienteComum" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Minha Conta</title>
        <style>
            body {
                text-align: center;
                background-color: #F5F5F5;
            }
            #conterner {
                margin: 0 auto;
                margin-top: 10px;
                width: 90%;
                padding: 20px;
                color: #000000;
            }

            #tabe {
                margin-top: 20px;
                font-family: arial, sans-serif;
                border-collapse: collapse;
                width: 100%;
            }
            td, th {
                border: 2px solid #dddddd;
                text-align: left;
                padding: 8px;
            }.botaoEnviar {
                margin-top: 2%;
                width: 30%;
                text-align: center;
                padding: 10px;
                border: 1px solid #eee;
                border-radius: 5px;
                background-color: #ADD8E6;
                font-size: 12px;
                font-weight: bold;
                border: 1px solid #000;
            }
            strong {
                font-family: arial, sans-serif;
                font-weight: bold;
            }
            .btn {
                margin-left: 14%;
                text-align: center;
                padding: 10px;
                border: 1px solid #eee;
                border-radius: 5px;
                background-color: #ADD8E6;
                font-size: 12px;
                font-weight: bold;
                color: #000;	
                text-decoration: none;
                border: 1px solid #000;
                font-size: 10.5pt;
            }
            .bt {
                text-align: center;
                padding: 10px;
                border: 1px solid #eee;
                border-radius: 5px;
                background-color: #ADD8E6;
                font-size: 12px;
                font-weight: bold;
                color: #000;	
                text-decoration: none;
                border: 1px solid #000;
                font-size: 10.5pt;
            }
            hr{
                margin-top: 20px;
                border: 1px solid #dddddd;
                border-radius: 5px;
            }
            #caixa {
                margin: auto;
                margin-top: 1%;
                width: 70%;
                border: 3px solid #000;
                padding: 10px;
                background-color: #F5F5F5;
            }
            section{
                margin: auto;
                margin-top: 5%;
                width: 70%;
                border: 3px solid #000;
                padding: 10px;
                padding-bottom: 15px;
            }  
            .left{
                width: 40%;
                text-align: left;
                margin-right: 50px;
                display: inline-block;
            }
            .right{
                width: 40%;
                text-align: right;
                margin-left: 50px;
                display: inline-block;   
            }
            nav{
                text-align: center;
                margin-top: 50px;
                display: block;
            }
            nav .btn{
                margin: 5px;
            }
            .btj{
                width: 35%;
                margin: 20px;
                margin-top: 50px;
                padding: 10px;
                border: 1px solid;
                border-radius: 10px;

            }
            .des{
                width: 50px;
                height: 60px;
            }
            .txt {
                border-radius: 5px;
                border: 1px solid #DEB887;
                height: 20px; 
            }
            #cliente {
                width: 95%;
                border: 1px solid #000;
                padding: 10px;
                border-radius: 3px;
                margin-left: 1%;
                margin-bottom: 3%;
                text-align: left;
            }

            #endereco {
                width: 95%;
                border: 1px solid #000;
                padding: 10px;
                margin-top: 1%;
                border-radius: 3px;
                margin-left: 1%;
                text-align: left;
            }

            .botaoEnviar {
                /* padding: 20px; */
                border: 1px solid #eee;
                border-radius: 5px;
                background-color: #ADD8E6;
                font-size: 12px;
                font-weight: bold;
                color: #000;	
                border: 1px solid #000;
                height: 30px;
                width: 100px;
            }

            .botaoApagar {
                /* padding: 20px; */
                border: 1px solid #eee;
                border-radius: 5px;
                background-color: #FF0000;
                font-size: 12px;
                font-weight: bold;
                color: #000;	
                border: 1px solid #000;
                height: 30px;
                width: 100px;
            }
            span {
                font-weight: bold;
                text-align: left;
            }

            hr{
                margin-top: 20px;
                border: 1px solid #dddddd;
                border-radius: 5px;
            }

            input {
                border-radius: 5px;
                border: 1px solid #DEB887;
                height: 20px; 
                text-align: left;
            }
            form{
                text-align: left;
            }

        </style>
        <script type="text/javascript" src="js/scripts.js"></script>

        <script type="text/javascript" src="js/scripts.js"></script>
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"
                integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
        crossorigin="anonymous"></script>

        <script>
            $(document).ready(function () {

                function limpa_formulário_cep() {
                    // Limpa valores do formulário de cep.
                    $("#log").val("");
                    $("#bairro").val("");
                    $("#city").val("");
                    $("#uf").val("");
                }

                //Quando o campo cep perde o foco.
                $("#cep").blur(function () {

                    //Nova variável "cep" somente com dígitos.
                    var cep = $(this).val().replace(/\D/g, '');

                    //Verifica se campo cep possui valor informado.
                    if (cep != "") {

                        //Expressão regular para validar o CEP.
                        var validacep = /^[0-9]{8}$/;

                        //Valida o formato do CEP.
                        if (validacep.test(cep)) {

                            //Preenche os campos com "..." enquanto consulta webservice.
                            $("#log").val("...");
                            $("#bairro").val("...");
                            $("#city").val("...");
                            $("#uf").val("...");

                            //Consulta o webservice viacep.com.br/
                            $.getJSON("https://viacep.com.br/ws/" + cep + "/json/?callback=?", function (dados) {

                                if (!("erro" in dados)) {
                                    //Atualiza os campos com os valores da consulta.
                                    $("#log").val(dados.logradouro);
                                    $("#bairro").val(dados.bairro);
                                    $("#city").val(dados.localidade);
                                    $("#uf").val(dados.uf);
                                } //end if.
                                else {
                                    //CEP pesquisado não foi encontrado.
                                    limpa_formulário_cep();
                                    alert("CEP não encontrado.");
                                }
                            });
                        } //end if.
                        else {
                            //cep é inválido.
                            limpa_formulário_cep();
                            alert("Formato de CEP inválido.");
                        }
                    } //end if.
                    else {
                        //cep sem valor, limpa formulário.
                        limpa_formulário_cep();
                    }
                });
            });

        </script>

    </head>
    <body> 
        <section id="caixa"> 
            <h2 class="titulo">Distribuidora de Gás</h2>
            <hr>
            <div class="left">
                <%                    request.setCharacterEncoding("UTF-8");
                    response.setCharacterEncoding("UTF-8");

                    String cpf = (String) session.getAttribute("cpf");
                    String codigo = (String) session.getAttribute("codigo");
                    String nome = (String) session.getAttribute("nome");
                    String senha = (String) session.getAttribute("senha");

                    if (nome == null) {
                        response.sendRedirect("Login.jsp");
                    } else {
                        out.println("Bem vindo, " + nome + "<br>");
                    }

                %>
            </div>
            <div class="right">
                <a href="Deslogar.jsp">
                    <img src="imagens/deslogar.png" class="des">
                </a>
            </div>
            <nav>
                <a class="btn" href="Home.jsp">Home</a>
                <a class="btn" href="SegundaVia.jsp">2° Via Boletos</a>
                <a class="btn" href="Pagar.jsp">Boletos</a>
                <a class="btn" href="MeuPagamento.jsp">Meus Pagamentos </a>
                <a class="btn" href="Cadastro.jsp">Se tornar mensalista</a>
                <a class="btn" href="Redirecionamentos.jsp">Minha conta</a>
            </nav>
            <hr>
            <%                request.setCharacterEncoding("UTF-8");
                response.setCharacterEncoding("UTF-8");

                String email = (String) session.getAttribute("email");
                results = cli.consultar("SELECT * FROM clienteComum WHERE cpf = '" + cpf + "'");

                while (results.next()) {
            %>

            <br>
            <form name="meuForm" action="AlterarComum.jsp" method="post">
                <ul>
                    <li>ALTERE SUAS INFORMAÇÕES</li>
                </ul>
                <div id="cliente">

                    
                    <span>Nome:</span> <input type="text" id="nome" name="nome" value='<%=results.getString("nome")%>'style="width: 50%; margin-left: 54px"required><br><br>
                    <span>CPF:</span> <input type="text" id="cpf" name="cpf" value='<%=results.getString("cpf")%>'style="width: 50%; margin-left: 63px" disabled><br><br>
                    <span>Email:</span> <input type="email" id="email" name="email" value='<%=results.getString("email")%>'style="width: 50%; margin-left: 55px" required><br><br>
                    <span>Senha:</span> <input type="password" id="senha" name="senha" value='<%=results.getString("senha")%>' style="margin-left: 55px"required><br><br>
                    <span>Telefone:</span> <input type="text" id="telefone" name="telefone" value='<%=results.getString("telefone")%>'style="margin-left: 39px"required><br><br>

                    <span>CEP:</span> <input type="text" id="cep" name="cep" value='<%=results.getString("cep")%>'style="margin-left: 65px"required><br><br>
                    <span>Logradouro:</span> <input type="text" id="log" name="log" value='<%=results.getString("logradouro")%>'style="margin-left: 16px; width: 50%"required><br><br>
                    <span>Bairro:</span> <input type="text" id="bairro" name="bairro" value='<%=results.getString("bairro")%>'style="margin-left: 53px; width: 50%"required><br><br>
                    <span>Cidade:</span> <input type="text" id="city" name="city" value='<%=results.getString("cidade")%>'style="margin-left: 50px; width: 50%"required><br><br>
                    <span>UF:</span> <input type="text" id="uf" name="uf" value='<%=results.getString("uf")%>'style=" margin-left: 76px; width: 5%" required><br><br>
                    <span>Numero:</span> <input type="number" id="num" name="num" value='<%=results.getInt("numero")%>'style="margin-left: 42px; width: 16%" required><br><br>
                    <span>Complemento:</span> <input type="text" id="complemento" name="complemento" value='<%=results.getString("complemento")%>' style="margin-left: 1px; width: 50%" required><br><br>
                </div>
                <%
                    }
                %>
                <input type="submit" onClick="return validarCampos();" value="Alterar Dados" class="botaoEnviar">
            </form>
            <form>
                <a href="ApagarContaComum.jsp" class="apagar" ><input type="submit" name="apagar" value="Apagar Conta" class="botaoApagar"></a>
            </form>

        </section>
    </body>
</html>

