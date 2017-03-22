/*
숙제
연봉 단위별로 인원수를 체크하세요
범위		사원수(최고치,최저치,평균치)
1000미만	@@
~2000미만	@@@
~3000미만	@@
~4000미만	
~5000미만	
~6000미만	
*/
SELECT TRUNC(SAL/1000), COUNT(SAL), MAX(SAL), MIN(SAL), AVG(SAL) 
FROM EMP 
GROUP BY TRUNC(SAL/1000);

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