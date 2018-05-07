
----------------------------------------------------------------------------------------------------

USE RYPlatformDB
GO

----д˽�˷�������Ϣ
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_WritePersonalRoomJoinInfo]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_WritePersonalRoomJoinInfo]
GO


SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------



----------------------------------------------------------------------------------------------------
-- ��Ϸд��
CREATE PROC GSP_GR_WritePersonalRoomJoinInfo

	-- ϵͳ��Ϣ
	@dwUserID INT,								-- �û� I D
	@dwTableID INT,								-- ���� I D
	@dwChairID INT,								-- ���� I D
	@dwKindID INT,								-- ��Ϸ ����
	@szRoomID NVARCHAR(6),						-- ����ID
	@szRoomGUID NVARCHAR(31)					-- ����Ψһ��ʶ	
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN
	
	-- �����ǰ������Ҳ�����
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