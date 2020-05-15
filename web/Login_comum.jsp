<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*" language="java"%>
<%@include file="conecta.jsp" %>
<%    ResultSet rs = null;
    String email = request.getParameter("email");
    String senha = request.getParameter("senha");
    String sql;

    if (!email.isEmpty() && !senha.isEmpty()) {
        try {

            sql = "SELECT cpf, nome, senha, email FROM clienteComum WHERE email = '" + email + "'";
            rs = stm.executeQuery(sql);
            if (rs.next() == true) {
                if (email.equals(rs.getString("email")) && senha.equals(rs.getString("senha"))) {
                    session.setAttribute("email", email);
                    session.setAttribute("senha", senha);
                    session.setAttribute("nome", rs.getString("nome"));
                    session.setAttribute("cpf", rs.getString("cpf"));
                    response.sendRedirect("Home.jsp");
                } else if (email == rs.getString("email")) {
                    if (senha != rs.getString("senha")) {
                        out.print("<script>alert('Senha esta incorreta!');"
                                + "history.go(-1);</script>");
                    }
                } else if (senha != rs.getString("senha")) {
                    out.print("<script>alert('Senha esta incorreta!');"
                            + "history.go(-1);</script>");
                }
            } else {
                out.print("<script>alert('Você ainda não possui cadastro!');"
                        + "history.go(-1);</script>");
            }

        } catch (SQLException el) {
            out.println(el);
        }
    } else {
        out.print("<script>alert('Os campos de login estão vazios ou um dos campos esta vazio!');"
                + "history.go(-1);</script>");
    }
%>
