use master
go

if exists(Select * FROM SysDataBases WHERE name='Ventas')
BEGIN
	DROP DATABASE Ventas
END
go

CREATE DATABASE Ventas
--ON(
--	NAME=Ventas,
--	FILENAME='C:\Ventas.mdf'
--)
go

USE Ventas
go

-----------------------------------------------------------

CREATE TABLE Articulos
(
	CodArt int PRIMARY KEY,
	NomArt varchar(20) NOT NULL,
	PreArt float NOT NULL
) 
go

-----------------------------------------------------------

Create Procedure AltaArticulo
@cod int,
@nom varchar(20),
@pre float
AS
Begin
	if (exists(select * from Articulos where codArt = @cod))
		return -1
		
	else
	begin
		Insert Articulos(CodARt, NomArt, PreArt) Values (@cod, @nom, @pre)
		if @@ERROR <> 0
			return -2
			
		return 1
	end
end
go


Create Procedure BajaArticulo
@cod int
AS
Begin
	if (not exists(select * from Articulos where codArt = @cod))
		return -1
		
	else
	begin
		Delete From Articulos where codArt = @cod
		if @@ERROR <> 0
		return -2
		
		return 1
	end
end
go


Create Procedure ModArticulo
@cod int,
@nom varchar(20),
@pre float
AS
Begin
	if (not exists(select * from Articulos where codArt = @cod))
		return -1
		
	else
	begin
		Update Articulos Set NomArt=@nom, PreArt=@pre where codArt = @cod
		if @@ERROR <> 0
		return -2
		
		return 1
	end
end
go


Create Procedure BuscoArticulo
@cod int
AS
Begin
	Select *
	From Articulos
	where codArt = @cod
end
go


Create Procedure ListoArticulo
AS
Begin
	Select *
	From Articulos
end
go

-----------------------------------------------------------

Exec AltaArticulo 23, "Licuadora", 2500
go
Exec AltaArticulo 48, "Máquina de Coser", 6700
go
Exec AltaArticulo 514, "Ventilador de Techo Vertical", 250
go
