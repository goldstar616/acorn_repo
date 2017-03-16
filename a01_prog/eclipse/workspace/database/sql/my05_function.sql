/*
LPAD/RPAD �Լ�.
Ư�� ���ڿ��� �ش��ϴ� ���ڿ��� ä��� ó���� �ϴ� ���� ���Ѵ�.
LPAD : ���ʿ� ���ڷ� ä�켼��
	LPAD(������, ��ü ���ڿ� ũ��, '�ݺ��� ���ڿ�')
# himan�̶�� ���ڿ� ���ʿ� '#' 20��
��ü ũ�⸦ �����, �ش� ũ�Ⱑ ���� ������ ���ڷ� ä��..
varchar : ����������, char : ����������
*/
select lpad('himan', 20, '#') from dual;

/*
RPAD : �����ʿ� �ش� ũ�Ⱑ �� ������ Ư�����ڷ� ä��..
ex) good job���� ���ڰ� 20���� �� ������ @�� �����ʿ� ä��
*/
select rpad('good job', 20, '@') from dual;
-- Ȯ�ο���) ename�� job�� ũ��� ������ ���ڿ���ŭ �����ʰ� ���ʿ� �ش� ���ڿ��� �Ʒ� ��������
-- ��������..
-- 1. ename�� job���� ������ ũ�⸦ Ȯ���Ѵ�.
-- 2. ������ �߿� ���� ū �������� ũ�⸦ Ȯ���ؼ�.
-- 3. ename���� �����ʿ� @, job���� ���ʿ� ^�� �߰��ؼ� ��Ÿ���� �Ѵ�.
-- 4. ������ ���� ������ ���
--		�����ȣ	�̸�(@)	��å(^)	�Ի���
select max(length(ename)), max(length(job)) from emp;
select empno, rpad(ename, 6, '@'), lpad(job, 9, '^'), hiredate from emp;

/*
������ ���ڸ� �����ϴ� ���
LTRIM : ���ʿ� ���鹮�ڸ� �����ϴ� ó��
RTRIM : �����ʿ� ���鹮�ڸ� �����ϴ� ó��
ex) [����]This is your best day!! ���ʿ� ���鹮�ڸ� ���� ó��..!!
*/
select ltrim('     this is your best day!!!') showData,
		length('    this is your best day!!!') beforeLen,
		length(ltrim('    this is your best day!!!')) afterLen
from dual;
-- �����ʿ� ���鹮�ڿ��� �����ϴ� ó��
select rtrim('what we dwell on is who we become!    ') showdata,
		length('what we dwell on is who we become!    ') beforeLen,
		length(rtrim('what we dwell on is who we become!    ')) afterLen
from dual;

/*
trim
	������, ���ʿ� �ִ� ������ ����ؼ� Ư�� ���ڿ��� ���� ó���ϴ� �Լ�.
	trim('������ ���ڿ�' from data)
	ex)'aaaaaaaaGood morning!!aaaaaaaaaa'���� �����ʰ� ���ʿ� a���ڿ��� ����ó��
*/
select trim('a' from 'aaaaaaaaGood morning!!aaaaaaaaaa') showdata from dual;
-- Ȯ�ο���) job�� 'N'�̳� 'R', 'T'�� ������ ������ �������� ������ ���� ����ϼ���.
-- �̸� ��å
select ename, trim('T' from trim('R' from trim('N' from job))) from emp;

/*
��¥ �Լ�..
sysdate : ����Ŭ ����� ���� ��¥�� �ð��� ����ϴ� ��ü..
*/
select sysdate from dual;
select sysdate+1 from dual;
select sysdate-1 from dual;
select sysdate today, sysdate-1 yesterday, sysdate+1 tomorrow from dual;
select ename, hiredate, sysdate, sysdate - hiredate from emp;

/*
months_between : �ΰ��� ��¥ ������ ������ ���� ���� ���ϴ� ����..
	months_between(�񱳳�¥������1, �񱳳�¥������2)
ex) �� �������� �ٹ��� ���� ���� ���ϼ���..
*/
select ename, hiredate, months_between(sysdate, hiredate) workingMonth from emp;

/*
add_months : �̷������� ��Ÿ���� �Լ��� ���� ���� ���ؼ� �ش糯¥�� ��Ÿ���� �Ѵ�.
	add_months(���ص�����, ���İ�����)
ex) �Ի� ��¥���� 6������ �߰��� ��¥�� ����ϼ���.
*/
select ename, hiredate, add_months(hiredate, 6) after6Months from emp;

/*
����1)
6������ ���ϱⰣ���� �޿��� 70%�� �����ϱ�� �ߴ�.
����� ���ϱⰣ��������� ����ϰ�, 6�������� �޿��� ������ ����ϼ���..
���޿� - sal/13
���ϱⰣ - ���޿��� 70%
���ϱⰣ���޿��Ѿ� - ���ϱⰣ6������ �޿� �Ѿ��� 10���� �����ؼ� ���
�����ȣ	�����	�Ի���	���ϱⰣ�������	���ϱⰣ���޿�(10��������)
*/
select empno, ename, hiredate, add_months(hiredate, 6), trunc(((sal/13) * 0.7) * 6, -1) from emp; 

/*
next_day : �ְ������� ���� ����� ��¥�� ������ ��, Ȱ��..
	next_day(��¥������, '����') : �ش� ���Ͽ� ���� ����� ��¥ ���..
*/
select sysdate, next_day(sysdate, '������') from dual;
/*
Ȯ�ο���) ������� �Ի���, ù��° ������� ����ϼ���..
*/
select ename, hiredate, next_day(hiredate, '�����') firstHoliday from emp;

/*
last_day �Լ�
	�ش� ���� ������ ��¥�� ��ȯó��.
*/
select last_day(sysdate) thisLastDate, 
	last_day(sysdate)+1 nextFirstDate from dual; -- ������ ù��
	
-- (����) �޿� ���.. 3�ܰ� �޿����� ����� ����ϼ���.
-- 1�ܰ� ��� 20��
-- 2�ܰ� ��� ��������
-- 3�ܰ� ������ 10��
-- ��� �Ի��� ù����1 ù����2 ù����3
select ename, hiredate,
		last_day(add_months(hiredate, -1))+20,
		last_day(hiredate) grade02,
		last_day(hiredate)+10
		from emp;
		
/*
����ȯ �Լ�
����Ŭ���� �����Ͱ� ����ȯ�� �ؼ�, �ʿ��� �����̳� type���� ��Ÿ���� �Ѵ�.
�� ��, Ȱ���ϴ� ���� ����ȯ �Լ��̴�.
to_char() : ��¥�� �������� ���������� ��ȯ
to_date() : �������� ��¥������ ��ȯ
to_number() : �������� ���������� ��ȯ

to_char()
1) ��¥���� ���������� ��ȯ�ϱ�.
	to_char(��¥������, 'ǥ���� ��������')
	ǥ���ϴ� ���� ������ ����
	YYYY : �⵵ ǥ��, YY : �⵵ 2�ڸ� ǥ��
	MM : �� ǥ��, MON : �� �������� ǥ�� ex)JAN
	DAY : ���� ǥ��, DY : ���� ��� ǥ��
	DD : ��¥ ǥ��
	
ex) �Ի����� �⵵-��-�Ϸ� ǥ���Ͻÿ�..
*/
select ename, to_char(hiredate, 'YYYY-MM-DD') hiredate1,
		to_char(hiredate, 'YY-MM-DD') hiredate2,
		to_char(hiredate, 'YYYY"��" MM"��" DD"��"') hiredate2
		from emp;
-- Ȯ�ο���
-- �Ʒ��������� ����ϼ���.
-- [����̸�]�� @@�� @@�� @@�Ͽ� �޿��� @@@���� �ޱ�� �ϰ� �Ի��߽��ϴ�.
select '['||ename||']�� '||to_char(hiredate, 'YY"��" MM"��" DD"��"')
		||'�� �޿��� '||sal||'���� �ޱ�� �ϰ� �Ի��߽��ϴ�.' from emp; 
/*
2) �ð�������� to_char(��¥������, '��¥������� �ð��������')
	AM �Ǵ� PM : �������� ǥ��
	AM. �Ǵ� PM. : ����. ����. ǥ��
	HH �Ǵ� HH12 : 12�ð� ǥ��(1~12)
	HH24 : 24�ð� ǥ��(0~23)
	MI : minutes ��ǥ��
	SS : seconds ��ǥ��
ex) ����ð��� ��¥�� �ð� ���Ŀ� ���� ǥ��
	YYYY/MM/DD	HH24:MI:SS
*/
select to_char(sysdate, 'YYYY/MM/DD HH24:MI:SS') today from dual;
/*
����
	�ٹ��������� ���� ���� ���ʽ� ����
	���� ������ ����~���� �ֱٿ� �Ի��� ������
	1/3 = 30%, 1/3 = 20%, 1/3 = 10% (��������)
	���, �Ի���, ���糯¥(@@/@@/@@ AM @@�� @@�� @@��), �ٹ�������,
*/
select ename, hiredate, to_char(sysdate, 'YY/MM/DD AM HH24:MI:SS') , trunc((sysdate - hiredate)/365) from emp;

/*
�������� ������ ó��..
to_char(������, '����')

�������
0 : �ڸ����� ���� ���� ���, ������ �ڸ����� ���� �������� �ڸ��� ���� ū��쿡
	0���� ä������.
9 : �ڸ��� ������� �ش� ������ ��Ÿ��. ä������ �ʴ´�.
L : ������ ���ݴ���ǥ��
. : �Ҽ��� ǥ��
, : õ���� ǥ��
*/
select to_char(1000, '00000') from dual; -- �ش� �ڸ������� Ŭ�� 0���� ä����.
select to_char(1000, '99999') from dual; -- ä������ ó������ ����.
select to_char(1000, '999') from dual; -- �ڸ����� ������ ##�� ǥ�õ�.
select to_char(24333, 'L999999') from dual; -- ������ ǥ��
select to_char(24333, 'L999,999') from dual; -- õ(,)���� ǥ��
select to_char(24333.2422, '999,999.999') from dual; -- �Ҽ���(.) ǥ��
-- Ȯ��) �̸��� �޿��� ǥ���ϵ�
-- �޿��� �Ҽ��� ���ϴ� ǥ�õ��� �ʰ�, �ڸ����� 7�ڸ��� ǥ���ϵ� ��Ÿ���� �ʴ�
-- �ڸ��� '0'���� ǥ���Ͻð�
select ename, to_char(sal, 'L0000000') from emp;

/*
to_date():
�Է��� ��¥���� ���ڸ� �Է��� ��, ��¥ �����͸� ��ȸ ó��..
�˻��� �ҷ��� ���ڸ� ��¥�� ��ȯ�Ͽ� ó��..
���ڴ� ��¥���·� ��� �ν��ϴ°�?
1980/12/12 --> to_date()���� � �������� �Է��� ������ ����.!!!
to_date(�Էµ�����, '������ ����')
ex) to_date(19811020, 'YYYYMMDD')
select * from emp
where hiredate='12/17/1980'; (x)
�Ի����� 1980/12/17�� �����͸� �˻�
*/
select * from emp
where hiredate=to_date('1980/12/17', 'YYYY/MM/DD');

/*
Ȯ�ο���) �Է°��� '1981-02-20'�̸�, �� �����ͷ� �˻��Ǵ� �Ի��Ͽ� �ش��ϴ�
			�����	�Ի���(1981��02��20��)�� ����Ϸ��� �Ѵ�.
*/
select ename, to_char(hiredate, 'YYYY"��""MM"��"DD"��"') "�Ի���"
from emp
where hiredate=to_date('1981-02-20', 'YYYY-MM-DD');
/*
����
��ȸ���� '1981�� 01�� 01��'���� '1982�� 12�� 12��' ������ ������ ��,
	�μ��� 30�� �����͸� ��ȸ�Ͽ�,
list����
	�����(10�ڸ�-�տ� #��ȣó��)
	��å(10�ڸ�-�������ڿ� '-'ó��)
	�Ի���(@@�� @@�� @@�� @���� 24�� @@�� @@��)
	����( ####1,600.0 ǥ��)�� ��Ÿ������.. 
*/
select lpad(ename, 10 , '#'), rpad(ename, 10, '-'), to_char(hiredate, 'YYYY"�� "MM"�� "DD"�� "DAY" "HH24"�� "MI"�� "SS"��"'), lpad(to_char(sal, '9,999.9'), 11, '#') from emp;

/*
������ ���ڿ��� �ԷµǾ��� ��, ó���� to_number() �Լ�
�ԷµǴ� ���ڿ��� ������ ����, to_number�� ������ �Է� ó��..
to_number(�Է��� ������, '��������')
*/
-- select '20,000' - '30,000' from dual;
select to_number('20,000','99,999') - to_number('30,000', '99,999') calcu from dual;
-- Ȯ�ο���) ������ �˻��ҷ��� �Ѵ�. '3,000'�̶�� �Է°��� ���� 3000������ ������
-- ���� ����� �̸��� ������ W(��) 3,000�� ����ϼ���.
select ename, to_char(sal, 'L99,999')
from emp
where sal < to_number('3,000', '9,999');
/*
������ ���ʽ��� �ջ��� �ݾ��� �̸��� �Ѿ����� ǥ���ҷ��� �Ѵ�.
nvl : �ش� �����Ͱ� null�϶�, ǥ���� default �����͸� �����Ͽ�,
	���� ���� ������ ���������� �����͸� ó���ϱ� ���� ���̴�.
	���� nvl(������,0)	�����϶��� 0
	���� nvl(������,' ')	�����϶��� ' '�������� ó��..
*/
select ename, sal, comm, sal+nvl(comm,0) tot
from emp;
-- ���� �̸� �����ڹ�ȣ ���ʽ� ==> �����Ͱ� ���� ���� �����ڹ�ȣ��� '�ְ���', ���ʽ��� '0'ǥ��
select ename, nvl(to_char(mgr), '�ְ���'), nvl(comm, 0) from emp; 