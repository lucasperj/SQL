CREATE USER 'lucas'@'localhost' IDENTIFIED BY 'lucas123';
CREATE USER 'larissa'@'%' IDENTIFIED BY 'larissa123';

GRANT ALL ON SoftBlue.* TO 'lucas'@'localhost';
GRANT SELECT ON SoftBlue.* TO 'larissa'@'%';
GRANT INSERT ON SoftBlue.funcionarios TO 'larissa'@'%';
REVOKE INSERT ON SoftBlue.funcionarios FROM 'larissa'@'%';
REVOKE SELECT ON SoftBlue.* FROM 'larissa'@'%';


DROP USER 'lucas'@'localhost';
DROP USER 'larissa'@'%';

SELECT User FROM mysql.user;
SHOW grants FOR 'larissa'@'%';