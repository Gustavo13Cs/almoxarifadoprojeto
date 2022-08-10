--DDL BANCO DE DADOS

Create Table AREA (
AREID int identity(1,1) Primary key,
AREDESCRICAO VARCHAR(100) NOT NULL,
)

create table Colaborador (
 colid int identity(1,1) Primary key,
 colnome varchar(100) not null,
 colcargo varchar(100) null,
 Areid int,
 Foreign key (Areid) References Area(Areid)
)

Create table PRODUTO(
PROID INT PRIMARY KEY IDENTITY (1,1),
PRODESCRICAO VARCHAR(100) NOT NULL,
PROMINIMO INT DEFAULT  0 CHECK (PROMINIMO>=0),
PROMAXIMO INT DEFAULT 0 CHECK (PROMAXIMO>=0),
PROESTOQUE INT DEFAULT 0 CHECK (PROESTOQUE>=0)
) 

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