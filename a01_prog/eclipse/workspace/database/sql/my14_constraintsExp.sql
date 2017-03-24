select * from a01_not_nullExp;
select * from a02_nullExp;
-- 묵시적 null 값 입력. 제약조건이 있기에 에러발생..
insert into a01_not_nullExp(job) values('프로그래머1');
-- 명시적 null 값 입력..
-- 테이블명(컬럼명시X) ==> 전체 컬럼에 대한 입력을 처리하겠다
-- values(전체컬럼에 들어갈 데이터를 명시)
insert into a02_nullExp values(null, '홍길동','프로그래머3');
select * from a02_nullExp;
insert into a01_not_nullExp values(null, '신길동','프로그래머3');
-- 명시적으로 null값에 호출하더라도 제약조건이 하나라도 있으면 입력이
-- 되지 않는다.
/*
데이터 딕션어리(data dictionary)를 통해 constraints 확인하기..
user_constraints : 전체 테이블에 대한 제약조건 내용 확인하기..
constraint_type
 제약조건의 유형에 대한 내용을 선언하는 부분. *******시험*******
 P : PRIMARY KEY : ## - 제약조건에 NOT NULL, UNIQUE를 설정한다.
 						보통 메인테이블에서 KEY로 정의하는 컬럼설정.
 R : FOREIGN KEY(외래키) : 해당 컬럼에 데이터다 참조한 다른 테이블에
 						데이터가 반드시 있어야 처리되는 경우
						EX) dept에 deptno인 경우, 부서번호에 대한 정보
						부서정보 key deptno가 등록되어 있어야지..
						emp테이블에서 deptno에 데이터 입력할 수 있게끔 
						처리해야 무결성을 지킬 수 있다.
 U : UNIQUE (유일키설정) : 해당 컬럼의 데이터가 다른 컬럼의 데이터와 비교
 						해서 반드시 하나의 유일한 데이터가 되게 할 때
						설정하는  옵션.												
 						EX) DEPT테이블에 DEPTNO가 다른 데이터와 비교해서
						같은 DEPTNO로 다른 DNAME(부서이름)이 입력되게
						되면 데이터 무결성에 문제가 발생하기에 이를 입력
						당시 사전에 에러를 발생시켜 무결성을 확보하기 위
						해서 처리한다.
						20 회계감사  
						20 총무      ==> 무결성에 문제를 발생시킴.
 C : CHECK              특정한 컬럼에 특정한 데이터만 들어오게 처리하는
 						제약 조건을 말한다. 
						EX) EMP에 컬럼으로 GENDER(성별)을 설정했을 때,
						F(여자), M(남자)만 들어오게 하여, 데이터 자체
						에 대한 통일을 유지하여 무결성 확보를 하기 위한
						목적으로 사용된다.					
*/
select * from user_constraints;
/*
UNIQUE : 유일키 설정 처리..
1. 연습테이블만들기( EMP03)
2. 컬럼에 유일키 설정하기(UNIQUE)
3. 데이터 입력 TEST - 데이터를 동일할 때, 어떤 에러가 발생하는지 확인.
4. 데이터 딕션너리에서 해당 제약사항 확인하기..
*/
SELECT * FROM EMP03;
DROP TABLE EMP03;
CREATE TABLE EMP03(
	EMPNO NUMBER UNIQUE, -- EMPNO가 중복이 되지 않게 제약조건으로 설정
	ENAME VARCHAR2(30),
	JOB VARCHAR2(30)
);
SELECT * FROM EMP03;
INSERT INTO EMP03 VALUES(1000,'ALLEN','SALESMAN');
INSERT INTO EMP03 VALUES(1001,'JONES','MANAGER');
-- 동일한 값 1000은 컬럼으로 설정시 UNIQUE로 설정했기에 에러가 발생한다.
INSERT INTO EMP03 VALUES(1000,'HIMAN', 'SUPERMAN');
-- DATA DICTIONARY를 통해서 제약사항을 확인할 수 있다.
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM USER_CONSTRAINTS
WHERE TABLE_NAME='EMP03';
/*
확인예제 - 테이블 생성시 DROP하고, 새로 생성처리.
STUDENT라는 학생테이블에 컬럼으로  학번, 이름, 학과을 설정한 후에,
제약조건으로 학번에 UNIQUE를 설정해서 생성하세요.
데이터 입력으로 해당 내용이 처리되는지 확인
데이터 딕션너리를 통해서 제약조건이 등록되어 있는지 확인..
*/
DROP TABLE STUDENT; 
CREATE TABLE STUDENT(
	STNUMBER VARCHAR2(10) UNIQUE,
	NAME VARCHAR2(50),
	MAJOR VARCHAR2(100)
);
INSERT INTO STUDENT VALUES('C070801','홍정아','컴퓨터공학');
INSERT INTO STUDENT VALUES('C070802','김정기','경영정보');
INSERT INTO STUDENT VALUES('C070801','이준희','멀티미디어');
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM USER_CONSTRAINTS
WHERE TABLE_NAME='STUDENT';
/*
제약 조건명을 사용자 정의하기..
1. 테이블 생성시, 설정
	형식
	create table 테이블명
		제약조건선언할컬럼 데이터type ex) empno number
		constraint 제약조건명(테이블명_컬럼명_제약조건유형축약) 제약조건
							ex) constraint emp_empno_pk primary key,

*/
create table emp05(
	empno number constraint emp_empno_pk primary key,
	ename varchar2(20)
);
select * 
from user_constraints
where table_name='EMP05';

/*
확인예제..
   PROFESSOR 테이블을 생성하된
	PROID, NAME ==> 둘다 CONSTRAINT를 설정하는데,
			NOT NULL, UNIQUE로 이름을 지정해서 설정하세요.
	MAJOR
   user_constraints에서 지정된 제약조건이름 검색해서 확인.
*/

create table PROFESSOR(
	PROID VARCHAR2(10) CONSTRAINT PROFESSOR_PROID_NN NOT NULL,
	NAME VARCHAR2(30) CONSTRAINT PROFESSOR_NAME_UQ UNIQUE,
	MAJOR VARCHAR2(20) 
);
select * 
from user_constraints
where table_name='PROFESSOR';
/*
하나의 컬럼이 아니라, 두개의 이상의 컬럼으로 제약조건을 선언하는 경우..
EX) 학생테이블을 KEY을 컬럼을 신규로 생성하는 것이 아니라.
	GRADE(학년) PART(반) NO(번호)  이름..
형식
	CREATE TABLE 테이블명(
		컬럼명1 데이터TYPE,
		컬럼명2 데이터TYPE,
		컬럼명3  데이터TYPE,
		CONSTRAINT 제약조건명(테이블_컬럼복합_제약단축) 제약조건(컬럼1, 컬럼2..)
	);	
	한꺼번에 다중의 컬럼으로 제약조건을 처리함으로 해당 내용에 대한 KEY 컬럼을 신규작성할 필요가 
	없을 때, 활용된다. 단 위 제약조건 해당 내용에 한꺼번에 처리하지 않으면 에러가 발생..
EX) 학생테이블을 KEY을 컬럼을 신규로 생성하는 것이 아니라.
	GRADE(학년) PART(반) NO(번호)  이름..
*/
DROP TABLE HIGHSCHOOL;
CREATE TABLE HIGHSCHOOL(
	GRADE NUMBER,
	PART NUMBER,
	NO NUMBER,
	NAME VARCHAR2(30),
	CONSTRAINT HIGHSCHOOL_DIST_PK PRIMARY KEY(GRADE, PART, NO)
	-- HIGHSCHOOL테이블에 PRIMARY KEY를 3개의 컬럼으로 잡는데, GRADE, PART, NO
	-- GRADE, PART, NO를 동시에 조합에서 동일한 데이터가 안 나오게 처리..
);
INSERT INTO HIGHSCHOOL VALUES(1,1,2,'김길동');
INSERT INTO HIGHSCHOOL VALUES(1,1,3,'신길동');
SELECT * FROM HIGHSCHOOL;
select * 
from user_constraints
where table_name='HIGHSCHOOL';

CREATE TABLE ADDRESS(
	STATE VARCHAR2(50),
	CITY VARCHAR2(50),
	AREA VARCHAR2(50),
	ADNUMBER NUMBER,
	HOST VARCHAR2(50),
	RISDNUMBER NUMBER,
	CONSTRAINT ADDRESS_COM_PK 
		PRIMARY KEY(STATE, CITY,AREA,ADNUMBER)
);
INSERT INTO ADDRESS VALUES('서울특별시','강남구','대치동',253,'김길동',4);
SELECT * FROM ADDRESS;
/*2. 제약조건을 따로 지정하여 설정하는 방법..
	1) 테이블 생성
	2) ALTER TABLE 테이블명
	      ADD CONSTRAINT 제약조건명 제약조건유형(컬럼명)
		  MODIFY 컬럼명 CONSTRAINT 제약조건명 제약조건유형
		  DROP 제약조건명*/
		  








