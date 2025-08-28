-- 1. ALTER 기능을 이용하여 CHECK 제약 조건(입력되는 데이터를 점검하는 기능) 추가
 -- 키 : 150<=height<=190
 -- 주소 : '경기', '서울', '경남', '경북', '전남'
 -- INSERT	INTO usertbl VALUES('SJH','수정고',1987,'경기','011','1111111',140,'2008-8-8') 
 -- INSERT	INTO usertbl VALUES('ITS','정보고',1979,'제주','011','2222222',173,'2012-4-4')
USE sqldb;
ALTER TABLE usertbl
	ADD CONSTRAINT ch1 CHECK(height BETWEEN 150 AND 190);
    
ALTER TABLE usertbl
	ADD CONSTRAINT ch2 
		CHECK(addr IN('경기','서울','경남','경북','전남');
        
INSERT INTO usertbl VALUES('SJH', '수정고', 1987, '경기', '011', '1111111', 140, '2008-8-8');
INSERT INTO usertbl VALUES('ITS', '정보고', 1979, '제주', '011', '2222222', 173, '2012-4-4');
-- 2. ALTER문을 이용하여 회원 가입일을 입력하지 않고 
 -- default라고 적으면 자동으로 2023-09-21이 입력되도록 추가
 -- INSERT INTO usertbl	VALUES('oop','바비킴',1973,'서울','010','0000000',176,	DEFAULT)
 -- SELECT * FROM usertbl;
ALTER TABLE usertbl 
	ALTER COLUMN mDATE SET DEFAULT '2023-09-21';
    INSERT INTO usertbl	VALUES('oop','바비킴',1973,'서울','010','0000000',176,	DEFAULT);
    SELECT * FROM usertbl;
    
-- 3. ALTER로 회원테이블(usertbl)에 email 주소 열 추가
 -- SELECT * FROM usertbl ;
ALTER TABLE usertbl
	ADD COLUMN email VARCHAR(100);
-- 4. ALTER로 mobile1 열을 삭제
 -- SELECT * FROM usertbl ;
ALTER TABLE usertbl
	DROP COLUMN mobile1;
-- 5. 가상 테이블 이름 : v_userbuytbl 열 : userID, name, addr, prodName, amount
-- SELECT * FROM v_userbuytbl ;
	CREATE VIEW v_userbuytbl AS 
    SELECT U.userID, name, addr, prodName, amount
		FROM usertbl U JOIN buytbl B ON U.userID=B.userID;
	
	SELECT * FROM v_userbuytbl ;

-- 6. 회원 테이블(usertbl)에서 mDate로 인덱스 생성하기
SELECT * FROM usertbl WHERE mDATE>'2014-01-01';
CREATE INDEX idx_mdate ON usertbl(mDATE);

-- 7. 사용자 계정(team) 비번 1234로 생성 후 v_userbuytbl 가상테이블에 대한 SELECT 권한만 부여
CREATE USER 'team'@'%'IDENTIFIED BY '1234';
GRANT SELECT
	ON sqldb.v_userbuytbl
    TO 'team'@'%';
    
-- 8. 사용자 계정 agent, 호스트 localhost, 비번 ~123#으로 생성 후 
 -- sqldb의 모든 테이블에 대해 SELECT, INSERT 권한 부여
CREATE USER  'agent'@'localhost'  IDENTIFIED BY '~123#';
GRANT SELECT,INSERT on sqldb.*  to  'agent'@'localhost';

-- 9. 사용자 agent에게 INSERT 권한 철회 
REVOKE insert ON  sqldb.* from 'agent'@'localhost';
-- 10. 사용자 agent 비번을 abc123으로 변경 

ALTER USER 'agent'@'localhost' IDENTIFIED by 'abc123';
-- 11. 사용자 agent 권한 확인
show GRANTS FOR 'agent'@'localhost';
-- 12. 사용자 agent 계정 잠금
ALTER USER 'agent'@'localhost' ACCOUNT LOCK;
ALTER USER 'agent'@'localhost' ACCOUNT UNLOCK;