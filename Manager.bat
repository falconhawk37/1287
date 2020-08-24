@echo oFF
title Command Manager falconhawk37

goto WITH_AUTHORIZATION

:AUTHORIZATION_ERROR
	pause >nul
	cls

:WITH_AUTHORIZATION
	echo.

call :User_Check
echo.

call :Colors "Cyan" "black" "'						Welcome to Command Manager!						'"
echo.

:: Список доступных команд
echo ^<Command list^>: act ^| push ^| pull ^| sync ^| restore ^| reload ^| exit

:Loop
	goto Manage_Menu

:Manage_Menu
	echo.

::	Обнуление переменных
	set cmd=
	set agree=
	set access=

	set /p cmd=^<Enter command^>: 

	if not defined cmd goto Manage_Menu
	if /i %cmd%==act (start Bat\Activation_For_TR.bat & goto Manage_Menu)
	if /i %cmd%==push (start Bat\Push_For_TR.bat & goto Manage_Menu)
	if /i %cmd%==pull (start Bat\Pull_For_TR.bat & goto Manage_Menu)
	if /i %cmd%==sync (set access=sync & echo %access% > access.txt & start Bat\Activation_For_TR.bat & goto Manage_Menu)
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
	chcp 65001 >nul
	cmdkey /list:git:https://github.com > %USERPROFILE%\User_toggler.txt
	chcp 866 >nul
	findstr "User" %USERPROFILE%\User_toggler.txt > temp.txt
	set /p UserCheck=<temp.txt
	del temp.txt & del %USERPROFILE%\User_toggler.txt
	set UserCheck=%UserCheck:~10%

	if %UserCheck%==falconhawk37 exit/b

	:: Проверка на существование файла Users_data.txt
	if not exist %USERPROFILE%\Users_data.txt (call :Colors "Black" "DarkRed" "'      The file '%USERPROFILE%\Users_data.txt' is not exist! Create it and try again!      '" & echo. & call :Colors "darkyellow" "black" "'      Press any key to try again...      '" & goto AUTHORIZATION_ERROR)

	findstr "Ed" %USERPROFILE%\Users_data.txt > temp.txt
	set /p Er_pass=< temp.txt
	del temp.txt
	set Er_pass=%Ed_pass:~14%

	if %UserCheck% neq falconhawk37 (cmdkey /delete:git:https://github.com >nul & cmdkey /generic:git:https://github.com /user:falconhawk37 /pass:%Er_pass% >nul)

	call :Colors "Green" "black" "'///***   The user have been changed successfully!   ***///'"
	exit/b
