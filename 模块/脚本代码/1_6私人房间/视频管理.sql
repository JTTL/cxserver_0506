
----------------------------------------------------------------------------------------------------

USE RYPlatformDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_QueryVideoInfo]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_QueryVideoInfo]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_QueryVideoDetails]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_QueryVideoDetails]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_QueryPlayBackCodeYZ]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_QueryPlayBackCodeYZ]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 查询视频列表
CREATE PROC GSP_MB_QueryVideoInfo
	@iQueryType INT,								-- 0:约战 1:普通				
	@dwUserID	INT,								-- 用户 I D
	@dwPlayBack INT,								-- 类型
	@wIndexBegin INT,								-- 索引开始
	@wIndexEnd INT,									-- 索引结束
	@strErrorDescribe NVARCHAR(127) OUTPUT			-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN		
	IF @dwPlayBack=0
	BEGIN
		-- 查询用户
		IF not exists(SELECT * FROM RYAccountsDBLink.RYAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID)
		BEGIN
			SET @strErrorDescribe = N'抱歉，你的用户信息不存在！'
			return 1
		END
		IF @iQueryType=0
		BEGIN
			SELECT a.UserID as UserID,c.NickName as NickName,c.GameID as GameID,c.FaceID as FaceID,c.CustomID as CustomID,a.PersonalRoomGUID as PersonalGUID,a.RoomID as RoomID,a.Score as TotalScore,a.WriteTime as CreateTime,
			a.ChairID as ChairID,a.KindID as KindID,c.Gender as Gender,0 as QueryType,
			(case when (EXISTS(select * from [RYPlatformDB].[dbo].[StreamCreateTableFeeInfo] where UserID=a.UserID and RoomID=a.RoomID )) then 1 else 0 end) AS CreateRoom 
			FROM [RYPlatformDB].[dbo].[PersonalRoomScoreInfo]  a ,
			(select top (@wIndexEnd) PersonalRoomGUID from [RYPlatformDB].[dbo].[RecordBackInfo] where UserID=@dwUserID and DateDiff(d,Dates,GetDate()) <= 1 and (PersonalRoomGUID NOT IN (select top (@wIndexBegin) PersonalRoomGUID from [RYPlatformDB].[dbo].[RecordBackInfo] where UserID=@dwUserID  and DateDiff(d,Dates,GetDate()) <= 1 )) group by PersonalRoomGUID having count(PersonalRoomGUID) > 0) b , 			
			[RYAccountsDB].[dbo].[AccountsInfo] c				
			where a.PersonalRoomGUID = b.PersonalRoomGUID and c.UserID = a.UserID order by a.WriteTime desc
		END
		ELSE
		BEGIN
			SELECT a.UserID as UserID,c.NickName as NickName,c.GameID as GameID,c.FaceID as FaceID,c.CustomID as CustomID,a.VideoNumber as VideoNumber,a.Score as TotalScore,a.BuildVideoTime as CreateTime,			 
			a.ChairID as ChairID,a.KindID as KindID,c.Gender as Gender,1 as QueryType
			FROM [RYTreasureDB].[dbo].[RecordVideoPlayerInfo]  a ,					
			(select top (@wIndexEnd) VideoNumber from [RYTreasureDB].[dbo].[RecordVideoPlayerInfo] where UserID=@dwUserID and (VideoNumber NOT IN (select top (@wIndexBegin) VideoNumber from [RYTreasureDB].[dbo].[RecordVideoPlayerInfo]  where UserID=@dwUserID))) b ,		
			[RYAccountsDB].[dbo].[AccountsInfo] c			
			where c.UserID = a.UserID and b.VideoNumber=a.VideoNumber and DateDiff(d,a.BuildVideoTime,GetDate()) <= 1 			
		END	
	END	
	ELSE
	BEGIN	
		IF EXISTS (select *  from [RYPlatformDB].[dbo].[PersonalRoomScoreInfo] where PlayBackCode=@dwPlayBack)	
		BEGIN
			SELECT a.UserID as UserID,c.NickName as NickName,c.GameID as GameID,c.FaceID as FaceID,c.CustomID as CustomID,a.PersonalRoomGUID as PersonalGUID,a.RoomID as RoomID,a.Score as TotalScore,a.WriteTime as CreateTime,
			a.ChairID as ChairID,a.KindID as KindID,c.Gender as Gender,b.UserID as PlayUserID,0 as QueryType,
			(case when (EXISTS(select * from [RYPlatformDB].[dbo].[StreamCreateTableFeeInfo] where UserID=a.UserID and RoomID=a.RoomID )) then 1 else 0 end) AS CreateRoom 
			FROM [RYPlatformDB].[dbo].[PersonalRoomScoreInfo]  a ,
			(select UserID,PersonalRoomGUID from [RYPlatformDB].[dbo].[PersonalRoomScoreInfo] where PlayBackCode=@dwPlayBack) b ,
			[RYAccountsDB].[dbo].[AccountsInfo] c			
			where a.PersonalRoomGUID = b.PersonalRoomGUID and c.UserID = a.UserID and DateDiff(d,a.WriteTime,GetDate()) <= 1 order by a.WriteTime desc
		END
		ELSE		
		BEGIN
			SELECT a.UserID as UserID,c.NickName as NickName,c.GameID as GameID,c.FaceID as FaceID,c.CustomID as CustomID,a.VideoNumber as VideoNumber,a.Score as TotalScore,a.BuildVideoTime as CreateTime,			 
			a.ChairID as ChairID,a.KindID as KindID,c.Gender as Gender,b.UserID as PlayUserID,1 as QueryType
			FROM [RYTreasureDB].[dbo].[RecordVideoPlayerInfo]  a ,	
			(select UserID,VideoNumber from [RYTreasureDB].[dbo].[RecordVideoPlayerInfo]  where PlayBackCode=@dwPlayBack) b ,		
			[RYAccountsDB].[dbo].[AccountsInfo] c			
			where c.UserID = a.UserID and b.VideoNumber=a.VideoNumber and DateDiff(d,a.BuildVideoTime,GetDate()) <= 1
		END			
	END
END

RETURN 0

GO
----------------------------------------------------------------------------------------------------

-- 查询视频详情
CREATE PROC GSP_MB_QueryVideoDetails
	@szPersonalGUID	NVARCHAR(31),					-- 约战房唯一 I D
	@strErrorDescribe NVARCHAR(127) OUTPUT			-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN	
	SELECT a.ID as VideoNumber,a.UserID as UserID,b.NickName as NickName,a.Score as Score,a.GamesNum as GameNum,@szPersonalGUID as PersonalGUID 
	FROM [RYPlatformDB].[dbo].[RecordBackInfo] a,[RYAccountsDB].[dbo].[AccountsInfo] b
	where PersonalRoomGUID=@szPersonalGUID and a.UserID = b.UserID
END 

RETURN 0

GO
----------------------------------------------------------------------------------------------------

-- 查询回放码
CREATE PROC GSP_MB_QueryPlayBackCodeYZ
	@dwUserID		INT,							-- 用户 I D
	@szPersonalGUID	NVARCHAR(31),					-- 约战房唯一 I D
	@strErrorDescribe NVARCHAR(127) OUTPUT			-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	declare @bFind	INT
	declare @Code	INT
	SET @Code=0      
	select @Code=PlayBackCode from  [RYPlatformDB].[dbo].[PersonalRoomScoreInfo] where PersonalRoomGUID=@szPersonalGUID and UserID=@dwUserID and DateDiff(d,WriteTime,GetDate()) <= 1
	
	IF @Code=0
	BEGIN
		SET @bFind=0       
		WHILE @bFind=0    
		BEGIN
			SET @Code = cast(ceiling(rand() * 899999) as int)+100000
			IF NOT EXISTS (select * from  [RYPlatformDB].[dbo].[PersonalRoomScoreInfo] where PlayBackCode=@Code and DateDiff(d,WriteTime,GetDate()) <= 1)
			BEGIN
				SET @bFind = 1  
				UPDATE [RYPlatformDB].[dbo].[PersonalRoomScoreInfo] SET PlayBackCode =@Code WHERE UserID=@dwUserID and PersonalRoomGUID=@szPersonalGUID   
			END
		END 
	END	
	
	SELECT @Code as Code
END

RETURN 0

GO
----------------------------------------------------------------------------------------------------