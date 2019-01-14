CREATE database IF NOT EXISTS RRHH;

USE RRHH;

DROP TABLE IF EXISTS Empleado;
DROP TABLE IF EXISTS Departamento;

CREATE TABLE Departamento
       (numero TINYINT,
        nombre VARCHAR(14),
        ciudad VARCHAR(13),
        PRIMARY KEY(numero));

INSERT INTO Departamento VALUES (10,'Contabilidad','Nueva York');
INSERT INTO Departamento VALUES (20,'Investigacion','Dallas');
INSERT INTO Departamento VALUES (30,'Ventas','Chicago');
INSERT INTO Departamento VALUES (40,'Operaciones','Boston');

CREATE TABLE Empleado
       (numero INT NOT NULL,
        nombre VARCHAR(10),
        empleo VARCHAR(9),
        jefe INT,
        fechaEntrada DATE,
        sueldo FLOAT,
        complemento FLOAT,
        numeroDepartamento TINYINT,
        PRIMARY KEY(numero),
        FOREIGN KEY (numeroDepartamento) REFERENCES Departamento(numero) );

INSERT INTO Empleado VALUES
        (7369,'Smith','Ordenanza',7902,'2000-12-17',800,NULL,20);
INSERT INTO Empleado VALUES
        (7499,'Allen','Vendedor',7698,'2001-02-20',1600,300,30);
INSERT INTO Empleado VALUES
        (7521,'Ward','Vendedor',7698,'2001-02-22',1250,500,30);
INSERT INTO Empleado VALUES
        (7566,'Jones','Directivo',7839,'2001-04-02',2975,NULL,20);
INSERT INTO Empleado VALUES
        (7654,'Martin','Vendedor',7698,'2001-09-28',1250,1400,30);
INSERT INTO Empleado VALUES
        (7698,'Blake','Directivo',7839,'2001-05-01',2850,NULL,30);
INSERT INTO Empleado VALUES
        (7782,'Clark','Directivo',7839,'2001-06-09',2450,NULL,10);
INSERT INTO Empleado VALUES
        (7788,'Scott','Analista',7566,'2002-12-09',3000,NULL,20);
INSERT INTO Empleado VALUES
        (7839,'King','Director',NULL,'2001-11-17',5000,NULL,10);
INSERT INTO Empleado VALUES
        (7844,'Turner','Vendedor',7698,'2001-09-08',1500,0,30);
INSERT INTO Empleado VALUES
        (7876,'Adams','Ordenanza',7788,'2003-01-12',1100,NULL,20);
INSERT INTO Empleado VALUES
        (7900,'James','Ordenanza',7698,'2001-12-03',950,NULL,30);
INSERT INTO Empleado VALUES
        (7902,'Ford','Analista',7566,'2001-12-03',3000,NULL,20);
INSERT INTO Empleado VALUES
        (7934,'Miller','Ordenanza',7782,'2002-01-23',1300,NULL,10);
        