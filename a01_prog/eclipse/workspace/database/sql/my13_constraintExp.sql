CREATE TABLE A01_NOT_NULLEXP
(
	EMPNO NUMBER NOT NULL,
	ENAME VARCHAR2(20) NOT NULL,
	JOB VARCHAR2(20)
);

CREATE TABLE A02_NULLEXP
(
	EMPNO NUMBER,
	ENAME VARCHAR2(20),
	JOB VARCHAR2(20)
);

/*
1) �����͸� �Է½�, ������ NULL�� �Է�
2) ������ �Է½�, ����� NULL�� �Է�
*/

INSERT INTO A01_NOT_NULLEXP VALUES('���α׷���1'); 
-- NOT NULL ����
INSERT INTO A02_NULLEXP VALUES('���α׷���2');

INSERT INTO A01_NOT_NULLEXP(JOB) VALUES('���α׷���1'); 
-- NOT NULL ����
INSERT INTO A01_NOT_NULLEXP(EMPNO, ENAME, JOB) VALUES(7000, 'ȫ�浿', '���α׷���1'); 
-- �����Է�
INSERT INTO A01_NOT_NULLEXP(EMPNO, JOB) VALUES(7001, '���α׷���1'); 
-- NOT NULL ���� (1���� �ɸ��� ����)
INSERT INTO A01_NOT_NULLEXP(EMPNO, ENAME) VALUES(7002, '�ű浿'); 
-- �����Է� JOB�� �������

/*
������ ��ųʸ�(DATA DICT)
CONSTRAINT_TYPE
���������� ������ ���� ������ �����ϴ� �κ�. *******����*******
P : PRIMARY KEY : ## - �������ǿ� NOT NULL, UNIQUE�� �����Ѵ�
						���� ���� ���̺���
R : FOREIGN KEY(�ܷ�Ű) : �ش� �÷��� �����Ͱ� ������ �ٸ� ���̺�
							�����Ͱ� �ݵ�� �־�� ó���Ǵ� ���
							EX) DEPT�� DEPTNO�� ���, �μ���ȣ�� ���� ����
							�μ����� KEY DEPTNO�� ��ϵǾ� �־����
							EMP���̺��� DEPTNO�� ������ �Է��� �� �ְԲ�
							ó���ؾ� ���Ἲ�� ��ų �� �ִ�
U
C
*/

/*
���������� ����� ����
1. ���̺� ������, ����
	����
	CREATE TABLE ���̺��
		�������Ǽ������÷� ������TYPE, EX) EMPNO NUMBER
		CONSTRAINT �������Ǹ�(���̺��_�÷���_���������������) ��������
								EX) CONSTRAINT EMP_EMPNO_PK PRIMARY KEY,
2. ���������� ���� �����Ͽ� �����ϴ� ���
	
*/

CREATE TABLE EMP50
(
	EMPNO NUMBER CONSTRAINT EMP_EMPNO_PK PRIMARY KEY,
	ENAME VARCHAR2(20)
);

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME='EMP50';

/*
Ȯ�ο���
	PROFESSOR ���̺��� �����ϵ�
	
*/

CREATE TABLE PROFESSOR
(
	PROID VARCHAR2(20) CONSTRAINT PROFESSOR_PROID_NN NOT NULL,
	NAME VARCHAR2(20) CONSTRAINT PROFESSOR_NAME_UN UNIQUE,
	MAJOR VARCHAR2(20)
);

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME='PROFESSOR';

/*
�ϳ��� �÷��� �ƴ϶�, �ΰ��� �÷����� ���������� �����ϴ� ���
EX) �л����̺��� KEY�� �ű� �÷����� �����ϴ� ���� �ƴ϶�
	GRADE(�г�) PART(��) NO(��ȣ)
����
	CREATE TABLE ���̺��
	(
		�÷���1 ������TYPE,
		�÷���2 ������TYPE,
		�÷���3 ������TYPE,
		CONSTRAINT �������Ǹ�(���̺�_�÷�����_�������) ��������(�÷�1, �÷�2)
	);
*/

create table highschool
(
   grade number,
   part number,
   no number,
   name varchar2(30),
   constraint highschool_dist_pk primary key(grade, part, no)
   --highschool���̺� primary key�� 3���� �÷����� ��µ�, grade, part, no 
   -- grade, part, no�� ���ÿ� �����ؼ� ������ �����Ͱ� �� �����Բ� ó��..
);
   
insert into highschool values(1,1,2,'��浿');
insert into highschool values (1,1,3,'�ű浿');
select * from highschool;

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME='HIGHSCHOOL';
/*
Ȯ�ο���
	ADDRESS��� ���̺�
	��/������	��/����		��		����	������	�ְ��ο�
	PRIMARY KEY(��/������	��/����		��		����)
*/

CREATE TABLE ADDRESS
(
	ADD1 VARCHAR2(10),
	ADD2 VARCHAR2(10),
	ADD3 VARCHAR2(10),
	ADD4 VARCHAR2(10),
	CONSTRAINT ADDRESS_ADD_PK PRIMARY KEY(ADD1,ADD2,ADD3,ADD4),
	OWNER VARCHAR(10),
	CNT NUMBER
);

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME='ADDRESS';