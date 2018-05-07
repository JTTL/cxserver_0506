
----------------------------------------------------------------------------------------------------

USE RYTreasureDB
GO

----д˽�˷�������Ϣ
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_WriteRecordBackInfo]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_WriteRecordBackInfo]
GO


SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------



----------------------------------------------------------------------------------------------------
-- ��Ϸд��
CREATE PROC GSP_GR_WriteRecordBackInfo

	-- ϵͳ��Ϣ
	@strID	 VARCHAR(22),						-- һ����Ϸ��ʶ	
	@strPersonalRoomGUID NVARCHAR(31),			-- ˽�˷���Ψһ��ʶ					
	@dwUserID INT,								-- �û� I D
	@szRoomID NVARCHAR(6),						-- ����ID
	@lVariationScore BIGINT,					-- �û�����
	@lGamesNum INT								-- ��Ϸ����
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
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

----д˽�˷�������Ϣ
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_WriteRecordBackInfo]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_WriteRecordBackInfo]
GO


SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------



----------------------------------------------------------------------------------------------------
-- ��Ϸд��
CREATE PROC GSP_GR_WriteRecordBackInfo

	-- ϵͳ��Ϣ
	@strID	 VARCHAR(22),						-- һ����Ϸ��ʶ	
	@strPersonalRoomGUID NVARCHAR(31),			-- ˽�˷���Ψһ��ʶ					
	@dwUserID INT,								-- �û� I D
	@szRoomID NVARCHAR(6),						-- ����ID
	@lVariationScore BIGINT,					-- �û�����
	@lGamesNum INT								-- ��Ϸ����
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN
	
	INSERT INTO RYPlatformDBLink.RYPlatformDB.dbo.RecordBackInfo(ID,PersonalRoomGUID ,UserID, RoomID, Score, GamesNum, Dates) 
												VALUES (@strID,  @strPersonalRoomGUID, @dwUserID, @szRoomID, @lVariationScore, @lGamesNum, GETDATE()) 

	--INSERT INTO .RYPlatformDB..RecordBackInfo(ID,UserID, RoomID, Score) 
	--											VALUES (@strID, @dwUserID, @szRoomID, @lVariationScore) 
	
END

RETURN 0

GO