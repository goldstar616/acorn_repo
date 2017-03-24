/*
오라클에서 계층형 구조의 테이블을 효과적으로 지원하기 위한
query를 말한다. (self join을 효과적 처리)

계층형 구조 : 상하위 관계에 테이블 구조를 설정한 것을 말한다
ex) 할아버지(id, parentId, role : 1, 0, '할아버지')
	아버지(2, 1, '아버지')
	삼촌(3, 1, '삼촌')
	아들(4, 2, '아들')
	사촌동생(5, 3, '사촌')
	손자(6, 4, '손자')
계층형 sql 형식
select ....컬럼
from 테이블명
where 조건
start with 조건(비교연산자 ex)컬럼=데이터 : 계층형 sql의 시작조건 처리-최상위 계층의 조건처리
							ex)가족관계의 최상위 계층은 parentId=0
							우리가족만 계층 내용을 처리하고자 할 때, 
							parentId=2(아버지 계층이후로 나타남)
connect by [nocycle] 조건 and 조건
	상위관계를 연결시켜주는 조건에 대한 선언. nocycle:
*/
-- mgr(관리자 번호)인데, empno에 매핑되어 있음.
select level, empno, (lpad(' ', 4*(level)) || job) job, mgr
from emp
start with mgr is null -- 최상위 계층의 조건은 MGR이 NULL일 때
connect by prior empno = mgr; -- 최상위 컬럼과 하위 컬럼 연결처리 
/*
계층형으로 mgr이 null일때 부터 시작하여, 하위계층이 emp로 mgr이 있는지
여부를 확인하여 해당하는 mgr의 데이터가 empno에 없을 때 까지

계층형으로 간격을 처리 lpad('왼쪽에 입력할 문자', 반복할 갯수)
레벨별로 계층형이 표시될 수 있게끔 처리
'	' : 공백을 4칸씩 lpad('	', 4*(level))
*/

-- ex) 확인예제 family를 계층구조로 출력하세요
-- 출력형식 : level role(계층구조공백처리), 이름
select level, (lpad(' ', 4*(level-1)) || role01) role, name
from family
start with parentnumid = 0 
connect by prior numid = parentnumid
order by level; 
-- level은 1부터 시작, 공백이 항상 있기 때문에 -1

/*
order sibilings by 컬럼[asc/desc]
해당 계층구조 컬럼에 대한 같은 레벨의 정렬 순서를 설정한다
최근에 등록된 형제를 먼저 list하느냐? 먼저 등록된 형제를 먼저 list하느냐?
*/
insert into family values(5,1,'큰아버지','홍정인');
insert into family values(6,0,'작은할아버지','홍길상');

select level, (lpad(' ', 4*(level-1)) || role01) role, name
from family
start with parentnumid = 0 
connect by prior numid = parentnumid
order siblings by NUMID DESC;

/*
board 계층형 게시판 테이블 만들어서 list하기
	고유id(글번호), 		타이틀, 		내용, 			등록일자, 		수정일자, 		작성자, 		조회수
	no,		parentno,		title,			content,		CREATEDATE,		UPDATEDATE,		writer,			readcnt
	number,	number,			varchar2(50),	varchar2(1000),	date,			date,			varchar2(50),	number
*/
CREATE TABLE BOARD
(
	NO			NUMBER PRIMARY KEY,
	PARENTNO	NUMBER,
	TITLE		VARCHAR2(50),
	CONTENT		VARCHAR2(1000),
	CREATEDATE	DATE,
	UPDATEDATE	DATE,
	WRITER		VARCHAR2(50),
	READCNT		NUMBER
);

SELECT * FROM BOARD;
-- 1, 0, '글등록시작', '냉무', SYSDATE, SYSDATE, '작가01'
INSERT INTO BOARD VALUES(1, 0, '글등록시작', '냉무', sysdate, sysdate, '작가01', 0);
INSERT INTO BOARD VALUES(2, 0, '2번째네요!이런!', '냉무', sysdate, sysdate, '작가02', 0);
-- 첫번째 글에 대한 답글로 처리
INSERT INTO BOARD VALUES(3, 1, '1번째를 놓쳤습니다.', '냉무', sysdate, sysdate, '홍영삼', 0);
INSERT INTO BOARD VALUES(4, 3, 'ㅎㅎ 등록이 빨랐네요', '냉무', sysdate, sysdate, '작가03', 0);
INSERT INTO BOARD VALUES(5, 1, '좋은글 부탁합니다!', '냉무', sysdate, sysdate, '작가03', 0);
-- 글번호, 타이틀, 등록일, 등록자
SELECT NO, LPAD(' ', 4*(LEVEL-1)) || TITLE,
		TO_CHAR(CREATEDATE, 'YYYY/MM/DD') CREATEDATE, WRITER
FROM BOARD
START WITH PARENTNO=0
CONNECT BY PRIOR NO=PARENTNO
ORDER SIBLINGS BY NO DESC; 

INSERT INTO BOARD VALUES(6, 2, '^^ 좋은 게시판되길~~', '냉무', sysdate, sysdate, '희망맨', 0);
INSERT INTO BOARD VALUES(7, 1, '첫번째가 좋죠~~', '냉무', sysdate, sysdate, '하이맨', 0);

SELECT ROWNUM, NO, LPAD(' ', 4*(LEVEL-1)) || TITLE,
		TO_CHAR(CREATEDATE, 'YYYY/MM/DD') CREATEDATE, WRITER
FROM BOARD
START WITH PARENTNO=0
CONNECT BY PRIOR NO=PARENTNO
ORDER SIBLINGS BY NO DESC; 

SELECT ROWNUM, A.*
FROM EMP A
ORDER BY EMPNO DESC;
-- ROWNUM : 데이터 LIST에서 고유로 NUMBERING이 붙는 키워드

