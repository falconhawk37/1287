@echo off

git status
set access=DoNotClose

:Push_Or_Pull
	goto EnterCMD

:EnterCMD
	set /p enter_command="Push or Pull? (push/pull): "
	if /i %enter_command%==^Push (goto Push) else (if /i %enter_command%==^pull (goto Pull) else (goto Push_Or_Pull))

:Push
	call Bat\Push_For_TR.bat
	goto MAIN_ACT

:Pull
	call Bat\Pull_For_TR.bat
	goto MAIN_ACT

:MAIN_ACT
	title Activation...
	cd ..
	start "Activation" sublime_text
 	cd Test_Repository/
 	title Activated
 	browser-sync start --server --direction --files "**/*"