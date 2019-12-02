CREATE TABLE [dbo].[Purchases]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [UserId] INT NOT NULL, 
    [ProductId] INT NOT NULL, 
    CONSTRAINT [FK_Purchases_ToCustomers] FOREIGN KEY ([UserId]) REFERENCES [Customers]([Id]), 
    CONSTRAINT [FK_Purchases_ToProducts] FOREIGN KEY ([ProductId]) REFERENCES [Products]([Id]) 
	
)

GO

CREATE INDEX [IX_Purchases_UserId] ON [dbo].[Purchases] ([UserId])

GO

CREATE INDEX [IX_Purchases_ProductId] ON [dbo].[Purchases] ([ProductId])
