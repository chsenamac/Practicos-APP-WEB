use master
go

------------------------------------------------------------------------------------------------------------------
-- Determina si está la base de datos Biblioteca y la borra
if exists(Select * FROM SysDataBases WHERE name='Biblioteca')
BEGIN
	DROP DATABASE Biblioteca
END
go

-- Crea la base de datos Biblioteca en el lugar especificado
CREATE DATABASE Biblioteca
--ON
--(
--	NAME=Biblioteca,
--	FILENAME='c:\Biblioteca.mdf'
--)
go

------------------------------------------------------------------------------------------------------------------
-- Pone en uso la BD
USE Biblioteca
go

-- Creación de tablas
CREATE TABLE Publicaciones
(
	ISBN int PRIMARY KEY CHECK(ISBN > 0),
	Titulo varchar(20) NOT NULL
) 
go

CREATE TABLE Papel
(
	ISBN int PRIMARY KEY,
	Peso float NOT NULL CHECK(Peso > 0),
	FOREIGN KEY (ISBN) REFERENCES Publicaciones(ISBN)
) 
go

CREATE TABLE Digital
(
	ISBN int PRIMARY KEY,
	Formato varchar(3) NOT NULL,
	Protegida bit NOT NULL,
	FOREIGN KEY (ISBN) REFERENCES Publicaciones(ISBN)
) 
go

CREATE TABLE Prestamos
(
	Numero int PRIMARY KEY IDENTITY(1,1),
	Fecha datetime NOT NULL DEFAULT GETDATE(),
	Vencimiento datetime NOT NULL,
	Nombre varchar(20) NOT NULL,
	ISBN int NOT NULL FOREIGN KEY (ISBN) REFERENCES Publicaciones(ISBN),
	Devuelto bit NOT NULL DEFAULT 0,
	CHECK (CONVERT(date, Fecha) <= CONVERT(date, GETDATE()))
 )
go

------------------------------------------------------------------------------------------------------------------
-- Datos de prueba

INSERT INTO Publicaciones(ISBN ,Titulo)VALUES (1,'T 1')
INSERT INTO Publicaciones(ISBN ,Titulo)VALUES (2,'T 2')
INSERT INTO Publicaciones(ISBN ,Titulo)VALUES (3,'T 3')
INSERT INTO Publicaciones(ISBN ,Titulo)VALUES (4,'T 4')
INSERT INTO Publicaciones(ISBN ,Titulo)VALUES (5,'T 5')
INSERT INTO Publicaciones(ISBN ,Titulo)VALUES (6,'T 6')
INSERT INTO Publicaciones(ISBN ,Titulo)VALUES (7,'T 7')
INSERT INTO Publicaciones(ISBN ,Titulo)VALUES (8,'T 8')
INSERT INTO Publicaciones(ISBN ,Titulo)VALUES (9,'T 9')
INSERT INTO Publicaciones(ISBN ,Titulo)VALUES (10,'T 10')
INSERT INTO Publicaciones(ISBN ,Titulo)VALUES (11,'T 10')
INSERT INTO Publicaciones(ISBN ,Titulo)VALUES (12,'T 12')
INSERT INTO Publicaciones(ISBN ,Titulo)VALUES (13,'T 12')
INSERT INTO Publicaciones(ISBN ,Titulo)VALUES (14,'T 13')
INSERT INTO Publicaciones(ISBN ,Titulo)VALUES (15,'T 13')
go

INSERT INTO Papel(ISBN ,Peso ) VALUES (2,22)
INSERT INTO Papel(ISBN ,Peso ) VALUES (4,44)
INSERT INTO Papel(ISBN ,Peso ) VALUES (6,66)
INSERT INTO Papel(ISBN ,Peso ) VALUES (8,88)
INSERT INTO Papel(ISBN ,Peso ) VALUES (10,55)
INSERT INTO Papel(ISBN ,Peso ) VALUES (12,66)
INSERT INTO Papel(ISBN ,Peso ) VALUES (14,33)
go

INSERT INTO Digital(ISBN ,Formato ,Protegida ) VALUES (1,'DOC',1)
INSERT INTO Digital(ISBN ,Formato ,Protegida ) VALUES (3,'PDF',0)
INSERT INTO Digital(ISBN ,Formato ,Protegida ) VALUES (5,'DOC',0)
INSERT INTO Digital(ISBN ,Formato ,Protegida ) VALUES (7,'DOC',1)
INSERT INTO Digital(ISBN ,Formato ,Protegida ) VALUES (9,'PDF',1)
INSERT INTO Digital(ISBN ,Formato ,Protegida ) VALUES (11,'DOC',0)
INSERT INTO Digital(ISBN ,Formato ,Protegida ) VALUES (13,'PDF',1)
INSERT INTO Digital(ISBN ,Formato ,Protegida ) VALUES (15,'PDF',1)
go

-- DEVUELTOS
INSERT INTO Prestamos(Fecha ,Vencimiento ,Nombre ,ISBN, Devuelto) VALUES('20220613','20220614','Ana Aosa',1,1)
INSERT INTO Prestamos(Fecha ,Vencimiento ,Nombre ,ISBN, Devuelto) VALUES('20221030','20221109','Lia Sosa',1,1)
INSERT INTO Prestamos(Fecha ,Vencimiento ,Nombre ,ISBN, Devuelto) VALUES('20220613','20220614','Ana Rocha',2,1)
INSERT INTO Prestamos(Fecha ,Vencimiento ,Nombre ,ISBN, Devuelto) VALUES('20221030','20221109','Lia Rocha',2,1)
go

-- NO DEVUELTOS
INSERT INTO Prestamos(Fecha ,Vencimiento ,Nombre ,ISBN, Devuelto) VALUES('20220613','20220614','José Rocha',3,0)
INSERT INTO Prestamos(Fecha ,Vencimiento ,Nombre ,ISBN, Devuelto) VALUES('20221030','20221109','Mario Sosa',5,0)
INSERT INTO Prestamos(Fecha ,Vencimiento ,Nombre ,ISBN, Devuelto) VALUES('20220613','20220614','Mario Rocha',4,0)
INSERT INTO Prestamos(Fecha ,Vencimiento ,Nombre ,ISBN, Devuelto) VALUES('20221020','20221030','José Sosa',6,0)
INSERT INTO Prestamos(Fecha ,Vencimiento ,Nombre ,ISBN, Devuelto) VALUES('20220920','20220930','José Sosa',9,0)
INSERT INTO Prestamos(Fecha ,Vencimiento ,Nombre ,ISBN, Devuelto) VALUES('20221001','20231001','José Sosa',10,0)
go

-- PRESTADOS DOS VECES
INSERT INTO Prestamos(Fecha ,Vencimiento ,Nombre ,ISBN, Devuelto) VALUES('20220612','20220613','Ana Sosa',7,1)
INSERT INTO Prestamos(Fecha ,Vencimiento ,Nombre ,ISBN, Devuelto) VALUES('20220613','20220614','Ana Sosa',7,1)
INSERT INTO Prestamos(Fecha ,Vencimiento ,Nombre ,ISBN, Devuelto) VALUES('20221030','20221109',' Ana Sosa',7,0)
INSERT INTO Prestamos(Fecha ,Vencimiento ,Nombre ,ISBN, Devuelto) VALUES('20220612','20220613','Ana Sosa',8,1)
INSERT INTO Prestamos(Fecha ,Vencimiento ,Nombre ,ISBN, Devuelto) VALUES('20220613','20220614','Ana Sosa',8,0)
go

------------------------------------------------------------------------------------------------------------------
-- Publicaciones

CREATE PROCEDURE EliminarPublicacion
@ISBN int
AS
BEGIN 
	
	IF NOT EXISTS (SELECT ISBN FROM Publicaciones WHERE ISBN = @ISBN)
		RETURN -1

	IF EXISTS (SELECT ISBN FROM Prestamos WHERE ISBN = @ISBN)
		RETURN -2

	DECLARE @Error int

	BEGIN TRAN
	DELETE Papel WHERE  ISBN = @ISBN 
	SET @Error = @@ERROR
	
	DELETE Digital	WHERE  ISBN = @ISBN
	SET @Error += @@ERROR
	
	DELETE Publicaciones WHERE  ISBN = @ISBN
	SET @Error += @@ERROR
	
	IF(@Error = 0)
	BEGIN
		COMMIT TRAN
		RETURN 1
	END
	
	ELSE
	BEGIN
		ROLLBACK TRAN
		RETURN -3
	END	
end
go

----------------------------------------------------------------------
-- Papel

CREATE PROCEDURE AgregarPublicacionPapel
@ISBN int,
@Titulo varchar(20),
@Peso float
AS
BEGIN 
	if EXISTS (SELECT ISBN FROM Publicaciones WHERE ISBN = @ISBN)
		RETURN -1

	DECLARE @Error int
	
	BEGIN TRAN

	INSERT Publicaciones(ISBN, Titulo) VALUES(@ISBN, @Titulo)
	SET @Error = @@ERROR

	INSERT Papel(ISBN, Peso) VALUES(@ISBN, @Peso)
	SET @Error += @@ERROR

	IF(@Error = 0)
	BEGIN
		COMMIT TRAN
		RETURN 1
	END
	
	ELSE
	BEGIN
		ROLLBACK TRAN
		RETURN -2
	END	
END
go

--------------------------------------------------------------------------------

CREATE PROCEDURE BuscarPublicacionPapel
@ISBN int
AS
BEGIN 
	SELECT PU.*, Peso  
	FROM Papel AS PA INNER JOIN Publicaciones AS PU
	ON PA.ISBN = PU.ISBN
	AND PU.ISBN = @ISBN
END
go

--------------------------------------------------------------------------------------

CREATE PROCEDURE ModificarPublicacionPapel
@ISBN int,
@Titulo varchar(20),
@Peso float
AS
BEGIN 
	if NOT EXISTS (SELECT ISBN FROM Papel WHERE ISBN = @ISBN)
		RETURN -1
	
	DECLARE @Error int
	
	BEGIN TRAN

	UPDATE Papel SET Peso = @Peso
	WHERE ISBN = @ISBN
	SET @Error = @@ERROR

	UPDATE Publicaciones 
	SET Titulo = @Titulo	
	WHERE ISBN = @ISBN
	SET @Error += @@ERROR

	IF(@Error = 0)
	BEGIN
		COMMIT TRAN
		RETURN 1
	END
	
	ELSE
	BEGIN
		ROLLBACK TRAN
		RETURN -2
	END	
END
go

----------------------------------------------------------------------

CREATE PROCEDURE ListarPublicacionesPapel 
AS
BEGIN 
	SELECT PU.*, Peso  
	FROM Papel AS PA INNER JOIN Publicaciones AS PU
	ON PA.ISBN = PU.ISBN
END
go

----------------------------------------------------------------------

CREATE PROCEDURE ListarPapelesDisponibles 
AS
BEGIN 
	SELECT PU.*, Peso  
	FROM Papel AS PA INNER JOIN Publicaciones AS PU
	ON PA.ISBN = PU.ISBN
	AND PA.ISBN NOT IN (SELECT ISBN FROM Prestamos WHERE Devuelto = 0)
END
go

----------------------------------------------------------------------
-- Digital

CREATE PROCEDURE AgregarPublicacionDigital
@ISBN int,
@Titulo varchar(20),
@Formato varchar(3),
@Protegida bit
AS
BEGIN 
	if EXISTS (SELECT ISBN FROM Publicaciones WHERE ISBN = @ISBN)
		RETURN -1

	DECLARE @Error int
	
	BEGIN TRAN

	INSERT Publicaciones(ISBN, Titulo) VALUES(@ISBN, @Titulo)
	SET @Error = @@ERROR

	INSERT Digital(ISBN, Formato, Protegida) VALUES(@ISBN, @Formato, @Protegida)
	SET @Error += @@ERROR

	IF(@Error = 0)
	BEGIN
		COMMIT TRAN
		RETURN 1
	END
	
	ELSE
	BEGIN
		ROLLBACK TRAN
		RETURN -2
	END	
END
go

---------------------------------------------------------------------------------------

CREATE PROCEDURE BuscarPublicacionDigital
@ISBN int
AS
BEGIN 
	SELECT PU.*, Formato, Protegida
	FROM Digital AS PD INNER JOIN Publicaciones AS PU
	ON PD.ISBN = PU.ISBN
	AND PU.ISBN = @ISBN
END
go

------------------------------------------------------------------------------------------

CREATE PROCEDURE ModificarPublicacionDigital
@ISBN int,
@Titulo varchar(20),
@Formato varchar(3),
@Protegida bit
AS
BEGIN 
	if NOT EXISTS (SELECT ISBN FROM Digital WHERE ISBN=@ISBN)
		RETURN -1

	DECLARE @Error int
	
	BEGIN TRAN

	UPDATE Digital 
	SET Formato = @Formato, Protegida = @Protegida 
	WHERE ISBN = @ISBN
	SET @Error = @@ERROR

	UPDATE Publicaciones 
	SET Titulo = @Titulo 
	WHERE ISBN = @ISBN
	SET @Error += @@ERROR

	IF(@Error = 0)
	BEGIN
		COMMIT TRAN
		RETURN 1
	END
	
	ELSE
	BEGIN
		ROLLBACK TRAN
		RETURN -2
	END	
END
go

----------------------------------------------------------------

CREATE PROCEDURE ListarPublicacionesDigital
AS
BEGIN 
	SELECT PU.*, Formato, Protegida
	FROM Digital AS PD INNER JOIN Publicaciones AS PU
	ON PD.ISBN = PU.ISBN
END
go

-----------------------------------------------------------------

CREATE PROCEDURE ListarDigitalesDisponibles
AS
BEGIN 
	SELECT PU.*, Formato, Protegida
	FROM Digital AS PD INNER JOIN Publicaciones AS PU
	ON PD.ISBN = PU.ISBN
	AND PD.ISBN NOT IN (SELECT ISBN FROM Prestamos WHERE Devuelto = 0)
END
go

-----------------------------------------------------------------
-- Préstamos

CREATE PROCEDURE AgregarPrestamo 
@Vencimiento datetime,
@Nombre varchar(20),
@ISBN int  
AS
BEGIN 
	-- Restricción de la acción, no del dato en sí
	if CONVERT(date, @Vencimiento) <= CONVERT(date, GETDATE())
		RETURN -1

	if NOT EXISTS (SELECT ISBN FROM Publicaciones WHERE ISBN = @ISBN)
		RETURN -2
		
	if EXISTS (SELECT ISBN FROM Prestamos WHERE ISBN = @ISBN AND Devuelto = 0)
		RETURN -3
	
	INSERT INTO Prestamos(Vencimiento, Nombre, ISBN) VALUES(@Vencimiento, @Nombre, @ISBN)
	IF(@@Error = 0)
		RETURN ident_current('Prestamos')
		
	ELSE
		RETURN -4
END
go

----------------------------------------------------------------------------------------------

CREATE PROCEDURE BuscarPrestamo 
@Numero int 
AS
BEGIN 
	SELECT *
	FROM Prestamos 
	WHERE Numero = @Numero
END
go

----------------------------------------------------------------------------

CREATE PROCEDURE DevolverPrestamo 
@Numero int 
AS
BEGIN 
	DECLARE @Devuelto bit
	
	SELECT @Devuelto = Devuelto FROM Prestamos WHERE Numero = @Numero
	IF @Devuelto IS NULL
		RETURN -1
	
	ELSE IF @Devuelto = 1
		RETURN -2

	UPDATE Prestamos
	SET Devuelto = 1
	WHERE Numero = @Numero
	return @@rowcount
END
go

--------------------------------------------------------------------

CREATE PROCEDURE ListarPrestamos 
AS
BEGIN 
	SELECT *   
	FROM Prestamos
END
go

---------------------------------------------------------------------

CREATE PROCEDURE ListarPrestamosNodevueltos 
AS
BEGIN 
	SELECT *  
	FROM Prestamos
	WHERE Devuelto = 0
END
go

--------------------------------------------------------------------

CREATE PROCEDURE ListarPrestamosVencidos 
@FechaLimite datetime
AS
BEGIN 
	SELECT * 
	FROM Prestamos
	WHERE Vencimiento < @FechaLimite
	AND Devuelto = 0
END
go

--select * from Prestamos

