/*
subquery?
�ϳ��� select ������ �� �ȿ� ���Ե� �� �ϳ��� select ������ ���Ѵ�.
���� ������ �����ϰ� �ִ� �������� ��������(main query), ���Ե� �� �ϳ���
������ ���� ����(subquery)��� �Ѵ�.
ex) ������̺��� ������ �ְ�� ���� ����� �̸��� ������ list�ϼ���
*/
SELECT ENAME, SAL -- MAIN QUERY
FROM EMP
WHERE SAL = (SELECT MAX(SAL) FROM EMP); -- SUBQUERY
/*
�ۼ��� ������
1. ���������� �񱳿�����(=,>,<...)�� �����ʿ� ����ؾ� �ϰ� ��ȣ��
	�ѷ����ִ� ���� �Ϲ����̴�.
2. ���������� ���� ������ ����Ǳ� ������ ����ȴ�.

���������� ����
1. ������ ������ ó���Ǵ� ���
	SELECT * 
	FROM ���̺� 
	WHERE �÷��� = (SELECT �÷� FROM ���̺� WHERE ����)
	## ���ϰ� ���� : =,>,< (�񱳿����� Ȱ��)
	���߰� ���� : IN, EXIST, ANY, ALL
2. ���̺�� ��ü�� SUBQUERY ó���ϴ� ���
	SELECT �÷���1+�÷���2, ....
	FROM (SELECT �÷���1, �÷���2, �Լ�(�÷���3)
			FROM ���̺��
			WHERE ����)
3. SELECT (SELECT �÷�1 FROM ���̺�� WHERE ����=��������1),
		�÷�2, �÷�3
	FROM ���̺�
	WHERE ����
*/
-- 1. ���ǰ����� SUBQUERY�� ���Ǵ� ���
--		EX) ��տ������� ���� ������� �̸��� ������ ����ϼ���
SELECT ENAME, SAL
FROM EMP
WHERE SAL > (SELECT AVG(SAL) FROM EMP);
-- EX) ���ʽ��� �ִ� ����� ��, �ְ��� ����� �̸��� ������ ���ʽ���
--		����ϼ���
SELECT ENAME, SAL, COMM
FROM EMP
WHERE COMM = (SELECT MAX(COMM) FROM EMP);
-- EX) ���ʽ��� �ִ� ����� ��, ��� ���ʽ����� ���� ��� �̸��� ������ ���ʽ���
--		����ϼ���
SELECT ENAME, SAL, COMM
FROM EMP
WHERE NVL(COMM, 0) > (SELECT AVG(NVL(COMM, 0)) FROM EMP);
/*
(SELECT AVG(COMM)
FROM EMP
WHERE COMM IS NOT NULL)
*/
/*
Ȯ�ο���
1. �μ���ȣ�� ���� ���� ����� �̸��� �μ��� ����ϼ���
2. ���� �ֱٿ� �Ի��� ����� �̸��� ��å, �Ի����� ����ϼ���
*/
SELECT E.ENAME, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO AND E.DEPTNO = (SELECT MAX(DEPTNO) FROM EMP);

-- MAX(HIREDATE) ���� �ֱ� �Ի���
-- MIN(HIREDATE) ���� ���� �Ի���
SELECT ENAME, JOB, HIREDATE
FROM EMP
WHERE HIREDATE = (SELECT MAX(HIREDATE) FROM EMP); 

-- SUBQUERY�� ������� 2�� �̻��� ���
-- EX) �μ����� �Ի����� �ְ��� ������� �̸��� �Ի����� ����ϼ���.
SELECT DEPTNO, MAX(HIREDATE)
FROM EMP
GROUP BY DEPTNO;
-- 1) ���� ���ǿ� ���� ó��
SELECT *
FROM EMP
WHERE DEPTNO IN (SELECT DEPTNO FROM EMP WHERE DEPTNO < 30);
-- IN ���п� QUERY�� �־ �ش��ϴ� ������ ������ ������ ó���� �� �ִ�.
-- SAL�� 3000, DEPTNO 20
SELECT * 
FROM EMP 
WHERE SAL = 3000 AND DEPTNO = 20;
-- DEPTNO, HIREDATE�� ������ �Ѵ� QUERY�� ���ؼ� ó���� ��
SELECT ENAME, HIREDATE
FROM EMP
WHERE (DEPTNO, HIREDATE) IN (SELECT DEPTNO, MAX(HIREDATE) 
								FROM EMP GROUP BY DEPTNO);
-- SUBQUERY�� ������� �ΰ� �̻� ���� ����, �ش� �÷��� ������ �´� �÷���
--	������ �־ ���ó���� �����ϰ� �Ѵ�. 
--	(�÷�1, �÷�2) IN (SELECT �÷�1, �Լ�(�÷�2) FROM ...)

/*
Ȯ�ο���
1. JOB(��å��)�� ���� ���� ������ �޴� ����� �̸�, ��å, ������ ����ϼ���
*/
SELECT ENAME, JOB, SAL
FROM EMP
WHERE (SAL, JOB) IN (SELECT MIN(SAL), JOB
					FROM EMP
					GROUP BY JOB);

/*
����(��������)
1. �Ի��� �б⺰�� ���� ���� ������ �޴� ����� ����ϼ���
2. ������ 3000�� ��� �߿�, ���(���̺�Ȱ�뵵 ����)�� �����
	�ش� ��޺� �ְ� ������ �޴� ����� �̸�, ���, ������ ����ϼ���
*/
SELECT B.HQ , MAX(A.SAL) 
FROM EMP A, (select empno, ename, trunc((to_number(to_char(hiredate, 'MM'))-1)/3) HQ from emp) B
WHERE A.EMPNO = B.EMPNO
GROUP BY B.HQ;

SELECT A.ENAME, B.HQ
FROM EMP A, (select empno, ename, trunc((to_number(to_char(hiredate, 'MM'))-1)/3) HQ from emp) B
WHERE A.EMPNO = B.EMPNO;
/*
��� ���̺��� 30�� �Ҽ� ����� �߿��� �޿��� ���� ���� �޴� ��� ����
���� �޿��� ���� ����� �̸��� �޿��� ����ϼ���.
##
30�� �Ҽ� ����� �߿��� �޿��� ���� ���� �޴� ��� 
==> 1) GROUP �Լ� �̿�
	2) ��ü �����͸� SUBQUERY�� �ε��ؼ�
		== ALL, ANY, ..(SUBQUERY)
		ALL : SUBQUERY�� ��� ���� ��ġ�� ��.
		<==> ANY, SOME : SUBQUERY�� ������� �ϳ� �̻� ��ġ�ϸ�
*/
SELECT ENAME, SAL
FROM EMP
WHERE SAL >= ALL(SELECT SAL FROM EMP WHERE DEPTNO = 30);
/**/
SELECT SAL FROM EMP WHERE DEPTNO = 30;

/*
Ȯ�ο���
1. ������ 3000�̸��� ��� �߿�, �ֱٿ� �Ի��� ����� �����ȣ�� ���� �Ի�����
	����ϼ���
*/
SELECT EMPNO, SAL, HIREDATE
FROM EMP
WHERE HIREDATE >= ALL(SELECT HIREDATE FROM EMP WHERE SAL < 3000);

SELECT HIREDATE FROM EMP WHERE SAL < 3000;
/*
����
1. �μ���ȣ�� 30�� ��� �߿�, ���� ���߿� �Ի��� ������� ������ ������
	����ϼ���
2. ������ 'SALESMAN'�� ����� �޴� �޿����� �ּ� �޿����� ���� �޴� �������
	�̸��� �޿��� ����ϵ� �μ���ȣ 20���� ����� �����Ѵ�. (ANY������ �̿�)
*/

/*
WHERE EXISTS(SUBQUERY)
:�ش� SUBQUERY�� �����Ͱ� �ִ��� ���θ� üũ�ؼ� ���� SQL�� ó���ϰ��� �� ��
Ȱ��ȴ�
EX) �μ���ȣ�� 30�� �����Ͱ� ������ ��ü ������̺��� LIST�ϼ���
	���࿡ �μ���ȣ�� 30���� ������ ��ü ������̺� LIST�� ���� ó���ϰڴ�
*/
SELECT *
FROM EMP
WHERE EXISTS(SELECT * FROM EMP WHERE DEPTNO=40);
/*
Ȯ�ο���
�����ڹ�ȣ(MGR)�� �������߿� NULL���� ������, �̸��� �����ڹ�ȣ, ��å�� 
����ϰ��� �Ѵ�. SQL�� �ۼ��ϼ���.
*/
SELECT ENAME, MGR, JOB
FROM EMP
WHERE EXISTS(SELECT * FROM EMP WHERE MGR IS NULL);

SELECT ENAME, MGR, JOB
FROM EMP
WHERE EXISTS(SELECT * FROM EMP WHERE JOB IS NULL); -- ����� �ȵ�

/*
���������� Ȱ���� ���̺� ����, ������ �Է�, ����, ����
1. ���̺� �����ϱ�
	1) ������ + ����
		CREATE TABLE �������̺��
		AS SELECT �÷�1, �÷�2 FROM ���̺� WHERE ����
	EX) ������ 2000�̻��� �������߿� �����ȣ(NO) �����(NAME) ����(SALARY)��
		���̺� EMP001�� ������� �Ѵ�.
*/
CREATE TABLE EMP001
AS
SELECT EMPNO NO, ENAME NAME, SAL SALARY
FROM EMP
WHERE SAL >= 2000;
SELECT * FROM EMP001;
DROP TABLE EMP001;
-- �μ��̸�(DNAME) �߰�
CREATE TABLE EMP001
AS
SELECT E.EMPNO NO, E.ENAME NAME, E.SAL SALARY, D.DNAME
FROM EMP E, DEPT D
WHERE E.SAL >= 2000 AND E.DEPTNO = D.DEPTNO;
SELECT * FROM EMP001;

SELECT E.EMPNO NO, E.ENAME NAME, E.SAL SALARY, D.DNAME
FROM EMP E, DEPT D
WHERE E.SAL >= 2000 AND E.DEPTNO = D.DEPTNO;

/*
Ȯ�ο��� - EMP, SALGRADE ���̺��� Ȱ���Ͽ�
������ ���� �ű����̺��� �����ϼ���
������ 1000�̻� �Ǵ� �����͸�,
�����(NAME), �μ���ȣ(PARTNO), ����(SALARY), �޿����(GRADE)
�� ��, EMPGRADE ���̺��� �����ϼ���.
*/
CREATE TABLE EMPGRADE
AS
SELECT E.ENAME NAME, E.DEPTNO PARTNO, E.SAL SALARY, G.GRADE GRADE
FROM EMP E, SALGRADE G
WHERE E.SAL BETWEEN G.LOSAL AND G.HISAL;

SELECT * FROM SALGRADE;
SELECT * FROM EMP;
SELECT E.ENAME NAME, E.DEPTNO PARTNO, E.SAL SALARY, G.GRADE GRADE
FROM EMP E, SALGRADE G
WHERE E.SAL BETWEEN G.LOSAL AND G.HISAL;

/*
��������
������ ���� ������ ���̺��� �����ϼ���
�̸�(NAME) ��ȣ(NO) �Ի���(CREDATE)-���ڿ� ���ر��رٹ�����(WORKYEARS)
					@@@@�� @@�� @@��       @@@@
NEW_EMP�� �����ϼ���
*/

/*
�������� ������ �����ϰ��� �� ��
*/
CREATE TABLE EMP_STRUCTOR
AS
SELECT * 
FROM EMP
WHERE 1=0;