/*
제약 조건 추가하기
ALTER TABLE 테이블명
ADD CONSTRAINT 테이블명_컬럼명_제약조건단축 제약조건유형(컬럼명);
EX) 제약조건 NOT NULL(x), UNIQUE(O)
*/
/* 제약조건 추가, 삭제, 수정 연습.
1. address 테이블에  host컬럼에  UNIQUE 제약조건을 추가..
2. 데이턱 딕션어리에서 확인.
3. host컬럼의 제약조건을 삭제..
4. address 테이블에 host컬럼에 NOT NULL 제약조건으로 변경.
5. 데이터 딕션어리에서 확인
*/
-- 1. 추가
ALTER TABLE address
add constraint address_host_uq unique(host);
-- 2. 확인
select * from user_constraints
where table_name='ADDRESS';
-- 3. 삭제..
/*
ALTER TABLE 테이블명
DROP CONSTRAINT 등록된제약조건명
*/
ALTER TABLE address
drop constraint address_host_uq; 
-- address 테이블에서 제약조건 address_host_uq 삭제
-- 4. 수정(modify)
-- 제약의 유형에 따라 add와 modify를 쓰는 경우가 있다..
-- not null의 경우에는 add로 제약조건을 등록할 수 없다.
-- 이 경우에는 modify를 활용하여야 한다.
/* 형식
	 ALTER TABLE 테이블명
	 MODIFY 컬럼명 CONSTRAINT 제약조건명  제약조건유형(EX-NOT NULL)
*/
	ALTER TABLE address
	MODIFY host constraint address_host_nn NOT NULL;
-- 	host라는 컬럼에 제약조건을 address_host_nn을 하고, 이는 not null
--  제약조건으로 변경 처리한다.
	select * from user_constraints
	where table_name='ADDRESS';
/*  확인예제
	1. EMP테이블의 복사 테이블 EMP07을 만들고,
	2. ENAME컬럼에 UNIQUE 제약조건을 설정한 후,
	3. 위 제약조건을 삭제하고,
	4. ENAME컬럼의 제약조건을 NOT NULL로 변경하세요..
*/	
CREATE TABLE emp07
as select * from emp;

alter table EMP07
add constraint emp07_ename_uq unique(ename);
SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME='EMP07';
ALTER TABLE EMP07
DROP CONSTRAINT emp07_ename_uq;



ALTER TABLE EMP07
MODIFY ename CONSTRAINT emp07_ename_nn not null;

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME='EMP07';

/*
제약조건 활성 및 비활성화 처리..
: 제약조건을 임시적으로 비활성화 함으로 데이터를 test하거나,
특정한 기간에 제약조건이 맞지 않는 내용을 입력하는 하게 처리하는
것을 말한다.
형식
alter table 테이블명
enable/disable CONSTRAINT 제약조건명; 

ALTER TABLE EMP07
MODIFY ename CONSTRAINT emp07_ename_nn not null;
*/
ALTER TABLE EMP07
ENABLE CONSTRAINT emp07_ename_nn;





select * from address;


