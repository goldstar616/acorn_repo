/*
데이터 사전(데이터 dictionary)
관리자에서 데이터베이스와 관련된 정보를 제공하는 것을 말한다.

DBA_XXX : 관리자만 접근 가능한 객체(테이블 등)의 정보 조회.
ALL_XXX : 자신 계정 소유 또는 권한을 부여 받은 객체(테이블)의 정보조회
USER_XXX : 자신의 계정이 소유한 객체 등에 관련 정보 조회.
*/
SELECT * FROM USER_TABLES
WHERE TABLE_NAME LIKE '%EMP__'; -- 사용자 테이블 관련 정보..
/*
제약조건 확인하기..
USER_CONSTRAINTS에서 각 테이블의 무결성 제약조건에 관련된 내용을 데이터
딕셔너리를 통해서 확인할 수 있다.
*/
SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME LIKE '%EMP__';
/*
## CONSTRAINT_TYPE
P : PRIMARY KEY
R : FOREIGN KEY
U : UNIQUE
C : CHECK, NOT NULL

** 데이터 사전을 통해서 생성된 테이블의 목록, 테이블의 구조, 
제약조건을 확인할 수 있다..
*/
SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME LIKE '%DEPT%';