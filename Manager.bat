@echo off
title Command Manager falconhawk37

echo.
call :User_Check
echo.

call :Colors "Cyan" "black" "'						Welcome to Command Manager!						'"
echo.

echo ^<Command list^>: act ^| push ^| pull ^| restore ^| reload ^| exit

:Loop
	goto Manage_Menu

:Manage_Menu
	echo.
	set cmd=
	set agree=
	set /p cmd=^<Enter command^>: 
	if not defined cmd goto Manage_Menu
	if /i %cmd%==act (start Bat\Activation_For_TR.bat & goto Manage_Menu)
	if /i %cmd%==push (start Bat\Push_For_TR.bat & goto Manage_Menu)
	if /i %cmd%==pull (start Bat\Pull_For_TR.bat & goto Manage_Menu)
	if /i %cmd%==restore (goto Restore)
	if /i %cmd%==exit (exit)
	if /i %cmd%==reload (start Manager.bat & exit)
	call :Colors "darkred" "black" "'///***   %cmd% is undefined command!   ***///'"
	goto Manage_Menu

:Colors
	powershell write-host -fore %1 -back %2 %3
	exit /b

:Agreement
	set agreement="'   You trying to %reply%   '"
	echo.
	call :Colors "black" "darkyellow" %agreement%
	set /p agree=^<Yes or Not (Y/N)^>
	echo.
	if not defined agree (call :Colors "darkred" "black" "'///***   The command is undefined!   ***///'" & goto Manage_Menu)
	if /i %agree%==N (goto Manage_Menu)
	if /i %agree%==Y (exit /b)
	echo.
	goto Manage_Menu

:Restore
	set reply=%cmd%. All of the changes you made will be deleted.
	call :Agreement
	start Bat\Restore_For_TR.bat
	goto Manage_Menu

:User_Check
	chcp 65001
	cmdkey /list:git:https://github.com > C:\Users\User\User_toggler.txt
	chcp 866
	findstr "User" C:\Users\User\User_toggler.txt > temp.txt
	set /p UserCheck=<temp.txt
	del temp.txt & del C:\Users\User\User_toggler.txt
	set UserCheck=%UserCheck:~10%

	if %UserCheck%==falconhawk37 exit/b

	findstr "Er" C:\Users\User\Users_data.txt > temp.txt
	set /p Er_pass=< temp.txt
	del temp.txt
	set Er_pass=%Er_pass:~14%

	if %UserCheck% neq falconhawk37 (cmdkey /delete:git:https://github.com >nul & cmdkey /generic:git:https://github.com /user:falconhawk37 /pass:%Er_pass% >nul)

	call :Colors "Green" "black" "'///***   The user have been changed successfully!   ***///'"
	exit/b
