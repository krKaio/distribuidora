<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*" language="java"%>
<%@include file="conecta.jsp" %>
<%    ResultSet rs = null;
    String cpf = request.getParameter("cpf");
    String codigo = request.getParameter("codigo");
    String sql, nome;

    if (!cpf.isEmpty() && !codigo.isEmpty()) {
        try {

            sql = "SELECT cpf, nome, codigo, email FROM client WHERE cpf = '" + cpf + "'";
            rs = stm.executeQuery(sql);
            if (rs.next() == true) {
                if (cpf.equals(rs.getString("cpf")) && codigo.equals(rs.getString("codigo"))) {
                    session.setAttribute("cpf", cpf);
                    session.setAttribute("codigo", codigo);
                    session.setAttribute("nome", rs.getString("nome"));
                    session.setAttribute("email", rs.getString("email"));
                    response.sendRedirect("Home.jsp");
                } else if (cpf == rs.getString("cpf")) {
                    if (codigo != rs.getString("codigo")) {
                        out.print("<script>alert('Código esta incorreto!');"
                                + "history.go(-1);</script>");
                    }
                } else if (codigo != rs.getString("codigo")) {
                    out.print("<script>alert('Codigo esta incorreto!');"
                            + "history.go(-1);</script>");
                }
            } else {
                out.print("<script>alert('Você ainda não se tronou um mensalista!');"
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
