-- 모든 호스트에서 접속 가능한 reporter 계정에게
-- market_db 전체 SELECT만 허용
-- 1 계정 생성

USE market_db;
CREATE USER 'reporter'@'%'IDENTIFIED BY'abc123';

-- 2 권한 부여
GRANT SELECT ON market_db.* TO 'reporter'@'%';

-- 3 권힌 확인
SHOW GRANTS FOR 'reporter'@'%';

-- 4 권한 검증


-- inv_bot 계정을 192.168.0.% 대역에서만 접속 가능하게 만들고,
-- market_db.buy에 Insert , UPDATE만 허용
CREATE USER 'inv_bot'@'192.168.0.%' IDENTIFIED BY 'abc123';
GRANT INSERT,UPDATE
 ON market_db.buy 
 TO 'inv_bot'@'192.168.0.%';

-- 역할 ro_market을 만들고 market_db.* SELECT 권한을 부여
CREATE ROLE ro_market;
GRANT SELECT ON market_db.* to ro_market;
-- 사용자 auditor(localhost)에 역할 부여 및 기본 역할로 설정
CREATE USER 'auditor'@'localhost' IDENTIFIED BY 'and'
DEFAULT ROLE ro_market;
 SET DEFAULT ROLE ro_market TO 'auditor'@'localhost';


-- 기본 역할 설정 
SET DEFAULT ROLE 역할이름 TO 계정;
-- 역할 writer_buy에 market_db.buy INSERT, UPDATE 권한을 부여
-- 사용자 writer1(10.0.%)과 writer2(localhost)에 적용
CREATE ROLE writer_buy;
GRANT INSERT,UPDATE ON market_db.buy
to writer_buy;

CREATE USER 'writer1'@'10.0.%' IDENTIFIED BY'abc123';
CREATE USER 'writer2'@'localhost' IDENTIFIED BY'abc123';

GRANT writer_buy TO 'writer1'@'10.0.%','writer2'@'localhost';

SELECT CURRENT_USER();

--  계정 잠그기
ALTER USER 'reporter'@'%' ACCOUNT LOCK;

-- 계정 해제
ALTER USER 'reporter'@'%' ACCOUNT UNLOCK;
-- 현재 세션의 실제 매칭 계정 확인, 특정 사용자의 권한 목록 확인
SELECT CURRENT_USER();
SHOW GRANTS FOR 'root'@'localhost';

-- writer_buy 역할에서 UPDATE 권한만 회수
REVOKE UPDATE ON market_db.buy FROM 'writer_buy';

-- 사용자 단위로 특정 권한만 회수
-- inv_bot 에게서 market_db.buy의 UPDATE만 회수(INSERT는 유지)
REVOKE UPDATE ON market_db.buy FROM 'inv_bot'@'192.168.0.%';

-- 역할 자체 회수 & 기본 역할 해제alter
-- writer1 사용자에서 writer_buy 역할을 뺴고, 기본 역할도 해제 
REVOKE writer_buy FROM 'writer1'@'10.0.%';
SET DEFAULT ROLE NONE TO 'writer1'@'10.0.%';