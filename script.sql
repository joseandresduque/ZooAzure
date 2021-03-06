USE [master]
GO
/****** Object:  Database [zoodb]    Script Date: 15/12/2017 18:08:01 ******/
CREATE DATABASE [zoodb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'zoodb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\zoodb.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'zoodb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\zoodb_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [zoodb] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [zoodb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [zoodb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [zoodb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [zoodb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [zoodb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [zoodb] SET ARITHABORT OFF 
GO
ALTER DATABASE [zoodb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [zoodb] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [zoodb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [zoodb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [zoodb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [zoodb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [zoodb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [zoodb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [zoodb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [zoodb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [zoodb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [zoodb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [zoodb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [zoodb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [zoodb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [zoodb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [zoodb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [zoodb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [zoodb] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [zoodb] SET  MULTI_USER 
GO
ALTER DATABASE [zoodb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [zoodb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [zoodb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [zoodb] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [zoodb]
GO
/****** Object:  User [testuser]    Script Date: 15/12/2017 18:08:01 ******/
CREATE USER [testuser] FOR LOGIN [testuser] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [testuser]
GO
/****** Object:  StoredProcedure [dbo].[ActualizarClasificaciones]    Script Date: 15/12/2017 18:08:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  create procedure [dbo].[ActualizarClasificaciones]
  	@idClasificacion int,
	@denominacion nvarchar(50)
as
begin
	UPDATE Clasificaciones SET denominacion = @denominacion where idClasificacion = @idClasificacion
end;

GO
/****** Object:  StoredProcedure [dbo].[ActualizarTiposAnimal]    Script Date: 15/12/2017 18:08:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  create procedure [dbo].[ActualizarTiposAnimal]
  	@idTipoAnimal int,
	@denominacion nvarchar(50)
as
begin
	UPDATE TiposAnimal SET denominacion = @denominacion where idTipoAnimal = @idTipoAnimal
end;
GO
/****** Object:  StoredProcedure [dbo].[EliminarClasificaciones]    Script Date: 15/12/2017 18:08:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[EliminarClasificaciones]
    @idClasificacion int
AS
BEGIN
    DELETE FROM Clasificaciones WHERE idClasificacion = @idClasificacion 
END;

GO
/****** Object:  StoredProcedure [dbo].[EliminarEspecie]    Script Date: 15/12/2017 18:08:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[EliminarEspecie]
    @idEspecie bigint
AS
BEGIN
    DELETE FROM Especies WHERE idEspecie = @idEspecie
END;
GO
/****** Object:  StoredProcedure [dbo].[EliminarTipoAnimal]    Script Date: 15/12/2017 18:08:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[EliminarTipoAnimal]
    @idTipoAnimal bigint
AS
BEGIN
    DELETE FROM TiposAnimal WHERE idTipoAnimal = @idTipoAnimal 
END;
GO
/****** Object:  StoredProcedure [dbo].[Get_Clasificaciones]    Script Date: 15/12/2017 18:08:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create procedure [dbo].[Get_Clasificaciones]
  as
  Begin
	select idClasificacion, denominacion from Clasificaciones
  end;

GO
/****** Object:  StoredProcedure [dbo].[Get_Clasificaciones_Id]    Script Date: 15/12/2017 18:08:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  create procedure [dbo].[Get_Clasificaciones_Id] 
	@idClasificacion int
  as
  Begin
	select idClasificacion, denominacion from Clasificaciones
		where idClasificacion = @idClasificacion
  end;
  
 --- exec Get_Clasificaciones_Id 2

GO
/****** Object:  StoredProcedure [dbo].[Get_Especies]    Script Date: 15/12/2017 18:08:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure  [dbo].[Get_Especies]
  as
  Begin
	SELECT e.idEspecie, c.idClasificacion,c.denominacion as ClasificacionDenominacion,tp.idTipoAnimal, 
	       tp.denominacion as AnimalDenominacion,e.nombre,e.nPatas,e.esMascotas
		FROM Especies as e
		inner join Clasificaciones as c 
		on e.idClasificacion = c.idClasificacion
		inner join TiposAnimal as  tp 
		on e.idTipoAnimal = tp.idTipoAnimal
		group by 
			e.idEspecie,
			c.idClasificacion, 
			c.denominacion,
			tp.idTipoAnimal, 
			tp.denominacion,
			e.nombre,
			e.nPatas,
			e.esMascotas
		order by e.nombre
  end;

GO
/****** Object:  StoredProcedure [dbo].[Get_Especies_Id]    Script Date: 15/12/2017 18:08:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  --exec Get_TiposAnimal_Id 3
  

   create procedure [dbo].[Get_Especies_Id]
	@idEspecie bigint
	  as
  Begin
	SELECT e.idEspecie, c.idClasificacion,c.denominacion as ClasificacionDenominacion,tp.idTipoAnimal, 
	       tp.denominacion as AnimalDenominacion,e.nombre,e.nPatas,e.esMascotas
		FROM Especies as e
		inner join Clasificaciones as c 
		on e.idClasificacion = c.idClasificacion
		inner join TiposAnimal as  tp 
		on e.idTipoAnimal = tp.idTipoAnimal
		where e.idEspecie = @idEspecie
		group by 
			e.idEspecie,
			c.idClasificacion, 
			c.denominacion,
			tp.idTipoAnimal, 
			tp.denominacion,
			e.nombre,
			e.nPatas,
			e.esMascotas
		order by e.nombre
  end;

 -- exec Get_Especies_Id 6


GO
/****** Object:  StoredProcedure [dbo].[Get_TiposAnimal]    Script Date: 15/12/2017 18:08:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  create procedure [dbo].[Get_TiposAnimal]
  as
  Begin
	select idTipoAnimal, denominacion from TiposAnimal
  end;
  
GO
/****** Object:  StoredProcedure [dbo].[Get_TiposAnimal_Id]    Script Date: 15/12/2017 18:08:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  create procedure [dbo].[Get_TiposAnimal_Id]
	@idTipoAnimal bigint
  as
  Begin
	select idTipoAnimal, denominacion from TiposAnimal
		where idTipoAnimal = @idTipoAnimal
  end;

GO
/****** Object:  StoredProcedure [dbo].[GetClasiAnimal]    Script Date: 15/12/2017 18:08:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetClasiAnimal]
AS
BEGIN
	select 'clasificacion' tipo, c.idClasificacion as id, c.denominacion
	from Clasificaciones as c 
	union all
	select 'tipoAnimal' tipo, ta.idTipoAnimal as id, ta.denominacion
	from TiposAnimal as ta 
END

GO
/****** Object:  StoredProcedure [dbo].[InsertarClasificacion]    Script Date: 15/12/2017 18:08:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[InsertarClasificacion]
	@denominacion nvarchar(50)
AS
BEGIN
	INSERT [dbo].[Clasificaciones] ( [denominacion]) VALUES (@denominacion)
END;

GO
/****** Object:  StoredProcedure [dbo].[InsertarEspecie]    Script Date: 15/12/2017 18:08:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[InsertarEspecie]
	 @idClasificacion int
	,@idTipoAnimal bigint
	,@nombre nvarchar(50)
	,@nPatas smallint
	,@esMascotas bit
as
Begin
INSERT INTO Especies (
		  idClasificacion
		 ,idTipoAnimal
		 ,nombre  
		 ,nPatas
		 ,esMascotas
		 )
		 values(
		  @idClasificacion
		 ,@idTipoAnimal
		 ,@nombre
		 ,@nPatas
		 ,@esMascotas
		 )
end;



GO
/****** Object:  StoredProcedure [dbo].[InsertarTipoAnimal]    Script Date: 15/12/2017 18:08:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[InsertarTipoAnimal]
	@denominacion nvarchar(50)
AS
BEGIN
	INSERT [dbo].[TiposAnimal] ( [denominacion]) VALUES (@denominacion)
END;

GO
/****** Object:  Table [dbo].[Clasificaciones]    Script Date: 15/12/2017 18:08:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clasificaciones](
	[idClasificacion] [int] IDENTITY(1,1) NOT NULL,
	[denominacion] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Clasificaciones] PRIMARY KEY CLUSTERED 
(
	[idClasificacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Especies]    Script Date: 15/12/2017 18:08:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Especies](
	[idEspecie] [bigint] IDENTITY(1,1) NOT NULL,
	[idClasificacion] [int] NOT NULL,
	[idTipoAnimal] [bigint] NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
	[nPatas] [smallint] NOT NULL,
	[esMascotas] [bit] NOT NULL,
 CONSTRAINT [PK_Especies] PRIMARY KEY CLUSTERED 
(
	[idEspecie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TiposAnimal]    Script Date: 15/12/2017 18:08:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TiposAnimal](
	[idTipoAnimal] [bigint] IDENTITY(1,1) NOT NULL,
	[denominacion] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_TiposAnimal] PRIMARY KEY CLUSTERED 
(
	[idTipoAnimal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Clasificaciones] ON 

INSERT [dbo].[Clasificaciones] ([idClasificacion], [denominacion]) VALUES (1, N'Ovíparos')
INSERT [dbo].[Clasificaciones] ([idClasificacion], [denominacion]) VALUES (2, N'Vivíparos')
INSERT [dbo].[Clasificaciones] ([idClasificacion], [denominacion]) VALUES (3, N'Ovovivíparos')
INSERT [dbo].[Clasificaciones] ([idClasificacion], [denominacion]) VALUES (4, N'Omnívoros')
INSERT [dbo].[Clasificaciones] ([idClasificacion], [denominacion]) VALUES (5, N'Carnívoros')
INSERT [dbo].[Clasificaciones] ([idClasificacion], [denominacion]) VALUES (6, N'Herbívoros')
INSERT [dbo].[Clasificaciones] ([idClasificacion], [denominacion]) VALUES (7, N'CLASIFICACION1')
SET IDENTITY_INSERT [dbo].[Clasificaciones] OFF
SET IDENTITY_INSERT [dbo].[Especies] ON 

INSERT [dbo].[Especies] ([idEspecie], [idClasificacion], [idTipoAnimal], [nombre], [nPatas], [esMascotas]) VALUES (1, 1, 1, N'Peces', 0, 0)
INSERT [dbo].[Especies] ([idEspecie], [idClasificacion], [idTipoAnimal], [nombre], [nPatas], [esMascotas]) VALUES (2, 2, 6, N'Monos', 2, 1)
INSERT [dbo].[Especies] ([idEspecie], [idClasificacion], [idTipoAnimal], [nombre], [nPatas], [esMascotas]) VALUES (3, 5, 2, N'León', 4, 0)
INSERT [dbo].[Especies] ([idEspecie], [idClasificacion], [idTipoAnimal], [nombre], [nPatas], [esMascotas]) VALUES (4, 6, 4, N'Pajaro', 0, 1)
INSERT [dbo].[Especies] ([idEspecie], [idClasificacion], [idTipoAnimal], [nombre], [nPatas], [esMascotas]) VALUES (5, 4, 2, N'Cerdo', 4, 1)
INSERT [dbo].[Especies] ([idEspecie], [idClasificacion], [idTipoAnimal], [nombre], [nPatas], [esMascotas]) VALUES (6, 3, 4, N'Serpiente', 0, 1)
INSERT [dbo].[Especies] ([idEspecie], [idClasificacion], [idTipoAnimal], [nombre], [nPatas], [esMascotas]) VALUES (7, 5, 3, N'Ciempiés', 100, 0)
INSERT [dbo].[Especies] ([idEspecie], [idClasificacion], [idTipoAnimal], [nombre], [nPatas], [esMascotas]) VALUES (11, 3, 2, N'monito', 4, 0)
SET IDENTITY_INSERT [dbo].[Especies] OFF
SET IDENTITY_INSERT [dbo].[TiposAnimal] ON 

INSERT [dbo].[TiposAnimal] ([idTipoAnimal], [denominacion]) VALUES (1, N'ACUÁTICOS')
INSERT [dbo].[TiposAnimal] ([idTipoAnimal], [denominacion]) VALUES (2, N'TERRESTRES')
INSERT [dbo].[TiposAnimal] ([idTipoAnimal], [denominacion]) VALUES (3, N'INVERTEBRADOS')
INSERT [dbo].[TiposAnimal] ([idTipoAnimal], [denominacion]) VALUES (4, N'VERTEBRADOS')
INSERT [dbo].[TiposAnimal] ([idTipoAnimal], [denominacion]) VALUES (5, N'CUADRÚPEDOS')
INSERT [dbo].[TiposAnimal] ([idTipoAnimal], [denominacion]) VALUES (6, N'BÍPEDOS')
INSERT [dbo].[TiposAnimal] ([idTipoAnimal], [denominacion]) VALUES (7, N'ANIMAL1')
SET IDENTITY_INSERT [dbo].[TiposAnimal] OFF
ALTER TABLE [dbo].[Especies]  WITH CHECK ADD  CONSTRAINT [FK__Especie_Clasificaciones] FOREIGN KEY([idClasificacion])
REFERENCES [dbo].[Clasificaciones] ([idClasificacion])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Especies] CHECK CONSTRAINT [FK__Especie_Clasificaciones]
GO
ALTER TABLE [dbo].[Especies]  WITH CHECK ADD  CONSTRAINT [FK__Especie_TipoAnimal] FOREIGN KEY([idTipoAnimal])
REFERENCES [dbo].[TiposAnimal] ([idTipoAnimal])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Especies] CHECK CONSTRAINT [FK__Especie_TipoAnimal]
GO
USE [master]
GO
ALTER DATABASE [zoodb] SET  READ_WRITE 
GO
