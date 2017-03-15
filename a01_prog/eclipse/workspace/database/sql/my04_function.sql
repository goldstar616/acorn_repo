/*
�����Լ� : ���ڸ� ó���ϴ� �Լ�. ���밪, �����Լ�(sin, cos, tan...)
			�ø�(ceil), �ݿø�(round), ����(trunc, floor), ������(mod)�� ó����.
1. abs : ���밪-��ȣ�� ���� ����, ����� ó���ϴ� �Լ��� ���Ѵ�.
*/
select 25, -25, abs(25), abs(-25) from dual;

/*
2. floor() : �Ҽ��� �Ʒ��� ������ �Լ�.
*/
select 25.75, floor(25.75) from dual;

/*
3. round() : �ݿø� ó�� �Լ�
	round(������, �ݿø��� �ڸ���)
		�ݿø��� �ڸ��� : ��� - �Ҽ��� ������ �ڸ��� ó��
							���� - �ʴ���(1), �����(2) ������ �ش� ������ŭ �ݿø�ó��.
*/
select 25.278888, round(25.278888, 2) from dual;
select 625.2999, round(625.2999, -2) from dual; -- ���ڸ��� �ݿø� ó����.
-- ����) sal�� �����̶�� �� ��, �̴� �޿���(1/13)�� ó���Ͻÿ�, �� �̴��� ���ʽ��� �ִ� ���Դϴ�.
-- ��³��� : ���, ����, �̴ޱ޿�, ���ʽ�, �ѱ޿���
select empno, sal, round(sal/13), nvl(comm, 0), round((sal/13) + nvl(comm, 0)) from emp;

/*
4. trunc() : Ư�� �ڸ��� ���Ϸ� ���� ó��
	trunc(������, �ڸ���ó��)
*/ 
select trunc(24.2433, 2), trunc(24.243, -1) from dual;

/*
���� sal�� ��������
1000�̸�		10% �λ�
1000~2000�̸�	20% ���ʽ�
2000~3000�̸�	30% ���ʽ�
3000~4000�̸�	40% ���ʽ�
4000~5000�̸�	50% ���ʽ�
5000~�̻�		60% ���ʽ���
�����ϱ�� �ߴ�.. �Լ��� Ȱ���ؼ�, �Ʒ� ������ ó���Ͻÿ�.
��� �̸� ���� ���ʽ�(%) ���ʽ�
*/



-- �����ȣ�� Ȧ���� ����� �˻��ϼ���..
select * from emp
where mod(empno, 2) = 1;

/*
����
����� �μ� �������� 1���� 2������ ����� ü����ȸ�� �ϱ�� �ߴ�.
�μ���ȣ�� 10, 30 ==> 1��
�μ���ȣ�� 20, 40 ==> 2��
���� ������ ������ ���� ����ϼ���.
�μ���ȣ �����ȣ �̸� ���� 
*/
select deptno, empno, ename, (mod(deptno/10, 2) + 1)||'��' from emp; 

/*
���� ó�� �Լ�.
1. upper ��� �����͸� �빮�ڷ� ��ȯó��
	upper(������)
	�Ϲ������� ������Ͱ� �ҹ��ڳ� �빮�ڰ� ���� �ԷµǾ� �ִ� ���,
	�ش� �����͸� �Է¹���(��ҹ��� ���о���)�� �ش� �����͸� �˻��� ��� ���� ���δ�.
*/
select upper('hi! Good days!!') from dual;

/*
2. �ҹ��ڸ� ��ȯ�ϴ� lower�Լ�..
	lower(������)
*/
select lower('Good night!!! This is the Best day!!') from dual;
select empno, lower(ename), lower(job) from emp;

/*
3. initcap�Լ� : ù���ڸ� �빮��, �������� �ҹ��� ó��..
	initcap(������)
*/
select initcap(ename), initcap(job) from emp;
/* Smith is a Cleck!! ���� ���..*/
select initcap(ename)||' is a '||initcap(job)||'!!!' introJob from emp;

/*
4. ���ڱ��̸� ó���ϴ� length
���� length(������)
*/
select length('himan') from dual;
--��å�� 5�� ������ �����͸� ����ϼ���..
select * from emp where length(job) <= 5;

/*
5.lengthb() : byte�� ũ�⸦ ��� - ����(1�ڴ� 1byte), �ѱ�(1�ڴ� 2bytes)
*/
select lengthb('himan'), lengthb('ȫ�浿') from dual;

/*
6. substr(), substrb() : Ư�� ���ڿ��� �Ϻθ� �����ϴ� �Լ�.
	substr(������, 1���� count�Ͽ� ������ ��ġ����, ������ ���ڿ��� ����)
*/
select substr('welcome to Oracle world!!', 4, 5) from dual;
/* ex) job�� �������� 5���� ���ڿ��� �����Ͽ�, �̸��� ��å�� ��� */
select ename, substr(job, 1, 5) from emp;
/*
Ȯ�ο���
�Ʒ� ������ �����͸� ȭ�鿡 list�ϼ���..
���	�̸�	��å(�̸��� ���ڿ��� ��ŭ�� ǥ��)
*/
select empno, ename, substr(job, 1, length(ename)) from emp;
-- hiredate�� ���, ������ type�� ��¥����������, �ڵ� ����ȯ�� �Ǿ�
-- ���ڿ� ó�� �Լ��� ���ڿ��� �����Ͽ� ó���� �� �ִ�.
select substr(hiredate, 1, length(hiredate)) from emp;
-- 1980�� �����͸� ��Ÿ������..
select * from emp
where substr(hiredate, 1, 2) = '80';
-- 1982�� 12�� 01�� ~ 1982�� 12�� 31�� �Ի����� ����� �̸��� �Ի��Ϸ� ����ϼ���.
select ename, hiredate from emp 
where substr(hiredate, 1, 5) = '82/12';
-- ����) �Լ��� �̿��Ͽ� ���� ������ ����ϼ���..
-- @@@�� �Ի����� @@�� @@�� @@�� �̸�, ���� ������ @@@ ���� �ް� �ֽ��ϴ�.
-- column�� empinfo
-- ����) substr�� Ȱ���Ͽ� JOB�� MAN���� ������ �����͸� ����ϼ���!!

/*
7. Ư�� ������ ��ġ�� ���� instr
	instr(������, '�˻��� ����')
*/
select instr('hi!! good man', 'man') from dual;
/*
instr(������, '�˻��� ����', �˻��� ������ġ, ���° �˻���ġ ����� ������ ���ϴ� ����)
instr('hi!! oh my girl!! hi!! feel so good!', 'o', 3, 2);
*/
select instr('hi!! oh my girl!! hi!! feel so good!', 'o', 3, 2) from dual;
/* 
����
�Ի����� 12���� �����͸� �̸��� �Ի����� ����ϼ��� instr()�� Ȱ�� 
*/