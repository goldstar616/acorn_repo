-- 숙제(조별과제)
-- 1. 입사일 분기별로 가장 높은 연봉을 받는 사람을 출력하세요.
SELECT B.HQ , MAX(A.SAL) 
FROM EMP A, (select empno, ename, trunc((to_number(to_char(hiredate, 'MM'))-1)/3) HQ from emp) B
WHERE A.EMPNO = B.EMPNO
GROUP BY B.HQ;

-- 2. 연봉이 3000 이상인 사람 중에, 등급(테이블활용도 가능)을 나누어서
-- 	해당 등급별 최고 연봉을 받는 사람을  이름, 등급, 연봉을 출력하세요.


-- 숙제.
-- 1. 부서번호가 30인 사람 중에, 가장 나중에 입사한 사람보다 연봉이 많으면 출력하세요.

-- 2. 직급이 'SALESMAN'인 사원이 받는 급여들의 최소 급여보다 많이 받는 사원들의 이름과
-- 급여를 출력하되 부서번호 20번인 사원은 제외한다. (ANY연산자 이용)

-- 조별숙제
-- 다음과 같은 형태의 테이블을 구성하세요.
-- 이름(name) 번호(no) 입사일(credate)-문자열   올해기준근무연수(workyears)
-- 					@@@@ 년 @@@ 월 @@@ 일      @@@@
-- new_emp 로 구성하세요.
