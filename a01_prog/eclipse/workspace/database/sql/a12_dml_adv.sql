/*
여러가지 고급 DML query!!
1. 다중 테이블에 다중행 입력하기..
	insert 구문을 여러번 써서 데이터를 입력하는 경우가 많은 데이터를 입력
	할 때 번거러운 경우가 있다.
	한번은 suberquery를 통해서 여러 동일한 구조의 테이블에 입력할 때,
	insert all 구문을 활용하면 손쉽게 처리할 수 있다.
	1) 형식
	INSERT ALL
	INTO 테이블1명 VALUES(컬럼1, 컬럼2, 컬럼3)
	INTO 테이블2명 VALUES(컬럼1, 컬럼2, 컬럼4)
	SELECT 컬럼1, 컬럼2, 컬럼3, 컬럼4
	FROM 테이블명
	WHERE 조건
	EX) EMP테이블에서 구조복사테이블 생성 
	    	EMP_HIR(EMPNO, ENAME, HIREDATE)
			EMP_MGR(EMPNO, ENAME, MGR)
		원본 EMP테이블에서 부서번호가20인 데이터를 해당 테이블에
		데이터 입력처리..
		
*/
-- 구조복사테이블 생성하기..
	CREATE TABLE EMP_HIR
	AS
	SELECT EMPNO, ENAME, HIREDATE
	FROM EMP WHERE 1=0;
	SELECT * FROM EMP_HIR;
	CREATE TABLE EMP_MGR
	AS
	SELECT EMPNO, ENAME, MGR
	FROM EMP WHERE 1=0;
INSERT ALL
	INTO EMP_HIR VALUES(EMPNO,ENAME, HIREDATE)
	INTO EMP_MGR VALUES(EMPNO, ENAME, MGR)
	SELECT EMPNO, ENAME, HIREDATE, MGR
	FROM EMP
	WHERE DEPTNO=10;
/*
서버 쿼리를 이용한 데이터 수정하기..
UPDATE 테이블명
SET (변경할컬럼1, 변경할컬럼2) = (SELECT 컬럼1,컬럼2 FROM 테이블)
WHERE 조건..
EX) 20번 부서의 지역명을 40번 부서의 지역명으로 변경하기 위해서 서버쿼리
	를 활용해보자..
*/		
CREATE TABLE DEPT01
AS
SELECT * FROM DEPT;
-- 입력할 데이터 LOADING(SUBQUERY)
SELECT DNAME, LOC
FROM DEPT
WHERE DEPTNO=40; 
-- MAIN QUERY
UPDATE DEPT01
SET (DNAME, LOC) =( SELECT DNAME, LOC
					FROM DEPT
					WHERE DEPTNO=40)
WHERE DEPTNO=20;
SELECT * FROM DEPT01;
SELECT * FROM EMP;
CREATE TABLE EMP11
AS
SELECT *
FROM EMP;

UPDATE EMP11
SET (SAL,DEPTNO)=(
	SELECT SAL,DEPTNO
	FROM EMP11
	WHERE JOB='PRESIDENT')
WHERE JOB='CLERK';
SELECT * FROM EMP11
WHERE JOB='CLERK';
/*
MERGE 처리..
 DATA MINGRATION(데이터 이관처리) 할때, 많이 활용된다.
 테이블  A, 테이블 B 로 데이터를 이관처리시, 부서가 달라 입력되어 있는 데이터도 있고,
 신규로 입력해야될 데이터도 있으며, 입력되어 있는 데이터는 특정 컬럼을 수정처리해야
 될 경우 많이 활용된다.
형식 ex) 테이블A에 있으나  테이블B에는 없는 데이터는 insert처리
            테이블A에 있고, 테이블B에 있으나 특정한 컬럼을 수정하는 것을 update처리
		두가지 내용을 한번에 처리하는 것을 MERGE
	MERGE INTO 통합할테이블  EX) 테이블B
		USING 이전및참조할테이블  ex) 테이블A
		ON 조건처리-일반적으로 두 테이블의 KEY값(공통컬럼)을 조건으로 처리한다.
		                       ex) 테이블A.컬럼01=테이블B.컬럼01
		WHEN MATCHED THEN -- 두개의 테이블 KEY데이터가 공통으로 있을 때.
		    업데이터 관련처리         ex) 테이블A의 컬럼01과 테이블B에 컬럼01에
			update set 		해당 데이터가 동일한 경우..
			통합할테이블.변경할컬럼=이전및참조할테이블.컬럼	
			              ex) 테이블B.변경컬럼 = 테이블A.컬럼														
		WHEN NOT MATCHED THEN -- 한쪽 테이블에 데이터 없는 경우
								EX) 테이블A에는 있으나, 테이블 B에는 없는 경우
			입력관련처리..					
		    insert [테이블X] values(이전및참조할테이블.컬럼...)
								EX) INSERT VALUES(테이블B.컬럼명....);
*/
/*
EMP01, EMP02 데이터를 로딩해서..EMP01에 데이터 머지처리..
1. EMP01 복사테이블 만들기.
2. EMP02 복사테이블 만들기  EMP에 JOB='MANAGER'만... 
   EMP02 JOB ==> 'test'로 UPDATE (##empno는 동일, job이 다른 데이터)
   EMP02 입력 7935 '홍길동', 'SUPERMAN' 7839 SYSDATE 4000 100 40 
   	(## empno가 EMP01에 없는 데이터)
*/
select * from emp order by empno desc;
DROP TABLE EMP01;
CREATE TABLE EMP01
AS
	SELECT * FROM EMP; -- EMP01 복사테이블 생성
SELECT * FROM EMP01; -- 이 테이블에 머지 처리..
DROP TABLE EMP02;
CREATE TABLE EMP02
AS
	SELECT * FROM EMP
	WHERE JOB='MANAGER';
SELECT * FROM EMP02;
UPDATE EMP02
SET JOB='TEST'; -- EMP02의 JOB을 'TEST'로 변경
-- EMP02 입력 7935 '홍길동', 'SUPERMAN' 7839 SYSDATE 4000 100 40 
INSERT INTO EMP02 VALUES(7935,'홍길동','SUPERMAN',7839,SYSDATE, 4000,100,40);
SELECT * FROM EMP01;
SELECT * FROM EMP02;
MERGE INTO EMP01  -- 최종 데이터는 EMP01에 처리
	 USING EMP02   -- EMP02데이터를 사용함..
	 ON (EMP01.EMPNO = EMP02.EMPNO) -- 해당 KEY값이 EMPNO가 있는지 여부에 따라 UPDATE/INSERT                   
WHEN MATCHED THEN -- EMPNO값이 같을 때..
	UPDATE SET
	  EMP01.JOB = EMP02.JOB  -- EMP02.JOB 데이터 즉, 'test'데이터를 EMP01.JOB에 UPDATE
WHEN NOT MATCHED THEN --동일한 EMPNO값이 EMP01에 없을 경우,
	INSERT VALUES(EMP02.EMPNO, EMP02.ENAME, EMP02.JOB, EMP02.MGR, EMP02.HIREDATE,
	              EMP02.SAL, EMP02.COMM,EMP02.DEPTNO); 
SELECT * FROM EMP01 ORDER BY EMPNO;				  	  
/*
확인예제. 
EMP의 복사테이블 EMP03
EMP에서 부서번호(DEPTNO)가 30인 데이터를 EMP04로 복사테이블 만들기
	EMP04의 HIREDATE를 오늘날(SYSDATE)로 UPDATE 처리..
EMP04에 7370 '원더걸' 'SUPERMAN' 7839 SYSDATE 6000 400 40 데이터 입력
두 테이블 머지처리..
*/
DROP TABLE EMP03;
CREATE TABLE EMP03
AS
	SELECT * FROM EMP;
DROP TABLE EMP04;
CREATE TABLE EMP04
AS 
	SELECT * FROM EMP
	WHERE DEPTNO=30;
UPDATE EMP04
SET HIREDATE=SYSDATE;
INSERT INTO EMP04 VALUES(7370,'원더걸','SUPERMAN',7839,SYSDATE,6000,400,40);
MERGE INTO EMP03
 USING EMP04
 ON	(EMP03.EMPNO=EMP04.EMPNO)
WHEN MATCHED THEN
	UPDATE SET
		EMP03.HIREDATE=EMP04.HIREDATE
WHEN NOT MATCHED THEN
	INSERT VALUES(EMP04.EMPNO, EMP04.ENAME, EMP04.JOB, EMP04.MGR, EMP04.HIREDATE,
				  EMP04.SAL, EMP04.COMM, EMP04.DEPTNO);
SELECT * FROM EMP03;
SELECT * FROM EMP;				  
	
		
	 


	
	


