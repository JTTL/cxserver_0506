
#pragma pack(1)


//����������������ݽṹ
#define MAX_CELL_SCORE    5

struct tagDDZCustomRule
{
	//��������
	DWORD							wMaxScoreTimes;						//�����
	DWORD							wFleeScoreTimes;					//���ܱ���
	DWORD							cbFleeScorePatch;					//���ܲ���

	//ʱ�䶨��
	DWORD							cbTimeOutCard;						//����ʱ��
	DWORD							cbTimeCallScore;					//�з�ʱ��
	DWORD							cbTimeStartGame;					//��ʼʱ��
	DWORD							cbTimeHeadOutCard;					//�׳�ʱ��

	//�����׷�����
	DWORD							dwRoomCardCellScore[MAX_CELL_SCORE];//�����׷�
};


//////////////////////////////////////////////////////////////////////////////////

#pragma pack()

