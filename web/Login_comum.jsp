<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*" language="java"%>
<%@include file="conecta.jsp" %>
<%    ResultSet rs = null;
    String email = request.getParameter("email");
    String senha = request.getParameter("senha");
    String sql;
    
    if (!email.isEmpty() && !senha.isEmpty()) {
        try {

            sql = "SELECT nome, senha, email FROM clienteComum WHERE email = '" + email + "' and senha='" + senha + "'";
            rs = stm.executeQuery(sql);

            while (rs.next()) {
                if (email.equals(rs.getString("email")) && senha.equals(rs.getString("senha"))) {
                    session.setAttribute("email", email);
                    session.setAttribute("senha", senha);
                    session.setAttribute("nome", rs.getString("nome"));
                    session.setAttribute("email", rs.getString("email"));
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
