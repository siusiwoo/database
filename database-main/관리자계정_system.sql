관리자계정.sql

select * from tab;
select * from all_users;
--사용자 계정 만들기(18c)
--1) 사용자 계정 생성하기
create user C##dbexam identified by m1234;
--2) 사용자 계정에 권한 부여하기
grant create session, create table, create sequence, create view to C##dbexam;
--3) 사용자 계정의 테이블 스페이스를 users로 설정하기
alter user C##dbexam default tablespace users;
--4)사용자 계정에 테이블스페이스 쿼터 할당하기
alter user C##dbexam quota unlimited on users;

commit;

--사용자 계정 삭제하기(18c)
--1)계정에 테이블이 없을 경우
drop user C##dbexam;
--2)계정에 테이블이 있을 경우
drop user C##dbexam cascade;