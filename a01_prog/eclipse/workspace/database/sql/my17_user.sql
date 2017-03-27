/*
## 사용자 계정으로 접속 방법
sqlplus 계정/비번
show user - 로그인한 계정 확인
conn 계정/비번 - 계정 변경

## 여러가지 client 툴을 이용해서 접근 주요 핵심 정보
IP/PORT/SID/계정/비번
*/

/*
사용자 생성
CREATE USER 사용자명
IDENTIFIED BY 패스워드;
*/
CREATE USER scott01
IDENTIFIED BY tiger;

/*
권한 부여
1. session 접속권한
grant 권한종류
to 사용자 계정
*/
GRANT CREATE SESSION 
TO SCOTT01;

/*
테이블 스페이스  ------- 개념만 알면 됨(NCS용 훑고 넘어가기인듯) -------
데이터베이스 생성시, 각종 오브젝트(테이블, 인덱스, 뷰 등)가
실제 데이터 파일에 저장되는 물리적 공간
사용자 - 테이블 스페이스 매핑할 수 있음
1. 생성 형식
	CREATE TABLESPACE 테이블스페이스명
	DATAFILE '물리적 파일 위치' SIZE 크기 - EX)10M
	DEFAULT STORAGE - 초기 크기 설정 및 BLOCK단위 증가 크기 
	(
		INITIAL 크기 - 초기 크기
		NEXT 크기 - 증가 크기
		MAXEXTENDS - 최대 증가 크기
		PCTINCREASE - EXTENTS 증가율, DEFAULT값 50
	)
*/
CREATE TABLESPACE TS01
		DATAFILE 'C:\a01_prog\database\DF001.DBF01' SIZE 50M
		DEFAULT STORAGE
		(
			INITIAL 1024K
			NEXT 512K
			MAXEXTENTS 128
			PCTINCREASE 0
		);

/*
테이블 - 테이블스페이스 매칭
CREATE TABLE 테이블명
(
	...
) TABLESPACE 지정된테이블스페이스명;

DEFALUT 테이블스페이스 지정
ALTER DATABASE DEFAULT TABLESPACE 지정한테이블스페이스명;
*/
-- 지정된 테이블스페이스 확인
SELECT * FROM USER_TABLES
WHERE TABLE_NAME LIKE '%EMP%';

CREATE TABLE TSEXP
(
	NO NUMBER PRIMARY KEY
) TABLESPACE TSO1;
SELECT * FROM USER_TABLES
WHERE TABLE_NAME LIKE '%TSEXP%';