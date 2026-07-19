@echo off

set CONTAINER_NAME=student_db
set DB_NAME=student_management
set DB_USER=root
set DB_PASSWORD=YOUR_PASSWORD_HERE

:: example password: Sudo#12haha!
set SQL_QUERY=INSERT INTO users (fullname, email, password, role, is_active, is_verified) VALUES (
	'Admin',
	'admin@gmail.com', 
	'$2b$10$Ag.xFyHM5dFAtWc71yg9I.ZPPmS4xHPtq3gho.i1QXDqOmLthnai2', 
	 0,
	 1,
	 1
);

:: execute sql query in docker
docker exec -i %CONTAINER_NAME% mysql -u%DB_USER% -p%DB_PASSWORD% %DB_NAME% -e "%SQL_QUERY%"

echo.
echo Operation finished.
pause
