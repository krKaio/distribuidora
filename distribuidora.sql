CREATE DATABASE distribuidora;
USE distribuidora;

CREATE TABLE CLIENT (
  cpf VARCHAR(11) NOT NULL UNIQUE,
  nome VARCHAR(45) NULL,
  email VARCHAR(45) NULL,
  idade INT NULL,
  telefone VARCHAR(11) NULL,
  logradouro VARCHAR(45) NULL,
  numero INT NULL,
  cep VARCHAR(10) NULL,
  bairro VARCHAR(45) NULL,
  cidade VARCHAR(45) NULL,
  uf CHAR(2) NULL,
  complemento VARCHAR(45) NULL,
  codigo VARCHAR(8) UNICODE,
  PRIMARY KEY (cpf));
  
  
SELECT * FROM client;

  
  CREATE TABLE clienteComum (
  cpf VARCHAR(45) NULL,
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
  
  #####################################################################################################################################################
  
  create table estoque(
  modelo varchar(20) not null,
  qntd_estoque int not null,
  qntd_min int not null,
  qntd_max int not null,
  valor decimal(5,2) not null,
  primary key (modelo)
  );
  
  INSERT INTO estoque (modelo, qntd_estoque, qntd_min, qntd_max, valor)
  VALUES ("botijao", 1000, 250, 1000, 70.00);
    INSERT INTO estoque (modelo, qntd_estoque, qntd_min, qntd_max, valor)
  VALUES ("mensal", 1000, 250, 1000, 60.00);
  
 
  


#############################################################################################################################################################

  create table venda(
	id_venda int auto_increment,
    nome varchar(45) not null,
    cpf varchar (11) not null,
    descricao varchar(20) not null,
    qtd int not null,
    valor float not null,
    total float not null,
    dt_venda date,
    pago varchar(45),
    primary key(id_venda)
  );
  ###########
  #não precisa excutar o insert da venda
  INSERT INTO venda (nome, cpf, descricao, qtd, valor, total, dt_venda, pago)
  VALUES ("kaio", "12345", "botijao", 1, 80.00, 80.00, "11/04/2020", "nao");
  select * from venda where cpf = "37816947046";
  SELECT * FROM venda ;
  select * from estoque where modelo = "botijao";
  SELECT ADDDATE(dt_venda, INTERVAL 12 DAY) 
FROM venda where id_venda = 71;
select  adddate(dt_venda, interval 1 month ) as data_alterada FROM venda where id_venda = 84;

INSERT INTO venda (nome, cpf, descricao, qtd, valor, total, dt_venda, pago)
  VALUES ("teste", "82827906210", "mensal", 1, 60.00, 60.00, date_add("2020/05/30", interval 1 month ), "nao");

DELIMITER ;;
 CREATE TRIGGER `Tgr_Gerar` AFTER insert ON `venda` FOR EACH ROW BEGIN
        insert into venda (nome, cpf, descricao, qtd, valor, total, dt_venda, pago)
        VALUES (new.nome, new.cpf, "mensal", 1, new.valor, new.total, date_add("dt_venda", interval 1 month ), "nao");
        END ;;
DELIMITER ;
DELETE FROM `distribuidora`.`venda` WHERE (`id_venda` > '17');
drop table venda;

  select  curdate() as data_atual, date_sub(curdate(), interval 5 day ) as data_alterada FROM venda where id_venda = 84;
  
  
  UPDATE venda SET pago = 'sim' WHERE id_venda = 18 and total = 210.0;