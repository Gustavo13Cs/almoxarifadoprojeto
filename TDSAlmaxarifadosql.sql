use TDSAlmaxarifado

Select * from sys.tables

Create Table AREA (
AREID int identity(1,1) Primary key,
AREDESCRICAO VARCHAR(100) NOT NULL,
)

GO

insert area values ('Ti') 
insert area (AREDESCRICAO) values ('COZINHA') 
GO 
Select * from area

select areid 'Codigo', AREDESCRICAO 'Descrição' from AREA

-- ORDEM crescente pelo campo descricao

select AREID as 'Codigo', AREDESCRICAO 'Descrição' from AREA order by AREDESCRICAO asc

-- ORDEM descrecente pelo campo descricao

select AREID as 'Codigo', AREDESCRICAO 'Descrição' from AREA order by AREDESCRICAO desc

--Agregando dados 

select count(AREID) as 'Total de Registros' from AREA

create table Colaborador (
 colid int identity(1,1) Primary key,
 colnome varchar(100) not null,
 colcargo varchar(100) null,
 Areid int,
 Foreign key (Areid) References Area(Areid)
)

--Inserindo novos Colaboradores

insert Colaborador values ('Reginaldo',null,1)
insert Colaborador(colnome,Areid) values ('Breno',2)
insert Colaborador(colnome,Areid) values ('Edipo Rei',1)

select * from Colaborador

DELETE FROM Colaborador WHERE colnome ='Breno';
DELETE FROM Colaborador WHERE colnome ='Reginaldo';

Update Colaborador
Set colcargo='Tio'

update Colaborador set colcargo='Fazendeiro' where colid=7 -- primeiro tem que da o select na lista para ter certeza 

--Deletar

select * from Colaborador
where colid=5

delete Colaborador where colid=5

-- tentando apagar uma area que existe

select * from AREA where AREID=2

-- join
select C.colid 'Codigo',C.colnome 'Nome',C.colcargo'Cargo',A.AreDescricao 'Àrea' from Colaborador C join AREA A on C.Areid=A.AREID

-- mais testes 

insert Colaborador(colnome,Areid) values ('Ryandra',1)
insert Colaborador(colnome,Areid) values ('Marcus',1)
--
select Areid 'Codigo Àrea', count(Areid) 'Quantidade' from Colaborador group by Areid 
-- group by serve para agrupar informações

Create table PRODUTO(
PROID INT PRIMARY KEY IDENTITY (1,1),
PRODESCRICAO VARCHAR(100) NOT NULL,
PROMINIMO INT DEFAULT  0 CHECK (PROMINIMO>=0),
PROMAXIMO INT DEFAULT 0 CHECK (PROMAXIMO>=0),
PROESTOQUE INT DEFAULT 0 CHECK (PROESTOQUE>=0)
) 

select * from PRODUTO

Insert PRODUTO (PRODESCRICAO) values ('Feijão') 
Insert PRODUTO values ('Banana',0,100,10)
Insert PRODUTO (PRODESCRICAO, PROMINIMO, PROMAXIMO, PROESTOQUE) values ('Ratinho',1,20,40)

Create table ENTRADA(
ENTID INT PRIMARY KEY IDENTITY(1,1),
ENTDATA DATETIME NOT NULL,
ENTORIGEM VARCHAR(100) DEFAULT 'PADRAO' NULL,
ENTNUMERONOTA VARCHAR(100) NULL,
ENTOBSERVACAO VARCHAR(100)
)

go
select * from ENTRADA
go
Insert ENTRADA (ENTDATA, ENTORIGEM, ENTNUMERONOTA, ENTOBSERVACAO)
VALUES ('2022-27-07', 'Padrao', '001454', 'Menos 1 para jonas. Anote ai Ryandra')
go
Insert ENTRADA (ENTDATA, ENTORIGEM, ENTNUMERONOTA, ENTOBSERVACAO)
VALUES ('2022-27-07', 'Padrao', '002555', 'A nota é minha')
go
Insert ENTRADA (ENTDATA, ENTORIGEM, ENTNUMERONOTA, ENTOBSERVACAO)
VALUES ('2022-27-06', 'Padrao', '002555', 'A nota é minha')
go
Insert ENTRADA (ENTDATA, ENTORIGEM, ENTNUMERONOTA, ENTOBSERVACAO)
VALUES ('2022-30-01', 'Padrao', '0024444', 'Nota 4')

--notas  depois de janeiro de 2022
select  * from ENTRADA where ENTDATA>'2022-31-01'
-- notas notas do mes de junho
select  * from ENTRADA where ENTDATA>'2022-01-06' and  ENTDATA<='2022-30-06'
select * from ENTRADA where MONTH(entdata)= 6 and YEAR(entdata)='2022'

--notas notas no mes de 2022

Select * from ENTRADA where year(entdata)='2022'

--selecionar notas que na observacao contenha o nome Ryandra e do ano de 2022

Select * from ENTRADA where year(entdata)='2022' and ENTOBSERVACAO like '%Ryandra%'

--Selecionar todas as notas que a origem inicia com a letra p

select * from ENTRADA where ENTORIGEM like 'p%'

Create table ITENSENTRADA (
 ITEID INT PRIMARY KEY IDENTITY(1,1),
 ITEQUANTIDADE int not null check(ITEQUANTIDADE>0),
 ITEPRECO numeric(18,2) check (ITEPRECO>0) not null,
 ITETOTAL as ITEQUANTIDADE*ITEPRECO,
 ENTID int not null,
 PROID int not null,
 Foreign key (ENTID) References ENTRADA(ENTID),
 Foreign key (PROID) References PRODUTO(PROID),
 )

 select * from ITENSENTRADA
 select * from PRODUTO
 SELECT * from ENTRADA
 select * from Colaborador
 select * from AREA
 

 insert ITENSENTRADA (ENTID,PROID,ITEQUANTIDADE,ITEPRECO) VALUES (1,2,10,9.50)
 go
 insert ITENSENTRADA (ENTID,PROID,ITEQUANTIDADE,ITEPRECO) VALUES (2,3,5,2.50)

 select I.ITEID'Numero item',E.ENTDATA'DATA',P.PRODESCRICAO'Produto',I.ITEQUANTIDADE'Quantidade',I.ITEPRECO'Valor',I.ITETOTAL'Total' 
 from ITENSENTRADA I join ENTRADA E ON I.ENTID=E.ENTID
 JOIN PRODUTO P ON I.PROID=P.PROID
 
 --Custo da nota de entrada numero 1
 
 select COUNT (i.iteid) 'Qtd de item', sum (i.itetotal) 'Total  da nota' from  ITENSENTRADA i join ENTRADA E ON  I.ENTID=E.ENTID where i.ENTID=2

 create table SAIDA (
  SAIID INT PRIMARY KEY IDENTITY(1,1),
  SAIDATA DATETIME NOT NULL DEFAULT GETDATE (),
  SAIOBERVACAO VARCHAR(1000) null,
  COLID int not null,
  foreign key (COLID) References COLABORADOR(COLID)
 )

 select * from SAIDA
 select * from ITENSENTRADA
 select * from PRODUTO
 SELECT * from ENTRADA
 select * from Colaborador
 select * from AREA

 insert SAIDA(SAIDATA,SAIOBERVACAO,COLID) VALUES ('2022-20-01',null,9)
 go
 insert SAIDA (SAIOBERVACAO,COLID) VALUES ('Alungs itens quebrados',8)
 insert SAIDA (SAIOBERVACAO,COLID) VALUES ('Fragil',7)

 create table ITENSAIDA (
 ITSID int PRIMARY KEY IDENTITY (1,1),
 ITSQUANTIDADE int not null check(ITSQUANTIDADE>0),
 SAIID int,
 PROID INT,
 FOREIGN KEY (SAIID) REFERENCES SAIDA(SAIID),
 FOREIGN KEY(PROID) REFERENCES PRODUTO(PROID),
 )

 select * from ITENSAIDA
 select * from PRODUTO
 select * from SAIDA

 insert ITENSAIDA (ITSQUANTIDADE,SAIID,PROID) Values (2,1,1)
 insert ITENSAIDA (ITSQUANTIDADE,SAIID,PROID) Values (2,2,2)
 insert ITENSAIDA (ITSQUANTIDADE,SAIID,PROID) Values (2,3,3)
 
 --TRIGGER para prova

 select i.*,p.PRODESCRICAO, s.SAIDATA from ITENSAIDA i join PRODUTO p on i.PROID=p.PROID 
 join SAIDA s on i.SAIID=s.SAIID











