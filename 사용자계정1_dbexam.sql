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



--depart 테이블
create table depart(
    deptnumber number not null, --부서번호(학과번호)
    dname varchar2(25) not null, --부서명(학과명)
    loc varchar2(10) default null  --위치
);
create table depart2(
    deptno number not null, --부서번호(학과번호)
    dname varchar2(25) not null, --부서명(학과명)
    loc varchar2(10) default null  --위치
);
select * from depart;
select * from depart2;
drop table depart purge;


--depart 데이터 입력
insert into depart (deptnumber, dname) values (302, '전기공학과');
INSERT INTO depart VALUES (302, '전기공학과');
INSERT INTO depart VALUES (101, '컴퓨터공학과', '1호관');
INSERT INTO depart VALUES (102, '멀티미디어학과', '2호관');
INSERT INTO depart VALUES (201, '전자공학과', '3호관');
INSERT INTO depart VALUES (202, '기계공학과', '4호관');

insert into depart2 (deptnumber, dname) values (302, '전기공학과');
INSERT INTO depart2 VALUES (302, '전기공학과');
INSERT INTO depart2 VALUES (101, '컴퓨터공학과', '1호관');
INSERT INTO depart2 VALUES (102, '멀티미디어학과', '2호관');
INSERT INTO depart2 VALUES (201, '전자공학과', '3호관');
INSERT INTO depart2 VALUES (202, '기계공학과', '4호관');


--1)inner join 내부조인 : 교집합 해당 데이터를 가져옴
-- 방법1: 오라클 전용구문
select empno,name, emp.deptno, dname from emp,depart where emp.deptno = depart.deptnumber;   
--방법2 : Ansi 표준 => 교집합으로 가져오고 싶은 컬럼명이 다르면 조인 불가능
SELECT empno, name, deptno,dname from emp join depart2 using(deptno);

--2)outer join 외부조인 : 합집합 해당 데이터 가져옴
-- 방법1: 오라클 전용구문
select name, deptno, dname from emp E, dapert D where E.deptno(+)=D.deptnumber;

--2)outer join 외부조인 : 합집합 해당 데이터 가져옴
-- 방법1: 오라클 전용구문
select name, deptno, dname from emp E, dapert D where E.depart=D.deptnumber(+);
--  방법2 : Ansi 표준
SELECT empno, name, deptno,dname from emp right join depart2 using(deptno);
--2)outer join 외부조인(full 조인) :
--  방법2 : Ansi 표준
SELECT * from emp full join depart2 using(deptno);
select * from emp;
select * from depart;

-- 시퀀스 sequence : 자동으로 순자적으로 증가하는 순번을 생성하는 데이터베이스 객체 
create sequence seq_board nocycle nocache;
--nocycle max20억개 nomaxvalue 무한 cycle 안적으면 no cycle
--nocache  
drop sequence empno;
create sequence empno increment by 2 start with 40000;
create sequence empno increment by 100 minvalue 100 maxvalue 500 start with 125 cycle cache 2;
INSERT INTO emp VALUES (empno.nextval, '홍길동', '사원', '031)781-2158', 101);
commit;
select * from emp;
--emp 테이블
create table emp(
    empno number primary key, --직원번호
    name varchar2(20) not null,   --이름
    position varchar2(10) not null,  --직급
    tel VARCHAR(15) not null, --전화번호
    deptno number not null  --학과번호
    --primary key(empno) --not null, unique
);
select * from emp;
drop table emp purge;


--emp 데이터 입력
INSERT INTO emp VALUES (20101, '홍길동', '사원', '031)781-2158', 101);
INSERT INTO emp VALUES (10102, '김철수', '과장', '032)261-8947', 101);
INSERT INTO emp VALUES (10103, '이영희', '대리', '02)824-9637', 102);
INSERT INTO emp VALUES (10104, '고길동', '사원', '02)824-9637', 102);
INSERT INTO emp VALUES (10105, '강호동', '사원', '02)824-9637', 102);
INSERT INTO emp VALUES (10106, '아이유', '사원', '02)881-2158', 105);