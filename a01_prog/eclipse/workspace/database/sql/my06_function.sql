/*
DECODE () : ���� ó���� ���� �Լ�
	DECODE(������, ������1, ����1������,
					������2, ����2������,
					�׿ܿ� ������)
gender�̶�� �÷��� 0�̸� ����, 1�̸� ����, �׿� �߼�
*/
select decode(0,0,'����',1,'����','�߼�') gender01, 
		decode(1,0,'����',1,'����','�߼�') gender02,
		decode(2,0,'����',1,'����','�߼�') gender03,
		decode(3,0,'����',1,'����','�߼�') gender04
from dual;   
-- �μ���ȣ�� 10 ȸ��, 20 ����, 30 ����, 40 �, �� �ܴ� '����'
select ename, decode(deptno, 10, 'ȸ��',
							20, '����',
							30, '����',
							40, '�',
							'����') from emp;
/*
��å�� �ѱ۷� Ǯ���ؼ� ���ó��
CLERK : ����, SALESMAN : ������, MANAGER : ������.....
�����ȣ, ��å(�ѱ�), �޿�
*/							
select ename, DECODE(JOB, 'CLERK', '����',
							'SALESMAN', '������',
							'MANAGER', '������',
							'ANALYST', '�м���',
							'PRESIDENT', '��ǥ',
							'��Ÿ') "��å(�ѱ�)" from emp;
/* ���� ������ ���� ���ü�踦 �������� �Ѵ�.
decode�� Ȱ���ؼ�,
	1000 �̸�		F���	������ 3%
	1000 ~ 2000�̸�	E���	������ 5%
	2000 ~ 3000�̸�	D���	������ 7%
	3000 ~ 4000�̸�	C���	������ 4%
	4000 ~ 5000�̸�	B���	������ 3%
	5000 ~ 6000�̸�	A���	������ 2%
�̸� �μ� ���� ������� ������ �Ѿ�(����+������)
*/
select ename, sal, 
		decode(trunc(sal + 1000, -3)/1000, 1, 'F���',
											2, 'E���',
											3, 'D���',
											4, 'C���',
											5, 'B���',
											6, 'A���',
											'��Ÿ') "�������",
		decode(trunc(sal + 1000, -3)/1000, 1, sal * 0.03,
											2, sal * 0.05,	
											3, sal * 0.07,	
											4, sal * 0.04,	
											5, sal * 0.03,	
											6, sal * 0.02,
											sal) "������",
		decode(trunc(sal + 1000, -3)/1000, 1, sal * 1.03,
											2, sal * 1.05,	
											3, sal * 1.07,	
											4, sal * 1.04,	
											5, sal * 1.03,	
											6, sal * 1.02,
											sal) "�Ѿ�"										
from emp;

/*
case �Լ� : ���ǿ� ���� ���� �ٸ� ó���� ����
CASE WHEN ����1(�񱳿�����) THEN ó���ҵ�����
	WHEN ����2(�񱳿�����) THEN ó���ҵ�����
	WHEN ����3(�񱳿�����) THEN ó���ҵ�����
	ELSE �� ���ǿ� �ش����� ���� �� ó���� ������..
END
EX) ������ ���� ������� ��� ó��..
*/
SELECT CASE WHEN 80>=90 THEN 'A'
			WHEN 80>=80 THEN 'B'
			WHEN 80>=70 THEN 'C'
			WHEN 80>=60 THEN 'D'
		ELSE 'F'
	END GRADE
FROM DUAL;
-- �μ���ȣ�� �������� �űԺμ� ���ġ ó���Ѵ�.
SELECT EMPNO, ENAME,
	CASE WHEN DEPTNO=10 THEN '�μ��̵�'
		WHEN DEPTNO=20 THEN '�ο�����'
		WHEN DEPTNO=30 THEN '��������'
		ELSE '���μ�����'
	END RESULT
FROM EMP;
/*
����) �Ի� �б� ���� ǥ��(1/4, 2/4, 3/4, 4/4) �Ի� �б⸦ ǥ��
�����ȣ, �̸�, �Ի�(��/��), �Ի�б�
*/
select empno, ename, to_char(hiredate, 'YY/MM'),
	case when trunc((to_number(to_char(hiredate, 'MM'))-1)/3) = 0 then '1��б�'
		when trunc((to_number(to_char(hiredate, 'MM'))-1)/3) = 1 then '2��б�'
		when trunc((to_number(to_char(hiredate, 'MM'))-1)/3) = 2 then '3��б�'
		when trunc((to_number(to_char(hiredate, 'MM'))-1)/3) = 3 then '4��б�'
		else '����'
	end "�Ի�б�"
from emp;