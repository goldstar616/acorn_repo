/*
계층형 질의
오라클에서 계층형 구조의 테이블을 효과적으로 지원하기 위한
query를 말한다. (self join을 효과적 처리)

계층형 구조 : 상하위 관계에 테이블 구조를 설정한 것을 말한다.
ex)         할아버지(id, parentId, role : 1, 0, '할아버지') 
   아버지(2,1,'아버지')      삼촌(3,1,'삼촌')    
 아들(4,2,'아들')          사촌동생(5,3,'사촌')
손자(6,4,'손자')
계층형 sql 형식
select ....컬럼
from 테이블명
where 조건
start with 조건(비교연산자 ex)컬럼=데이터  : 
                              계층sql의 시작조건 처리-최상위 계층의 조건처리.
                  ex) 가족관계의 최상위 계층은 parentId=0
				    우리가족만 계층 내용을 처리하고자 할 때,
					 parentId=2(아버지 계층이후로 나타남)
connect by [nocycle]  조건 and 조건
    상위관계를 연결시켜주는 조건에 대한 선언. nocycle :반복여부에 대한 처리.
	ex) connect by id = parentId  
	  현재 id값을 확인해서 상위에 있는 id값이 있는지 하위데이터에 확인해서
	  계층구조로 나타나게 하는 것을 말한다. prior:사전 - 상하위 관계에 대한
	                                       처리하게 됨 					 
	ex) emp 테이블을 기준으로 계층구조의 내용 처리하고자 한다.
order siblings by 컬럼 [asc/desc]
 해당 계층구조 컬럼에 대한 같은 레벨의 정렬 순서를 설정한다.
 최근에 등록된 형제를 먼저 list하느냐? 먼저 등록된 형제를 먼저 list하느냐?
 level이 같고, 부모가 같은 데이터들에 대한 list 우선 순위를 결정.  	

## column 옵션  :level -해당 계층의 계층단계을 표시
	ex) 최상위 데이터는 1, 차상위는 2...	
	
*/
select * from emp;
-- mgr(관리자 번호)인데, empno에 매핑되어 있음..
select level, empno, lpad(' ', 4*(level)) || job job, mgr
from emp
start with mgr is null --최상계층의 조건은 mgr이 null일 때
connect by prior empno = mgr; -- 최상컬럼과 하위 컬럼과 연결처리.
 
/*  
계층형으로 mgr이 null일 때 부터 시작하여, 하위계층이 empno로 mgr이 있는지
여부를 확인하여, 해당하는 mgr의 데이터가 empno에 없을 때 까지
일단 하나의 node전체를 리스팅한다.
계층형의로 간격을 처리... lpad('왼쪽에 입력할 문자', 반복할 횟수)
 레벨별로 계층형이 표시될 수 있게끔 처리..
 ' ' :공백을 4칸씩  lpad(' ', 4*(level)) || job
*/
-- ex) 확인예제 family를 계층구조로 출력하세요.
-- 출력형식 :  level  role(계층구조공백처리), 이름

select level, lpad(' ',4*(level-1)) || role01 role, name 
from family
start with parentnumid=0
connect by prior numid=parentnumid
order siblings by numid asc; -- role01==> numid 
select * from family;
insert into family values(5,1,'큰아버지','홍정인');
insert into family values(6,0,'작은할아버지','홍길상');
/*
board 계층형 게시판 테이블 만들어서 list하기..
	고유id(글번호), 타이틀, 내용, 등록일자, 수정일자, 작성자, 조회수
	no,    parentno, title,        content,       credte,uptdte, writer,    readcnt
	number,number, varchar2(50), varchar2(1000), date, date, varchar2(50), number
*/
create table board(
	no number primary key,
	parentno number,
	title varchar2(50),
	content varchar2(1000),
	credte date,
	uptdte date,
	writer varchar2(50)
);
select * from board;
-- 1, 0, '글등록시작','냉무',sysdate,sysdate,'작가01'
insert into board values(1, 0, '글등록시작','냉무',sysdate,sysdate,'작가01');
insert into board values(2, 0, '2번째네요!이런!','냉무',sysdate,sysdate,'작가02');
-- 첫번째 글에 대한 답글로 처리..
insert into board values(3, 1, '1번째를 놓쳤습니다.','냉무',sysdate,sysdate,'홍영심');
insert into board values(4, 3, 'ㅎㅎ 등록이 빨랐네요','냉무',sysdate,sysdate,'작가01');
insert into board values(5, 1, '좋은 글 부탁합니다!','냉무',sysdate,sysdate,'작가03');
-- 글번호, 타이틀, 등록일(YYYY/MM/DD), 등록자
select rownum , no, lpad(' ',4*(level-1)) || title title, 
       to_char(credte,'YYYY/MM/DD') credte, writer
from board
start with parentno=0  -- 최상위 계층 조건 처리
connect by prior no = parentno -- 계층 연결 조건 설정
order siblings by no desc; -- 최근에 등록된 글을 최상위로 처리
select * from board;
insert into board values(7, 1, '첫번째가 좋죠~~',
		'냉무',sysdate,sysdate,'하이맨');
select rownum, a.*
from emp a
order by empno desc;		
-- rownum : 데이터 list에서 고유로 numbering이 붙는 키워드..
	   









