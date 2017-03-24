/*
����Ŭ���� ������ ������ ���̺��� ȿ�������� �����ϱ� ����
query�� ���Ѵ�. (self join�� ȿ���� ó��)

������ ���� : ������ ���迡 ���̺� ������ ������ ���� ���Ѵ�
ex) �Ҿƹ���(id, parentId, role : 1, 0, '�Ҿƹ���')
	�ƹ���(2, 1, '�ƹ���')
	����(3, 1, '����')
	�Ƶ�(4, 2, '�Ƶ�')
	���̵���(5, 3, '����')
	����(6, 4, '����')
������ sql ����
select ....�÷�
from ���̺��
where ����
start with ����(�񱳿����� ex)�÷�=������ : ������ sql�� �������� ó��-�ֻ��� ������ ����ó��
							ex)���������� �ֻ��� ������ parentId=0
							�츮������ ���� ������ ó���ϰ��� �� ��, 
							parentId=2(�ƹ��� �������ķ� ��Ÿ��)
connect by [nocycle] ���� and ����
	�������踦 ��������ִ� ���ǿ� ���� ����. nocycle:
*/
-- mgr(������ ��ȣ)�ε�, empno�� ���εǾ� ����.
select level, empno, (lpad(' ', 4*(level)) || job) job, mgr
from emp
start with mgr is null -- �ֻ��� ������ ������ MGR�� NULL�� ��
connect by prior empno = mgr; -- �ֻ��� �÷��� ���� �÷� ����ó�� 
/*
���������� mgr�� null�϶� ���� �����Ͽ�, ���������� emp�� mgr�� �ִ���
���θ� Ȯ���Ͽ� �ش��ϴ� mgr�� �����Ͱ� empno�� ���� �� ����

���������� ������ ó�� lpad('���ʿ� �Է��� ����', �ݺ��� ����)
�������� �������� ǥ�õ� �� �ְԲ� ó��
'	' : ������ 4ĭ�� lpad('	', 4*(level))
*/

-- ex) Ȯ�ο��� family�� ���������� ����ϼ���
-- ������� : level role(������������ó��), �̸�
select level, (lpad(' ', 4*(level-1)) || role01) role, name
from family
start with parentnumid = 0 
connect by prior numid = parentnumid
order by level; 
-- level�� 1���� ����, ������ �׻� �ֱ� ������ -1

/*
order sibilings by �÷�[asc/desc]
�ش� �������� �÷��� ���� ���� ������ ���� ������ �����Ѵ�
�ֱٿ� ��ϵ� ������ ���� list�ϴ���? ���� ��ϵ� ������ ���� list�ϴ���?
*/
insert into family values(5,1,'ū�ƹ���','ȫ����');
insert into family values(6,0,'�����Ҿƹ���','ȫ���');

select level, (lpad(' ', 4*(level-1)) || role01) role, name
from family
start with parentnumid = 0 
connect by prior numid = parentnumid
order siblings by NUMID DESC;

/*
board ������ �Խ��� ���̺� ���� list�ϱ�
	����id(�۹�ȣ), 		Ÿ��Ʋ, 		����, 			�������, 		��������, 		�ۼ���, 		��ȸ��
	no,		parentno,		title,			content,		CREATEDATE,		UPDATEDATE,		writer,			readcnt
	number,	number,			varchar2(50),	varchar2(1000),	date,			date,			varchar2(50),	number
*/
CREATE TABLE BOARD
(
	NO			NUMBER PRIMARY KEY,
	PARENTNO	NUMBER,
	TITLE		VARCHAR2(50),
	CONTENT		VARCHAR2(1000),
	CREATEDATE	DATE,
	UPDATEDATE	DATE,
	WRITER		VARCHAR2(50),
	READCNT		NUMBER
);

SELECT * FROM BOARD;
-- 1, 0, '�۵�Ͻ���', '�ù�', SYSDATE, SYSDATE, '�۰�01'
INSERT INTO BOARD VALUES(1, 0, '�۵�Ͻ���', '�ù�', sysdate, sysdate, '�۰�01', 0);
INSERT INTO BOARD VALUES(2, 0, '2��°�׿�!�̷�!', '�ù�', sysdate, sysdate, '�۰�02', 0);
-- ù��° �ۿ� ���� ��۷� ó��
INSERT INTO BOARD VALUES(3, 1, '1��°�� ���ƽ��ϴ�.', '�ù�', sysdate, sysdate, 'ȫ����', 0);
INSERT INTO BOARD VALUES(4, 3, '���� ����� �����׿�', '�ù�', sysdate, sysdate, '�۰�03', 0);
INSERT INTO BOARD VALUES(5, 1, '������ ��Ź�մϴ�!', '�ù�', sysdate, sysdate, '�۰�03', 0);
-- �۹�ȣ, Ÿ��Ʋ, �����, �����
SELECT NO, LPAD(' ', 4*(LEVEL-1)) || TITLE,
		TO_CHAR(CREATEDATE, 'YYYY/MM/DD') CREATEDATE, WRITER
FROM BOARD
START WITH PARENTNO=0
CONNECT BY PRIOR NO=PARENTNO
ORDER SIBLINGS BY NO DESC; 

INSERT INTO BOARD VALUES(6, 2, '^^ ���� �Խ��ǵǱ�~~', '�ù�', sysdate, sysdate, '�����', 0);
INSERT INTO BOARD VALUES(7, 1, 'ù��°�� ����~~', '�ù�', sysdate, sysdate, '���̸�', 0);

SELECT ROWNUM, NO, LPAD(' ', 4*(LEVEL-1)) || TITLE,
		TO_CHAR(CREATEDATE, 'YYYY/MM/DD') CREATEDATE, WRITER
FROM BOARD
START WITH PARENTNO=0
CONNECT BY PRIOR NO=PARENTNO
ORDER SIBLINGS BY NO DESC; 

SELECT ROWNUM, A.*
FROM EMP A
ORDER BY EMPNO DESC;
-- ROWNUM : ������ LIST���� ������ NUMBERING�� �ٴ� Ű����

