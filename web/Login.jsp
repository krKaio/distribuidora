<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*" language="java"%>
<%@include file="conecta.jsp" %>
<%    ResultSet rs = null;
    String cpf = request.getParameter("cpf");
    String codigo = request.getParameter("codigo");
    String sql, nome;
    
    if (!cpf.isEmpty() && !codigo.isEmpty()) {
        try {

            sql = "SELECT cpf, nome, codigo FROM client WHERE cpf = " + cpf + " and codigo='" + codigo + "'";
            rs = stm.executeQuery(sql);

            while (rs.next()) {
                if (cpf.equals(rs.getString("cpf")) && codigo.equals(rs.getString("codigo"))) {
                    session.setAttribute("cpf", cpf);
                    session.setAttribute("codigo", codigo);
                    session.setAttribute("nome", rs.getString("nome"));
                    response.sendRedirect("Home.jsp");
                } else {
                    response.sendRedirect("index.html");
                }
            }
        } catch (SQLException el) {
            out.println(el);
        }
    } else {
        response.sendRedirect("index.html");
    }
%>
