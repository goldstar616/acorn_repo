/*
숫자함수 : 숫자를 처리하는 함수. 절대값, 수학함수(sin, cos, tan...)
			올림(ceil), 반올림(round), 내림(trunc, floor), 나머지(mod)를 처리함.
1. abs : 절대값-부호에 관계 없이, 양수로 처리하는 함수를 말한다.
*/
select 25, -25, abs(25), abs(-25) from dual;

/*
2. floor() : 소숫점 아래를 버리는 함수.
*/
select 25.75, floor(25.75) from dual;

/*
3. round() : 반올림 처리 함수
	round(데이터, 반올림할 자리수)
		반올림한 자리수 : 양수 - 소숫점 이하의 자리수 처리
							음수 - 십단위(1), 백단위(2) 식으로 해당 단위만큼 반올림처리.
*/
select 25.278888, round(25.278888, 2) from dual;
select 625.2999, round(625.2999, -2) from dual; -- 백자리로 반올림 처리됨.
-- 숙제) sal을 연봉이라고 할 때, 이달 급여분(1/13)을 처리하시오, 단 이달은 보너스가 있는 달입니다.
-- 출력내용 : 사번, 연봉, 이달급여, 보너스, 총급여액
select empno, sal, round(sal/13), nvl(comm, 0), round((sal/13) + nvl(comm, 0)) from emp;

/*
4. trunc() : 특정 자리수 이하로 절삭 처리
	trunc(데이터, 자리수처리)
*/ 
select trunc(24.2433, 2), trunc(24.243, -1) from dual;

/*
숙제 sal을 기준으로
1000미만		10% 인상
1000~2000미만	20% 보너스
2000~3000미만	30% 보너스
3000~4000미만	40% 보너스
4000~5000미만	50% 보너스
5000~이상		60% 보너스를
지급하기로 했다.. 함수를 활용해서, 아래 내용을 처리하시오.
사번 이름 연봉 보너스(%) 보너스
*/



-- 사원번호가 홀수인 사람을 검색하세요..
select * from emp
where mod(empno, 2) = 1;

/*
숙제
사원을 부서 기준으로 1팀과 2팀으로 나누어서 체육대회를 하기로 했다.
부서번호가 10, 30 ==> 1팀
부서번호가 20, 40 ==> 2팀
으로 나누고 다음과 같이 출력하세요.
부서번호 사원번호 이름 팀명 
*/
select deptno, empno, ename, (mod(deptno/10, 2) + 1)||'팀' from emp; 

/*
문자 처리 함수.
1. upper 모든 데이터를 대문자로 전환처리
	upper(데이터)
	일반적으로 운영데이터가 소문자나 대문자가 섞여 입력되어 있는 경우,
	해당 데이터를 입력문자(대소문자 구분없이)로 해당 데이터를 검색할 경우 많이 쓰인다.
*/
select upper('hi! Good days!!') from dual;

/*
2. 소문자를 반환하는 lower함수..
	lower(데이터)
*/
select lower('Good night!!! This is the Best day!!') from dual;
select empno, lower(ename), lower(job) from emp;

/*
3. initcap함수 : 첫문자만 대문자, 나머지는 소문자 처리..
	initcap(데이터)
*/
select initcap(ename), initcap(job) from emp;
/* Smith is a Cleck!! 형식 출력..*/
select initcap(ename)||' is a '||initcap(job)||'!!!' introJob from emp;

/*
4. 문자길이를 처리하는 length
형식 length(데이터)
*/
select length('himan') from dual;
--직책이 5자 이하인 데이터를 출력하세요..
select * from emp where length(job) <= 5;

/*
5.lengthb() : byte의 크기를 출력 - 영문(1자당 1byte), 한글(1자당 2bytes)
*/
select lengthb('himan'), lengthb('홍길동') from dual;

/*
6. substr(), substrb() : 특정 문자열의 일부를 추출하는 함수.
	substr(데이터, 1부터 count하여 시작할 위치지정, 추출한 문자열의 갯수)
*/
select substr('welcome to Oracle world!!', 4, 5) from dual;
/* ex) job을 기준으로 5개의 문자열을 추출하여, 이름과 직책을 출력 */
select ename, substr(job, 1, 5) from emp;
/*
확인예제
아래 형식의 데이터를 화면에 list하세요..
사번	이름	직책(이름의 문자열수 만큼만 표시)
*/
select empno, ename, substr(job, 1, length(ename)) from emp;
-- hiredate의 경우, 데이터 type이 날짜형식이지만, 자동 형변환이 되어
-- 문자열 처리 함수로 문자열을 추출하여 처리할 수 있다.
select substr(hiredate, 1, length(hiredate)) from emp;
-- 1980년 데이터를 나타내세요..
select * from emp
where substr(hiredate, 1, 2) = '80';
-- 1982년 12월 01일 ~ 1982년 12월 31일 입사일인 사람을 이름과 입사일로 출력하세요.
select ename, hiredate from emp 
where substr(hiredate, 1, 5) = '82/12';
-- 과제) 함수를 이용하여 다음 내용을 출력하세요..
-- @@@님 입사일은 @@년 @@월 @@일 이며, 현재 연봉은 @@@ 만원 받고 있습니다.
-- column명 empinfo
-- 과제) substr을 활용하여 JOB이 MAN으로 끝나는 데이터를 출력하세요!!

/*
7. 특정 문자의 위치를 구한 instr
	instr(데이터, '검색할 문자')
*/
select instr('hi!! good man', 'man') from dual;
/*
instr(데이터, '검색할 문자', 검색할 시작위치, 몇번째 검색위치 출력할 것인지 정하는 변수)
instr('hi!! oh my girl!! hi!! feel so good!', 'o', 3, 2);
*/
select instr('hi!! oh my girl!! hi!! feel so good!', 'o', 3, 2) from dual;
/* 
숙제
입사일이 12월인 데이터를 이름과 입사일을 출력하세요 instr()을 활용 
*/