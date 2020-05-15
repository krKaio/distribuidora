CREATE DATABASE distribuidora;
USE distribuidora;

CREATE TABLE CLIENT (
  cpf VARCHAR(11) NOT NULL UNIQUE,
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
  VALUES ("1234", "kaio", "krkaioreis@outlook.com", 22,"1313", "sei la", 642, "08730270", "sei laaa", "sao paulo", "sp", "esquina av japao", "c5c5dse6");
  
SELECT * FROM client;

  
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
  
  INSERT INTO clienteComum ( cpf, nome, email, senha, telefone, cep, logradouro, bairro, cidade, uf, numero, complemento )
  VALUES ("123546", "Marcos", "marcosvpcruz@yahoo.com.br", "endmarkz", "132131", "08010-400", "seila", "São Miguel", "São Paulo", "SP", "100", "casa");
  
  select * from clientecomum;
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
  VALUES ("botijao", 50, 25, 100, 70.00);
  
UPDATE estoque SET qntd_estoque = qntd_estoque - 2 WHERE modelo = "botijao" ;
  select * from estoque;
  
  create table boleto (
  modelo varchar(20) not null,
  qntd int not null,
  cod int not null auto_increment,
  cpf varchar(45) not null,
  valor decimal (5,2) not null,
  dt date,
  primary key (cod),
  constraint fk_cod foreign key (cpf) references client(cpf),
  constraint fk_gas foreign key (modelo) references estoque(modelo)
  );
  
  INSERT INTO boleto (modelo, qntd, cpf, valor)
  values ("mensal", 1, "12345", 50.00);
  
  select * from estoque;
  
  create table pagamento(
  cod_boleto int not null,
  modelo varchar(20) not null,
  pagou varchar(3),
  cod int not null,
  cpf varchar(45) not null,
  valor decimal(5,2) not null,
  valor_pago decimal(5,2),
  primary key (cod_boleto),
  constraint fk_cpf foreign key (cpf) references client(cpf),
  constraint fk_blt foreign key (cod) references boleto(cod),
  constraint fk_mdlgas foreign key (modelo) references estoque(modelo)
  );
  insert into pagamento (cod_boleto, modelo, pagou, cod, cpf, valor, valor_pago)
  values (132256, "mensal", "nao", 12345, "12345", 29.99, 00.00);
   select * from pagamento;
  
DELIMITER ;;
 CREATE TRIGGER `Tgr_Update` AFTER insert ON `boleto` FOR EACH ROW BEGIN
        UPDATE estoque SET qntd_estoque = qntd_estoque - NEW.qntd
        WHERE modelo = NEW.modelo;
        END ;;
DELIMITER ;

create table BoletoPago(
 cod_boleto int not null,
 modelo varchar(20) not null,
 valor decimal(5,2) not null,
 primary key (cod_boleto),
 constraint fk_BLP foreign key (cod_boleto) references pagamento(cod_boleto),
 constraint fk_mdgas foreign key (modelo) references estoque(modelo)
 );
 select * from BoletoPago;
 drop trigger Tgr_Insert;
 
 DELIMITER ;;
 CREATE TRIGGER `Tgr_Insert` AFTER insert ON `BoletoPago` FOR EACH ROW BEGIN
        UPDATE pagamento SET valor_pago = valor
        WHERE cod_boleto = NEW.cod_boleto;
        END ;;
DELIMITER ;

insert into BoletoPago (cod_boleto, modelo, valor) values (1112, "mensal", 29.99);

INSERT INTO pagamento (cod_boleto, modelo, cod, cpf, valor, valor_pago) values(1113,'mensal',(select max(cod) as cod from boleto),"12345",29.99, 0.00);

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
    primary key(id_venda)
  );
  INSERT INTO venda (nome, cpf, descricao, qtd, valor, total, dt_venda)
  VALUES ("kaio", "12345", "botijao", 1, 80.00, 80.00, "11/04/2020");
  select * from venda where cpf = "12345";
  SELECT * FROM venda ;
  select * from estoque where modelo = "botijao";
  
  UPDATE venda SET pago = 'sim' WHERE id_venda = 18 and total = 210.0;