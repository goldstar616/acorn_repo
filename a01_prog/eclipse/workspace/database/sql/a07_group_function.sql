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
       max(sal) max01, min(sal) min01
from emp;	
/*
�׷캰�� �������� ���ġ ó���ϱ�..
select ó���ұ׷��÷�, �׷��Լ�
from ���̺��
where ����..
group by ó���ұ׷�Ŀ��
�μ���ȣ���� ���ջ� �������� ����ϼ���..
*/
select deptno, sum(sal),avg(sal) avg01, count(sal) cnt,
       max(sal) max01, min(sal) min01
from emp
group by deptno;
   