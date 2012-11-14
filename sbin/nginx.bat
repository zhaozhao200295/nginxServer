@echo off

title Nginx Server
color A

if "%1" neq "inline" (
    setlocal
)
if "%1" equ "inline" (
    if "%2" equ "stop" goto CLEAR_TOKENS
)

if "%DIT_HOME%" equ "" (
    call "server.bat" inline %~n0
)

if "%1" neq "inline" (
    set WEB_ROOT=%ROOT_PATH%\www
    set WEB_ROOT=%WEB_ROOT:\=\\%
)

rem ===================================替换配置文件=============================
SET NGINX_SERVER=start

if not exist "%SERVER_CONF%\nginx.conf" goto no_conf

if exist "%SERVER_CONF%\nginx1.conf" (
   del /f /q "%SERVER_CONF%\nginx1.conf"
)
copy "%SERVER_CONF%\nginx.conf" "%SERVER_CONF%\nginx1.conf"

sfk156 replace "%SERVER_CONF%\nginx1.conf" /#WEB_ROOT#/%WEB_ROOT%/ -yes
sfk156 replace "%SERVER_CONF%\nginx1.conf" /#CLOUD_ROOT#/%CLOUD_ROOT%/ -yes
sfk156 replace "%SERVER_CONF%\nginx1.conf" /#PMA_ROOT#/%PMA_ROOT%/ -yes
sfk156 replace "%SERVER_CONF%\nginx1.conf" /#WEB_LOGS#/%SERVER_LOGS%/ -yes
sfk156 replace "%SERVER_CONF%\nginx1.conf" /#WEB_PORT#/%WEB_PORT%/ -yes
sfk156 replace "%SERVER_CONF%\nginx1.conf" /#CLOUD_PORT#/%CLOUD_PORT%/ -yes
sfk156 replace "%SERVER_CONF%\nginx1.conf" /#PMA_PORT#/%PMA_PORT%/ -yes
sfk156 replace "%SERVER_CONF%\nginx1.conf" /#PHP52_PORT#/%PHP52_PORT%/ -yes
sfk156 replace "%SERVER_CONF%\nginx1.conf" /#PHP53_PORT#/%PHP53_PORT%/ -yes

rem =======================启动服务 开始==========================
if exist %SERVER_CONF%\nginx.all.pid (
    del /f /q "%SERVER_CONF%\*.pid"
)
rem 记录启动前当前应用的进程号列表
call getpid.bat nginx.exe "%SERVER_CONF%\nginx1.pid"

cd /d %SERVER_CONF%
rem 以后台方式启动 nginx
RunHiddenConsole "%SERVER_NGINX%\nginx.exe" -c "%SERVER_CONF%\nginx1.conf"

rem 记录启动后当前应用的进程号列表
call getpid.bat nginx.exe "%SERVER_CONF%\nginx2.pid"

rem 记录将当前启动应用的进程号
logdelta "%SERVER_CONF%\nginx1.pid" "%SERVER_CONF%\nginx2.pid" >> "%SERVER_CONF%\nginx.all.pid"

if "%1" equ "inline" goto nginx_inline
goto PRINT_MESSAGE
rem =======================启动服务 结束==========================


rem ================================ 交互操作（开始） =============================
:OPEN_BROWSER
echo 正在打开页面，请稍后。
explorer http://localhost:%WEB_PORT%
goto PRINT_MESSAGE

:PRINT_MESSAGE
cls

tasklist /FI "IMAGENAME eq nginx.exe"

ECHO.
ECHO  nginx port：%WEB_PORT%
ECHO     website: http://localhost:%WEB_PORT%
ECHO.

ECHO 输入"r"然后按回车键打开浏览器，如需关闭服务请直接回车键。
set KEY=
set /P KEY=

if "%KEY%" equ "r" goto OPEN_BROWSER
if "%KEY%" neq "r" goto CLEAR_TOKENS
rem ================================ 交互操作（结束） =============================


rem ================================ 终止服务（开始） =============================
:CLEAR_TOKENS
rem 删除本应用启动的进程
for /f "tokens=1* delims= " %%i in ('type %SERVER_CONF%\nginx.all.pid') do (
    if "%%i" neq "" taskkill /f /pid %%i /t
)

rem 删除配置文件
del /f /q "%SERVER_CONF%\nginx1.conf"

del /f /q "%SERVER_CONF%\*.pid"

exit /b 0
rem ================================ 终止服务（结束） =============================


:no_conf
echo.
echo No nginx.conf found!
echo.
exit /b 1

:nginx_inline
if "%1" neq "inline" (
    cmd /k
)