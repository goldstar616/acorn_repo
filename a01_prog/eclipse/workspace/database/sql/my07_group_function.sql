/*
�׷��Լ� : �����͸� �׷캰�� ���ġ�� ó���� �� Ȱ��ȴ�.
sum() : ���ջ�.
avg() : ���
count() : ����
max() : �ִ밪
min() : �ּҰ�
*/
select sum(sal) tot, avg(sal) avg01, count(sal) cnt,
		max(sal) max01, min(sal) min01
from emp

/*
�׷캰�� �������� ���ġ ó���ϱ�
SELECT ó���� �׷� �÷�, �׷��Լ�
FROM ���̺��
WHERE ����(�׷��� ó���ϱ� �� ����)
GROUP BY ó���� �׷�����
HAVING �׷쿡 ���� ����ó��(�׷��� �� �Ŀ� ����)
*/

select sum(sal) tot, avg(sal) avg01, count(sal) cnt,
		max(sal) max01, min(sal) min01
from emp
GROUP BY DEPTNO;

-- ��ü ������ �Ǽ��� Ȯ���ϼ���.
-- COUNT(�÷�, ��ü(*))
-- Ư���÷��� �����Ͱ� �ִ� �Ǽ��� ��� ó��
SELECT COUNT(*) CNT, COUNT(COMM) BONUS_CNT
FROM EMP;
SELECT COMM FROM EMP;

-- �ߺ��Ǵ� �����Ϳ� ���� ���� Ȯ�� ó��
SELECT DISTINCT JOB FROM EMP;
SELECT COUNT(JOB) FROM EMP;
-- �ߺ��� �����͸� ������ �Ǽ� ó��COUNT(DISTINCT �÷���)
SELECT COUNT(DISTINCT JOB) FROM EMP;
-- �׷��Լ��� ���ǹ� ó��
-- ������ 3000�̻��� ����߿� ��å��(JOB)�� �ο����� ���ϼ���.
SELECT JOB, COUNT(JOB) 
FROM EMP 
WHERE SAL >= 3000
GROUP BY JOB;

-- Ȯ�ο���
-- �Ի����� 1~3���� ����� �μ����� �ο����� üũ�ϼ���
-- �μ���ȣ	�ο���
-- @@		@@@
SELECT DEPTNO, COUNT(DEPTNO)
FROM EMP
WHERE TO_NUMBER(TO_CHAR(HIREDATE, 'MM')) BETWEEN 1 AND 3
GROUP BY DEPTNO;

SELECT FLOOR(TO_NUMBER(TO_CHAR(HIREDATE,'MM'))/4)+1, COUNT(*)
FROM EMP
GROUP BY FLOOR(TO_NUMBER(TO_CHAR(HIREDATE, 'MM'))/4)+1;
-- TO_CHAR(HIREDATE, 'MM') : HIREDATE��¥�� �����͸� ������ ���ڷ� ���
SELECT HIREDATE, TO_CHAR(HIREDATE, 'MM') FROM EMP;
-- TO_NUMBER() : ������ ���ؼ� ���ڸ� ���������� ��ȯó��
SELECT HIREDATE, TO_NUMBER(TO_CHAR(HIREDATE, 'MM')) FROM EMP;
-- /4���ϸ� 1~3, 4~6...
SELECT HIREDATE, TO_NUMBER(TO_CHAR(HIREDATE, 'MM'))/4 FROM EMP;
-- FLOOR() �Ҽ������� ���� ����ó��
SELECT HIREDATE, FLOOR(TO_NUMBER(TO_CHAR(HIREDATE, 'MM'))/4) FROM EMP;
-- Ư�� �Լ��� ó���� �����͸� �׷캰�� ���ġ�� ������ ��, Ȱ��ȴ�.
SELECT FLOOR(TO_NUMBER(TO_CHAR(HIREDATE, 'MM'))/4) PART,
		COUNT(*)
FROM EMP
GROUP BY FLOOR(TO_NUMBER(TO_CHAR(HIREDATE, 'MM'))/4);

/*
����
���� �������� �ο����� üũ�ϼ���
����		�����(�ְ�ġ,����ġ,���ġ)
1000�̸�	@@
~2000�̸�	@@@
~3000�̸�	@@
~4000�̸�	
~5000�̸�	
~6000�̸�	
*/
SELECT TRUNC(SAL/1000), COUNT(SAL), MAX(SAL), MIN(SAL), AVG(SAL) 
FROM EMP 
GROUP BY TRUNC(SAL/1000);

/*
HAVING ����
GROUP BY �ȿ� �־��� �׷��� �����Ϳ� ���� ������ ó���ϰ��� �� ��, Ȱ��ȴ�.
EX) �μ����� ��� ������ ó���ϰ�,
	�� �׷캰 ��� �������� 2000�̻��� �����͸� �ε��ϼ���.
*/
SELECT DEPTNO, AVG(SAL)
FROM EMP
WHERE SAL >= 2000 -- ����� �׷캰�� �������� ����ó��
GROUP BY DEPTNO
HAVING AVG(SAL) >= 2000; -- �׷쳻���� ����ó��

-- ex) �μ��� �ִ밪�� �ּҰ��� ���ϵ� �ִ� �޿��� 2900�̻��� �μ���
SELECT DEPTNO, MAX(SAL), MIN(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING MAX(SAL) >= 2900;