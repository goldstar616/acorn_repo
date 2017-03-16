select * from emp;
/*
그룹함수: 데이터를 그룹별로 통계치를 처리할 때 활용된다.
sum() : 총합산.
avg() : 평균
count() : 갯수
max() :최대값
min() :최소값

*/
select sum(sal) tot, avg(sal) avg01, count(sal) cnt,
       max(sal) max01, avg(sal) min01
from emp;	   