-- 주석

create table dbtest(
    name varchar2(20),
    age number(3),
    height number(5,2),
    logtime date
);
-- 테이블 확인
select * FROM tab;
-- 테이블 구조 확인
desc dbtest;
-- 1) 휴지통 이동
DROP TABLE dbtest;
-- 2) 복원
flashback TABLE dbtest to BEFORE DROP;
-- 3) 휴지통 비우기
PURGE RECYCLEBIN;
-- 4) 휴지통으로 이동하지 않고 영구적으로 삭제
DROP TABLE dbtest PURGE;

-- 데이터 추가(레코드)
INSERT INTO dbtest(name,height,age,logtime) values ('김길동','170.525',20,sysdate);
INSERT INTO dbtest Values ('김길동','170.525',20,sysdate);
INSERT INTO dbtest Values ('김길동',20,'170.525',sysdate);
INSERT INTO dbtest Values ('홍길동',25,'178.525',sysdate);
INSERT INTO dbtest Values ('honggil',25,'178.525',sysdate);
INSERT INTO dbtest Values ('Honggil',25,'178.525',sysdate);
INSERT INTO dbtest (name,age) Values ('홍당무',45);
INSERT INTO dbtest (name,age)Values ('김홍석',45);
INSERT INTO dbtest (name,age)Values ('홍게',30);
INSERT INTO dbtest (name,height) Values ('홍당무',185);
-- 데이터 확인
select * from dbtest;
select name,age,logtime from dbtest;
-- 데이터 있는 컬럼의 갯수 확인
select count(age) from dbtest;
--null을 포함한 데이터 있는 컬럼의 갯술 확인
select count(*) from dbtest;
-- 검색 결과를정렬
select * from dbtest order by name asc; -- default가 오름차순
select * from dbtest order by name desc; -- default가 내림차순
select * from dbtest order by name,height ; -- 두번째 기준 추가
select * from dbtest order by age desc,height asc; -- 첫번쨰 기준은 내림차순, 두번째 기준은 오름차순
-- 조건 검색
select * from dbtest where name ='홍당무';
select * from dbtest where name ='honggil';
select * from dbtest where name like '홍%'; -- 홍으로 시작하면
select * from dbtest where name like '%홍%'; -- 홍이 들어가면
select * from dbtest where name like '홍__'; -- 글자수 지정하려면_를 이용
-- 2가지 기준을 모두 만족
select * from dbtest where name like '홍%' and age<=30;
-- 1가지 기준을 만족해도 가져옴
select * from dbtest where name like '홍%' or age<=30;
-- 나이가 null인 데이터
select * from dbtest where age is null;
-- 나이가 null이아닌 데이터
select * from dbtest where age is not null;
COMMIT;
--마지막 커밋 전 으로 회귀
rollback;
select * from dbtest;
-- 중복을 제외하고 출력
select DISTINCT name from dbtest;
-- 별칭 (alias) 활용
select name as "이름" from dbtest;

-- SelfEx null이 하나라도 포함된 데이터 모두 표시
select * from dbtest where age is null or height is null or name is null or logtime is null;
-- SelfEx null이 하나라도 포함안된 데이터 모두 표시
select * from dbtest where age is not null and height is not null and name is not null and logtime is not null;