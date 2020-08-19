@echo off

if not defined access (title Pull) else (title Pull_From_Activation)

git status

set /p enter_message="Enter the commit message: "
if not defined enter_message goto NoneMSG
if %enter_message%==^date (goto DateMSG) else goto NewMSG

pause

:DateMSG
	echo Uploaded %date% %time%> Bat/mssg.txt
	set /p message=< Bat/mssg.txt
	goto MAIN_PULL
	
:NewMSG
	echo %enter_message% %date% %time%> Bat/mssg.txt
	set /p message=< Bat/mssg.txt
	goto MAIN_PULL

:NoneMSG
	set /p message=< Bat/mssg.txt
	goto MAIN_PULL

:Colors
	powershell write-host -fore Black -back DarkGreen %1
	exit /b

:MAIN_PULL
	git commit -m "%message%"
	git status
	git pull
	git status
	git restore .
	git status
	echo.
	call :Colors "'  The files have been pulled successfully!  '"
	echo.
	if not defined access (timeout /t 5) else (exit /b)
	exit