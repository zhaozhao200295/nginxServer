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

rem ================================ ������������ʼ�� =============================
:RELOAD
echo ���ڴ�ҳ�棬���Ժ�
explorer http://localhost:%WEB_PORT%

cls

tasklist /FI "IMAGENAME eq nginx.exe"

echo.
echo ҳ���ַ��http://localhost:%WEB_PORT%
echo.

echo ����"r"Ȼ�󰴻س����������������رշ�����ֱ�ӻس�����
set KEY=
set /P KEY=

if "%KEY%" equ "r" goto RELOAD

if "%NGINX_SERVER%" equ "start" (
    call "%CURR%\sbin\nginx.bat" inline stop
)
rem ================================ ���������������� =============================