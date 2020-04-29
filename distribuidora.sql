CREATE DATABASE distribuidora;
USE distribuidora;

CREATE TABLE CLIENT (
  cpf VARCHAR(45) NOT NULL UNIQUE,
  nome VARCHAR(45) NULL,
  email VARCHAR(45) NULL,
  idade INT NULL,
  telefone VARCHAR(11) NULL,
  logadouro VARCHAR(45) NULL,
  numero INT NULL,
  cep VARCHAR(10) NULL,
  bairro VARCHAR(45) NULL,
  cidade VARCHAR(45) NULL,
  uf CHAR(2) NULL,
  complemento VARCHAR(45) NULL,
  codigo VARCHAR(8) UNICODE,
  PRIMARY KEY (cpf));
  
  INSERT INTO CLIENT ( cpf, nome, email, idade, telefone, logadouro, numero, cep, bairro, cidade, uf, complemento, codigo )
  VALUES ("1234", "kaio", "krkaioreis@outlook.com", 22,"1313", "sei la", 642, "08730-270", "sei laaa", "sao paulo", "sp", "esquina av japao", "c5c5dse6");
  
SELECT * FROM client;

CREATE TABLE planos (
  id_plano INT NOT NULL AUTO_INCREMENT,
  tp_plano VARCHAR(45) NULL,
  duracao INT NULL,
  descricao VARCHAR(45) NULL,
  valor FLOAT NULL,
  dt_emissao DATE NULL,
  dt_vencimento DATE NULL,
  PRIMARY KEY (id_plano));
    
INSERT INTO planos (tp_plano, duracao, descricao, valor, dt_emissao, dt_vencimento)
  VALUES ("Plano 1", 3, "Plano de 3 meses", 70.00, "2020-04-24", "2020-05-24");
INSERT INTO planos (tp_plano, duracao, descricao, valor, dt_emissao, dt_vencimento)
  VALUES ("Plano 2", 6, "Plano de 6 meses", 60.00, "2020-04-24", "2020-05-24");
INSERT INTO planos (tp_plano, duracao, descricao, valor, dt_emissao, dt_vencimento)
  VALUES ("Plano 3", 9, "Plano de 9 meses", 50.00, "2020-04-24", "2020-05-24");
INSERT INTO planos (tp_plano, duracao, descricao, valor, dt_emissao, dt_vencimento)
  VALUES ("Plano 4", 12, "Plano de 12 meses", 40.00, "2020-04-24", "2020-05-24");

    
CREATE TABLE fatura (
  id_fatura INT NOT NULL AUTO_INCREMENT,
  f_cpf VARCHAR(45) NOT NULL,
  f_nome VARCHAR(45) NULL,
  f_email VARCHAR(45) NULL,
  f_tp_plano VARCHAR(45) NULL,
  f_descricao VARCHAR(45) NULL,
  f_valor FLOAT NULL,
  f_dt_emissao DATE NULL,
  f_dt_vencimento DATE NULL,
  f_logadouro VARCHAR(45) NULL,
  f_numero INT NULL,
  f_cep VARCHAR(9) NULL,
  f_bairro VARCHAR(45) NULL,
  f_cidade VARCHAR(45) NULL,
  f_uf CHAR(2) NULL,
  f_complemento VARCHAR(45) NULL,
  f_codigo VARCHAR(8) UNICODE,
  PRIMARY KEY (id_fatura));
  
  SELECT f_cpf, f_nome, f_email, f_tp_plano, f_dt_emissao, f_dt_vencimento, f_valor, f_codigo FROM fatura
  WHERE f_cpf = "1234";
  
INSERT INTO fatura (f_cpf, f_nome, f_email, f_tp_plano, f_descricao, f_valor, f_dt_emissao, f_dt_vencimento, f_logadouro, f_numero, f_cep, f_bairro, f_cidade, f_uf, f_complemento, f_codigo)
  VALUES ("1234", "kaio", "krkaioreis@outlook.com","Plano 1", "Plano de 3 meses", 70.00, "2020-04-24", "2020-05-24", "sei la", 642, "08730-270", "sei laaa", "sao paulo", "sp", "esquina av japao", "c5c5dse6");
  INSERT INTO fatura (f_cpf, f_nome, f_email, f_tp_plano, f_descricao, f_valor, f_dt_emissao, f_dt_vencimento, f_logadouro, f_numero, f_cep, f_bairro, f_cidade, f_uf, f_complemento, f_codigo)
  VALUES("1234", "kaio", "krkaioreis@outlook.com","Plano 1", "Plano de 3 meses", 111.00, "2020-04-24", "2020-05-24", "Rua Franz Steiner", 642, "08730-270", "Alto Ipiranga", "Mogi das Cruzes", "sp", "esquina av japao", "jo2fp0ga");
  
  select * from fatura;
  
  CREATE TABLE clienteComum (
  nome VARCHAR(45) NULL,
  email VARCHAR(45) NOT NULL UNIQUE,
  senha VARCHAR(45) NULL,
  telefone VARCHAR(11) NULL,
  cep VARCHAR(10) NULL,
  logradouro VARCHAR(45) NULL,
  bairro VARCHAR(45) NULL,
  cidade VARCHAR(45) NULL,
  uf CHAR(2) NULL,
  numero INT NULL,
  complemento VARCHAR(45) NULL,
  PRIMARY KEY (email));
  
  INSERT INTO clienteComum ( nome, email, senha, telefone, cep, logradouro, bairro, cidade, uf, numero, complemento )
  VALUES ("Marcos", "marcosvpcruz@yahoo.com.br", "endmarkz", "132131", "08010-400", "seila", "São Miguel", "São Paulo", "SP", "100", "casa");
  
  select * from clientecomum;
  