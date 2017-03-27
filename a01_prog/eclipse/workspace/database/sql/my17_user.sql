/*
## ����� �������� ���� ���
sqlplus ����/���
show user - �α����� ���� Ȯ��
conn ����/��� - ���� ����

## �������� client ���� �̿��ؼ� ���� �ֿ� �ٽ� ����
IP/PORT/SID/����/���
*/

/*
����� ����
CREATE USER ����ڸ�
IDENTIFIED BY �н�����;
*/
CREATE USER scott01
IDENTIFIED BY tiger;

/*
���� �ο�
1. session ���ӱ���
grant ��������
to ����� ����
*/
GRANT CREATE SESSION 
TO SCOTT01;

/*
���̺� �����̽�  ------- ���丸 �˸� ��(NCS�� �Ȱ� �Ѿ���ε�) -------
�����ͺ��̽� ������, ���� ������Ʈ(���̺�, �ε���, �� ��)��
���� ������ ���Ͽ� ����Ǵ� ������ ����
����� - ���̺� �����̽� ������ �� ����
1. ���� ����
	CREATE TABLESPACE ���̺����̽���
	DATAFILE '������ ���� ��ġ' SIZE ũ�� - EX)10M
	DEFAULT STORAGE - �ʱ� ũ�� ���� �� BLOCK���� ���� ũ�� 
	(
		INITIAL ũ�� - �ʱ� ũ��
		NEXT ũ�� - ���� ũ��
		MAXEXTENDS - �ִ� ���� ũ��
		PCTINCREASE - EXTENTS ������, DEFAULT�� 50
	)
*/
CREATE TABLESPACE TS01
		DATAFILE 'C:\a01_prog\database\DF001.DBF01' SIZE 50M
		DEFAULT STORAGE
		(
			INITIAL 1024K
			NEXT 512K
			MAXEXTENTS 128
			PCTINCREASE 0
		);

/*
���̺� - ���̺����̽� ��Ī
CREATE TABLE ���̺��
(
	...
) TABLESPACE ���������̺����̽���;

DEFALUT ���̺����̽� ����
ALTER DATABASE DEFAULT TABLESPACE ���������̺����̽���;
*/
-- ������ ���̺����̽� Ȯ��
SELECT * FROM USER_TABLES
WHERE TABLE_NAME LIKE '%EMP%';

CREATE TABLE TSEXP
(
	NO NUMBER PRIMARY KEY
) TABLESPACE TSO1;
SELECT * FROM USER_TABLES
WHERE TABLE_NAME LIKE '%TSEXP%';