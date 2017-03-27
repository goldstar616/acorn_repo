/*
## 사용자 계정으로 접속 방법..
command 창에서 접속하는 방법..
sqlplus system/1111  또는 sqlplus scott/tiger
sqlplus 내부에서 
sql>conn 계정명/비밀번호

## 여러가지 client 툴을 이용해서 접근 주요 핵심 정보..

IP/port번호/ sid/ 계정/비밀번호

*/
/*
## 사용자 생성하기..(system계정의 worksheet에서 처리)
create user 사용자명
identified by 패스워드;
ex) scott01이란 계정에 비밀번호가 tiger로 설정하여
	생성 하겠습니다.
*/
create user c##scott01 identified by tiger;
/*
권한 부여
1. session : 접속 관련된 권한 부여..
형식
grant 권한종류
to 사용자계정
 계정이 생성된 것으로 해당 계정을 접속해서 사용할 수 있는
 것이 아니라, 접속 권한을 설정해야지 접속이 된다..
 ex) scott01 계정에 접속권한를 설정해 준 뒤에 접속을 해보자.
 system 관리자 계정으로 접속한 뒤..
 grant create session
 to scott01;   -- 접속할 session권한을 scott01에게 준다.

*/
grant create session
to c##scott01;
/*
테이블 스페이스
데이터베이스 생성시, 각종 오브젝트(테이블, 인덱스, 뷰등)가
실제 데이터 파일에 저장되는 물리적 공간이고, 
사용자와 매핑해서 테이블 스페이스 즉 물리적 공간 파일을 매핑할 
수 있다..
1. 생성 형식..
	## create tablespace 테이블스페이스명
		datafile '물리적파일이 있는 위치' size 크기설정(ex 10M
		default storage( -- 물리적 크기에 설정 초기 및 
									block단위 별 증가 크기.
		   initial 크기   : 초기의 크기설정.
		   next  크기 : 증가의 크기설정
		   maxextends : 최대 증가의 크기 : 생성할 extends의 최대 값..
		   pctincrease : extents의 증가율, defult값은 50..
		)
	ex) 테이블 스페이스 이름 ts01로 하고..
		C:\a01_prog\database\ 폴드 생성.
		파일명 : DF001.DBF01
		크기는 50M
		initial : 1024k
		next : 512k
		최대 증가 크기 maxextents : 128
		pctincrease  :0 
*/
create tablespace ts01
		datafile 'C:\a01_prog\database\DF001.DBF01' size 50M
		default storage(
			initial 1024k
			next 512k
			maxextents 128
			pctincrease 0
		);
/*
특정한 테이블 생성시, 지정된 테이블스페이스와 매핑..
create table 테이블이름(

) tablespace 지정된테이블스페이스명;

default 테이블 스페이스 지정..
alter database default tablespace 지정한테이블스페이스명;

*/		







