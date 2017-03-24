/*a08_join.sql*/
select count(*)
from emp, dept; -- (emp테이블)  X  (dept테이블)
-- 크로스 조인
select count(*)
from emp;
/


select count(*) from dept;
select * from emp;
select * from dept;
/*
equal join : 두개이상 테이블에서 각테이블에 소속되어 있는 컬럼의 데이터가 같은 값이 있을 때,
연관하여 처리할 수 있는 join을 말한다.
형식  
	select 표현할컬럼
	from 테이블1, 테이블2
	where 테이블1.공통컬럼 = 테이블2.공통컬럼
	공통컬럼 : 같은 데이터가 있는 컬럼..
*/
select * 
from emp, dept
where emp.deptno = dept.deptno; 
-- 사원이 이름과 직책, 소속부서명을 출력하세요..
select ename, job, dname
from emp, dept
where emp.DEPTNO = dept.DEPTNO;
select * from emp;
-- ex) dept를 조건하여 사원명, 부서위치(loc)를 출력
select * from dept;
select ename, loc
from emp, dept
where emp.DEPTNO = dept.DEPTNO;
-- 확인예제) 보너스가 있는 사원의 이름과 부서명을 출력하세요!!
select * from emp;
select ename, dname
from emp a, dept b
where a.DEPTNO = b.DEPTNO
and a.comm is not null;
/*과제
	부서위치별 사원의 수를 아래 형식으로 출력하세요..
	부서위치   사원 수..
*/
select loc, count(*)
from emp e, dept d
where e.deptno = d.deptno
group by loc;

select * from emp;
/*
non-equi join
테이블 사이에 컬럼의 값이 직접적으로 일치하지 않을 시 사용하는 조인으로 '='를 제외한 연산자를 사용한다.
*/
select * from salgrade;
-- 급여 등급을 5개로 나누고 이 등급을 표시하시오..
--  where sal between [losal] and [hisal]
-- 이름과 연봉 연봉등급을 출력하세요..
--  테이블 alias 사용하기 :테이블의 컬럼에 같은 이름이 없으면 의미가 없지만
-- 	   같은 이름이 있으면 구분하기위해 테이블명[공백]alias를 활용한다.
--    테이블alias.컬럼명
--    또한, 데이터 컬럼의 명이 많아, 가독성을 위해 기술하는 경우도 있다.
select e.ename, e.sal, s.grade
from emp e, salgrade s
where e.sal BETWEEN s.LOSAL and s.HISAL;
/* 숙제
student10  아이디, 이름 
studentPoint 아이디, 과목, 점수
gradeCheck 최저점수lopoint, 최고점수hipoint, 학점등급(A~F)
1) 아이디를 조인해서(equal join)
	이름 과목 점수  출력
2) 	점수를 조인해서(not equal join)
    과목  점수 학점등급
3) 	student10 studentPoint gradeCheck 조인을 하여..
   이름  과목  학점등급
*/
CREATE TABLE student_main
(
   ID VARCHAR2(20) PRIMARY KEY,
   PASS VARCHAR2(20),
   NAME  VARCHAR2 (50)
);

CREATE TABLE STUDENT_POINT(
	ID VARCHAR2(20) REFERENCES STUDENT_MAIN(ID),
	subject VARCHAR2(50),
	POINT NUMBER
);
drop table gradecheck;
create table gradecheck(
   ptGRADE   varchar2(10),
   lopt   NUMBER,
   hipt   NUMBER	
);
insert into gradecheck values('A학점',90,100);
insert into gradecheck values('B학점',80,89);
insert into gradecheck values('C학점',70,79);
insert into gradecheck values('D학점',60,69);
insert into gradecheck values('F학점',0,59);

SELECT * FROM STUDENT_MAIN;
SELECT * FROM STUDENT_POINT;
INSERT INTO STUDENT_MAIN VALUES('C001001','7777','홍길동');
INSERT INTO STUDENT_MAIN VALUES('C001002','7777','신길동');
INSERT INTO STUDENT_MAIN VALUES('C001003','7777','마길동');
/*
outer join
두개의 조인 관계에 있는 테이블에 있서, 한쪽 또는 양쪽다 
조건이 만족하지 않아도 데이터 결과를 출력해야 하는 경우에 활용되는 조인이다.
where 데이터가 없는 테이블.컬럼명(+) = 데이터가 있는 테이블.컬럼명
*/
select * from dept;
select distinct deptno from emp;
-- 부서번호별로 매칭되는 사원이름을 출력하되, 
--    이름이 없으면 없다는 표시가 필요
-- 
--부서번호, 부서명,  이름
select d.deptno, d.dname, nvl(e.ename,'인원없음') ename
from emp e, dept d
where e.deptno(+) = d.deptno
order by e.deptno;
/*
숙제) outer join, group을 활용하여 
	  부서명별  인원을 확인할려고 한다.
	  아래의 형식으로 출력하세요  인원이 없는 곳은 0으로 표시
	  부서명  인원
*/
/*
self join : 말 그대로 자기 자신과 조인을 맺는 것을 말한다.
from절에 같은 이름을 테이블을 나열하여, 다른 테이블인 것처럼 인식해서
조인하여 그 결과물을 출력하는 것을 말한다.
select *
from 테이블명 alias01, 동일테이블명 alias02
where alias01.연관컬럼 = alias2.연관컬럼
ex) 사원테이블(emp)에서  사원명  관리자명을 출력하세요..
*/
select work.ename, work.mgr,manager.ename 
from emp work, emp manager
where work.mgr = manager.empno;
/*
계층형 join관계 정보 테이블 만들기(self join)
1. 구조를 정리한다..
	id와 상위id를 입력하는 key를 만든다.
	numid, parentnumid, role01, name
	아이디, 상위아이디, 역할, 이름
2. 테이블을 생성한다.
	create table family(
		numid number,
		parentnumid number,
		role01 varchar2(100),
		name varcahr2(500)
	);	
3. 데이터를 입력한다.(위에 세워놓은 계층형 구조에 의한 데이터 입력처리)
	insert into family values(1,0,'할아버지','홍길동');
	insert into family values(2,1,'아버지','홍정길');
	insert into family values(3,2,'아들','홍현호');
	insert into family values(4,1,'삼촌','홍정호');
	
	
4. 입력된 데이터 내용이 정상적으로 되어 있는지 확인한다.
	- 조회 처리..
*/
	create table family(
		numid number,
		parentnumid number,
		role01 varchar2(100),
		name varchar2(500)
	);	
	insert into family values(1,0,'할아버지','홍길동');
	insert into family values(2,1,'아버지','홍정길');
	insert into family values(3,2,'아들','홍현호');
	insert into family values(4,1,'삼촌','홍정호');
	select * from family;
/* 이름  role 상위이름
*/	
select cur.name, cur.role01, par.name pname
from family cur, family par
where cur.parentnumid=par.numid;