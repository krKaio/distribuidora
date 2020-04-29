<%-- 
    Document   : Cadastro
    Created on : 16/04/2020, 15:03:50
    Author     : KRGUI
--%>

<%@page import="java.math.BigInteger"%>
<%@page import="java.security.SecureRandom"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro</title>
        <style>
            body {
                text-align: center;
                background-color: #F5F5F5
            }
            section{
                margin: auto;
                margin-top: 5%;
                width: 50%;
                border: 3px solid green;
                padding: 10px;
            }
            input{
                margin: 5px; 
            }   
            
        </style>
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"
            integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
            crossorigin="anonymous"></script>
            
    <!-- Adicionando Javascript -->
    <script type="text/javascript" >
        //Codigo para puxar dados através do CEP digitado
        $(document).ready(function() {
          
            function limpa_formulário_cep() {
                // Limpa valores do formulário de cep.
                $("#log").val("");
                $("#bairro").val("");
                $("#city").val("");
                $("#uf").val("");
            }
            
            //Quando o campo cep perde o foco.
            $("#cep").blur(function() {

                //Nova variável "cep" somente com dígitos.
                var cep = $(this).val().replace(/\D/g, '');

                //Verifica se campo cep possui valor informado.
                if (cep != "") {

                    //Expressão regular para validar o CEP.
                    var validacep = /^[0-9]{8}$/;

                    //Valida o formato do CEP.
                    if(validacep.test(cep)) {

                        //Preenche os campos com "..." enquanto consulta webservice.
                        $("#log").val("...");
                        $("#bairro").val("...");
                        $("#city").val("...");
                        $("#uf").val("...");

                        //Consulta o webservice viacep.com.br/
                        $.getJSON("https://viacep.com.br/ws/"+ cep +"/json/?callback=?", function(dados) {

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
        <script type="text/javascript" >
        
            // Codigo JavaScript para validar campos do form
            function validar(){
               
                //codigo para validar Nome
                var semNome = document.meuForm.nome.value;
                if(semNome == ""){
                    alert("Digite um nome");
                    document.meuForm.nome.focus();
                    return false;
                }
                
                //codigo para validar email
                var semEmail = document.meuForm.email.value;
                if(semEmail == ""){
                    alert("Digite um email");
                    document.meuForm.email.focus();
                    return false;
                }
                
                //codigo para validar Senha
                var semSenha = document.meuForm.senha.value;
                if(semSenha == ""){
                    alert("Digite uma senha");
                    document.meuForm.senha.focus();
                    return false;
                }
                
                //codigo para validar CEP
                var semCEP = document.meuForm.cep.value;
                if(semCEP == ""){
                    alert("Digite um CEP");
                    document.meuForm.cep.focus();
                    return false;
                }
                
                 //codigo para validar CEP
                var semNum = document.meuForm.num.value;
                if(semNum == ""){
                    alert("Digite um numero da residência");
                    document.meuForm.num.focus();
                    return false;
                }
                var semCpf = document.meuForm.cpf.value;
                if(semCpf == ""){
                    alert("Digite um cpf");
                    document.meuForm.cpf.focus();
                    return false;
                }
            }  
        </script>
    
    </head>
    <body>
        <section>
            <h1>Distribuidoura de Gás</h1>
            <form name="meuForm" action="Cadastrar.jsp" method="post">
                Nome:<input type="text" name="name" placeholder="Nome"><br>
                Email<input type="text" name="email" placeholder="E-mail"><br>
                CPF:<input type="text" name="cpf" placeholder="CPF"><br>
                Idade:<input type="text" name="idade" placeholder="Idade"><br>
                Telefone:<input type="text" name="telefone" placeholder="Telefone"><br>
                CEP:<input type="text" id="cep" name="cep" placeholder="CEP"><br>
                Logradouro:<input type="text" id="log" name="log" placeholder="Logradouro"><br>
                Bairro:<input type="text" id="bairro" name="bairro" placeholder="Bairro"><br>
                Cidade:<input type="text" id="city" name="city" placeholder="Cidade"><br>
                UF:<input type="text" id="uf" name="uf" placeholder="UF"><br>
                Número:<input type="text" id="num" name="num" placeholder="Número da residência"><br>
                Complemento:<input type="text" name="complemento" placeholder="Complemento"><br>
                <input type="submit" onClick="return validar();" value="Cadastrar">
            </form>
             
        </section>
    </body>
</html>
