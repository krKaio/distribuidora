package meuBeans;

import java.io.Serializable;
import java.sql.*;

public class ClienteComum implements Serializable {

    private String cpf;
    private String nome;
    private String email;
    private String senha;
    private String telefone;
    private String cep;
    private String logradouro;
    private String bairro;
    private String cidade;
    private String uf;
    private int numero;
    private String complemento;

    public ClienteComum() {
    }
    /**
     * @return the cpf
     */
    public String getCpf() {
        return cpf;
    }

    /**
     * @param cpf the cpf to set
     */
    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    /**
     * @return the nome
     */
    public String getNome() {
        return nome;
    }

    /**
     * @param nome the nome to set
     */
    public void setNome(String nome) {
        this.nome = nome;
    }

    /**
     * @return the email
     */
    public String getEmail() {
        return email;
    }

    /**
     * @param email the email to set
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * @return the senha
     */
    public String getSenha() {
        return senha;
    }

    /**
     * @param senha the senha to set
     */
    public void setSenha(String senha) {
        this.senha = senha;
    }

    /**
     * @return the telefone
     */
    public String getTelefone() {
        return telefone;
    }

    /**
     * @param telefone the telefone to set
     */
    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    /**
     * @return the cep
     */
    public String getCep() {
        return cep;
    }

    /**
     * @param cep the cep to set
     */
    public void setCep(String cep) {
        this.cep = cep;
    }

    /**
     * @return the logradouro
     */
    public String getLogradouro() {
        return logradouro;
    }

    /**
     * @param logradouro the logradouro to set
     */
    public void setLogradouro(String logradouro) {
        this.logradouro = logradouro;
    }

    /**
     * @return the bairro
     */
    public String getBairro() {
        return bairro;
    }

    /**
     * @param bairro the bairro to set
     */
    public void setBairro(String bairro) {
        this.bairro = bairro;
    }

    /**
     * @return the cidade
     */
    public String getCidade() {
        return cidade;
    }

    /**
     * @param cidade the cidade to set
     */
    public void setCidade(String cidade) {
        this.cidade = cidade;
    }

    /**
     * @return the uf
     */
    public String getUf() {
        return uf;
    }

    /**
     * @param uf the uf to set
     */
    public void setUf(String uf) {
        this.uf = uf;
    }

    /**
     * @return the numero
     */
    public int getNumero() {
        return numero;
    }

    /**
     * @param numero the numero to set
     */
    public void setNumero(int numero) {
        this.numero = numero;
    }

    /**
     * @return the complemento
     */
    public String getComplemento() {
        return complemento;
    }

    /**
     * @param complemento the complemento to set
     */
    public void setComplemento(String complemento) {
        this.complemento = complemento;
    }

    

    public String incluir() {
        try {
            // Carregar Driver do MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");
            //Fazer a conexão verifique se o usuário root e a senha são iguais na máquina de teste caso contrário, altere na linha abaixo.
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/distribuidora?useTimezone=true&serverTimezone=UTC&useSSL=false", "root", "root");
            Statement stmt = con.createStatement();//Criar o fluxo para mandar comando sql o banco
            
            String sql = "INSERT INTO clientecomum (cpf, nome, email, senha, telefone, cep, logradouro, bairro, cidade, uf, numero, complemento)"
                    + " values('"+ getCpf()+"','"+getNome()+"','"+getEmail()+"', '"+getSenha()+"','"+getTelefone()+"','"
                    +getCep()+"','"+getLogradouro()+"','"+getBairro()+"','"+getCidade()+"','"+getUf()+"',"+getNumero()+",'"+getComplemento()+"');";
            
            stmt.executeUpdate(sql);// Executa o comando SQL
            con.close();//Fecha a conexão
            stmt.close();//Fecha o fluxo 
        } catch (ClassNotFoundException e) {
            return "Erro:" + e.getMessage();
        } catch (SQLException e) {
            return "Erro:" + e.getMessage();
        }
        return ("ok");
    }

    public boolean alterar(String cpf) {
        try {
            // Carregar Driver do MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");
            //Fazer a conexão verifique se o usuário root e a senha são iguais na máquina de teste caso contrário, altere na linha abaixo.
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/distribuidora?useTimezone=true&serverTimezone=UTC&useSSL=false", "root", "root");
            Statement stmt = con.createStatement();//Criar o fluxo para mandar comando sql o banco
            
            String query = "update clienteComum set nome ='"+getNome()+"', email='"+getEmail()+"', senha='"+getSenha()+"',"
                    + " telefone='"+getTelefone()+"', cep='"+getCep()+"', logradouro='"+getLogradouro()+"',"
                    + " bairro='"+getBairro()+"', cidade='"+getCidade()+"', uf='"+getUf()+"', numero="+getNumero()+","
                    + " complemento='"+getComplemento()+"' where cpf='"+cpf+"'";
            stmt.executeUpdate(query); // Executa o comando SQL
            con.close();//Fecha a conexão
            stmt.close();//Fecha o fluxo
        } catch (ClassNotFoundException e) {
            return (false);
        } catch (SQLException e) {
            return (false);
        }
        return (true);
    }

    public boolean excluir(String cpf) {
        try {
            // Carregar Driver do MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");
            //Fazer a conexão verifique se o usuário root e a senha são iguais na máquina de teste caso contrário, altere na linha abaixo.
             Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/distribuidora?useTimezone=true&serverTimezone=UTC&useSSL=false", "root", "root");
            Statement stmt = con.createStatement();//Criar o fluxo para mandar comando sql o banco
            
            String sql = "Delete from clienteComum where cpf= '"+cpf+"'";
            stmt.executeUpdate(sql);// Executa o comando SQL
            con.close();//Fecha a conexão
            stmt.close();//Fecha o fluxo 
        } catch (ClassNotFoundException ex) {
            return (false);
        } catch (SQLException e) {
            return (false);
        }
        return (true);
    }

    public ResultSet consultar(String sql) {
        ResultSet resultado;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");// Carregar Driver do MySQL
            //Fazer a conexão verifique se o usuário root e a senha 123 são iguais na máquina de teste caso contrário, altere na linha abaixo.
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/distribuidora?useTimezone=true&serverTimezone=UTC&useSSL=false", "root", "root");
            Statement stmt = con.createStatement();//Criar o fluxo para mandar comando sql o banco		
            resultado = stmt.executeQuery(sql);// Executa o comando SQL
            return resultado;
        } catch (Exception ex) {
            return null;
        }
    }

}
