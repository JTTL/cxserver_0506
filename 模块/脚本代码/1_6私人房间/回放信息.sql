
----------------------------------------------------------------------------------------------------

USE RYTreasureDB
GO

----写私人房配置信息
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_WriteRecordBackInfo]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_WriteRecordBackInfo]
GO


SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------



----------------------------------------------------------------------------------------------------
-- 游戏写分
CREATE PROC GSP_GR_WriteRecordBackInfo

	-- 系统信息
	@strID	 VARCHAR(22),						-- 一局游戏标识	
	@strPersonalRoomGUID NVARCHAR(31),			-- 私人房间唯一标识					
	@dwUserID INT,								-- 用户 I D
	@szRoomID NVARCHAR(6),						-- 房间ID
	@lVariationScore BIGINT,					-- 用户分数
	@lGamesNum INT								-- 游戏局数
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	
	INSERT INTO RYPlatformDBLink.RYPlatformDB.dbo.RecordBackInfo(ID,PersonalRoomGUID ,UserID, RoomID, Score, GamesNum, Dates) 
												VALUES (@strID,  @strPersonalRoomGUID, @dwUserID, @szRoomID, @lVariationScore, @lGamesNum, GETDATE()) 

	--INSERT INTO .RYPlatformDB..RecordBackInfo(ID,UserID, RoomID, Score) 
	--											VALUES (@strID, @dwUserID, @szRoomID, @lVariationScore) 
	
END

RETURN 0

GO


USE RYGameScoreDB
GO

----写私人房配置信息
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_WriteRecordBackInfo]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_WriteRecordBackInfo]
GO


SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------



----------------------------------------------------------------------------------------------------
-- 游戏写分
CREATE PROC GSP_GR_WriteRecordBackInfo

	-- 系统信息
	@strID	 VARCHAR(22),						-- 一局游戏标识	
	@strPersonalRoomGUID NVARCHAR(31),			-- 私人房间唯一标识					
	@dwUserID INT,								-- 用户 I D
	@szRoomID NVARCHAR(6),						-- 房间ID
	@lVariationScore BIGINT,					-- 用户分数
	@lGamesNum INT								-- 游戏局数
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	
	INSERT INTO RYPlatformDBLink.RYPlatformDB.dbo.RecordBackInfo(ID,PersonalRoomGUID ,UserID, RoomID, Score, GamesNum, Dates) 
												VALUES (@strID,  @strPersonalRoomGUID, @dwUserID, @szRoomID, @lVariationScore, @lGamesNum, GETDATE()) 

	--INSERT INTO .RYPlatformDB..RecordBackInfo(ID,UserID, RoomID, Score) 
	--											VALUES (@strID, @dwUserID, @szRoomID, @lVariationScore) 
	
END

RETURN 0

GO