/*
role이란?
사용자에게 보다 효율적으로 권한을 부여할 수 있도록 여러 개의 권한
을 묶어 놓은 것을 말한다. 사용자를 생성하면 바로 사용할 수 있는
것이 아니라, 각종 권한을 부여해야 하는데 role을 통해서 손 쉽게
다양한 권한을 한번에 부여 할 수 있다..

롤의 종류
1. connect 롤
주로 사용자가 데이터베이스에 접속할 수 있도록 하는 기본적인 
데이터베이스의 권한이라고 할 수 있다.
ex) ALTER SESSION, CREATE CLUSTER, CREATE DATABASE LINK,
CREATE SEQUENCE, CREATE SESSION, CREATE SYNONYM, 
CREATE TABLE, CREATE VIEW
2. resource 롤
사용자가 객체(테이블, 뷰, 인덱 등)를 생성할 수 있도록 권한을 묶는
것을 말한다.
create cluster, create procedure, create equence, 
create table, create trigger
3. dba 롤
사용자가 데이터베이스 객체를 관리하고 사용자들을 작성하고 변경제거
할 수 있는 강력한 권한의 롤을 말한다.

롤의 활용 순서
1. 롤을 생성(데이터베이스 관리자)
	형식) create role 롤의 이름..
	ex) create role roleexp01;
2. 롤에 권한 부여
	형식) grant 권한1, 권한2, 권한3 to 롤의 이름
	ex) grant create session, create table, create view 
	    to  roleexp01;
3. ##사용자에 롤을 부여.
	형식) grant 롤이름  to 사용자
	ex) grant roleexp01 to scott01;
	




 








*/