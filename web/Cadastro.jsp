<%-- 
    Document   : Cadastro
    Created on : 16/04/2020, 15:03:50
    Author     : KRGUI
--%>
<%@page import="java.math.BigInteger"%>
<%@page import="java.security.SecureRandom"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="conecta.jsp" %>
<jsp:useBean id="men" class="meuBeans.ClienteMensal" />
<jsp:useBean id="cli" class="meuBeans.ClienteComum" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro</title>
        <style>

            * {
                font-family: arial, sans-serif;
            }

            body {
                background-color: #F8F8FF;
            }

            span {
                font-weight: bold;
            }

            hr {
                width: 50%;
                background-color: #000;
                height: 2px;
            }

            input {
                border-radius: 5px;
                border: 1px solid #DEB887;
                height: 20px; 
            }

            #caixa {
                margin: auto;
                margin-top: 1%;
                width: 70%;
                border: 3px solid #000;
                padding: 10px;
                background-color: #F5F5F5;
            }

            #cliente {
                width: 95%;
                border: 1px solid #000;
                padding: 10px;
                border-radius: 3px;
                margin-left: 1%;
                margin-bottom: 3%;
            }

            #endereco {
                width: 95%;
                border: 1px solid #000;
                padding: 10px;
                margin-top: 1%;
                border-radius: 3px;
                margin-left: 1%;
            }

            .botaoEnviar {
                /* padding: 20px; */
                margin-top: 15px;
                margin-left: 5px;
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

            .titulo {
                text-align: center;
            }

        </style>
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"
                integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
        crossorigin="anonymous"></script>

        <!-- Adicionando Javascript -->
        <script type="text/javascript" >
            //Codigo para puxar dados através do CEP digitado
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
        <%                    request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");

            String cpf = (String) session.getAttribute("cpf");
            String codigo = (String) session.getAttribute("codigo");
            String nome = (String) session.getAttribute("nome");
            String senha = (String) session.getAttribute("senha");

            if (nome == null) {
                response.sendRedirect("Login.jsp");
            } else {

            }

        %>
        <section id="caixa">
            <h2 class="titulo">Distribuidora de Gás</h2>
            <hr>
            <%                ResultSet rss = men.consultar("SELECT * FROM client WHERE cpf = '" + cpf + "'");
                if (rss.isBeforeFirst()) {
                    while (rss.next()) {
                        if (cpf.equals(rss.getString("cpf"))) {
                            out.println("<script>alert('Você já é um mensalista.');"
                                    + "window.location.href ='Home.jsp';</script>");
                        }
                    }
                } else {

                    String email = (String) session.getAttribute("email");
                    results = cli.consultar("SELECT * FROM clientecomum WHERE cpf = '" + cpf + "'");
                    if (results.isBeforeFirst()) {
                    while (results.next()) {


            %>
            <br>
            <form name="meuForm" action="Cadastrar.jsp" method="post">
                <ul>
                    <li>DIGITE SUAS INFORMAÇÕES</li>
                </ul>
                <div id="cliente">
                    <span>Nome:</span> <input type="text" id="nome" name="nome" placeholder="Nome" value="<%= results.getString("nome")%>" style="width: 50%; margin-left: 23px" required><br><br>
                    <span>CPF:</span> <input type="text" id="cpf" name="cpf" placeholder="CPF" value="<%= results.getString("cpf")%>" style="width: 50%; margin-left: 35px"required><br><br>
                    <span>Email:</span> <input type="text" id="email" name="email" placeholder="E-mail" value="<%= results.getString("email")%>" style="width: 50%; margin-left: 25px"required><br><br>
                    <span>Telefone:</span> <input type="text" id="telefone" name="telefone" placeholder="Telefone" value="<%= results.getString("telefone")%>" style="margin-left: 5px"required><br><br>
                    <span>Idade:</span> <input type="text" id="idade" name="idade" placeholder="Idade" style="width: 10%; margin-left: 29px"required><br><br>
                </div>
                <ul>
                    <li>DIGITE SEU ENDEREÇO DE ENTREGA</li>
                </ul>
                <div id="endereco">
                    <span>CEP:</span> <input type="text" id="cep" name="cep" placeholder="CEP" value="<%= results.getString("cep")%>" style="margin-left: 73px"required><br><br>
                    <span>Logradouro:</span> <input type="text" id="log" name="log" placeholder="Logradouro" value="<%= results.getString("logradouro")%>" style="margin-left: 17px; width: 50%"required><br><br>
                    <span>Bairro:</span> <input type="text" id="bairro" name="bairro" placeholder="Bairro" value="<%= results.getString("bairro")%>" style="margin-left: 60px; width: 50%"required><br><br>
                    <span>Cidade:</span> <input type="text" id="city" name="city" placeholder="Cidade" value="<%= results.getString("cidade")%>" style="margin-left: 55px; width: 50%"required><br><br>
                    <span>UF:</span> <input type="text" id="uf" name="uf" placeholder="UF" value="<%= results.getString("uf")%>" style=" margin-left: 88px; width: 5%"required><br><br>
                    <span>Número:</span> <input type="text" id="num" name="num" placeholder="Número da residência" value="<%= results.getInt("numero")%>" style="margin-left: 50px; width: 16%"required><br><br>
                    <span>Complemento:</span> <input type="text" name="complemento" placeholder="Complemento" value="<%= results.getString("complemento")%>" style="margin-left: 3px; width: 50%"><br><br>
                    <span>Dia de pagamento:</span> <input type="number" name="dt_vencimento" placeholder="dia de pagamento" style="margin-left: 3px; width: 3%" required><br><br>
                </div>
                <input type="submit" onClick="return validar();" value="Cadastrar" class="botaoEnviar">
            </form>

        </section>
        <%                }
            }}
        %>
    </body>
</html>
