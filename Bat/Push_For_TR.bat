@echo off

if not defined access (title Push) else (title Push_From_Activation)

git status

set /p enter_message="Enter the commit message: "
if not defined enter_message goto NoneMSG
if %enter_message%==^date (goto DateMSG) else goto NewMSG

pause

:DateMSG
	echo Uploaded %date% %time%> Bat/mssg.txt
	set /p message=< Bat/mssg.txt
	goto MAIN_PUSH
	
:NewMSG
	echo %enter_message% %date% %time%> Bat/mssg.txt
	set /p message=< Bat/mssg.txt
	goto MAIN_PUSH

:NoneMSG
	set /p message=< Bat/mssg.txt
	goto MAIN_PUSH

:Colors
	powershell write-host -fore Black -back DarkGreen %1
	exit /b

:MAIN_PUSH
	git add .
	git commit -m "%message%"
	echo.
 	git status
 	echo.
	git push
	echo.
	call :Colors "'  The files have been pushed successfully!  '"
	echo.
	if not defined access (timeout /t 5) else (exit /b)
	exit