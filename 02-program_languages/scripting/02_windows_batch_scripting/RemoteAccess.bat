echo �����ǿ�����
net use \\IP\ipc$ "password" /user:"username"

echo �鿴Զ��D���µ�1.txt�ļ�������
type \\IP\D$\1.txt

echo �鿴Զ�������Ĺ�����Դ����������Ĭ�Ϲ��� 
net view \\IP 

echo �鿴���������Ĺ�����Դ�����Կ������ص�Ĭ�Ϲ��� 
net share 

echo �õ�Զ���������û����б� 
nbtstat -A IP 

echo �õ������������û��б� 
net user 

echo �鿴Զ�������ĵ�ǰʱ�� 
net time \\IP 

echo ��ʾ����������ǰ���� 
net start 

echo ��Զ�����������ļ�(����ǰĿ¼�µ��ļ����Ƶ��Է�c����) 
copy 1.txt \\IP\c

echo ɾ��һ��ipc$����
net use \\IP\ipc$ /del

pause

