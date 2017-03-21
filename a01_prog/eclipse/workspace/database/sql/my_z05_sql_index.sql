/*
�ε�����?
�����Ϳ� ������ �����ϴ� ���� ���� �����μ� �����ͺ��̽��� ���� ��� ������ �ִ� ��ü
1) ����
- �˻� �ӵ��� ��������.
- �ý��ۿ� �ɸ��� ���ϸ� �ٿ��� �ý��� ��ü ������ ����Ų��.
2) ��������
- ����(������, ��������), ���̺� ����, ������ �Է�, ����
- ��� ������ ���Ͻ� ����
3) ��� ����
- ���̺��� ���� ���� ���� ��.(������ �Ǽ�)
- where ������ index�� �ش� �÷��� ���� ���� ��.(��ȸ���� ����Ѵ�)
	ps) ���̺� �Է�, ����, ������ ���� �Ͼ� ���� ������� �ʴ� ����
		�Ϲ����̴�.
- �˻� ����� ��ü �������� 2~4%������ ��.
	ex) 1000������ �����Ͱ� �ִ� �λ����� �ִ� ��쿡 �˻��� 20~40���� �ȿ�
		�����͸� �ε��ؼ� ���� �� index�� ó����.
4) �ε����� ����
- �ε����� ���� �߰� ������ �ʿ�
- �ε����� �����ϴµ� �ð��� �ɸ���. 
*/
/*
�ε��� ���� ���� �����.
1. �������̺� �����
create table emp_idx_exp as select * from emp;
2. �ε��� ó���� �÷� ����.
emp_idx_exp���� empno�� index�� ����
3. �ε��� ����(�ش� ���̺� �ε��� ����)
create index �ε����̸�
on ���������̺��(��������÷�)
create index index_empno_emp_idx_exp
on emp_idx_exp(empno);
*/
CREATE TABLE EMP_IDX_EXP
AS SELECT * FROM EMP;

-- EMP_IDX_EXP ���̺� EMPNO�� INDEX�� �����Ѵ�.
CREATE INDEX INDEX_EMPNO_EMP_IDX_EXP
ON EMP_IDX_EXP(EMPNO);

-- �ε��� ����
-- DROP INDEX �ε����̸�
DROP INDEX INDEX_EMPNO_EMP_IDX_EXP;

/*
Ȯ�ο���
DEPT ���̺� ���纻 DEPT_IDX_EXP �����,
�ε��� �̸��� IDX_DEPTNO_DEPT�� �ؼ� ����, Ȯ�� �� ���� ó��
*/
CREATE TABLE DEPT_IDX_EXP
AS SELECT * FROM DEPT;

CREATE INDEX IDX_DEPTNO_DEPT
ON DEPT_IDX_EXP(DEPTNO);

DROP INDEX IDX_DEPTNO_DEPT;