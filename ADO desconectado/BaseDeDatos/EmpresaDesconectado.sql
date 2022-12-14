Use Master

if exists(Select * FROM SysDataBases WHERE name='Empresa')
BEGIN
	DROP DATABASE Empresa
END
go

create database Empresa 
--on(
--	name = 'Empresa',
--	filename = 'c:\Empresa.mdf'
--)
go

USE  Empresa
go

---------------------------------------------------------------------

CREATE TABLE Empresas
(
	ruc int PRIMARY KEY,
	nombre varchar(50)not null,
)
GO

CREATE TABLE  Empleados
(
	 cedula int PRIMARY KEY ,
	 nombre varchar(50) not null,
	 edad int not null,
	 sueldo float not null,
	 casado bit not null,
	 trabajaEn int not null FOREIGN KEY REFERENCES Empresas(ruc) 
)
go

---------------------------------------------------------------------

CREATE PROCEDURE ListarEmpresas
AS
Begin
	SELECT * 
	FROM Empresas
End
go

CREATE PROCEDURE EmpleadosPorRuc
@Ruc int
AS
Begin
	SELECT * 
	FROM Empleados
	WHERE TrabajaEn = @Ruc
End
go 

CREATE PROCEDURE BuscarEmpleado
@cedula int
AS
Begin
	Select *
	From Empleados
	Where cedula = @cedula
End
go

CREATE PROCEDURE BuscarEmpresa
@ruc int
AS
Begin
	Select *
	From Empresas
	Where ruc = @ruc
End
go

---------------------------------------------------------------------

INSERT INTO Empresas(ruc   ,nombre)VALUES (11111111,'RochaTur');
INSERT INTO Empresas(ruc   ,nombre)VALUES (22222222,'Mar y Playa');
INSERT INTO Empresas(ruc   ,nombre)VALUES (33333333,'Palmares de Rocha');
INSERT INTO Empresas(ruc   ,nombre)VALUES (44444444,'Rulemanes');
go

INSERT INTO   Empleados (cedula, nombre, edad, sueldo, casado,	trabajaEn) VALUES(1111111,'Lia I',11,11111.11,1,11111111);
INSERT INTO   Empleados (cedula, nombre, edad, sueldo, casado,	trabajaEn) VALUES(2222222,'Mia II',22,22222.22,0,22222222);
INSERT INTO   Empleados (cedula, nombre, edad, sueldo, casado,	trabajaEn) VALUES(3333333,'Rosa III',33,33333.33,1,11111111);
INSERT INTO   Empleados (cedula, nombre, edad, sueldo, casado,	trabajaEn) VALUES(4444444,'Juan IV',44,44444.44,0,11111111);
INSERT INTO   Empleados (cedula, nombre, edad, sueldo, casado,	trabajaEn) VALUES(5555555,'Ana V',55,55555.55,1,22222222);
go
