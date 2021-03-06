﻿/*
Deployment script for OnlineShop

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "OnlineShop"
:setvar DefaultFilePrefix "OnlineShop"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET PAGE_VERIFY NONE,
                DISABLE_BROKER 
            WITH ROLLBACK IMMEDIATE;
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367)) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
PRINT N'Creating [dbo].[Customers]...';


GO
CREATE TABLE [dbo].[Customers] (
    [Id]       INT           IDENTITY (1, 1) NOT NULL,
    [Name]     NVARCHAR (50) NULL,
    [Email]    VARCHAR (100) NOT NULL,
    [Password] NCHAR (30)    NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Customers].[IX_Customers_Column]...';


GO
CREATE NONCLUSTERED INDEX [IX_Customers_Column]
    ON [dbo].[Customers]([Name] ASC);


GO
PRINT N'Creating [dbo].[Products]...';


GO
CREATE TABLE [dbo].[Products] (
    [Id]          INT            IDENTITY (1, 1) NOT NULL,
    [Name]        NVARCHAR (50)  NOT NULL,
    [Description] NVARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Purchases]...';


GO
CREATE TABLE [dbo].[Purchases] (
    [Id]        INT IDENTITY (1, 1) NOT NULL,
    [UserId]    INT NOT NULL,
    [ProductId] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Purchases].[IX_Purchases_UserId]...';


GO
CREATE NONCLUSTERED INDEX [IX_Purchases_UserId]
    ON [dbo].[Purchases]([UserId] ASC);


GO
PRINT N'Creating [dbo].[Purchases].[IX_Purchases_ProductId]...';


GO
CREATE NONCLUSTERED INDEX [IX_Purchases_ProductId]
    ON [dbo].[Purchases]([ProductId] ASC);


GO
PRINT N'Creating [dbo].[FK_Purchases_ToCustomers]...';


GO
ALTER TABLE [dbo].[Purchases] WITH NOCHECK
    ADD CONSTRAINT [FK_Purchases_ToCustomers] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Customers] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Purchases_ToProducts]...';


GO
ALTER TABLE [dbo].[Purchases] WITH NOCHECK
    ADD CONSTRAINT [FK_Purchases_ToProducts] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Products] ([Id]);


GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Purchases] WITH CHECK CHECK CONSTRAINT [FK_Purchases_ToCustomers];

ALTER TABLE [dbo].[Purchases] WITH CHECK CHECK CONSTRAINT [FK_Purchases_ToProducts];


GO
PRINT N'Update complete.';


GO
