USE [RYPlatformDB]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TABLE [dbo].[PersonalCellScore](
[ID] [int] IDENTITY(1,1)  PRIMARY KEY NOT NULL,
[KindID] [INT] NOT NULL , 
[CellScore] INT DEFAULT 0 NOT NULL  
)
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PersonalCellScore', @level2type=N'COLUMN',@level2name=N'KindID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏底分' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PersonalCellScore', @level2type=N'COLUMN',@level2name=N'CellScore'
GO




--CREATE TABLE [dbo].[PersonalCellScore](
--	[ID] [int] IDENTITY(1,1) NOT NULL,
--	[KindID] [INT] NOT NULL,
--	[CellScore] [INT] NOT NULL
-- CONSTRAINT [PK_PersonalCellScore_Index] PRIMARY KEY CLUSTERED 
--(
--	[ID] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]

--GO
--EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PersonalCellScore', @level2type=N'COLUMN',@level2name=N'KindID'
--GO

--EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏底分' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PersonalCellScore', @level2type=N'COLUMN',@level2name=N'CellScore'

