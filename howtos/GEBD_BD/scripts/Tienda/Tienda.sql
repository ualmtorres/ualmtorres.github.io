CREATE DATABASE IF NOT EXISTS Tienda;

USE Tienda;

CREATE TABLE IF NOT EXISTS Que(
	id int NULL,
	producto varchar(60) NULL,
	tamanoEnvase varchar(20) NULL,
	marca varchar(50) NULL,
	variedad varchar(50) NULL,
	familia varchar(50) NULL,
	seccion varchar(50) NULL,
	tipoEnvase varchar(20) NULL,
	unidadMedida varchar(20) NULL,
	PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Donde(
	id int NULL,
	tienda varchar(50) NULL,
	poblacion varchar(20) NULL,
	provincia varchar(20) NULL,
	comunidadAutonoma varchar(20) NULL,
	regionVentas varchar(20) NULL,
	PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Cuando(
	id int NULL,
	fecha date NULL,
	diaMes int NULL,
	diaAno int NULL,
	diaSemana varchar(12) NULL,
	diaSemanaNumero int NULL,
	mesNombre varchar(12) NULL,
	mesNumero int NULL,
	ano int NULL,
	PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Venta(
	idCuando int NULL,
	idQue int NULL,
	idDonde int NULL,
	importe float NULL,
	unidades int NULL,
	coste float NULL,
	clientes int NULL,
	PRIMARY KEY(idCuando, idDonde, idQue)
);
