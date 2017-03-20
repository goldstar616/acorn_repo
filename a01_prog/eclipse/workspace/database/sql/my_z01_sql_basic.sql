/*
1. DML : Data Maniplulation Language
1) select : ��ȸ�� ���.
2) insert : ������ �Է½� ���.
   insert into ���̺�� values(������1, ������2, ������3);
*/
/*
���̺� �����ϱ�
create table ���ο����̺��
as select * from ���������̺��;
*/
create table dept01
as select * from dept;
/*
������ �Է�1)
ex) insert into dept01 values(50, '�ѹ���', '����');
*/
insert into dept01 values(50, '�ѹ���', '����');
commit; -- Ȯ��ó��, �������ϰų� �ٸ� ����ڵ� ����� �����͸� �� �� �ְ�.

/*
������ �Է�2
insert into ���̺��(�������÷���1, �������÷���2) 
			values (ù��°�Է��ҵ�����, �ι�°�Է��ҵ�����);
ex) dept01���̺��� deptno�� 60�� �Է��Ѵ�.
	dept01���̺��� deptno�� loc�� �Է��Ѵ�.
*/
insert into dept01(deptno) values(60);
insert into dept01(deptno, loc) values(70, '��õ');

/*
3) update : �ԷµǾ� �ִ� ������ ������, ������ �ʿ��� �κ��� ����ó���Ѵ�.
	update ���̺��
	set �����ϰ��� �ϴ� �÷��� = ������ ������
	where �����ϰ��� �ϴ� ����(�÷���=���ǵ�����)
*/
update dept01
set dname='�λ�',
	loc='����'
where deptno=60;
select * from dept01;

-- emp01�̶�� ���� ���̺��� �����
-- 1) empno�� ���� ���� ��ȣ���� +1�ؼ�, ename�� job, sal�� �Է��ϼ���
-- 2) �׿ܿ� �÷� mgr, hiredate(sysdate-���糯¥�� ����), deptno�� 40���� �����ϼ���
create table emp01
as select * from emp;
select max(empno)+1 from emp01;
insert into emp01(empno, ename, job, sal) values(7935, 'ȫ�浿','SUPERMAN', 5000);
update emp01
set mgr='7777',
	hiredate=sysdate,
	deptno=40
where empno=7935;
select * from emp01 where empno=7935;

/*
����
emp03 �������̺� ����
1. �Է� empno�� ���� ���������� -1, mgr:cleark�� mgr�Է�, sal:��տ���,
	comm:��ü comm�� �հ�
2. ���� ename:'�ű浿', job�� SUPERMAN, hiredate�� �ֱٿ� �Ի���+1
*/

/*
4. delete : Ư�� ������ �����͸� ����ó���ϴ� ����
	delete [����] from ���̺��
	where ����[�÷��� = ���ǵ�����]
*/
-- DNAME�� 'SALES'�� �����͸� DEPT01���� �����Ͻÿ�..
delete from dept01
where DNAME='SALES';
--Ȯ�ο��� deptno�� 50�̻��� �����͸� ��� �����Ͻÿ�..
--			emp01���̺� comm�� null�̰�, deptno�� 20�� �����͸� �����ϼ���.
delete from dept01
where deptno >= 50;
delete from emp01
where comm is null and deptno=20;

/*
transaction(Ʈ�����) : �����ͺ��̽����� ó���� �� ������ �ǹ��ϸ�,
�������� sql���� �ϳ��� ���� �۾� ������ ó���ϴµ� �̸� �ǹ��ϱ⵵ �Ѵ�.
tcl(transaction control language) : �̷��� Ʈ������� ��� ���� ��ɾ�..
commit : �������� dml�� ���� ����, ����, �Էµ� ������ Ȯ��ó��..
rollback : �����͸� commit�ϱ����� ���� ���� �Էµ� ������ ����ó��..
savepoint : �����͸� Ư���������� ����ó���ϰ��� �� ��, ������ save�ϴ� ���� ���Ѵ�..
*/
-- 1) dept01���̺� deptno 30 '�ѹ�' '����'�� �Է��� ��, rollbackó���� �غ���.
-- 2) dept01���̺� deptno 40 '�λ�' '����'�� �Է��� ��,
--		commit�ϰ� �������� ���� commit���� �ʰ� �������� ��� ��������
--		���� ������ Ȯ���Ѵ�.
insert into dept01 values(30, '�湫', '����');
rollback;
insert into dept01 values(40, '�λ�', '����');
-- db������ ���´�.
-- �ܺο��� commit�ϱ� ������ �����Ͱ� ���� ������ �ȴ�.
-- tool�� ���� autocommit�� �߻��ϴ� ��찡 �ִ�..

/*
*/