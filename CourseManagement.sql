USE [master]
GO
/****** Object:  Database [CourseManagement]    Script Date: 12/4/2015 11:39:25 PM ******/
CREATE DATABASE [CourseManagement]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CourseManagement', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\CourseManagement.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'CourseManagement_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\CourseManagement_log.ldf' , SIZE = 3456KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [CourseManagement] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CourseManagement].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CourseManagement] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CourseManagement] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CourseManagement] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CourseManagement] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CourseManagement] SET ARITHABORT OFF 
GO
ALTER DATABASE [CourseManagement] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CourseManagement] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [CourseManagement] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CourseManagement] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CourseManagement] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CourseManagement] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CourseManagement] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CourseManagement] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CourseManagement] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CourseManagement] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CourseManagement] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CourseManagement] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CourseManagement] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CourseManagement] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CourseManagement] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CourseManagement] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CourseManagement] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CourseManagement] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CourseManagement] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CourseManagement] SET  MULTI_USER 
GO
ALTER DATABASE [CourseManagement] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CourseManagement] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CourseManagement] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CourseManagement] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'CourseManagement', N'ON'
GO
USE [CourseManagement]
GO
/****** Object:  Table [dbo].[CourseMaster]    Script Date: 12/4/2015 11:39:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseMaster](
	[CourseId] [int] IDENTITY(1,1) NOT NULL,
	[CourseName] [nvarchar](100) NOT NULL,
	[CourseDuration] [numeric](18, 2) NOT NULL,
	[CourseFees] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_CourseMaster] PRIMARY KEY CLUSTERED 
(
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CourseStudentRef]    Script Date: 12/4/2015 11:39:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseStudentRef](
	[CourseStudentRefId] [int] IDENTITY(1,1) NOT NULL,
	[CourseId] [int] NOT NULL,
	[StudentId] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_CourseStudentRef] PRIMARY KEY CLUSTERED 
(
	[CourseStudentRefId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StudentMaster]    Script Date: 12/4/2015 11:39:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentMaster](
	[StudentId] [int] IDENTITY(1,1) NOT NULL,
	[StudentName] [nvarchar](100) NOT NULL,
	[Phone] [nvarchar](11) NULL,
	[Mobile] [nvarchar](11) NULL,
	[Address] [nvarchar](200) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_StudentMaster] PRIMARY KEY CLUSTERED 
(
	[StudentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[CourseMaster] ADD  CONSTRAINT [DF_CourseMaster_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[CourseStudentRef] ADD  CONSTRAINT [DF_CourseStudentRef_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[StudentMaster] ADD  CONSTRAINT [DF_StudentMaster_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[CourseStudentRef]  WITH CHECK ADD  CONSTRAINT [FK_CourseStudentRef_CourseStudentRef] FOREIGN KEY([CourseId])
REFERENCES [dbo].[CourseMaster] ([CourseId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CourseStudentRef] CHECK CONSTRAINT [FK_CourseStudentRef_CourseStudentRef]
GO
ALTER TABLE [dbo].[CourseStudentRef]  WITH CHECK ADD  CONSTRAINT [FK_CourseStudentRef_StudentMaster] FOREIGN KEY([StudentId])
REFERENCES [dbo].[StudentMaster] ([StudentId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CourseStudentRef] CHECK CONSTRAINT [FK_CourseStudentRef_StudentMaster]
GO
USE [master]
GO
ALTER DATABASE [CourseManagement] SET  READ_WRITE 
GO
