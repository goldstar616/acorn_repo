-- 컬럼명에 이름(별명) 붙이기!!
select * from emp;
-- empno를 별칭으로 companyNo로 쓰기로 했다. 출력하세요..
-- 컬럼명 as 나타날 별칭컬럼명 alias
select empno as companyNo from emp;
-- 별칭은 프로그램 영역에서 중요한 의미를 가진다..
-- 대다수 프로그램은 별칭으로 간편하게 사용하는 경우가 많다.
-- ex) rs.getString("별칭/컬럼명")
--  as 대신에 공백(' ')으로 처리한다.
select '사번은'||empno || ' 입니다!' show from emp;
-- 실제 application에서는 rs.getString("show")로 처리된다.
select * from emp;
-- 다음의 내용을 변경된 컬럼으로 나타내세요..
-- 컬럼명        depandname   upgradeRatio   enterCompany  
-- 출력데이터  (부서번호)이름    연봉의 10%     입사년월일
select '( '||deptno||' ) '|| ename depandname, sal*0.1 upgradeRatio, 
		hiredate enterCompany from emp;
-- 	공백값을 별칭으로 처리하기..: " "사이 별칭명을 적어준다.
select ename "name intro" from emp;
-- 한글을 별칭으로 처리할 때도, " "사이에 처리
select deptno "부서번호" from emp;

select * from emp;
-- 중복값 처리 : 데이터베이스에서는 동일한 값을 입력하는 것을 테이블단위로
-- 입력하는 것을 꺼려한다. 
-- 컬럼에 있는 모든 데이터가 동일해서는 안된다는 말이다.
-- 그런데, 한개 컬럼으로 조회할 때는 동일한 데이터가 나타날 수 있다.
select deptno from emp;
-- 일때, 하나 또는 다수의 컬럼의 데이터가 동일한 것을 filtering 해주는 처리가
-- 있는데 이를 distinct라고 한다.
-- 활용형식 select distinct 컬럼1, 컬럼2.. from 테이블
select distinct deptno from emp;
select * from emp;
-- 확인예제1) -mgr을 동일값 없이 출력하세요..
-- 확인예제2) job과 mgr 컬럼이 동일값 없이 출력하세요.
select distinct mgr from emp;
select distinct job, mgr from emp;
/*
조건처리..
특정한 데이터 list내용에서 필요한 데이터한 행단위로 filtering하는 것을
말한다.
1. 범위 처리..
*/
select * from emp;
-- 연봉이 3000이상인 데이터를 list 처리..
-- where 컬럼명 > 조건데이터
select * from emp
where sal>=3000;
-- 데이터베이스서 쓰이는 비교연산자
-- = (*), >, <, >=, <=,   <>,!=(다를때)
select * from emp;
-- 1) 부서번호 30인 데이터를 list 하세요..
select * from emp
where deptno=30;
-- 2) 연봉이 1000미만인 데이터
select * from emp
where sal<1000;
-- 3) ename이 SMITH인 데이터
select * from emp where ename='SMITH';
-- 4) COMM이 NULL인 데이터(*) - 지금까지 배운 함수활용
select * from emp where nvl(comm,0)=0;
-- 	null값을 나타내는 keyword is null
select * from emp where comm is null; 
--null값 아닐 때, is not null
select * from emp where comm is not null;
-- 5) MGR이 7698이 아닌 데이터
select * from emp where mgr != 7698;
-- 열과 행의 두가지 조건을 갖춘 데이터 list하기..
-- 행의 multi 조건에 대한 처리..
select * from emp;
-- 연봉이 3000이상인 사람의 이름과 연봉을 list
select ename, sal 
from emp
where sal>=3000;
select * from emp;
-- 연봉이 2000이하이고 직책이 SALESMAN인 사람의
-- 이름, 직책, 연봉을 출력..
select ename "이름", job "직책", sal "연봉"
from emp
where sal<=2000
and job='SALESMAN';
-- 컬럼명은 대소문자 구분하지 않지만, 데이터는 대소문자 구분한다.
-- 연습예제
-- 1. EMP중에 급여가 2000미만이 되는 사원 정보 중에 사번과 급여를 출력하라.
select ename, sal from emp where sal<2000;
-- 2. 연봉과 보너스의 합산 금액이 1500미만인 사람의 이름, 연봉, 보너스, 
--    합산액을 출력하세요.
select ename, sal, comm from emp where sal+nvl(comm,0)<1500;
-- 3. MGR이 NULL인 사람 JOB, 이름, 연봉을 출력하세요.
select job, ename, sal from emp where mgr is null;
-- 4. JOB이 CLERK인 사람중 DEPTNO가 30인 사람의 이름, 직책, 
--    부서번호를 출력하세요
select ename, job, deptno from emp where job = 'CLERK';
-- 5. 연봉이 2000에서 3000 사이에 있는 사람의 부서번호, 
--    이름, 연봉을 출력하세요.
select deptno, ename, sal
from emp where sal>=2000 and sal<=3000;
select * from emp;






		
		

