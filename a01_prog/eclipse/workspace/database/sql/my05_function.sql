/*
LPAD/RPAD 함수.
특정 문자열에 해당하는 문자열로 채우는 처리를 하는 것을 말한다.
LPAD : 왼쪽에 문자로 채우세요
	LPAD(데이터, 전체 문자열 크기, '반복할 문자열')
# himan이라는 문자열 왼쪽에 '#' 20번
전체 크기를 만들고, 해당 크기가 되지 않으면 문자로 채움..
varchar : 가변문자형, char : 고정문자형
*/
select lpad('himan', 20, '#') from dual;

/*
RPAD : 오른쪽에 해당 크기가 될 때까지 특정문자로 채움..
ex) good job에서 문자가 20개가 될 때까지 @로 오른쪽에 채움
*/
select rpad('good job', 20, '@') from dual;
-- 확인예제) ename과 job을 크기와 지정된 문자열만큼 오른쪽과 왼쪽에 해당 문자열을 아래 형식으로
-- 넣으세요..
-- 1. ename과 job에서 데이터 크기를 확인한다.
-- 2. 데이터 중에 가장 큰 데이터의 크기를 확인해서.
-- 3. ename에는 오른쪽에 @, job에는 왼쪽에 ^를 추가해서 나타나게 한다.
-- 4. 다음과 같은 순서로 출력
--		사원번호	이름(@)	직책(^)	입사일
select max(length(ename)), max(length(job)) from emp;
select empno, rpad(ename, 6, '@'), lpad(job, 9, '^'), hiredate from emp;

/*
공백의 문자를 삭제하는 방법
LTRIM : 왼쪽에 공백문자를 삭제하는 처리
RTRIM : 오른쪽에 공백문자를 삭제하는 처리
ex) [공백]This is your best day!! 왼쪽에 공백문자를 제거 처리..!!
*/
select ltrim('     this is your best day!!!') showData,
		length('    this is your best day!!!') beforeLen,
		length(ltrim('    this is your best day!!!')) afterLen
from dual;
-- 오른쪽에 공백문자열을 제거하는 처리
select rtrim('what we dwell on is who we become!    ') showdata,
		length('what we dwell on is who we become!    ') beforeLen,
		length(rtrim('what we dwell on is who we become!    ')) afterLen
from dual;

/*
trim
	오른쪽, 왼쪽에 있는 공백을 비롯해서 특정 문자열을 삭제 처리하는 함수.
	trim('삭제할 문자열' from data)
	ex)'aaaaaaaaGood morning!!aaaaaaaaaa'에서 오른쪽과 왼쪽에 a문자열을 삭제처리
*/
select trim('a' from 'aaaaaaaaGood morning!!aaaaaaaaaa') showdata from dual;
-- 확인예제) job에 'N'이나 'R', 'T'가 있으면 삭제된 내용으로 다음과 같이 출력하세요.
-- 이름 직책
select ename, trim('T' from trim('R' from trim('N' from job))) from emp;

/*
날짜 함수..
sysdate : 오라클 내장된 현재 날짜와 시간을 출력하는 객체..
*/
select sysdate from dual;
select sysdate+1 from dual;
select sysdate-1 from dual;
select sysdate today, sysdate-1 yesterday, sysdate+1 tomorrow from dual;
select ename, hiredate, sysdate, sysdate - hiredate from emp;

/*
months_between : 두개의 날짜 데이터 사이의 개월 수를 구하는 내용..
	months_between(비교날짜데이터1, 비교날짜데이터2)
ex) 각 직원들의 근무한 개월 수를 구하세요..
*/
select ename, hiredate, months_between(sysdate, hiredate) workingMonth from emp;

/*
add_months : 미래시점을 나타내는 함수로 개월 수를 더해서 해당날짜가 나타나게 한다.
	add_months(기준데이터, 이후개월수)
ex) 입사 날짜에서 6개월을 추가한 날짜를 출력하세요.
*/
select ename, hiredate, add_months(hiredate, 6) after6Months from emp;

/*
숙제1)
6개월의 인턴기간에는 급여의 70%만 지급하기로 했다.
사원의 인턴기간만료시점을 출력하고, 6개월간의 급여의 총합을 계산하세요..
월급여 - sal/13
인턴기간 - 월급여의 70%
인턴기간월급여총액 - 인턴기간6개월간 급여 총액을 10단위 절삭해서 출력
사원번호	사원명	입사일	인턴기간만료시점	인턴기간월급여(10단위절삭)
*/
select empno, ename, hiredate, add_months(hiredate, 6), trunc(((sal/13) * 0.7) * 6, -1) from emp; 

/*
next_day : 주간단위로 가장 가까운 날짜를 산출할 때, 활용..
	next_day(날짜데이터, '요일') : 해당 요일에 가장 가까운 날짜 출력..
*/
select sysdate, next_day(sysdate, '수요일') from dual;
/*
확인예제) 사원들의 입사후, 첫번째 토요일을 출력하세요..
*/
select ename, hiredate, next_day(hiredate, '토요일') firstHoliday from emp;

/*
last_day 함수
	해당 달의 마지막 날짜를 반환처리.
*/
select last_day(sysdate) thisLastDate, 
	last_day(sysdate)+1 nextFirstDate from dual; -- 다음날 첫날
	
-- (숙제) 급여 계산.. 3단계 급여일을 나누어서 출력하세요.
-- 1단계 당월 20일
-- 2단계 당월 마지막날
-- 3단계 다음달 10일
-- 사원 입사일 첫월급1 첫월급2 첫월급3
select ename, hiredate,
		last_day(add_months(hiredate, -1))+20,
		last_day(hiredate) grade02,
		last_day(hiredate)+10
		from emp;
		
/*
형변환 함수
오라클에서 데이터간 형변환을 해서, 필요한 형식이나 type으로 나타내야 한다.
이 때, 활용하는 것이 형변환 함수이다.
to_char() : 날짜나 숫자형을 문자형으로 변환
to_date() : 문자형을 날짜형으로 변환
to_number() : 문자형을 숫자형으로 변환

to_char()
1) 날짜형을 문자형으로 변환하기.
	to_char(날짜데이터, '표현할 문자형태')
	표현하는 문자 형태의 종류
	YYYY : 년도 표시, YY : 년도 2자리 표시
	MM : 월 표시, MON : 월 영문으로 표시 ex)JAN
	DAY : 요일 표시, DY : 요일 약어 표시
	DD : 날짜 표시
	
ex) 입사일을 년도-월-일로 표현하시오..
*/
select ename, to_char(hiredate, 'YYYY-MM-DD') hiredate1,
		to_char(hiredate, 'YY-MM-DD') hiredate2,
		to_char(hiredate, 'YYYY"년" MM"월" DD"일"') hiredate2
		from emp;
-- 확인예제
-- 아래형식으로 출력하세요.
-- [사원이름]은 @@년 @@월 @@일에 급여를 @@@만원 받기로 하고 입사했습니다.
select '['||ename||']은 '||to_char(hiredate, 'YY"년" MM"월" DD"일"')
		||'에 급여를 '||sal||'만원 받기로 하고 입사했습니다.' from emp; 
/*
2) 시간출력형식 to_char(날짜데이터, '날짜출력형식 시간출력형식')
	AM 또는 PM : 오전오후 표시
	AM. 또는 PM. : 오전. 오후. 표시
	HH 또는 HH12 : 12시간 표시(1~12)
	HH24 : 24시간 표시(0~23)
	MI : minutes 분표시
	SS : seconds 초표시
ex) 현재시간을 날짜와 시간 형식에 의해 표시
	YYYY/MM/DD	HH24:MI:SS
*/
select to_char(sysdate, 'YYYY/MM/DD HH24:MI:SS') today from dual;
/*
숙제
	근무개월수에 따른 차등 보너스 지급
	가장 오래된 개월~가장 최근에 입사한 개월수
	1/3 = 30%, 1/3 = 20%, 1/3 = 10% (연봉기준)
	사원, 입사일, 현재날짜(@@/@@/@@ AM @@시 @@분 @@초), 근무개월수,
*/
select ename, hiredate, to_char(sysdate, 'YY/MM/DD AM HH24:MI:SS') , trunc((sysdate - hiredate)/365) from emp;

/*
숫자형을 문자형 처리..
to_char(데이터, '형식')

출력형식
0 : 자릿수가 맞지 않은 경우, 지정된 자리수가 실제 데이터의 자리수 보다 큰경우에
	0으로 채워진다.
9 : 자리수 상관없이 해당 데이터 나타남. 채워지지 않는다.
L : 지역별 현금단위표시
. : 소숫점 표시
, : 천단위 표시
*/
select to_char(1000, '00000') from dual; -- 해당 자리수보다 클때 0으로 채워짐.
select to_char(1000, '99999') from dual; -- 채워지는 처리하지 않음.
select to_char(1000, '999') from dual; -- 자리수가 적으면 ##로 표시됨.
select to_char(24333, 'L999999') from dual; -- 원단위 표시
select to_char(24333, 'L999,999') from dual; -- 천(,)단위 표시
select to_char(24333.2422, '999,999.999') from dual; -- 소수점(.) 표시
-- 확인) 이름과 급여를 표시하되
-- 급여는 소숫점 이하는 표시되지 않고, 자리수는 7자리로 표시하되 나타나지 않는
-- 자리는 '0'으로 표시하시고
select ename, to_char(sal, 'L0000000') from emp;

/*
to_date():
입력한 날짜형의 문자를 입력할 때, 날짜 데이터를 조회 처리..
검색을 할려면 문자를 날짜로 변환하여 처리..
문자는 날짜형태로 어떻게 인식하는가?
1980/12/12 --> to_date()에서 어떤 형식으로 입력할 것인지 지정.!!!
to_date(입력데이터, '형식을 지정')
ex) to_date(19811020, 'YYYYMMDD')
select * from emp
where hiredate='12/17/1980'; (x)
입사일이 1980/12/17인 데이터를 검색
*/
select * from emp
where hiredate=to_date('1980/12/17', 'YYYY/MM/DD');

/*
확인예제) 입력값이 '1981-02-20'이며, 이 데이터로 검색되는 입사일에 해당하는
			사원명	입사일(1981년02월20일)을 출력하려고 한다.
*/
select ename, to_char(hiredate, 'YYYY"년""MM"월"DD"일"') "입사일"
from emp
where hiredate=to_date('1981-02-20', 'YYYY-MM-DD');
/*
숙제
조회값이 '1981년 01월 01일'부터 '1982년 12월 12일' 사이의 데이터 중,
	부서가 30인 데이터를 조회하여,
list형식
	사원명(10자리-앞에 #기호처리)
	직책(10자리-나머지뒤에 '-'처리)
	입사일(@@년 @@월 @@일 @요일 24시 @@분 @@초)
	연봉( ####1,600.0 표시)로 나타내세요.. 
*/
select lpad(ename, 10 , '#'), rpad(ename, 10, '-'), to_char(hiredate, 'YYYY"년 "MM"월 "DD"일 "DAY" "HH24"시 "MI"분 "SS"초"'), lpad(to_char(sal, '9,999.9'), 11, '#') from emp;

/*
숫자형 문자열이 입력되었을 때, 처리할 to_number() 함수
입력되는 문자열의 형식을 지정, to_number로 데이터 입력 처리..
to_number(입력할 데이터, '형식지정')
*/
-- select '20,000' - '30,000' from dual;
select to_number('20,000','99,999') - to_number('30,000', '99,999') calcu from dual;
-- 확인예제) 연봉을 검색할려고 한다. '3,000'이라는 입력값을 통해 3000이하의 연봉을
-- 가진 사람의 이름과 연봉을 W(원) 3,000로 출력하세요.
select ename, to_char(sal, 'L99,999')
from emp
where sal < to_number('3,000', '9,999');
/*
연봉과 보너스를 합산한 금액을 이름과 총액으로 표시할려고 한다.
nvl : 해당 데이터가 null일때, 표현할 default 데이터를 지정하여,
	값이 없을 때에도 정상적으로 데이터를 처리하기 위한 것이다.
	숫자 nvl(데이터,0)	숫자일때는 0
	문자 nvl(데이터,' ')	문자일때는 ' '공백으로 처리..
*/
select ename, sal, comm, sal+nvl(comm,0) tot
from emp;
-- 숙제 이름 관리자번호 보너스 ==> 데이터가 없을 때는 관리자번호경우 '최고레벨', 보너스는 '0'표시
select ename, nvl(to_char(mgr), '최고레벨'), nvl(comm, 0) from emp; 