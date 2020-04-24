create database distribuidora;
use distribuidora;

CREATE TABLE client (
  cpf VARCHAR(45) NOT NULL unique,
  nome VARCHAR(45) NULL,
  email VARCHAR(45) NULL,
  idade int NULL,
  telefone VARCHAR(11) NULL,
  logadouro VARCHAR(45) NULL,
  numero int NULL,
  cep VARCHAR(10) NULL,
  bairro VARCHAR(45) NULL,
  cidade VARCHAR(45) NULL,
  uf char(2) NULL,
  complemento VARCHAR(45) NULL,
  codigo varchar(8) unicode,
  PRIMARY KEY (cpf));
  
  INSERT INTO client ( cpf, nome, email, idade, telefone, logadouro, numero, cep, bairro, cidade, uf, complemento, codigo )
  VALUES ("1234", "kaio", "krkaioreis@outlook.com", 22,"1313", "sei la", 642, "08730-270", "sei laaa", "sao paulo", "sp", "esquina av japao", "c5c5dse6");
  
select * from fatura;

create table planos (
  id_plano int not null auto_increment,
  tp_plano varchar(45) null,
  duracao int null,
  descricao varchar(45) null,
  valor float null,
  dt_emissao date null,
  dt_vencimento date null,
  primary key (id_plano));
    
INSERT INTO planos (tp_plano, duracao, descricao, valor, dt_emissao, dt_vencimento)
  VALUES ("Plano 1", 3, "Plano de 3 meses", 70.00, "2020-04-24", "2020-05-24");
INSERT INTO planos (tp_plano, duracao, descricao, valor, dt_emissao, dt_vencimento)
  VALUES ("Plano 2", 6, "Plano de 6 meses", 60.00, "2020-04-24", "2020-05-24");
INSERT INTO planos (tp_plano, duracao, descricao, valor, dt_emissao, dt_vencimento)
  VALUES ("Plano 3", 9, "Plano de 9 meses", 50.00, "2020-04-24", "2020-05-24");
INSERT INTO planos (tp_plano, duracao, descricao, valor, dt_emissao, dt_vencimento)
  VALUES ("Plano 4", 12, "Plano de 12 meses", 40.00, "2020-04-24", "2020-05-24");

    
create table fatura (
  id_fatura int not null auto_increment,
  f_cpf VARCHAR(45) NOT NULL,
  f_nome VARCHAR(45) NULL,
  f_email VARCHAR(45) NULL,
  f_tp_plano varchar(45) null,
  f_descricao varchar(45) null,
  f_valor float null,
  f_dt_emissao date null,
  f_dt_vencimento date null,
  f_logadouro VARCHAR(45) NULL,
  f_numero int NULL,
  f_cep VARCHAR(10) NULL,
  f_bairro VARCHAR(45) NULL,
  f_cidade VARCHAR(45) NULL,
  f_uf char(2) NULL,
  f_complemento VARCHAR(45) NULL,
  f_codigo varchar(8) unicode,
  primary key (id_fatura));
  
  select f_cpf, f_nome, f_email, f_tp_plano, f_dt_emissao, f_dt_vencimento, f_valor, f_codigo from fatura
  where f_cpf = "1234";
  
INSERT INTO fatura (f_cpf, f_nome, f_email, f_tp_plano, f_descricao, f_valor, f_dt_emissao, f_dt_vencimento, f_logadouro, f_numero, f_cep, f_bairro, f_cidade, f_uf, f_complemento, f_codigo)
  VALUES ("1234", "kaio", "krkaioreis@outlook.com","Plano 1", "Plano de 3 meses", 70.00, "2020-04-24", "2020-05-24", "sei la", 642, "08730-270", "sei laaa", "sao paulo", "sp", "esquina av japao", "c5c5dse6");