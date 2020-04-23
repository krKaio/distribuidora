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
  VALUES (1234, "kaio", "krkaioreis@outlook.com", 22,"1313", "sei la", 642, "08730-270", "sei laaa", "sao paulo", "sp", "esquina av japao", "c5c5dse6");
  
select * from client;