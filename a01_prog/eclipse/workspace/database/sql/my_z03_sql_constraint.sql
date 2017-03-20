/*
������ ���Ἲ ���� ����?
�������� �ŷڼ��� Ȯ���ϱ� ���Ͽ�, ���̺� ������, �÷� �Ӽ�������
�����ϴ� ���� ���Ѵ�.
#�������� 5����..
1) not null : null ������� �ʴ´�
2) unique : ���ϰ��� �Է��� ������� �ʴ´�
3) primary key : not null�� unique�� ó���ؾ� �ϴ� ��..
4) foreign key : �����Ǵ� ���̺��� �÷����� �����ؾ� �Է��� ����
5) check : ���� ������ �����Ͱ��� ������ ������ ����..
*/
create table emp02
(
	empno number(4) not null,
	ename varchar2(10) not null,
	job varchar2(9),
	deptno number(4)
);
-- �������ǿ� �մ��ؾ��� �����Ͱ� �Է��� �����ϰԲ� ó����
insert into emp02 values(1000, 'ȫ�浿', '�븮', 30);
select * from emp02;
/*
unique �������� : ������ �Է¿� �־, ������ ������ �Է��� ������� �ʴ� ���� ���Ѵ�.
emp03 ���̺� 
*/
create table emp03
(
	empno number(4) unique,
	ename varchar(25),
	mgr number(4)
);
insert into emp03 values(1000, 'himan', null);
insert into emp03 values(1001, 'himan2', 7788);
insert into emp03 values(1002, null, null);
insert into emp03 values(1003, 'himan3', 8888);
-- insert into emp03 values(1003, 'himan4', 8899);  error
select * from emp03;

/*
primary key : not null(�ݵ�� ������ �Է��ؾ�), unique(�ݵ�� ������ ������)
	�� ������ �Ѵ� ó���� ��, ���δ�. �ַ� �������̺��� key���� ������ �� Ȱ��ȴ�.
	ex) member���̺� memberid���� primary key�� �����ϼ���..
*/
create table member
(
	memberid varchar(20) primary key,
	pass varchar(20),
	name varchar(50),
	loc varchar(100)
);
insert into member values('1111', '7777', 'ȫ�浿', '���ﰭ��');
insert into member values('1112', '7777', 'ȫ�浿', '���ﰭ��');
-- insert into member values(null, '7777', 'ȫ�浿', '���ﰭ��'); error

/*
foreign key : �����Ǵ� ���̺��� �ݵ�� ���� �Է��ؾ� �ϴ� ��츦 ���Ѵ�.
*/
DROP TABLE DEPT_REF;

create table dept_ref
(
	deptno number(2) PRIMARY KEY,
	dname varchar2(14),
	loc varchar2(13)
);

CREATE TABLE EMP_REF
(
   EMPNO      NUMBER (4) PRIMARY KEY,
   ENAME      VARCHAR2 (10),
   JOB        VARCHAR2 (9),
   MGR        NUMBER (4),
   HIREDATE   DATE,
   SAL        NUMBER (7, 2),
   COMM       NUMBER (7, 2),
   DEPTNO     NUMBER (2) REFERENCES DEPT_REF(DEPTNO)
);
-- �÷� Ÿ��
INSERT INTO DEPT_REF VALUES(10, '�λ�', '����');
SELECT * FROM DEPT_REF;
INSERT INTO EMP_REF(EMPNO, ENAME, DEPTNO) VALUES(1000, 'ȫ�浿', 10);
INSERT INTO EMP_REF(EMPNO, ENAME, DEPTNO) VALUES(1001, '�ű浿', 20);

/*
����
����Ű ���迡 �ִ� ���̺� �����ϱ�
�������̺� student_main(id,pass,name) : ���̵�, �н�����, �̸�
�������̺� student_point(id,subject, point):���̵� ���� ����
student_main�� student_point id�� foreign key ���踦 �����ϰ�,
student_main�� �����Ͱ� �־�߸� student_point�� �Է��� �� �ְԲ� ó��
*/
/*
check ���� ����
�ԷµǴ� ���� üũ�Ͽ� ������ �� �̿��� ���� ������ ���ϰ� ������ �����ϴ� ���� ���Ѵ�.
ex) ������̺� gender��� �÷��� �ΰ�, ���⿡ 'M', 'F' �ΰ��� �� �̿ܿ��� �Էµ���
���ϰ� ó������.
*/
create table emp04
(
	empno number(4),
	ename varchar2(10),
	gender varchar2(1) check(gender in('M', 'F'))
);

-- insert into emp04 values(9998, '�ű浿', 'D'); error