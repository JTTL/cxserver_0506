#pragma once

//游戏视频基类
class IGameVideo
{
public:
	IGameVideo(void){};
	virtual ~IGameVideo(void){};

public:
	//开始录像
	virtual bool __cdecl	StartVideo(ITableFrame	*pTableFrame)		= NULL;
	//停止和保存
	virtual bool __cdecl	StopAndSaveVideo(WORD wServerID,WORD wTableID)	= NULL;
	//增加录像数据
	virtual bool __cdecl    AddVideoData(WORD wMsgKind,Video_GameStart *pVideoGameStart,bool bFirst)=NULL;
	virtual bool __cdecl    AddVideoData(WORD wMsgKind,BYTE *pPack,int nSize)=NULL;
	virtual bool __cdecl    AddVideoData(WORD wMsgKind,CMD_S_OutCard *pVideoOutCard)=NULL;
		virtual bool __cdecl    AddVideoData(WORD wMsgKind,CMD_S_SendCard *pVideoSendCard)=NULL;
	virtual bool __cdecl    AddVideoData(WORD wMsgKind,CMD_S_OperateNotify *pVideoNotify)=NULL;
	virtual bool __cdecl    AddVideoData(WORD wMsgKind,CMD_S_OperateResult *pVideoResult)=NULL;
	virtual bool __cdecl    AddVideoData(WORD wMsgKind,CMD_S_GameConclude *pVideoConclude)=NULL;	
	virtual bool __cdecl    AddVideoData(WORD wMsgKind,CMD_S_Trustee *pVideoTrustee)=NULL;
	virtual bool __cdecl    AddVideoData(WORD wMsgKind,CMD_S_RECORD *pVideoRecord)=NULL;
};
