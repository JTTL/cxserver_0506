
#pragma pack(1)


//斗地主特殊规则数据结构
#define MAX_CELL_SCORE    5

struct tagDDZCustomRule
{
	//其他定义
	DWORD							wMaxScoreTimes;						//最大倍数
	DWORD							wFleeScoreTimes;					//逃跑倍数
	DWORD							cbFleeScorePatch;					//逃跑补偿

	//时间定义
	DWORD							cbTimeOutCard;						//出牌时间
	DWORD							cbTimeCallScore;					//叫分时间
	DWORD							cbTimeStartGame;					//开始时间
	DWORD							cbTimeHeadOutCard;					//首出时间

	//房卡底分设置
	DWORD							dwRoomCardCellScore[MAX_CELL_SCORE];//房卡底分
};


//////////////////////////////////////////////////////////////////////////////////

#pragma pack()

