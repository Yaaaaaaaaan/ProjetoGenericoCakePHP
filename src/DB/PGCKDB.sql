use PGCKDB;
drop database PGCKDB;
create database PGCKDB;
use PGCKDB;
create table usuarios(
	id int(11) not null auto_increment primary key,
	nome_usuario varchar(100) not null,
	nick_usuario varchar(40) not null unique,
	email_usuario varchar(150) not null,
	senha_usuario varchar(32) not null,
	created datetime,
	modified datetime
);
create table fornecedores(
	id int(11) not null auto_increment primary key,
	nome_fornecedor varchar(100) not null unique,
	created datetime,
	modified datetime
);
create table us_fo_dados(
	id int(11) not null  auto_increment primary key,
	usuario_id int(11) null unique,
	fornecedor_id int(11) null unique,
	cpf_us_fo_dado varchar(32) null unique,
	rg_us_fo_dado varchar(32) null unique,
	cnpj_us_fo_dado varchar(32) null unique,
	dn_us_fo_dado date null,
	rank_us_fo_dado int(1) null,
    created datetime,
	modified datetime,
	foreign key (usuario_id) references usuarios (id),
	foreign key (fornecedor_id) references fornecedores (id)
);
create table classe_produtos(
	id int(11) not null auto_increment primary key,
	ncb_classe_produto varchar(255) not null, /* Ex: Alimenticio, Vestuario */
	ncd_classe_produto varchar(255) not null unique, /* Ex: Perecivel, não Perecivel */
);
create table produtos(
	id int(11) not null auto_increment primary key,
	status_produto varchar(1) not null default 'A',
	desc_produto varchar(50) null default null,
	tam_produto varchar(5) null default null,
	estMin_produto int(11) null default null,
	estMax_produto int(11) null default null,
	classe_produto_id int(11) not null,
    created datetime,
	modified datetime,
	foreign key (classe_produto_id) references classe_produtos (id)
);
create table entradaProduto(
	id INT(11) NOT NULL AUTO_INCREMENT primary key,
	produto_id INT(11) NULL DEFAULT NULL,
	qtde INT(11) NULL DEFAULT NULL,
	vlrUnit DECIMAL(9,2) NULL DEFAULT  '0.00' ,
	created datetime,
	modified datetime,
	foreign key (produto_id) references produtos (id),
);
create table baseCalc(
	codBaseCalc int(11) not null auto_increment primary key,
	baseCalc DECIMAL(9,2) null default '0.00',
	dataIncl datetime default current_timestamp,
	idUsuarioFkBasC int(11),
	foreign key (idUsuarioFkBasC) references usuario (idUsuario)
);
create table configSistema(
	codConfigSistema int(11) not null auto_increment primary key,
	descConf int(11) not null,
	idUsuarioFkConfS int(11) not null,
	foreign key (idUsuarioFkConfS) references usuario (idUsuario)
);
create table estoque(
	codEst int(11) not null AUTO_INCREMENT primary key,
	codProdFkEst  INT(11) UNIQUE,
	qtde  INT(11) NULL DEFAULT NULL,
	vlrUnitCom  DECIMAL(9,2) NULL DEFAULT '0.00',
	baseCalc DECIMAL(9,2) null default '0.00',
	vlrUnitVen  DECIMAL(9,2) NULL DEFAULT '0.00',
	foreign key (codProdFkEst) references produto (codProd)
);
create table saidaProduto (
	codSaiProd INT(11) NOT NULL AUTO_INCREMENT primary key,
	codProdFkSai INT(11) NULL DEFAULT NULL,
	qtde INT(11) NULL DEFAULT NULL,
	dataSai datetime default current_timestamp,
	vlrUnit DECIMAL(9,2) NULL DEFAULT '0.00',
	idUsuarioFkSai int(11),
	foreign key (codProdFkSai) references produto (codProd),
	foreign key (idUsuarioFkSai) references usuario (idUsuario)
);
create table transacao(
	codTransacao Int(11) not null auto_increment primary key
	
);
create table docs(
	codDocs int(11) not null auto_increment primary key,
	nomeDocs varchar(255) not null unique,
	dataInclusaoDocs datetime default current_timestamp,
	codProdFkDocs INT(11)null default null,
	foreign key (codProdFkDocs) references produto (codProd)
);  
create table configUsuario(
	codConfigUsuario int(11) not null auto_increment primary key,
	idUsuarioFkConf int(11) not null unique,
	layoutUsuarioConf varchar(255) not null,
	codImgPrincUsuarioConf int(11) not null,
	foreign key (idUsuarioFkConf) references usuario (idUsuario),
	foreign key (codImgPrincUsuarioConf) references docs (codDocs)
);
create table historico(
	codHist int(11) not null auto_increment primary key,
	nomeTablHist varchar(255) not null,
	codLinhaInfoHist int(11) not null,
	descHist varchar(255) not null,
	infoAnte varchar(255) null,
	idUsuarioFkHist int(11) not null,
	dataHist datetime default current_timestamp,
	foreign key (idUsuarioFkHist) references usuario (idUsuario)
);
