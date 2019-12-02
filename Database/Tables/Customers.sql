CREATE TABLE [dbo].[Customers]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Name] NVARCHAR(50) NULL, 
    [Email] VARCHAR(100) NOT NULL, 
    [Password] NCHAR(30) NOT NULL
)

GO

CREATE INDEX [IX_Customers_Column] ON [dbo].[Customers] ([Name])
