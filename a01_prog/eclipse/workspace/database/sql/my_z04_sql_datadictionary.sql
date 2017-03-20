/*
������ ����(������ dictionary)
�����ڿ��� �����ͺ��̽��� ���õ� ������ �����ϴ� ���� ���Ѵ�.

DBA_XXX : �����ڸ� ���� ������ ��ü(���̺� ��)�� ���� ��ȸ.
ALL_XXX : �ڽ� ���� ���� �Ǵ� ������ �ο� ���� ��ü(���̺�)�� ������ȸ
USER_XXX : �ڽ��� ������ ������ ��ü � ���� ���� ��ȸ.
*/
SELECT * FROM USER_TABLES
WHERE TABLE_NAME LIKE '%EMP__'; -- ����� ���̺� ���� ����..
/*
�������� Ȯ���ϱ�..
USER_CONSTRAINTS���� �� ���̺��� ���Ἲ �������ǿ� ���õ� ������ ������
��ųʸ��� ���ؼ� Ȯ���� �� �ִ�.
*/
SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME LIKE '%EMP__';
/*
## CONSTRAINT_TYPE
P : PRIMARY KEY
R : FOREIGN KEY
U : UNIQUE
C : CHECK, NOT NULL

** ������ ������ ���ؼ� ������ ���̺��� ���, ���̺��� ����, 
���������� Ȯ���� �� �ִ�..
*/
SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME LIKE '%DEPT%';