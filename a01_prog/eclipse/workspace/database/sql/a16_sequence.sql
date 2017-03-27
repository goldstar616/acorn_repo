/*
sequence
오라클에서 중복된 값을 넣지 않기 위해 기본 키(primary key)를 
테이블에 하나의 컬럼에 설정한다.
이 컬럼에 중복되지 않는 값을 넣기 위해서 오라클에서는 sequence
라는 객체를 지원하고 있다. 
시퀀스는 데이블 내의 유일한 숫자를 자동으로 생성하여 자동으로
번호를 입력할 수 있게 하기에 사용자의 유일키 생성에 대한 부담을
줄여 준다.
ex) 학생 테이블에 번호를 입력한다.
	no 이름 ....
	no 컬럼에 1, 2, 3, 4, 5..  으로 자동으로 입력을 해야할 때.
	사번 테이블에 번호를 입력한다.
	empno ename
	1000 부터 시작 1001, 1002, 1003, 1004 .... 	
	학번입력..
	studId  name..
	C020001   시작여 C020002, C020003.....
	[단과코드][SEQUENCE] : 합성번호..
EX) 입력시, 자동으로 NUMBERING 처리..	
	INSERT INTO 테이블  VALUES( SEQUENCE명.NEXTVAL, ....)
	INSERT INTO 테이블  VALUES( 'C0'||SEQUENCE명.NEXTVAL, ....)
					--> 문자와 조합된 sequence 처리..

형식]	
CREATE SEQUENCE 시퀀스명
   	START WITH N  --> 시작하는 번호를 지정..EX) 1, 1001, 20001
	INCREMENT BY N  --> 증감 단위..EX) 1, 2(2 STEP단위로 증가)
	                                 -1(1 STEP단위로 감소)
	MAXVALUE N  --> 증가했을 때, 최고 범위 EX) 999999
							1 ~ 999999 까지 데이터를  NUMBERING
							처리한다.									  	
데이터 입력이나 활용시.
	시퀀스명.NEXTVAL : 시퀀스를 증가시키며 현재값을 출력..
	시퀀스명.CRURRVAL : 시퀀스의 현재값을 출력.

EX) ## 시작값이 1이고 1씩 증가하고, 최대값이 99999인 시퀀스 
	EXP01_SEQ를 만들어 보자..

*/
CREATE SEQUENCE EXP01_SEQ
		START WITH 1
		INCREMENT BY 1
		MAXVALUE 99999;
SELECT EXP01_SEQ.NEXTVAL FROM DUAL; -- 시작 번호가 1개 생성 및 NUMBERRING
-- 현재 서버의 유일한 NUMBER ....
SELECT EXP01_SEQ.CURRVAL FROM DUAL; -- 현재 번호 호출.
-- EX) 학생테이블(STUDENT_SEQ_EXP)에 
--     no 이름 
create table student_seq_exp(
	no number primary key,
	name varchar2(50)
);
-- 테이블에 seqence를 활용하여 데이터를 입력한다.
CREATE SEQUENCE student_SEQ
		START WITH 1
		INCREMENT BY 1
		MAXVALUE 99999;
insert into student_seq_exp values(	student_SEQ.nextval, '이름입력');
select * from student_seq_exp;
/* 확인예제
	1) emp_seq_exp 테이블 생성후(empno ename)
	emp_seq10 시퀀스 생성,
		1000 부터 시작 1001, 1002, 1003, 1004 .... 	
	입력처리..
	2) college 테이블 생성(studid, name)
	college_seq 시퀀스 생성.
		20001, 20002
	학번입력..
	studId  name..
	C020001   시작여 C020002, C020003.....
	[단과코드][SEQUENCE] : 합성번호..
*/

create sequence emp_seq10
	start with 1000
	increment by 1
	maxvalue 9999;
create table emp_seq_exp(
	empno number primary key,
	ename varchar2(50)
);	  

