<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="org.apache.commons.mail.SimpleEmail"%>
<%@page import="java.math.BigInteger"%>
<%@page import="java.security.SecureRandom"%>
<%@page import="org.apache.commons.mail.*"%>
<%
    
    //Gerando um código aleatório de 8 caracter e colocando em uma variavel codigo
    SecureRandom random = new SecureRandom();
    String token = new BigInteger(40, random).toString(32);
    String codigo = token;

    // email que o sistema utiliza para logar no gmail
    String meuEmail = "shuruprojetos@gmail.com"; // OBS: esse email utilizado precisou premissão para poder efetuar o login
    String minhaSenha = "shuruminos";
    //Pegando o email que o usuario informar
    String destino = request.getParameter("email");

    //fazendo a conexão e autenticação do email que irá logar
    SimpleEmail email = new SimpleEmail();
    email.setHostName("smtp.gmail.com");
    email.setSmtpPort(465);
    email.setAuthenticator(new DefaultAuthenticator(meuEmail, minhaSenha));
    email.setSSLOnConnect(true);

    // enviando o email com o codigo que foi gerado
    try {
        email.setFrom(meuEmail);
        email.setSubject("Teste de envio de um código!");
        email.setMsg("Enviando um código aleatório que será utilizado futuramente para autenticação do usuario\n"
                + "Seu Código é: "
                + codigo);
        email.addTo(destino);
        email.send();
        System.out.println("Email foi enviado!");

    } catch (Exception e) {
       out.println(e);
    }

%>
