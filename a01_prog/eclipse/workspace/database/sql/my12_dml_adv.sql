/*
�������� ��� DML QUERY!!
1. ���� ���̺� ������ �Է��ϱ�
	INSERT ������ ������ �Ἥ �����͸� �Է��ϴ� ��찡 ���� �����͸� �Է�
	�� �� ���ŷο� ��찡 �ִ�.
	�ѹ��� SUBQUERY�� ���ؼ� ���� ������ ������ ���̺� �Է��� ��,
	INSERT ALL ������ Ȱ���ϸ� �ս��� ó���� �� �ִ�.
	1) ����
	INSERT ALL
	INTO ���̺�1�� VALUES(�÷�1, �÷�2, �÷�3)
	INTO ���̺�2�� VALUES(�÷�1, �÷�2, �÷�4)
	SELECT �÷�1, �÷�2, �÷�3, �÷�4
	FROM ���̺��
	WHERE ����
	
*/
-- �����������̺� �����ϱ�
CREATE TABLE EMP_HIR
AS
SELECT EMPNO, ENAME, HIREDATE
FROM EMP WHERE 1=0;
CREATE TABLE EMP_MGR
AS
SELECT EMPNO, ENAME, MGR
FROM EMP WHERE 1=0;

INSERT ALL
INTO EMP_HIR VALUES(EMPNO, ENAME, HIREDATE)
INTO EMP_MGR VALUES(EMPNO, ENAME, MGR)
SELECT EMPNO, ENAME, HIREDATE, MGR
FROM EMP
WHERE DEPTNO=10;

/*
SUBQUERY�� �̿��� ������ �����ϱ�
UPDATE ���̺��
SET (������ �÷�1, ������ �÷�2) = (SELECT �÷�1, �÷�2 FROM ���̺�)
WHERE ����
EX) 20�� �μ��� �������� 40�� �μ��� ���������� �����ϱ� ���ؼ� SUBQUERY�� Ȱ���غ���
*/
CREATE TABLE DEPT10
AS SELECT * FROM DEPT;
-- �Է��� ������ LOADING(SUBQUERY)

SELECT DNAME, LOC
FROM DEPT
WHERE DEPTNO=40;
-- MAIN QUERY

UPDATE DEPT10
SET (DNAME, LOC) = (SELECT DNAME, LOC
					FROM DEPT
					WHERE DEPTNO=40)
WHERE DEPTNO=20;

/*
Ȯ�ο���
EMP���̺��� ���纻 EMP11 ����
	JOB(��å)�� PRESIDENT�� �ִ� SAL�� DEPTNO��
	JOB�� CLERK�� �ִ� �����ͷ� UPDATE�ϼ���
*/
CREATE TABLE EMP11
AS SELECT * FROM EMP;

UPDATE EMP11
SET (SAL, DEPTNO) = (SELECT SAL, DEPTNO
					FROM EMP11
					WHERE JOB='PRESIDENT')
WHERE JOB='CLERK';

SELECT * FROM EMP11 WHERE JOB='CLERK';

/*
MERGE ó��
DATA MINGRATION(������ �̰�ó��)�� ��, ���� Ȱ��ȴ�.
���̺� A, ���̺� B�� �����͸� �̰�ó����, �μ��� �޶� �ԷµǾ� �ִ� �����͵� �ְ�,
�űԷ� �Է��ؾߵ� �����͵� ������, �ԷµǾ� �ִ� �����ʹ� Ư�� �÷��� ����ó���ؾ�
�� ��� ���� Ȱ��ȴ�.
���� EX) ���̺�A�� ������ ���̺�B���� ���� �����ʹ� INSERTó��
		���̺�A�� �ְ�, ���̺�B�� ������ Ư���� �÷��� �����ϴ� ���� UPDATEó��
		�ΰ��� ������ �ѹ��� ó���ϴ� ���� MERGE
	MERGE INTO ���������̺� (EX) ���̺�B 
		USING ���������������̺� (EX) ���̺�A
		ON ����ó�� - �Ϲ������� �� ���̺��� KEY��(�����÷�)�� �������� ó���Ѵ�.
									EX) ���̺�A.�÷�01=���̺�B.�÷�01
		WHEN MATCHED THEN -- �� ���� ���̺� KEY�����Ͱ� �������� ���� ��
								EX) ���̺�A�� �÷�01�� ���̺�B�� �÷�01��
									�ش� �����Ͱ� ������ ���
			UPDATE ���� ó��
			UPDATE SET ���������̺�.�������÷�=���������������̺�.�÷�
								EX) ���̺�B.�����÷�=���̺�A.�÷�
		WHEN NOT MATCHED THEN -- ���� ���̺� �����Ͱ� ���� ���
								EX) ���̺�A���� ������, ���̺�B���� ���� ���
			INSERT ���� ó��
			INSERT VALUES (���������������̺�.�÷�...)
								EX) INSERT VALUES (���̺�B.�÷���...)
			(���̺� ���� ��� MERGE INTO�� ����Ǿ� ����)
*/
/*
EMP01, EMP02 �����͸� �ε��ؼ�.. EMP01�� ������ ����ó��..
1. EMP01 �������̺� �����.
2. EMP02 �������̺� ����� EMP�� JOB='MANAGER'��..
	EMP02 JOB ==> 'TEST'�� UPDATE
	EMP02 �Է� 7935 'ȫ�浿' 'SUPERMAN' 7839 SYSDATE 4000 100 40
	(## EMPNO�� EMP01�� ���� ������)
*/
-- EMP�� ����
CREATE TABLE EMP10
AS SELECT * FROM EMP;

-- EMP �Ϻ�
CREATE TABLE EMP20
AS SELECT * FROM EMP WHERE JOB='MANAGER';

-- EMP�� ������ ���� (UPDATE)
UPDATE EMP20
SET JOB='TEST'; -- EMP20�� JOB�� 'TEST'�� ����

-- EMP�� ���� �� �߰� (INSERT)
-- EMP20 �Է� 7935 'ȫ�浿' 'SUPERMAN' 7839 SYSDATE 4000 100 40
INSERT INTO EMP20 VALUES(7935, 'ȫ�浿', 'SUPERMAN', 7839, SYSDATE, 4000, 100, 40);

MERGE INTO EMP10 -- ���� �����ʹ� EMP10�� ó��
	USING EMP20		-- EMP20�����͸� �����
	ON (EMP10.EMPNO = EMP20.EMPNO) -- �ش� KEY���� EMPNO�� �ִ��� ���ο� ���� UPDATE/INSERT
WHEN MATCHED THEN -- EMPNO���� ���� ��
	UPDATE SET
	EMP10.JOB = EMP20.JOB -- EMP20.JOB ������ ��, 'TEST'�����͸� EMP10.JOB�� UPDATE
WHEN NOT MATCHED THEN
	INSERT VALUES(EMP20.EMPNO, EMP20.ENAME, EMP20.JOB, EMP20.MGR, EMP20.HIREDATE,
					EMP20.SAL, EMP20.COMM, EMP20.DEPTNO);
/*
Ȯ�ο��� 
EMP�� �������̺� EMP03 
EMP���� �μ���ȣ(DEPTNO)�� 30�� �����͸� EMP04�� �������̺� �����
      EMP04�� HIREDATE�� ���ó� (SYSDATE)�� UPDATE ó��
	EMP04�� 7370 '������' 'SUPERMAN' 7839 SYSDATE 6000 40 40 ������ �Է�
	�� ���̺� ����ó��
*/

CREATE TABLE EMP30
AS SELECT * FROM EMP;

CREATE TABLE EMP40
AS SELECT * FROM EMP WHERE DEPTNO=30;

UPDATE EMP40
SET HIREDATE = SYSDATE;

INSERT INTO EMP40 VALUES (7370, '������', 'SUPERMAN', 7839, SYSDATE, 6000, 40, 40);

MERGE INTO EMP30 -- ���� �����ʹ� EMP10�� ó��
	USING EMP40		-- EMP20�����͸� �����
	ON (EMP30.EMPNO = EMP40.EMPNO) -- �ش� KEY���� EMPNO�� �ִ��� ���ο� ���� UPDATE/INSERT
WHEN MATCHED THEN -- EMPNO���� ���� ��
	UPDATE SET
	EMP30.HIREDATE = EMP40.HIREDATE -- EMP20.JOB ������ ��, 'TEST'�����͸� EMP10.JOB�� UPDATE
WHEN NOT MATCHED THEN
	INSERT VALUES(EMP40.EMPNO, EMP40.ENAME, EMP40.JOB, EMP40.MGR, EMP40.HIREDATE,
					EMP40.SAL, EMP40.COMM, EMP40.DEPTNO);
SELECT * FROM EMP30;