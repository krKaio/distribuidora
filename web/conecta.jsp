<%-- 
    Document   : coneta
    Created on : 17/10/2019, 08:43:52
    Author     : logon
--%>

<%@page import="java.sql.*" %>
<%@page import="java.sql.PreparedStatement" %>
<%
    Connection con = null;
    Statement stm = null;
    ResultSet results = null;
    PreparedStatement pstmt = null;
    try{
     //banco de dados
     String servidor = "localhost:3306";
     String banco = "distribuidora";
     //login e senha
     String usuario = "root";
     String senha = "root";
     //Carregar o JDBC Driver
     String driverName = "com.mysql.jdbc.Driver";
     Class.forName(driverName);
     
     //estabelecer a conexão com o Banco
     String url = "jdbc:mysql://"+servidor+"/"+banco+"?useLegacyDatetimeCode=false&serverTimezone=America/Sao_Paulo&useSSL=false";
     con = DriverManager.getConnection(url, usuario, senha);
    // stm = con.createStatement();
     stm = con.createStatement();
     
    }catch(SQLException e){
        out.print("Conecta: " + e.getMessage());
    }
    


%>
