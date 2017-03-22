/*
서브 쿼리를 이용한 데이터 추가
INSERT 구문을 SELECT와 혼합해서, 데이터를 입력 처리가 가능.
형식 : INSERT INTO 테이블명
		SELECT * FROM 입력할테이블; 해당 SQL로 여러 라인의 데이터를
		한번에 입력할 수 있다.
		주의할 점) 입력할 테이블의 컬럼과 SELECT [선택컬럼명]의
		컬럼 갯수와 TYPE이 동일하여야 한다. 
*/
-- EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO
INSERT INTO EMP_STRUCTOR
SELECT * FROM EMP
WHERE SAL >= 3000;

/*
INSERT INTO 테이블명(컬럼1, 컬럼2, 컬럼3)
SELECT 컬럼1, 컬럼1+컬럼2, 함수(컬럼3) 
FROM 테이블명
WHERE 조건
*/
INSERT INTO EMP_STRUCTOR(EMPNO)
		SELECT EMPNO FROM EMP;
INSERT INTO EMP_STRUCTOR(EMPNO, SAL, ENAME)
		SELECT EMPNO, SAL+NVL(COMM, 0), RPAD(ENAME,7,'^^') FROM EMP;
/*
확인예제
DEPT_SUB 이라는 테이블을 DEPT테이블을 이용하여 만들되, 추가컬럼,
		KDNAME(한글이름), MEMBERCNT(등록된인원)
1) 구조만 있는 공백테이블 생성.
2) DEPT테이블을 이용해서 기존 데이터와 추가된 데이터를 입력하세요
	- 처음: 한글이름-없음, MEMBERCNT = 0
*/
CREATE TABLE DEPT_SUB
AS
SELECT DEPTNO, DNAME, LOC, '         ' KDNAME, 0 MEMBERCNT 
FROM DEPT
WHERE 1=0;

INSERT INTO DEPT_SUB
SELECT DEPTNO, DNAME, LOC, '없음' KDNAME, 0 MEMBERCNT
FROM DEPT;

/*
KDNAME에 대한 처리
DECODE (DEPTNO, 10, '회계', 20, '감사', 30, '영업', 40, '운영', '없음') KDNAME,
	0 MEMBERCNT
FROM DEPT;

*/
SELECT DEPTNO, DNAME, LOC, DECODE (DEPTNO, 10, '회계', 20, '감사', 30, '영업', 40, '운영', '없음') KDNAME, 0 MEMBERCNT
FROM DEPT;

/*
MEMBERCNT에 대한 처리
	EMP테이블에 데이터를 확인해서 처리
	SELECT DEPTNO, DNAME, LOC, 
		DECODE (DEPTNO, 10, '회계', 
						20, '감사', 
						30, '영업', 
						40, '운영', 
						'없음') KDNAME, 
		(SELECT COUNT(*) 
		FROM EMP 
		WHERE DEPTNO=A.DEPTNO) MEMBERCNT
	FROM DEPT A;
*/

INSERT INTO DEPT_SUB
SELECT DEPTNO, DNAME, LOC, 
		DECODE (DEPTNO, 10, '회계', 
						20, '감사', 
						30, '영업', 
						40, '운영', 
						'없음') KDNAME, 
		(SELECT COUNT(*) 
		FROM EMP 
		WHERE DEPTNO=A.DEPTNO) MEMBERCNT
FROM DEPT A;

/*
수정 서브쿼리:
	수정하는 MAIN SQL에서도 SUBQUERY로 해당 내용의 결과를
	처리하는 것을 말한다
UPDATE 테이블명
SET 컬럼명 = 데이터(데이터부분을 SUBQUERY로 처리
					SELECT 컬럼명
					FROM 테이블
					WHERE 조건)
WHERE 조건
*/
/*
-- 1. SUBQUERY
SELECT AVG(COMM)
FROM EMP;
-- 2. MAINQUERY
UPDATE EMP
SET	COMM=(SELECT AVG(COMM) FROM EMP)
WHERE EMPNO=7369;

확인예제
1. EMP_SUB77 이라는 EMP의 복사테이블을 생성
2. EMP_SUB77에서 COMM이 NULL값인 데이터에 SAL의 최저값으로 수정하세요
CREATE TABLE EMP_SUB77
AS SELECT * FROM EMP;
UPDATE EMP_SUB77
SET COMM=(SELECT MIN(SAL) FROM EMP_SUB77)
WHERE COMM IS NULL;
*/

