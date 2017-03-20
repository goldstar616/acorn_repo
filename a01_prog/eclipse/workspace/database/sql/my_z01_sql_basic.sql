/*
1. DML : Data Maniplulation Language
1) select : 조회시 사용.
2) insert : 데이터 입력시 사용.
   insert into 테이블명 values(데이터1, 데이터2, 데이터3);
*/
/*
테이블 복사하기
create table 새로운테이블명
as select * from 복사할테이블명;
*/
create table dept01
as select * from dept;
/*
데이터 입력1)
ex) insert into dept01 values(50, '총무부', '서울');
*/
insert into dept01 values(50, '총무부', '서울');
commit; -- 확정처리, 재접속하거나 다른 사용자도 변경된 데이터를 볼 수 있게.

/*
데이터 입력2
insert into 테이블명(변경할컬럼명1, 변경할컬럼명2) 
			values (첫번째입력할데이터, 두번째입력할데이터);
ex) dept01테이블에서 deptno만 60을 입력한다.
	dept01테이블에서 deptno와 loc만 입력한다.
*/
insert into dept01(deptno) values(60);
insert into dept01(deptno, loc) values(70, '인천');

/*
3) update : 입력되어 있는 데이터 내용중, 변경이 필요한 부분을 수정처리한다.
	update 테이블명
	set 변경하고자 하는 컬럼명 = 변경할 데이터
	where 변경하고자 하는 조건(컬럼명=조건데이터)
*/
update dept01
set dname='인사',
	loc='대전'
where deptno=60;
select * from dept01;

-- emp01이라는 복사 테이블을 만들고
-- 1) empno가 가장 많은 번호보다 +1해서, ename과 job, sal을 입력하세요
-- 2) 그외에 컬럼 mgr, hiredate(sysdate-현재날짜로 수정), deptno는 40으로 수정하세요
create table emp01
as select * from emp;
select max(empno)+1 from emp01;
insert into emp01(empno, ename, job, sal) values(7935, '홍길동','SUPERMAN', 5000);
update emp01
set mgr='7777',
	hiredate=sysdate,
	deptno=40
where empno=7935;
select * from emp01 where empno=7935;

/*
숙제
emp03 복사테이블 생성
1. 입력 empno의 가장 작은수보다 -1, mgr:cleark의 mgr입력, sal:평균연봉,
	comm:전체 comm의 합계
2. 수정 ename:'신길동', job은 SUPERMAN, hiredate는 최근에 입사일+1
*/

/*
4. delete : 특정 조건의 데이터를 삭제처리하는 구문
	delete [없음] from 테이블명
	where 조건[컬럼명 = 조건데이터]
*/
-- DNAME이 'SALES'인 데이터를 DEPT01에서 삭제하시오..
delete from dept01
where DNAME='SALES';
--확인예제 deptno가 50이상인 데이터를 모두 삭제하시오..
--			emp01테이블 comm이 null이고, deptno가 20인 데이터를 삭제하세요.
delete from dept01
where deptno >= 50;
delete from emp01
where comm is null and deptno=20;

/*
transaction(트랜잭션) : 데이터베이스에서 처리의 한 단위를 의미하며,
여러개의 sql문의 하나의 논리적 작업 단위를 처리하는데 이를 의미하기도 한다.
tcl(transaction control language) : 이러한 트랜잭션을 제어를 위한 명령어..
commit : 데이터의 dml을 통해 수정, 삭제, 입력된 내용을 확정처리..
rollback : 데이터를 commit하기전에 수정 삭제 입력된 내용을 원복처리..
savepoint : 데이터를 특정시점으로 원복처리하고자 할 때, 시점을 save하는 것을 말한다..
*/
-- 1) dept01테이블에 deptno 30 '총무' '강남'을 입력한 뒤, rollback처리를 해본다.
-- 2) dept01테이블에 deptno 40 '인사' '대전'을 입력한 뒤,
--		commit하고 재접속한 경우와 commit하지 않고 재접속한 경우 데이터의
--		변경 내용을 확인한다.
insert into dept01 values(30, '충무', '강남');
rollback;
insert into dept01 values(40, '인사', '대전');
-- db접속을 끊는다.
-- 외부에서 commit하기 전에는 데이터가 변경 원복이 된다.
-- tool에 따라 autocommit이 발생하는 경우가 있다..

/*
*/