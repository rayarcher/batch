@echo off
@echo Disable %USERNAME% and change group to Users
set nodryrun=%1
set mytrue=%2
goto :begin
:dryrun
	echo For work you need run %0 /nodryrun
	pause
    goto :EOF
:nodryrun
	echo Runing key /nodryrun detected
    IF /I [%mytrue%] == [confirm] goto :confirm
    goto :notrue
:notrue
    echo WARNING you need to know exactly what will happen, confirm parameter is required to confirm
    pause
    goto :EOF
:confirm
    echo confirm parameter is detected
    echo on
    rem goto :END
    net accounts /MaxPWAge:unlimited
    echo Add %USERNAME% to group User
    net localgroup  Users %USERNAME% /add
    net localgroup  Пользователи %USERNAME% /add
    echo Delete %USERNAME% from group Administrators
    net localgroup Administrators %USERNAME% /delete
    net localgroup Администраторы %USERNAME% /delete
    net user  %USERNAME% /Expires:Never
    echo Set %USERNAME% to disable and full name "Old User"
    net user %USERNAME%  /ACTIVE:NO /expires:never /FULLNAME:"Old User"
	goto :EOF
:begin
IF [%nodryrun%] == [/nodryrun] goto :nodryrun
goto :dryrun
:END
