CREATE USER 'director'@'%'
	IDENTIFIED BY 'abc123';
    
GRANT ALL PRIVILEGES 
	ON *.*
    TO 'director'@'%'
    WITH GRANT OPTION;
    
CREATE USER 'ceo'@'localhost'
	IDENTIFIED BY 'abc123';

GRANT SELECT 
	ON *.*
    TO 'ceo'@'localhost';

CREATE USER 'staff'@'localhost'
	IDENTIFIED BY 'abc123';
    
	GRANT ALL PRIVILEGES
		ON market_db.buy
        TO 'staff'@'localhost';
        
GRANT SELECT , INSERT
	ON market_db.member
    TO 'staff'@'localhost';
    
SHOW GRANTS FOR 'ceo'@'localhost';

ALTER USER 'ceo'@'localhost'
	IDENTIFIED BY '123abc';
    
RENAME USER 'ceo'@'localhost'
	TO 'master'@'localhost';
    
DROP USER 'master'@'localhost';

REVOKE SELECT, insert 
	ON market_db.member
	FROM 'staff'@'localhost';
    
SHOW GRANTS FOR 'staff'@'localhost';

    