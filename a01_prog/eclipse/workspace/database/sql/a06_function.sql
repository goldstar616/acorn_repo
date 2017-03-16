/*
DECODE () :조건 처리를 위한 함수
	DECODE(데이터, 데이터1, 조건1데이터,
	                  데이터2, 조건2데이터,
				  그외에데이터)
ex)gender이라는 컬럼에 0이면 남자, 1이면 여자, 그외 중성				  
*/
select decode(0,0,'남자',1,'여자','중성') gender01,
		decode(1,0,'남자',1,'여자','중성') gender02,
		decode(2,0,'남자',1,'여자','중성') gender03,
		decode(3,0,'남자',1,'여자','중성') gender04
from dual;		
-- 부서번호가 10 회계, 20 감사, 30 영업, 40 운영, 그외는 '미정'
select ename, 
		decode(deptno,  10, '회계',
						20, '감사',
						30, '영업',
						40, '운영',
						'미정') selDept
 from emp;
 /*
직책을 한글로 풀이해서 출력처리
 CLERK :점원, SALESMAN : 영업맨, MANAGER :관리자.....
 사원번호, 직책(한글), 급여
 */
select ename, 
DECODE(JOB, 'CLERK','점원',
			'SALESMAN','영업맨',
			'MANAGER','관리자',
			'ANALYST','분석가',
			'PRESIDENT','대표',
			'기타') "직책(한글)"
 from emp;
/* 숙제 
연봉에 따른 등급체계를 나눌려고 한다.
decode를 활용해서,
	 1000 미만 F등급         성과급 3%
	 1000 ~ 2000미만 E등급   성과급 5%
	 2000 ~ 3000 미만 D등급  성과급 7%
	 3000 ~ 4000 미만 C등급  성과급 4%
	 4000 ~ 5000 미만 B등급  성과급 3%
	 5000 ~ 6000 미만 A등급  성과급 2%
이름  부서  연봉  연봉등급  성과급  총액(연봉+성과급)
*/
/*
case 함수 :조건에 따라 서로 다른 처리가 가능
CASE WHEN 조건1(비교연산자) THEN 처리할데이터
     WHEN 조건2(비교연산자) THEN 처리할데이터
	 WHEN 조건3(비교연산자) THEN 처리할데이터
     ELSE 위조건에 해당하지 않을 때 처리할 데이터..
END
EX) 점수에 따른 학점계산 방법 처리.. 	 
*/
SELECT CASE WHEN 80>=90 THEN 'A'
			WHEN 80>=80 THEN 'B'
			WHEN 80>=70 THEN 'C'
			WHEN 80>=60 THEN 'D'
		ELSE 'F'
	  END GRADE
FROM DUAL;	
SELECT * FROM EMP;
-- 	부서번호를 기준으로 신규부서 재배치처리 한다.
SELECT empno, ename,
	case when deptno=10 then '부서이동'
		 when deptno=20 then '인원감축'
		 when deptno=30 then '전원승진'
	     else '현부서배정'
	end  result
FROM EMP;	
/*
숙제) 입사 분기 기준 표시(1/4,2/4,3/4,4/4) 입사 분기를 표기
 사원번호, 이름, 입사(년/월), 입사분기

*/		
