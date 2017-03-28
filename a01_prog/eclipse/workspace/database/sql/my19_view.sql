/*
VIEW
���� ����� �̷���� ���� ���̺�
�������� ������ ���� ������ ���

������
1. �������� ���̺� ���� ���� (���Ȼ��� ����)
2. ������ ���� ����ȭ

����
CREATE [OR REPLACE] VIEW ���̸�
AS SUBQUERY(SQL);
-- ������ �������� ����
*/
CREATE TABLE EMP08
AS SELECT * FROM EMP;

##CREATE VIEW EMP_VIEW10
AS SELECT EMPNO, ENAME, SAL, DEPTNO 
			FROM EMP08 
			WHERE DEPTNO = 30;

SELECT * FROM EMP_VIEW10;

INSERT INTO EMP_VIEW10 VALUES(8888, 'ȫ�浿', 1700, 30);

UPDATE EMP_VIEW10
SET ENAME='HIMAN'
WHERE EMPNO=7900;

INSERT INTO EMP_VIEW10 VALUES(8889, 'ȫ�浿2', 1700, 40);

SELECT * FROM EMP08;
SELECT * FROM EMP_VIEW10;
/*
VIEW�� �����Ͱ� ����Ǵ°� �ƴ϶� ���� TABLE�� �����.
DEPTN0 40�� �����Ͱ� �Է��� �ǳ� VIEW������ ������� ������ �ʴ´�.

VIEW�� ������ �ɼ� ����
1. DROP VIEW EMP_VIEW10
2. WITH CHECK OPTION
3. WITH READ ONLY(���ȿ�)
*/
DROP VIEW EMP_VIEW10;
 
CREATE VIEW EMP_VIEW10
AS SELECT EMPNO, ENAME, SAL, DEPTNO 
			FROM EMP08 
			WHERE DEPTNO = 30
			WITH CHECK OPTION;
INSERT INTO EMP_VIEW10 VALUES(8889, 'ȫ�浿2', 1700, 40); -- DEPTNO 40�� �����ʹ� ���� �ȵ�

DROP VIEW EMP_VIEW10;
 
CREATE VIEW EMP_VIEW10
AS SELECT EMPNO, ENAME, SAL, DEPTNO 
			FROM EMP08 
			WHERE DEPTNO = 30
			WITH READ ONLY;
INSERT INTO EMP_VIEW10 VALUES(8889, 'ȫ�浿2', 1700, 40); -- �Է� ��ü�� �ȵ�

/*
Ȯ�ο���
1. EMP09 �������̺� ����
2. ������ 3000�����̸� ��å�� SALESMAN�� �����̺� ���� WITH CHECK OPTION
3. ���ʽ��� ���� �������̸� �˻��� ������ �����̺� ���� WITH READ ONLY
*/
CREATE TABLE EMP09
AS SELECT * FROM EMP;

CREATE VIEW EMP_VIEW12
AS SELECT * FROM EMP09
	WHERE SAL<=3000
	AND JOB = 'SALESMAN'
	WITH CHECK OPTION;

SELECT * FROM EMP_VIEW12;
INSERT INTO EMP_VIEW12 VALUES(8000, 'ȫ�浿', 'SALESMAN', SYSDATE, 7698, 3000, 100, 40);
CREATE VIEW EMP_VIEW13
AS SELECT * FROM EMP09
	WHERE COMM IS NULL
	WITH READ ONLY;
INSERT INTO EMP_VIEW12 VALUES(8001, 'ȫ�浿2', 'SALESMAN', SYSDATE, 7698, 3000, 100, 40);

/*
���� ��
�ΰ� �̻��� �⺻ ���̺� ���� ���ǵ� ��
������ ������ �ܼ�ȭ
����
CREATE VIEW ���̸�
AS SELECT A.�÷�1, A.�÷�2, B.�÷�1
	FROM ���̺�1 A, ���̺�2 B
	WHERE A.�÷� = B.�÷�
	AND ����;
*/
CREATE VIEW SHOW_PART_VIEW
AS SELECT EMPNO, ENAME, DNAME
	FROM EMP09 A, DEPT B
	