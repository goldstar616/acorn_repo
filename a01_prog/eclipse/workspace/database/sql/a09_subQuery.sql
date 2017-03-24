/* a09_subQuery.sql
subquery?
하나의 select문장의 절 안에 포함된 또 하나의 select 문장을 말한다.
서버쿼리를 포함하고 있는 쿼리문을 메인쿼리(main query), 포함된 또 하나의
쿼리를 서브 쿼리(subquery)라고 한다.
ex) 사원테이블에서 연봉이 최고로 많은 사람의 이름과 연봉을 list하세요..
SELECT ENAME, SAL   --> MAIN QUERY
FROM EMP
WHERE SAL = ( SELECT MAX(SAL)
              FROM EMP )  --> SUBQUERY
SELECT MAX(@@), ENAM, JOB			   
작성시 주의점
1. 서버쿼리는 비교 연산자(=,>,<...)의 오른쪽에 기술해야 하고  괄호로
   둘러싸 주는 것이 일반적이다.
2. 서버쿼리는 메인 쿼리가 실행되기 이전에 실행된다.

서버쿼리의 유형
1. 조건의 값으로 처리되는 경우.
   SELECT *
   FROM 테이블
   WHERE 컬럼명 = (SELECT 컬럼 FROM 테이블 WHERE 조건);
   ## 단일값 조건: =,>,< (비교연산자 활용)
      다중값 조건: IN, EXIST, ANY, ALL

2. 테이블로 자체로 SUBQUERY 처리하는 경우..
   SELECT 컬럼명1+컬럼명2, ....
   FROM ( SELECT 컬럼명1, 컬럼명2, 함수(컬럼명3)
            FROM 테이블명
			WHER 조건  )
   WHERE 조건..			

3. SELECT (SELECT 컬럼1 FROM 테이블명 WHERE 조건=메인테이블 조건1 ),
          컬럼2, 컬럼3
    FROM 테이블
	WHERE 조건...		     
			  
*/
-- 1. 조건값으로 SUBQUERY가 사용되는 경우.
--   EX) 평균연봉보다 많은 사람들의 이름과 연봉을 출력하세요.
SELECT ENAME, SAL
FROM EMP
WHERE SAL>( SELECT AVG(SAL)
             FROM EMP );
--   EX) 보너스가 있는 사람들의 중, 최고인 사람의 이름과 연봉과 보너스를
--        출력하세요..
SELECT ENAME, SAL, COMM
FROM EMP
WHERE COMM =(
SELECT MAX(COMM)
FROM EMP);
--   EX) 보너스가 있는 사람들의 중, 평균 보너스보다 높은  출력하세요..
SELECT AVG(COMM)
FROM EMP
WHERE COMM IS NOT NULL;
--   EX) 사람들의 중, 평균 보너스보다 높은  출력하세요..
SELECT AVG(NVL(COMM,0))
FROM EMP;
SELECT ENAME, SAL, COMM
FROM EMP
WHERE COMM >(SELECT AVG(COMM)
				FROM EMP
			WHERE COMM IS NOT NULL);
SELECT * FROM EMP;
-- 확인예제
-- 1. 부서번호가 가장 높은 사람의 이름과 부서를 출력하세요..
SELECT ENAME, DEPTNO
FROM EMP
WHERE DEPTNO = (SELECT MAX(DEPTNO) FROM EMP);
-- 2. 가장 최근에 입사한 사람의 이름과 직책, 입사일을 출력하세요.
-- ==> MAX(HIREDATE):최근에 입사일
-- ==> MIN(HIREDATE):가장 먼저 입사한 입사일
SELECT ENAME, JOB, HIREDATE
FROM EMP
WHERE HIREDATE = (SELECT MAX(HIREDATE) FROM EMP);
SELECT * FROM EMP;
-- SUBQUERY의 결과값이 2개 이상인 경우..
-- EX) 부서별로 입사일이 최고인 사람들의 이름과 입사일을 출력하세요.
SELECT DEPTNO, MAX(HIREDATE)
FROM EMP
GROUP BY DEPTNO;
-- 1) 다중 조건에 대한 처리..
SELECT *
FROM EMP
WHERE DEPTNO IN (SELECT DEPTNO FROM EMP WHERE DEPTNO<30);
-- IN 구분에 QUERY을 넣어서 해당하는 다중의 데이터 내용을 처리할 수 있다.
-- SAL가 3000, DEPTNO 20
-- DEPTNO, HIREDATE의 조건을 둘다 QUERY에 의해서 처리할 때..
SELECT ENAME, HIREDATE, DEPTNO
FROM EMP
WHERE (DEPTNO, HIREDATE) IN ( SELECT DEPTNO, MAX(HIREDATE)
	                        FROM EMP
							 GROUP BY DEPTNO);
-- SUBQUERY로 결과값이	두개 이상 나올 때는, 해당 컬럼의 갯수에 맞는 컬럼을 선언해주어서
--  결과 처리가 가능하게 한다.  (컬럼1, 컬럼2 ) IN (SELECT 컬럼1, 함수(컬럼2) FROM...
SELECT * FROM EMP;
-- 확인예제
-- 1. JOB(직책별)로 가장 낮은 연봉을 받는 사람의 이름, 직책, 연봉을 출력하세요..
SELECT ENAME, JOB, SAL
FROM EMP
WHERE (SAL, JOB) IN(
					SELECT MIN(SAL), JOB
				FROM EMP
				GROUP BY JOB);
-- 숙제(조별과제)
-- 1. 입사일 분기별로 가장 높은 연봉을 받는 사람을 출력하세요.
select ename, sal, hiredate, floor(to_number(to_char(hiredate,'MM'))/4)+1 term
from emp
where sal in(  
	select max(sal)
	from(select floor(to_number(to_char(hiredate,'MM'))/4)+1 term, sal
			from emp)
	group by term
);



-- 2. 연봉이 3000 이상인 사람 중에, 등급(테이블활용도 가능)을 나누어서
-- 	해당 등급별 최고 연봉을 받는 사람을  이름, 등급, 연봉을 출력하세요.
select ename, grade, sal 
from emp, salgrade
where (grade, sal) in(
	select grade, max(sal)
	from emp, salgrade
	where sal>=3000
	and sal between losal and hisal
	group by grade);

select * from salgrade;


/*
사원 테이블에서 30번 소속 사원들 중에서 급여를 가장 많이 받는 사원 보다
많은 급여를 받은 사람의 이름과 급여를 출력하세요.
##
30번 소속 사원들 중에서 급여를 가장 많이 받는 사원 
==> 1) GROUP 함수이용.
    2) 전체데이터를 SUBQUERY로 로딩해서..
		== ALL, ANY ..(SUBQUERY)
		ALL : subquery에 모든 내용 합치될 때.
		<==> ANY, SOME : SUBQUERY의 결과값이 하나 이상 일치하면 
*/
SELECT ENAME, SAL
FROM EMP
WHERE SAL >= ALL(SELECT SAL FROM EMP WHERE DEPTNO=30);
/**/
SELECT SAL FROM EMP WHERE DEPTNO=30;
SELECT ENAME, SAL
FROM EMP
WHERE SAL >= ANY(SELECT SAL FROM EMP WHERE DEPTNO=30);
SELECT * FROM EMP;
-- 확인예제
-- 1. 연봉이 3000미만인 사람 중에, 최근에 입사한 사람의 사원번호와 연봉 입사일을
-- 	출력하세요
SELECT EMPNO, SAL, HIREDATE
FROM EMP
WHERE HIREDATE >=ALL(
SELECT HIREDATE
FROM EMP
WHERE SAL<3000);
-- 숙제.
-- 1. 부서번호가 30인 사람 중에, 가장 나중에 입사한 사람보다 연봉이 많으면 출력하세요.
select *
from emp
where sal>=any(
			select sal
			from emp
			where hiredate=(select max(hiredate) from emp
			where deptno=30)
			);

-- 2. 직급이 'SALESMAN'인 사원이 받는 급여들의 최소 급여보다 많이 받는 사원들의 이름과
-- 급여를 출력하되 부서번호 20번인 사원은 제외한다. (ANY연산자 이용)
SELECT ENAME, SAL, DEPTNO 
FROM EMP
WHERE SAL>=ANY(
				select SAL
				from emp
				where job='SALESMAN')
AND DEPTNO!=20;

/*
WHERE EXISTS(SUBQUERY)
:해당 SUBQUERY에 데이터가 있는지 여부를 체크해서 메인 SQL을 처리하고자 할때
활용된다.
EX) 부서번호가 30인 데이터가 있으면 전체 사원테이블을 LIST 하세요..
    만약에 부서번호가 30번이 없으면 전체 사원테이블 LIST가 없게 처리하겠다.
*/
SELECT * 
FROM EMP
WHERE EXISTS(SELECT * FROM EMP WHERE DEPTNO=30);
--  특정 조건에 의해서 전체 데이터 로딩 여부를 처리하고자 할 때, 활용된다.
-- 확인예제
-- 관리자번호(MGR)의 데이터중에 NULL값이 있으면, 이름과 관리자번호, 직책
--  을 출력하고자 한다. SQL을 작성하세요..
SELECT ENAME, MGR, JOB
FROM EMP
WHERE EXISTS(SELECT * FROM EMP WHERE MGR IS NULL);
/*
서버쿼리를 활용한 테이블 생성, 데이터 입력, 수정, 삭제..

1. 테이블 생성하기..
	1) 데이터 + 구조
		CREATE TABLE 생성테이블명
		AS SELECT 컬럼1, 컬럼2 FROM 테이블  WHERE 조건..
	EX) 연봉이 2000이상인 데이터 중에  사원번호(no) 사원명(name), 연봉(salary), 
	                         부서이름(dname) 로
	    테이블을 emp001을 만들려고 한다.	
*/
create table emp001
as
SELECT empno no, ename name, sal salary, dname
 FROM EMP A, DEPT B
 where A.DEPTNO=B.DEPTNO
 AND sal>=2000;
SELECT empno no, ename name, sal salary, dname
 FROM EMP A, DEPT B
 where A.DEPTNO=B.DEPTNO
 AND sal>=2000;
/*
 
 */
select * from emp;
drop table emp001;
-- 확인예제 - emp, salgrade 테이블을 활용하여
-- 다음과 같은 신규테이블을 구성하세요..
-- 연봉이 1000 이상 되는 데이터 를,
-- 사원명(name), 부서번호(partno), 연봉(salary), 급여등급(grade)
-- 로 된, empgrade 테이블을 생성하세요.
create table empgrade
 as
 select ename name, deptno partno, sal salary, grade
 from  emp, salgrade
 where sal between losal and hisal
 and sal>=1000;
select * from empgrade;
-- 조별숙제
-- 다음과 같은 형태의 테이블을 구성하세요.
-- 이름(name) 번호(no) 입사일(credate)-문자열   올해기준근무연수(workyears)
-- 					@@@@ 년 @@@ 월 @@@ 일      @@@@
-- new_emp 로 구성하세요.
create table new_emp
as
SELECT ENAME name, EMPNO NO, 
TO_CHAR(HIREDATE,'YYYY"년" MM"월" DD"일"') CREDATE,
floor(months_between(sysdate,HIREDATE)/12) workyears
from emp; 
select * from new_emp;

/*
데이터의 구조만 복사하고자 할 때..
where 1=0로 처리 해서 테이블을 생성
*/
create table emp_structor
as
select * 
from emp
where 1=0;
select * from emp_structor;
