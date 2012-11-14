@echo off

title Nginx Server
color A

setlocal

cd /d %~dp0

set CURR=%CD%
set SERVER_NAME=nginxServer
if "%DIT_HOME%" equ "" (
    call "%CURR%\sbin\server.bat" inline %~n0
)

set WEB_ROOT=%ROOT_PATH%\\h5slides
set WEB_ROOT=%WEB_ROOT:\=\\%

if "%NGINX_SERVER%" neq "start" (
    call "%CURR%\sbin\nginx.bat" inline
)

rem ================================ 交互操作（开始） =============================
:RELOAD
echo 正在打开页面，请稍后。
explorer http://localhost:%WEB_PORT%

cls

tasklist /FI "IMAGENAME eq nginx.exe"

echo.
echo 页面地址：http://localhost:%WEB_PORT%
echo.

echo 输入"r"然后按回车键打开浏览器，如需关闭服务请直接回车键。
set KEY=
set /P KEY=

if "%KEY%" equ "r" goto RELOAD

if "%NGINX_SERVER%" equ "start" (
    call "%CURR%\sbin\nginx.bat" inline stop
)
rem ================================ 交互操作（结束） =============================