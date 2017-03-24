/*
여러가지 고급 DML QUERY!!
1. 다중 테이블에 다중행 입력하기
	INSERT 구문을 여러번 써서 데이터를 입력하는 경우가 많은 데이터를 입력
	할 때 번거로운 경우가 있다.
	한번은 SUBQUERY를 통해서 여러 동일한 구조의 테이블에 입력할 때,
	INSERT ALL 구문을 활용하면 손쉽게 처리할 수 있다.
	1) 형식
	INSERT ALL
	INTO 테이블1명 VALUES(컬럼1, 컬럼2, 컬럼3)
	INTO 테이블2명 VALUES(컬럼1, 컬럼2, 컬럼4)
	SELECT 컬럼1, 컬럼2, 컬럼3, 컬럼4
	FROM 테이블명
	WHERE 조건
	
*/
-- 구조복사테이블 생성하기
CREATE TABLE EMP_HIR
AS
SELECT EMPNO, ENAME, HIREDATE
FROM EMP WHERE 1=0;
CREATE TABLE EMP_MGR
AS
SELECT EMPNO, ENAME, MGR
FROM EMP WHERE 1=0;

INSERT ALL
INTO EMP_HIR VALUES(EMPNO, ENAME, HIREDATE)
INTO EMP_MGR VALUES(EMPNO, ENAME, MGR)
SELECT EMPNO, ENAME, HIREDATE, MGR
FROM EMP
WHERE DEPTNO=10;

/*
SUBQUERY를 이용한 데이터 수정하기
UPDATE 테이블명
SET (변경할 컬럼1, 변경할 컬럼2) = (SELECT 컬럼1, 컬럼2 FROM 테이블)
WHERE 조건
EX) 20번 부서의 지역명을 40번 부서의 지역명으로 변경하기 위해서 SUBQUERY를 활용해보자
*/
CREATE TABLE DEPT10
AS SELECT * FROM DEPT;
-- 입력할 데이터 LOADING(SUBQUERY)

SELECT DNAME, LOC
FROM DEPT
WHERE DEPTNO=40;
-- MAIN QUERY

UPDATE DEPT10
SET (DNAME, LOC) = (SELECT DNAME, LOC
					FROM DEPT
					WHERE DEPTNO=40)
WHERE DEPTNO=20;

/*
확인예제
EMP테이블의 복사본 EMP11 생성
	JOB(직책)이 PRESIDENT에 있는 SAL과 DEPTNO를
	JOB이 CLERK에 있는 데이터로 UPDATE하세요
*/
CREATE TABLE EMP11
AS SELECT * FROM EMP;

UPDATE EMP11
SET (SAL, DEPTNO) = (SELECT SAL, DEPTNO
					FROM EMP11
					WHERE JOB='PRESIDENT')
WHERE JOB='CLERK';

SELECT * FROM EMP11 WHERE JOB='CLERK';

/*
MERGE 처리
DATA MINGRATION(데이터 이관처리)할 때, 많이 활용된다.
테이블 A, 테이블 B로 데이터를 이관처리시, 부서가 달라 입력되어 있는 데이터도 있고,
신규로 입력해야될 데이터도 있으며, 입력되어 있는 데이터는 특정 컬럼을 수정처리해야
될 경우 많이 활용된다.
형식 EX) 테이블A에 있으나 테이블B에는 없는 데이터는 INSERT처리
		테이블A에 있고, 테이블B에 있으나 특정한 컬럼을 수정하는 것을 UPDATE처리
		두가지 내용을 한번에 처리하는 것을 MERGE
	MERGE INTO 통합할테이블 (EX) 테이블B 
		USING 이전및참조할테이블 (EX) 테이블A
		ON 조건처리 - 일반적으로 두 테이블의 KEY값(공통컬럼)을 조건으로 처리한다.
									EX) 테이블A.컬럼01=테이블B.컬럼01
		WHEN MATCHED THEN -- 두 개의 테이블 KEY데이터가 공통으로 있을 때
								EX) 테이블A의 컬럼01과 테이블B에 컬럼01에
									해당 데이터가 동일한 경우
			UPDATE 관련 처리
			UPDATE SET 통합할테이블.변경할컬럼=이전및참조할테이블.컬럼
								EX) 테이블B.변경컬럼=테이블A.컬럼
		WHEN NOT MATCHED THEN -- 한쪽 테이블에 데이터가 없는 경우
								EX) 테이블A에는 있으나, 테이블B에는 없는 경우
			INSERT 관련 처리
			INSERT VALUES (이전및참조할테이블.컬럼...)
								EX) INSERT VALUES (테이블B.컬럼명...)
			(테이블 명의 경우 MERGE INTO에 선언되어 있음)
*/
/*
EMP01, EMP02 데이터를 로딩해서.. EMP01에 데이터 머지처리..
1. EMP01 복사테이블 만들기.
2. EMP02 복사테이블 만들기 EMP에 JOB='MANAGER'만..
	EMP02 JOB ==> 'TEST'로 UPDATE
	EMP02 입력 7935 '홍길동' 'SUPERMAN' 7839 SYSDATE 4000 100 40
	(## EMPNO가 EMP01에 없는 데이터)
*/
-- EMP랑 동일
CREATE TABLE EMP10
AS SELECT * FROM EMP;

-- EMP 일부
CREATE TABLE EMP20
AS SELECT * FROM EMP WHERE JOB='MANAGER';

-- EMP랑 변경점 존재 (UPDATE)
UPDATE EMP20
SET JOB='TEST'; -- EMP20의 JOB을 'TEST'로 변경

-- EMP에 없는 값 추가 (INSERT)
-- EMP20 입력 7935 '홍길동' 'SUPERMAN' 7839 SYSDATE 4000 100 40
INSERT INTO EMP20 VALUES(7935, '홍길동', 'SUPERMAN', 7839, SYSDATE, 4000, 100, 40);

MERGE INTO EMP10 -- 최종 데이터는 EMP10에 처리
	USING EMP20		-- EMP20데이터를 사용함
	ON (EMP10.EMPNO = EMP20.EMPNO) -- 해당 KEY값이 EMPNO가 있는지 여부에 따라 UPDATE/INSERT
WHEN MATCHED THEN -- EMPNO값이 같을 때
	UPDATE SET
	EMP10.JOB = EMP20.JOB -- EMP20.JOB 데이터 즉, 'TEST'데이터를 EMP10.JOB에 UPDATE
WHEN NOT MATCHED THEN
	INSERT VALUES(EMP20.EMPNO, EMP20.ENAME, EMP20.JOB, EMP20.MGR, EMP20.HIREDATE,
					EMP20.SAL, EMP20.COMM, EMP20.DEPTNO);
/*
확인예제 
EMP의 복사테이블 EMP03 
EMP에서 부서번호(DEPTNO)가 30인 데이터를 EMP04로 복사테이블 만들기
      EMP04의 HIREDATE를 오늘날 (SYSDATE)로 UPDATE 처리
	EMP04에 7370 '원더걸' 'SUPERMAN' 7839 SYSDATE 6000 40 40 데이터 입력
	두 테이블 머지처리
*/

CREATE TABLE EMP30
AS SELECT * FROM EMP;

CREATE TABLE EMP40
AS SELECT * FROM EMP WHERE DEPTNO=30;

UPDATE EMP40
SET HIREDATE = SYSDATE;

INSERT INTO EMP40 VALUES (7370, '원더걸', 'SUPERMAN', 7839, SYSDATE, 6000, 40, 40);

MERGE INTO EMP30 -- 최종 데이터는 EMP10에 처리
	USING EMP40		-- EMP20데이터를 사용함
	ON (EMP30.EMPNO = EMP40.EMPNO) -- 해당 KEY값이 EMPNO가 있는지 여부에 따라 UPDATE/INSERT
WHEN MATCHED THEN -- EMPNO값이 같을 때
	UPDATE SET
	EMP30.HIREDATE = EMP40.HIREDATE -- EMP20.JOB 데이터 즉, 'TEST'데이터를 EMP10.JOB에 UPDATE
WHEN NOT MATCHED THEN
	INSERT VALUES(EMP40.EMPNO, EMP40.ENAME, EMP40.JOB, EMP40.MGR, EMP40.HIREDATE,
					EMP40.SAL, EMP40.COMM, EMP40.DEPTNO);
SELECT * FROM EMP30;