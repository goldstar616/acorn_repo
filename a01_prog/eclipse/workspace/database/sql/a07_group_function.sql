select * from emp;
/*
�׷��Լ�: �����͸� �׷캰�� ���ġ�� ó���� �� Ȱ��ȴ�.
sum() : ���ջ�.
avg() : ���
count() : ����
max() :�ִ밪
min() :�ּҰ�

*/
select sum(sal) tot, avg(sal) avg01, count(sal) cnt,
       max(sal) max01, avg(sal) min01
from emp;	   