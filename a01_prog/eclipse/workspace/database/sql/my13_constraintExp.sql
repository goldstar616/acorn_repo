CREATE TABLE A01_NOT_NULLEXP
(
	EMPNO NUMBER NOT NULL,
	ENAME VARCHAR2(20) NOT NULL,
	JOB VARCHAR2(20)
);

CREATE TABLE A02_NULLEXP
(
	EMPNO NUMBER,
	ENAME VARCHAR2(20),
	JOB VARCHAR2(20)
);

/*
1) 데이터를 입력시, 묵시적 NULL값 입력
2) 데이터 입력시, 명시적 NULL값 입력
*/

INSERT INTO A01_NOT_NULLEXP VALUES('프로그래머1'); 
-- NOT NULL 에러
INSERT INTO A02_NULLEXP VALUES('프로그래머2');

INSERT INTO A01_NOT_NULLEXP(JOB) VALUES('프로그래머1'); 
-- NOT NULL 에러
INSERT INTO A01_NOT_NULLEXP(EMPNO, ENAME, JOB) VALUES(7000, '홍길동', '프로그래머1'); 
-- 정상입력
INSERT INTO A01_NOT_NULLEXP(EMPNO, JOB) VALUES(7001, '프로그래머1'); 
-- NOT NULL 에러 (1개라도 걸리면 에러)
INSERT INTO A01_NOT_NULLEXP(EMPNO, ENAME) VALUES(7002, '신길동'); 
-- 정상입력 JOB은 제약없음

/*
데이터 딕셔너리(DATA DICT)
CONSTRAINT_TYPE
제약조건의 유형에 대한 내용을 선언하는 부분. *******시험*******
P : PRIMARY KEY : ## - 제약조건에 NOT NULL, UNIQUE를 설정한다
						보통 메인 테이블에서
R : FOREIGN KEY(외래키) : 해당 컬럼에 데이터가 참조한 다른 테이블에
							데이터가 반드시 있어야 처리되는 경우
							EX) DEPT에 DEPTNO인 경우, 부서번호에 대한 정보
							부서정보 KEY DEPTNO가 등록되어 있어야지
							EMP테이블에서 DEPTNO에 데이터 입력할 수 있게끔
							처리해야 무결성을 지킬 수 있다
U
C
*/

/*
제약조건의 사용자 정의
1. 테이블 생성시, 설정
	형식
	CREATE TABLE 테이블명
		제약조건선언할컬럼 데이터TYPE, EX) EMPNO NUMBER
		CONSTRAINT 제약조건명(테이블명_컬럼명_제약조건유형축약) 제약조건
								EX) CONSTRAINT EMP_EMPNO_PK PRIMARY KEY,
2. 제약조건을 따로 지정하여 설정하는 방법
	
*/

CREATE TABLE EMP50
(
	EMPNO NUMBER CONSTRAINT EMP_EMPNO_PK PRIMARY KEY,
	ENAME VARCHAR2(20)
);

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME='EMP50';

/*
확인예제
	PROFESSOR 테이블을 생성하되
	
*/

CREATE TABLE PROFESSOR
(
	PROID VARCHAR2(20) CONSTRAINT PROFESSOR_PROID_NN NOT NULL,
	NAME VARCHAR2(20) CONSTRAINT PROFESSOR_NAME_UN UNIQUE,
	MAJOR VARCHAR2(20)
);

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME='PROFESSOR';

/*
하나의 컬럼이 아니라, 두개의 컬럼으로 제약조건을 선언하는 경우
EX) 학생테이블의 KEY를 신규 컬럼으로 생성하는 것이 아니라
	GRADE(학년) PART(반) NO(번호)
형식
	CREATE TABLE 테이블명
	(
		컬럼명1 데이터TYPE,
		컬럼명2 데이터TYPE,
		컬럼명3 데이터TYPE,
		CONSTRAINT 제약조건명(테이블_컬럼복합_제약단축) 제약조건(컬럼1, 컬럼2)
	);
*/

create table highschool
(
   grade number,
   part number,
   no number,
   name varchar2(30),
   constraint highschool_dist_pk primary key(grade, part, no)
   --highschool테이블에 primary key를 3개의 컬럼으로 잡는데, grade, part, no 
   -- grade, part, no를 동시에 조합해서 동일한 데이터가 안 나오게끔 처리..
);
   
insert into highschool values(1,1,2,'김길동');
insert into highschool values (1,1,3,'신길동');
select * from highschool;

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME='HIGHSCHOOL';
/*
확인예제
	ADDRESS라는 테이블에
	도/광역시	시/구군		동		번지	세대주	주거인원
	PRIMARY KEY(도/광역시	시/구군		동		번지)
*/

CREATE TABLE ADDRESS
(
	ADD1 VARCHAR2(10),
	ADD2 VARCHAR2(10),
	ADD3 VARCHAR2(10),
	ADD4 VARCHAR2(10),
	CONSTRAINT ADDRESS_ADD_PK PRIMARY KEY(ADD1,ADD2,ADD3,ADD4),
	OWNER VARCHAR(10),
	CNT NUMBER
);

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME='ADDRESS';