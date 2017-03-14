-- �÷��� �̸�(����) ���̱�!!
-- empno�� ��Ī���� companyNo�� ����� �ߴ�. ����ϼ���..
-- �÷��� as ��Ÿ�� ��Ī �÷��� alias
select empno as companyNo from emp;

-- ��Ī�� ���α׷� �������� �߿��� �ǹ̸� ������..
-- ��ټ� ���α׷��� ��Ī���� �����ϰ� ����ϴ� ��찡 ����.
-- ex) rs.getString("��Ī/�÷���")
-- as ��ſ� ����(' ')���� ó���Ѵ�.
select '����� '||empno ||' �Դϴ�!' show from emp;
-- ���� application������ rs.getString("show")�� ó���ȴ�.

-- ������ ������ ����� �÷����� ��Ÿ������..
-- �÷���		depandname		upgradeRatio	enterCompany
-- ��µ�����	(�μ���ȣ)�̸�	������ 10%		�Ի�����
select '( '||deptno||' ) '|| ename depandname, sal*0.1 upgradeRatio,
		hiredate enterCompany from emp;
		
-- ���鰪�� ��Ī���� ó���ϱ�..: " "���� ��Ī���� �����ش�.
select ename "name intro" from emp;
-- �ѱ��� ��Ī���� ó���� ����, " " ���̿� ó��
select deptno "�μ���ȣ" from emp;

-- �ߺ��� ó�� : �����ͺ��̽������� ������ ���� �Է��ϴ� ���� ���̺� ������
-- �Է��ϴ� ���� �����Ѵ�.
-- �÷��� �ִ� ��� �����Ͱ� �����ؼ��� �ȵȴٴ� ���̴�.
-- �׷���, �Ѱ� �÷����� ��ȸ�� ���� ������ �����Ͱ� ��Ÿ�� �� �ִ�.
select deptno from emp;
-- �� ��, �ϳ� �Ǵ� �ټ��� �÷��� �����Ͱ� ������ ���� filtering ���ִ� ó����
-- �ִµ� distinct��� �Ѵ�.
-- Ȱ������ select distinct �÷�1, �÷�2.. from ���̺�
select DISTINCT deptno from emp;

-- Ȯ�ο���1) -mgr�� ���ϰ� ���� ����ϼ���..
select distinct mgr from emp;
-- Ȯ�ο���2) job�� mgr �÷��� ���ϰ� ���� ����ϼ���..
select distinct job, mgr from emp;

/*
����ó��..
Ư���� ������ list���뿡�� �ʿ��� ������ �� �� ������ filtering ó���Ѵ�.
1. ���� ó��..
*/
-- ������ 3000�̻��� �����͸� list ó��..
-- where �÷��� > ���ǵ�����
select * from emp
where sal>=3000;
-- �����ͺ��̽����� ���̴� �񱳿�����
-- = (*), >, <, >=, <=,    <>, != (�ٸ���)
-- 1) �μ���ȣ 30�� �����͸� list �ϼ���..
select * from emp
where deptno = 30;
-- 2) ������ 1000�̸��� ������
select * from emp
where sal < 1000;
-- 3) ename�� SMITH�� ������
select * from emp
where ename = "SMITH";
-- 4) COMM�� NULL�� ������(*) - ���ݱ��� ��� �Լ� Ȱ��
select * from emp
where nvl(comm, 0) = 0; 
-- 5) MGR�� 7698�� �ƴ� ������
select * from emp
where mgr != 7698;

-- ���� ���� �ΰ��� ������ ���� ������ list�ϱ�..
-- ���� multi ���ǿ� ���� ó��..
-- ������ 3000�̻��� ����� �̸��� ������ list
select ename, sal from emp where sal>=3000;

-- ������ 2000�����̰� ��å�� SALESMAN�� �����
-- �̸�, ��å, ������ ���..
select ename "�̸�", job "��å", sal "����"
from emp
where sal<=2000
and job='SALESMAN';
-- �÷����� ��ҹ��� �������� ������, �����ʹ� ��ҹ��ڸ� �����Ѵ�.

/*
��������
1. EMP�߿� �޿��� 2000�̸��� �Ǵ� ��� ���� �߿� ����� �޿��� ����϶�.
2. ������ ���ʽ��� �ջ� �ݾ��� 1500�̸��� ����� �̸�, ����, ���ʽ�, �ջ����
	����ϼ���.
3. ��å�� MGR�� NULL�� ��� JOB�� �̸� ������ ����ϼ���.
4. JOB�� CLERK�� ����� DEPTNO�� 30�� ����� �̸�, ��å, �μ���ȣ�� ����ϼ���.
5. ������ 2000���� 3000 ���̿� �ִ� ����� �μ���ȣ,
	�̸�, ������ ����ϼ���.
### ȥ�� �ذ��ϰ�, �ذ����� ���ϴ� ������̳�, ����������� ������ �޾�
�ذ��ϰ�, �ٽ� ���ο� ������ �޾Ƽ� ȥ�� ������ �ذ��� �Ŀ� ����..~
*/
select empno, sal
from emp
where sal < 2000;

select ename, sal, nvl(comm, 0), (sal + nvl(comm, 0))
from emp
where (sal + nvl(comm, 0)) < 1500;

select job, ename, sal
from emp
where nvl(mgr, '0') = '0';

select ename, job, deptno
from emp
where job='CLERK' 
AND deptno=30;

select deptno, ename, sal
from emp
where sal <= 3000
and sal >= 2000;