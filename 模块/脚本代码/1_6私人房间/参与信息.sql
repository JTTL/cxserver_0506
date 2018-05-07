
----------------------------------------------------------------------------------------------------

USE RYPlatformDB
GO

----写私人房配置信息
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_WritePersonalRoomJoinInfo]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_WritePersonalRoomJoinInfo]
GO


SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------



----------------------------------------------------------------------------------------------------
-- 游戏写分
CREATE PROC GSP_GR_WritePersonalRoomJoinInfo

	-- 系统信息
	@dwUserID INT,								-- 用户 I D
	@dwTableID INT,								-- 桌子 I D
	@dwChairID INT,								-- 椅子 I D
	@dwKindID INT,								-- 游戏 类型
	@szRoomID NVARCHAR(6),						-- 房间ID
	@szRoomGUID NVARCHAR(31)					-- 房间唯一标识	
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	
	-- 如果当前房间玩家不存在
	DECLARE @dwExistUserID INT
	SELECT @dwExistUserID = UserID FROM PersonalRoomScoreInfo WHERE PersonalRoomGUID = @szRoomGUID AND UserID = @dwUserID

	IF @dwExistUserID IS NULL
	BEGIN
		INSERT INTO PersonalRoomScoreInfo(UserID, RoomID, Score, WinCount, LostCount, DrawCount, FleeCount, WriteTime, PersonalRoomGUID, ChairID,  KindID) 
												VALUES (@dwUserID, @szRoomID, 0,0, 0, 0, 0, GETDATE(), @szRoomGUID, @dwChairID, @dwKindID)  
		DECLARE @Card INT
		DECLARE @Fee INT										
		SELECT @Card=CardOrBean,@Fee=CreateTableFee FROM [RYPlatformDB].[dbo].[StreamCreateTableFeeInfo] where RoomID=@szRoomID and UserID=@dwUserID
		
		--IF @Fee IS NOT NULL
		--BEGIN
		--	IF @Card=1
		--	BEGIN
		--		exec RYPlatformDBLink.RYPlatformDB.dbo.GSP_GR_TaskForwardRoom @dwUserID,1,@Fee,0	
		--	END
		--END
	END

END

RETURN 0

GO