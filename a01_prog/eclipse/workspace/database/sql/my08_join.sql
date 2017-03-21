/*
CROSS JOIN
*/
SELECT COUNT(*)
FROM EMP, DEPT; -- EMP���̺� X DEPT���̺�
SELECT COUNT(*)
FROM EMP;
SELECT COUNT(*)
FROM DEPT;

/*
EQUI JOIN : �ΰ��̻� ���̺��� �����̺� �ҼӵǾ� �ִ� �÷��� �����Ͱ�
			���� ���� ���� ��, 
����
	SELECT ǥ�����÷�
	FROM ���̺�1, ���̺�2
	WHERE ���̺�1.�����÷� = ���̺�2.�����÷�
	�����÷� : ���� �����Ͱ� �ִ� �÷�
*/
SELECT * FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;
-- ����� �̸��� ��å, �ҼӺμ����� ����ϼ���
SELECT ENAME, JOB, DNAME
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;
-- ex) DEPT�� �����Ͽ� �����, �μ���ġ(LOC)�� ���
SELECT ENAME, LOC
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;

-- Ȯ�ο���) ���ʽ��� �ִ� ����� �̸��� �μ����� ����ϼ���
SELECT ENAME, DNAME
FROM EMP A, DEPT B
WHERE A.COMM IS NOT NULL AND A.DEPTNO = B.DEPTNO;

/*
NON-EQUI JOIN
���̺� ���̿� �÷��� ���� ���������� ��ġ���� ���� �� ����ϴ� ��������
*/
-- �޿� ����� 5���� ������ �� ����� ǥ���Ͻÿ�
-- WHERE SAL BETWEEN [LOSAL] AND [HISAL]
-- �̸��� ���� �������
-- ���̺� ALIAS ����ϱ� : ���̺��� �÷��� ���� �̸��� ������ �ǹ̰� ������
--	���� �̸��� ������ �����ϱ� ���� ���̺��[����]ALIAS�� Ȱ���Ѵ�.
--	���̺�ALIAS.�÷���
--	����, ������ �÷��� ���� ���� �������� ���� ����ϴ� ��쵵 �ִ�.
SELECT E.ENAME, E.SAL, S.GRADE
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL; 
/*
����
STUDENT10			���̵�(ID),			�̸�(NAME)	
STUDENTPOINT	���̵�(ID),			����(SUBJECT),		����(POINT)
GRADECHECK		��������(LOPOINT),	�ְ�����(HIPOINT),	�������(A~F)
1) ���̵� �����ؼ�(EQUAL JOIN)
	�̸� ���� ���� ���
2) ������ �����ؼ�(NOT EQUAL JOIN)
	���� ���� �������
3) STUDENT10 STUDENTPOINT GRADECHECK ������ �Ͽ�
	�̸� ���� �������
*/
CREATE TABLE GRADECHECK
(
	GRADE	VARCHAR2(4),
	LOPOINT	NUMBER(10),
	HIPOINT	NUMBER(10)
);

INSERT INTO GRADECHECK VALUES ('A', '91', '100');
INSERT INTO GRADECHECK VALUES ('B', '81', '90');
INSERT INTO GRADECHECK VALUES ('C', '71', '80');
INSERT INTO GRADECHECK VALUES ('D', '61', '70');
INSERT INTO GRADECHECK VALUES ('E', '51', '60');
INSERT INTO GRADECHECK VALUES ('F', '0', '50');

SELECT M.ID, P.SUBJECT, P.POINT
FROM STUDENT_MAIN M, STUDENT_POINT P
WHERE M.ID = P.ID;

SELECT P.SUBJECT, P.POINT, G.GRADE
FROM STUDENT_POINT P, GRADECHECK G
WHERE P.POINT BETWEEN G.LOPOINT AND G.HIPOINT; 

SELECT M.ID, P.SUBJECT, G.GRADE
FROM STUDENT_MAIN M, STUDENT_POINT P, GRADECHECK G
WHERE M.ID = P.ID AND P.POINT BETWEEN G.LOPOINT AND G.HIPOINT;

/*
OUTER JOIN
�� ���� ���� ���迡 �ִ� ���̺� �־�, ���� �Ǵ� ���� ��
������ �������� �ʴ��� ������ ����� ����ؾ� �ϴ� ��쿡 Ȱ��Ǵ� �����̴�.
*/
SELECT * FROM DEPT;
SELECT DISTINCT DEPTNO FROM EMP;
-- �μ���ȣ���� ��Ī�Ǵ� ����̸��� ����ϵ�, �̸��� ������ ���ٴ� ǥ�ð� �ʿ�
-- �̸� �μ���ȣ �μ���
-- WHERE �����Ͱ� ���� ���̺�.�÷���(+) = �����Ͱ� �ִ� ���̺�.�÷��� 
SELECT NVL(E.ENAME, '�ο�����') ENAME, D.DEPTNO, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO
ORDER BY E.DEPTNO DESC;

/*
����) OUTER JOIN, GROUP BY�� Ȱ���Ͽ� 
		�μ��� �ο��� Ȯ���ҷ��� �Ѵ�.
		�Ʒ��� �������� ����ϼ���.
		�ο��� ���� ���� 0���� ǥ��
		�μ���	�ο�	
*/
SELECT D.DNAME, COUNT(E.EMPNO)
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO
GROUP BY D.DNAME;

/*
SELF JOIN : �� �״�� �ڱ� �ڽŰ� ������ �δ� ���� ���Ѵ�.
FROM���� ���� �̸��� ���̺��� �����Ͽ�, �ٸ� ���̺��� ��ó�� �ν��ؼ�
�����Ͽ� �� ������� ����ϴ� ���� ���Ѵ�.
SELECT * FROM ���̺�� ALIAS01, �������̺�� ALIAS02
WHERE ALIAS01.�����÷� = ALIAS02.�����÷�
EX) ������̺�(EMP)���� ����� �����ڸ��� ����ϼ��� 
*/
SELECT WORK.ENAME, WORK.MGR, MANAGER.ENAME
FROM EMP WORK, EMP MANAGER
WHERE WORK.MGR = MANAGER.EMPNO;

/*
������ JOIN���� ���� ���̺� �����(SELF JOIN)
1. ������ �����Ѵ�
	ID�� ���� ID�� �Է��ϴ� KEY�� �����.
	NUMID,	PARENTNUMID,	ROLE01,	NAME
	���̵�,	�������̵�,		����,	�̸�
2. ���̺��� �����Ѵ�
	CREATE TABLE FAMILY
	(
		NUMID			NUMBER,
		PARENTNUMID		NUMBER,
		ROLE01			VARCHAR2(100),
		NAME			VARCHAR2(500)
	);
3. ���̺��� �Է��Ѵ�(���� �������� ������ ������ ���� ������ �Է�ó��)
	INSERT INTO FAMILY VALUES (1,0,'�Ҿƹ���','ȫ�浿');
	INSERT INTO FAMILY VALUES (2,1,'�ƹ���','ȫ����');
	INSERT INTO FAMILY VALUES (3,2,'�Ƶ�','ȫ��ȣ');
	INSERT INTO FAMILY VALUES (4,1,'����','ȫ��ȣ');
4. �Էµ� ������ ������ ���������� �Ǿ� �ִ��� Ȯ���Ѵ�.
	-��ȸ ó��
*/
CREATE TABLE FAMILY
(
	NUMID			NUMBER,
	PARENTNUMID		NUMBER,
	ROLE01			VARCHAR2(100),
	NAME			VARCHAR2(500)
);
INSERT INTO FAMILY VALUES (1,0,'�Ҿƹ���','ȫ�浿');
INSERT INTO FAMILY VALUES (2,1,'�ƹ���','ȫ����');
INSERT INTO FAMILY VALUES (3,2,'�Ƶ�','ȫ��ȣ');
INSERT INTO FAMILY VALUES (4,1,'����','ȫ��ȣ');
SELECT * FROM FAMILY;
/*
�̸� ROLE �����̸�
*/
SELECT CUR.NAME, CUR.ROLE01, PAR.NAME
FROM FAMILY CUR, FAMILY PAR
WHERE CUR.PARENTNUMID = PAR.NUMID;

