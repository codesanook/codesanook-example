--- https://www.sqlshack.com/understanding-sql-server-backup-types/

-- https://blog.sqlauthority.com/2018/03/07/sql-server-tail-log-backups/
-- Should I use semicolon https://stackoverflow.com/a/710697/1872200

-------------------- Truncate Users table, make a clean state ------------------
TRUNCATE TABLE Users
GO

-------------------- Insert data and create full backup ------------------
INSERT INTO Users 
(Email, FirstName, LastName, DateOfBirth)
VALUES
('jose@realman.com', 'Jose', 'Realman', '2020-01-20')
GO

-- Using WITH FORMAT to overwrite any existing backups and create a new media set.
-- Backtup to default database location /var/opt/mssql/backup/Codesanook.bak

BACKUP DATABASE Codesanook
TO DISK = 'CodesanookFullBackup.bak'   
WITH FORMAT 
GO  

-------------------- Insert data and create log backup 1 ------------------
INSERT INTO Users 
(Email, FirstName, LastName, DateOfBirth)
VALUES
('phoung@realman.com', 'Phuong', 'Realman', '2020-01-20')
GO

-- Backtup to default log location /var/opt/mssql/log/Codesanook_log.ldf

BACKUP LOG Codesanook 
TO DISK = 'CodesanookLogBackup1.trn'
WITH FORMAT 
GO

-------------------- Insert data and create differential backup base on the full backup ------------------
INSERT INTO Users 
(Email, FirstName, LastName, DateOfBirth)
VALUES
('you@realman.com', 'You', 'Realman', '2020-01-20')
GO

BACKUP DATABASE Codesanook  
TO DISK = 'CodesanookDifferentialBackup.bak'
WITH DIFFERENTIAL, FORMAT 
GO

-------------------- Insert data and create log backup 2 ------------------
INSERT INTO Users 
(Email, FirstName, LastName, DateOfBirth)
VALUES
('pong@realman.com', 'Pong', 'Realman', '2020-01-20')
GO

BACKUP LOG Codesanook 
TO DISK = 'CodesanookLogBackup2.trn'
WITH FORMAT 
GO

-------------------- Select all users ------------------
SELECT * FROM Users
GO

