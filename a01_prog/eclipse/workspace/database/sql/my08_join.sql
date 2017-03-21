/*
CROSS JOIN
*/
SELECT COUNT(*)
FROM EMP, DEPT; -- EMP테이블 X DEPT테이블
SELECT COUNT(*)
FROM EMP;
SELECT COUNT(*)
FROM DEPT;

/*
EQUI JOIN : 두개이상 테이블에서 각테이블에 소속되어 있는 컬럼의 데이터가
			같은 값이 있을 때, 
형식
	SELECT 표현할컬럼
	FROM 테이블1, 테이블2
	WHERE 테이블1.공통컬럼 = 테이블2.공통컬럼
	공통컬럼 : 같은 데이터가 있는 컬럼
*/
SELECT * FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;
-- 사원의 이름과 직책, 소속부서명을 출력하세요
SELECT ENAME, JOB, DNAME
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;
-- ex) DEPT를 조건하여 사원명, 부서위치(LOC)를 출력
SELECT ENAME, LOC
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;

-- 확인예제) 보너스가 있는 사원의 이름과 부서명을 출력하세요
SELECT ENAME, DNAME
FROM EMP A, DEPT B
WHERE A.COMM IS NOT NULL AND A.DEPTNO = B.DEPTNO;

/*
NON-EQUI JOIN
테이블 사이에 컬럼의 값이 직접적으로 일치하지 않을 시 사용하는 조인으로
*/
-- 급여 등급을 5개로 나누고 이 등급을 표시하시오
-- WHERE SAL BETWEEN [LOSAL] AND [HISAL]
-- 이름과 연봉 연봉등급
-- 테이블 ALIAS 사용하기 : 테이블의 컬럼에 같은 이름이 없으면 의미가 없지만
--	같은 이름이 있으면 구분하기 위해 테이블명[공백]ALIAS를 활용한다.
--	테이블ALIAS.컬럼명
--	또한, 데이터 컬럼의 명이 많아 가독성을 위해 기술하는 경우도 있다.
SELECT E.ENAME, E.SAL, S.GRADE
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL; 
/*
숙제
STUDENT10			아이디(ID),			이름(NAME)	
STUDENTPOINT	아이디(ID),			과목(SUBJECT),		점수(POINT)
GRADECHECK		최저점수(LOPOINT),	최고점수(HIPOINT),	학점등급(A~F)
1) 아이디를 조인해서(EQUAL JOIN)
	이름 과목 점수 출력
2) 점수를 조인해서(NOT EQUAL JOIN)
	과목 점수 학점등급
3) STUDENT10 STUDENTPOINT GRADECHECK 조인을 하여
	이름 과목 학점등급
*/
CREATE TABLE GRADECHECK
(
	GRADE	VARCHAR2(4),
	LOPOINT	NUMBER(10),
	HIPOINT	NUMBER(10)
);

INSERT INTO GRADECHECK VALUES ('A', '91', '100');
INSERT INTO GRADECHECK VALUES ('B', '81', '90');
INSERT INTO GRADECHECK VALUES ('C', '71', '80');
INSERT INTO GRADECHECK VALUES ('D', '61', '70');
INSERT INTO GRADECHECK VALUES ('E', '51', '60');
INSERT INTO GRADECHECK VALUES ('F', '0', '50');

SELECT M.ID, P.SUBJECT, P.POINT
FROM STUDENT_MAIN M, STUDENT_POINT P
WHERE M.ID = P.ID;

SELECT P.SUBJECT, P.POINT, G.GRADE
FROM STUDENT_POINT P, GRADECHECK G
WHERE P.POINT BETWEEN G.LOPOINT AND G.HIPOINT; 

SELECT M.ID, P.SUBJECT, G.GRADE
FROM STUDENT_MAIN M, STUDENT_POINT P, GRADECHECK G
WHERE M.ID = P.ID AND P.POINT BETWEEN G.LOPOINT AND G.HIPOINT;

/*
OUTER JOIN
두 개의 조인 관계에 있는 테이블에 있어, 한쪽 또는 양쪽 다
조건이 만족하지 않더라도 데이터 결과를 출력해야 하는 경우에 활용되는 조인이다.
*/
SELECT * FROM DEPT;
SELECT DISTINCT DEPTNO FROM EMP;
-- 부서번호별로 매칭되는 사원이름을 출력하되, 이름이 없으면 없다는 표시가 필요
-- 이름 부서번호 부서명
-- WHERE 데이터가 없는 테이블.컬럼명(+) = 데이터가 있는 테이블.컬럼명 
SELECT NVL(E.ENAME, '인원없음') ENAME, D.DEPTNO, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO
ORDER BY E.DEPTNO DESC;

/*
숙제) OUTER JOIN, GROUP BY를 활용하여 
		부서명별 인원을 확인할려고 한다.
		아래의 형식으로 출력하세요.
		인원이 없는 곳은 0으로 표시
		부서명	인원	
*/
SELECT D.DNAME, COUNT(E.EMPNO)
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO
GROUP BY D.DNAME;

/*
SELF JOIN : 말 그대로 자기 자신과 조인을 맺는 것을 말한다.
FROM절에 같은 이름을 테이블을 나열하여, 다른 테이블인 것처럼 인식해서
조인하여 그 결과물을 출력하는 것을 말한다.
SELECT * FROM 테이블명 ALIAS01, 동일테이블명 ALIAS02
WHERE ALIAS01.연관컬럼 = ALIAS02.연관컬럼
EX) 사원테이블(EMP)에서 사원명 관리자명을 출력하세요 
*/
SELECT WORK.ENAME, WORK.MGR, MANAGER.ENAME
FROM EMP WORK, EMP MANAGER
WHERE WORK.MGR = MANAGER.EMPNO;

/*
계층형 JOIN관계 정보 테이블 만들기(SELF JOIN)
1. 구조를 정리한다
	ID와 상위 ID를 입력하는 KEY를 만든다.
	NUMID,	PARENTNUMID,	ROLE01,	NAME
	아이디,	상위아이디,		역할,	이름
2. 테이블을 생성한다
	CREATE TABLE FAMILY
	(
		NUMID			NUMBER,
		PARENTNUMID		NUMBER,
		ROLE01			VARCHAR2(100),
		NAME			VARCHAR2(500)
	);
3. 테이블을 입력한다(위에 세워놓은 계층형 구조에 의한 데이터 입력처리)
	INSERT INTO FAMILY VALUES (1,0,'할아버지','홍길동');
	INSERT INTO FAMILY VALUES (2,1,'아버지','홍정길');
	INSERT INTO FAMILY VALUES (3,2,'아들','홍현호');
	INSERT INTO FAMILY VALUES (4,1,'삼촌','홍정호');
4. 입력된 데이터 내용이 정상적으로 되어 있는지 확인한다.
	-조회 처리
*/
CREATE TABLE FAMILY
(
	NUMID			NUMBER,
	PARENTNUMID		NUMBER,
	ROLE01			VARCHAR2(100),
	NAME			VARCHAR2(500)
);
INSERT INTO FAMILY VALUES (1,0,'할아버지','홍길동');
INSERT INTO FAMILY VALUES (2,1,'아버지','홍정길');
INSERT INTO FAMILY VALUES (3,2,'아들','홍현호');
INSERT INTO FAMILY VALUES (4,1,'삼촌','홍정호');
SELECT * FROM FAMILY;
/*
이름 ROLE 상위이름
*/
SELECT CUR.NAME, CUR.ROLE01, PAR.NAME
FROM FAMILY CUR, FAMILY PAR
WHERE CUR.PARENTNUMID = PAR.NUMID;

