use PGCKDB;
drop database PGCKDB;
create database PGCKDB;
use PGCKDB;
create table usuarios(
	id int(11) not null auto_increment primary key,
	nome varchar(100) not null,
	nick varchar(40) not null unique,
	email varchar(150) not null,
	senha varchar(32) not null,
	created datetime,
	modified datetime
);
create table configsis(
	id int(11) not null auto_increment primary key,
    tema int(2) null,
	usuario_id int(11) not null,
	foreign key (usuario_id) references usuarios (id)
);
create table fornecedores(
	id int(11) not null auto_increment primary key,
	nome varchar(100) not null unique,
	created datetime,
	modified datetime
);
create table usufor_dados(
	id int(11) not null  auto_increment primary key,
	usuario_id int(11) null unique,
	fornecedor_id int(11) null unique,
	cpf_usufor varchar(32) null unique,
	rg_usufor varchar(32) null unique,
	cnpj_usufor varchar(32) null unique,
	dn_usufor date null,
	rank_usufor int(1) null,
    created datetime,
	modified datetime,
	foreign key (usuario_id) references usuarios (id),
	foreign key (fornecedor_id) references fornecedores (id)
);
create table classe_produtos(
	id int(11) not null auto_increment primary key,
	nvclbase varchar(255) not null, /* Classe base Ex: Alimenticio, Vestuario */
	nvcldesc varchar(255) not null unique, /* Classe descrição Ex: Perecivel, não Perecivel */
);
create table produtos(
	id int(11) not null auto_increment primary key,
	status varchar(1) not null default 'A',
	descr varchar(50) null default null,
	taman varchar(5) null default null,
	estmin int(11) null default null,
	estmax int(11) null default null,
	classe_produto_id int(11) not null,
    created datetime,
	modified datetime,
	foreign key (classe_produto_id) references classe_produtos (id)
);
create table basecalcs(
	id int(11) not null auto_increment primary key,
	valor DECIMAL(9,2) null default '0.00',
	created datetime,
    modified datetime,
    produto_id int(11),
    foreign key (produto_id) references produtos (id)
	
);
create table estoque_produtos(
	id int(11) not null AUTO_INCREMENT primary key,
	produto_id  INT(11) UNIQUE,
	qtde_estoque_produto INT(11) NULL DEFAULT NULL,
	vlrunitcom_estoque_produto  DECIMAL(9,2) NULL DEFAULT '0.00',
	basecalc_id int(11),
	vlrunitven_estoque_produto  DECIMAL(9,2) NULL DEFAULT '0.00',
    created datetime,
	modified datetime,
	foreign key (produto_id) references produtos (id)
    foreign key (basecalc_id) references basecalcs (id)
);
create table status_produtos(
	id INT(11) NOT NULL AUTO_INCREMENT primary key,
	produto_id INT(11) NULL DEFAULT NULL,
	qtde_status_produto INT(11) NULL DEFAULT NULL,
	vlrunit_status_produto DECIMAL(9,2) NULL DEFAULT  '0.00' ,
    vlrtotal_status_produto DECIMAL(9,2) NULL DEFAULT  '0.00' ,
	created datetime,
	modified datetime,
	foreign key (produto_id) references produtos (id),
);
create table transacoes(
	id int(11) not null auto_increment primary key,
	status_produto_id int(11),
    usuario_id int(11) null,
    fornecedor_id int(11) null,
    desc_transacao varchar(50),
    fpgto_transacao varchar(50),
    total_transacao decimal(12,2) null,
    total_prods_transacao int(11) not null,
    created datetime,
	modified datetime,
    foreign key (status_produto_id) references status_produtos (id),
    foreign key (usuario_id) references usuarios (id),
    foreign key (fornecedor_id) references fornecedores (id)
);
create table docs(
	id int(11) not null auto_increment primary key,
	nome_docs varchar(255) not null unique,
	created datetime,
	produto_id INT(11)null default null,
	foreign key (produto_id) references produto (id),
    foreign key (usuario_id) references produto (id)
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
