/*
���� ������ �̿��� ������ �߰�
INSERT ������ SELECT�� ȥ���ؼ�, �����͸� �Է� ó���� ����.
���� : INSERT INTO ���̺��
		SELECT * FROM �Է������̺�; �ش� SQL�� ���� ������ �����͸�
		�ѹ��� �Է��� �� �ִ�.
		������ ��) �Է��� ���̺��� �÷��� SELECT [�����÷���]��
		�÷� ������ TYPE�� �����Ͽ��� �Ѵ�. 
*/
-- EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO
INSERT INTO EMP_STRUCTOR
SELECT * FROM EMP
WHERE SAL >= 3000;

/*
INSERT INTO ���̺��(�÷�1, �÷�2, �÷�3)
SELECT �÷�1, �÷�1+�÷�2, �Լ�(�÷�3) 
FROM ���̺��
WHERE ����
*/
INSERT INTO EMP_STRUCTOR(EMPNO)
		SELECT EMPNO FROM EMP;
INSERT INTO EMP_STRUCTOR(EMPNO, SAL, ENAME)
		SELECT EMPNO, SAL+NVL(COMM, 0), RPAD(ENAME,7,'^^') FROM EMP;
/*
Ȯ�ο���
DEPT_SUB �̶�� ���̺��� DEPT���̺��� �̿��Ͽ� �����, �߰��÷�,
		KDNAME(�ѱ��̸�), MEMBERCNT(��ϵ��ο�)
1) ������ �ִ� �������̺� ����.
2) DEPT���̺��� �̿��ؼ� ���� �����Ϳ� �߰��� �����͸� �Է��ϼ���
	- ó��: �ѱ��̸�-����, MEMBERCNT = 0
*/
CREATE TABLE DEPT_SUB
AS
SELECT DEPTNO, DNAME, LOC, '         ' KDNAME, 0 MEMBERCNT 
FROM DEPT
WHERE 1=0;

INSERT INTO DEPT_SUB
SELECT DEPTNO, DNAME, LOC, '����' KDNAME, 0 MEMBERCNT
FROM DEPT;

/*
KDNAME�� ���� ó��
DECODE (DEPTNO, 10, 'ȸ��', 20, '����', 30, '����', 40, '�', '����') KDNAME,
	0 MEMBERCNT
FROM DEPT;

*/
SELECT DEPTNO, DNAME, LOC, DECODE (DEPTNO, 10, 'ȸ��', 20, '����', 30, '����', 40, '�', '����') KDNAME, 0 MEMBERCNT
FROM DEPT;

/*
MEMBERCNT�� ���� ó��
	EMP���̺� �����͸� Ȯ���ؼ� ó��
	SELECT DEPTNO, DNAME, LOC, 
		DECODE (DEPTNO, 10, 'ȸ��', 
						20, '����', 
						30, '����', 
						40, '�', 
						'����') KDNAME, 
		(SELECT COUNT(*) 
		FROM EMP 
		WHERE DEPTNO=A.DEPTNO) MEMBERCNT
	FROM DEPT A;
*/

INSERT INTO DEPT_SUB
SELECT DEPTNO, DNAME, LOC, 
		DECODE (DEPTNO, 10, 'ȸ��', 
						20, '����', 
						30, '����', 
						40, '�', 
						'����') KDNAME, 
		(SELECT COUNT(*) 
		FROM EMP 
		WHERE DEPTNO=A.DEPTNO) MEMBERCNT
FROM DEPT A;

/*
���� ��������:
	�����ϴ� MAIN SQL������ SUBQUERY�� �ش� ������ �����
	ó���ϴ� ���� ���Ѵ�
UPDATE ���̺��
SET �÷��� = ������(�����ͺκ��� SUBQUERY�� ó��
					SELECT �÷���
					FROM ���̺�
					WHERE ����)
WHERE ����
*/
/*
-- 1. SUBQUERY
SELECT AVG(COMM)
FROM EMP;
-- 2. MAINQUERY
UPDATE EMP
SET	COMM=(SELECT AVG(COMM) FROM EMP)
WHERE EMPNO=7369;

Ȯ�ο���
1. EMP_SUB77 �̶�� EMP�� �������̺��� ����
2. EMP_SUB77���� COMM�� NULL���� �����Ϳ� SAL�� ���������� �����ϼ���
CREATE TABLE EMP_SUB77
AS SELECT * FROM EMP;
UPDATE EMP_SUB77
SET COMM=(SELECT MIN(SAL) FROM EMP_SUB77)
WHERE COMM IS NULL;
*/

