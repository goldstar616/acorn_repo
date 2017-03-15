--
/*
or ������ : ��ȸ ���ǿ� �־, �ϳ��� ���Ǹ� �����ϴ���,
			�ش� �����Ͱ� ��� ó���Ǵ� ���� ���Ѵ�.
select �÷�
from ���̺��
where �÷�1 = ����1 or �÷�2 = ����2;
�������� ���� �÷�1=����1�� �����ϰų�, �÷�2=����2�� ������ ��
�����Ͱ� ��Ÿ���� ������ �ش� �����͸� ���� list�Ѵ�.
ex) �μ���ȣ�� 30�̰ų� ������� 'SMITH'�� �����͸� list�ϼ���. 
*/
select * from emp where deptno=30 or ename='SMITH';
-- Ȯ�ο��� ���ʽ��� �ְų� ��å�� 'SALESMAN'�� ���� ����ϼ���.
select * from emp where (nvl(comm, 0) != 0) or job='SALESNAM';

/*
NOT ������
�ش� �����ڴ� ���̸� ����, �����̸� ������ ó���Ǿ� ��Ÿ�� �ʿ䰡 ���� ��,
Ȱ���Ѵ�.
�Ϲ������� , ���� �̿ܿ� �����͸� ����Ʈ�ϰ��� �� �� Ȱ��ȴ�. 
*/
select * from emp where not deptno = 10; -- deptno <> 10, deptno != 10 (������ ȿ��)
-- Ȯ�ο���) ������ 2000~3000�� �ƴ�(2000�̸� �̰ų� 3000�ʰ�)�� ���� not
-- keyword�� Ȱ���ؼ� list�ϼ���.
select * from emp where not (sal > 2000 and sal <= 3000);
-- Ȯ�ο���) ��å�� SALESMAN�� �ƴϰ�, ������ 2000�̻��� ����� LIST�ϼ���
select * from emp where not job = 'SALESMAN' and sal >= 2000;

/*
between and ������
�������� ������ Ư�� ���� ���̿� ���� ��, Ȱ��Ǵ� Ű�����̴�.
where �÷��� between A and B
�ش� �������� �÷��� ������ A�� B���̿� �ִ� ���� ���Ѵ�.
ex) ������ 2000���� 3000���̿� �ִ� �����͸� list�ϼ���..
*/
select * from emp
where sal between 2000 and 3000;
-- Ȯ�ο��� ����� 7400~7500 ���̿� ������ ������ 2000�̸��̰ų� 3000�ʰ��ϴ�
-- �����͸� list �ϼ���...
select * from emp
where (empno between 7400 and 7500) and not (sal between 2000 and 3000);

/*
��¥�� ���� ó��..
�Ի����� 1987/01/01 ���� 1987/12/31 ���̿� �ִ� �����͸� list�ϼ���..
*/
select * from emp
where hiredate between '1981/01/01' and '1981/12/31';
-- Ȯ�ο���) �Ի����� 1981�� 12���� �Ի��� ����� �̸��� �μ���ȣ�� ����ϼ���.
select * from emp
where hiredate between '1981/12/01' and '1981/12/31';

/*
IN ������
	�ش� �����Ϳ� ���� ������ ó���� ��, ���� �����Ϳ� ���� ��ȸ�� �ϰ��� �Ҷ� Ȱ��ȴ�.
	or�����ڿ� ������ ����
	����) �÷��� IN (�ش絥����1, �ش絥����2, �ش絥����3)
*/
-- ������ ��ȣ�� 7902, 7566, 7839�� ���� LIST�ϼ���..
select * from emp
where mgr in (7902, 7566, 7839);
-- Ȯ�ο���) ����̸��� 'SMITH', 'WARD', 'JONES' �� ��� ��,
-- 			������ 1000�̸��� �����͸�
--			�̸��� ������ ����ϼ���.
select ename, sal from emp
where ename in ('SMITH', 'WARD', 'JONES') and sal < 1000;

/*
******* ���迡 ���� ���� **********
like �����ڿ� ���ϵ�ī�� (%,_)Ȱ���ϱ�. 
Ư�� �����Ϳ� ���� ���ڿ� ��ü ������ ��Ȯ�ϰ� ���� ���� ��, �˻������� ���� like�����ڿ�
���ϵ�ī�带 Ȱ���ϴ� ����̴�..
����) �˻��÷��� like '%�˻��ҵ�����%';
ex) ������� K�� ���Ե� �����͸� list�ϼ���
*/
select * from emp
where ename like '%K%';
-- ���� K�� �����ϴ� �����͸� list�ҷ���?
select * from emp
where ename like 'K%';
-- ��å��, MAN���� ������ �����͸� list�ϼ���..
select * from emp
where ename like '%MAN';
-- Ȯ�ο���) ��å��, S�� �����ϴ� �����Ϳ��� ���ʽ��� 300�̰ų� 400�̰ų�,
--			700�� �����͸� ��å, �����, ���ʽ��� list�ϼ���..
select job, ename, comm
from emp
where job like 'S%'
and comm in(300,400,700);

/*
���ϵ�ī��(_) ����ϱ�
_���ڼ��� �����ؼ� �ش系���� �˻��ϰ��� �Ҷ�, Ȱ���Ѵ�..
ex) �ι�° ���ڰ� 'A'�� ����� list
*/
select * from emp
where ename like '_A%'; -- �ι�° ���ڰ� A�ε� ���� ��ü ���
-- Ȯ�ο���) ������� 3��° ���ڰ� A�� �������߿� �޿��� 2000�̻��� ���� list�ϼ���.
select * from emp
where ename like '__A%' and sal > 2000;

/*
NOT LIKE '���ϵ�ī��(%,_)' �ش� ������ �ƴ� ���� ���
ex) �̸��� 'A'���ڰ� ���Ե��� �ʴ� ����� �˻�.
*/
select * from emp
where ename not like '%A%';
-- Ȯ�ο���) ��å�� ER�� ������ �ʴ� ������ ��, 1981�⵵�� �Ի��� ����� list�ϼ���..
select * from emp
where job not like '%ER' and hiredate between '1981/01/01' and '1981/12/31';

/*
����ó��..
�����ʹ� ������ ���������� ��������, ������������ ����ó���� �� �ִ�.
�׷�, �̿� ���� ���صǴ� �÷��� ���ؾ� �ϸ�, ������������ �������������� ǥ���ؾ� �Ѵ�.
����) order by �����÷�1 asc/desc
asc(ascending) : ���������� ���ϸ� �Ϲ������� �������� ������ ������������ ��µȴ�. default
desc(descending) : ���������� ���Ѵ�. 
*/  
select * from emp
order by sal asc;
select * from emp
order by sal desc;
-- ex) ��å�� MANAGER�� �����͸� �Ի��� �������� ������������ LIST
select * from emp
where job = 'MANAGER'
order by hiredate asc;
-- Ȯ�ο���) ���ʽ��� �ִ� �����͸� �������� ������������ �����, �޿�, ���ʽ��� ����ϼ���
select ename, sal, comm
from emp
where comm is not null
order by comm desc;
-- comm�� ������ ���� sal�������� �������� ó���Ѵ�.
select ename, sal, comm
from emp
where comm is not null
order by comm desc, sal desc;
/*
Ȯ�ο���
1) �Ի����� ������������ �����ϵ�, �����ȣ, �����, ����, �Ի����� ���
2) �����ȣ�� �������� ������������ �����Ͽ� �����ȣ�� ����� ���
3) �μ���ȣ�� ���� ������� ����ϵ� ���� �μ��� ����� �ֱ� �Ի��� ������� ���
	�μ���ȣ, �Ի���, �����, �޿������� ���
*/
-- 1)
select empno, ename, job, hiredate
from emp
order by hiredate;
-- 2)
select empno, ename
from emp
order by empno desc;
-- 3)
select deptno, hiredate, ename, sal
from emp
order by deptno, hiredate desc;

select * from dual;
/*
dual : �����͸� �׽�Ʈ�ϱ� ���� �뵵�� oracle ���� ��ü, �� ������ ��µȴ�.
�ַ�, ����, �Լ����볻�� Ȯ���ϴµ� Ȱ��
*/
select 10+10 plus, sysdate, 10||'+'||10||'='||(10+10) calcu from dual;