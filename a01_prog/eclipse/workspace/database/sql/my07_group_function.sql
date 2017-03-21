/*
그룹함수 : 데이터를 그룹별로 통계치를 처리할 때 활용된다.
sum() : 총합산.
avg() : 평균
count() : 갯수
max() : 최대값
min() : 최소값
*/
select sum(sal) tot, avg(sal) avg01, count(sal) cnt,
		max(sal) max01, min(sal) min01
from emp

/*
그룹별로 데이터의 통계치 처리하기
SELECT 처리할 그룹 컬럼, 그룹함수
FROM 테이블명
WHERE 조건(그룹을 처리하기 전 조건)
GROUP BY 처리할 그룹지정
HAVING 그룹에 대한 조건처리(그룹이 된 후에 조건)
*/

select sum(sal) tot, avg(sal) avg01, count(sal) cnt,
		max(sal) max01, min(sal) min01
from emp
GROUP BY DEPTNO;

-- 전체 데이터 건수를 확인하세요.
-- COUNT(컬럼, 전체(*))
-- 특정컬럼에 데이터가 있는 건수만 출력 처리
SELECT COUNT(*) CNT, COUNT(COMM) BONUS_CNT
FROM EMP;
SELECT COMM FROM EMP;

-- 중복되는 데이터에 대한 갯수 확인 처리
SELECT DISTINCT JOB FROM EMP;
SELECT COUNT(JOB) FROM EMP;
-- 중복된 데이터를 제외한 건수 처리COUNT(DISTINCT 컬럼명)
SELECT COUNT(DISTINCT JOB) FROM EMP;
-- 그룹함수와 조건문 처리
-- 연봉이 3000이상인 사람중에 직책별(JOB)로 인원수를 구하세요.
SELECT JOB, COUNT(JOB) 
FROM EMP 
WHERE SAL >= 3000
GROUP BY JOB;

-- 확인예제
-- 입사일이 1~3월인 사람의 부서별로 인원수를 체크하세요
-- 부서번호	인원수
-- @@		@@@
SELECT DEPTNO, COUNT(DEPTNO)
FROM EMP
WHERE TO_NUMBER(TO_CHAR(HIREDATE, 'MM')) BETWEEN 1 AND 3
GROUP BY DEPTNO;

SELECT FLOOR(TO_NUMBER(TO_CHAR(HIREDATE,'MM'))/4)+1, COUNT(*)
FROM EMP
GROUP BY FLOOR(TO_NUMBER(TO_CHAR(HIREDATE, 'MM'))/4)+1;
-- TO_CHAR(HIREDATE, 'MM') : HIREDATE날짜형 데이터를 월단위 문자로 출력
SELECT HIREDATE, TO_CHAR(HIREDATE, 'MM') FROM EMP;
-- TO_NUMBER() : 연산을 위해서 문자를 숫자형으로 변환처리
SELECT HIREDATE, TO_NUMBER(TO_CHAR(HIREDATE, 'MM')) FROM EMP;
-- /4로하면 1~3, 4~6...
SELECT HIREDATE, TO_NUMBER(TO_CHAR(HIREDATE, 'MM'))/4 FROM EMP;
-- FLOOR() 소숫점이하 삭제 내림처리
SELECT HIREDATE, FLOOR(TO_NUMBER(TO_CHAR(HIREDATE, 'MM'))/4) FROM EMP;
-- 특정 함수가 처리된 데이터를 그룹별로 통계치를 내게할 때, 활용된다.
SELECT FLOOR(TO_NUMBER(TO_CHAR(HIREDATE, 'MM'))/4) PART,
		COUNT(*)
FROM EMP
GROUP BY FLOOR(TO_NUMBER(TO_CHAR(HIREDATE, 'MM'))/4);

/*
숙제
연봉 단위별로 인원수를 체크하세요
범위		사원수(최고치,최저치,평균치)
1000미만	@@
~2000미만	@@@
~3000미만	@@
~4000미만	
~5000미만	
~6000미만	
*/
SELECT TRUNC(SAL/1000), COUNT(SAL), MAX(SAL), MIN(SAL), AVG(SAL) 
FROM EMP 
GROUP BY TRUNC(SAL/1000);

/*
HAVING 조건
GROUP BY 안에 주어진 그룹의 데이터에 대한 조건을 처리하고자 할 때, 활용된다.
EX) 부서별로 평균 연봉을 처리하고,
	그 그룹별 평균 연봉에서 2000이상인 데이터를 로딩하세요.
*/
SELECT DEPTNO, AVG(SAL)
FROM EMP
WHERE SAL >= 2000 -- 평균을 그룹별로 내기전에 조건처리
GROUP BY DEPTNO
HAVING AVG(SAL) >= 2000; -- 그룹내에서 조건처리

-- ex) 부서의 최대값과 최소값을 구하되 최대 급여가 2900이상인 부서만
SELECT DEPTNO, MAX(SAL), MIN(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING MAX(SAL) >= 2900;