@echo off

title Develope Integration Toolkit
color A

echo ============================================================
echo = Develope Integration Toolkit (DIT)                       =
echo = version 1.0                                              =
echo = BingheSoft ^& Technology                                 =
echo = Internal Use Only                                        =
echo = www.binghesoft.com                                       =
echo ============================================================
echo.


if "%1" neq "inline" (
    setlocal
)
if "%1" equ "inline" (
    if "%2" equ "" goto call_faild
)

cd /d %~dp0..\..

set ROOT_PATH=%CD%
if "%SERVER_NAME%" equ "" (
    set SERVER_NAME=%~n0
)
set DIT_HOME=%ROOT_PATH%\%SERVER_NAME%

set SERVER_LOGS=%DIT_HOME%\logs\%2
set SERVER_CONF=%DIT_HOME%\conf\%2
set SERVER_TOOLS=%DIT_HOME%\tools
set SERVER_SBIN=%DIT_HOME%\sbin
set SERVER_APACHE=%DIT_HOME%\apache-2.2
set SERVER_NGINX=%DIT_HOME%\nginx-0.8.50
set PHP52_HOME=%DIT_HOME%\php-5.2
set PHP53_HOME=%DIT_HOME%\php-5.3.8.0
set MYSQL_HOME=%DIT_HOME%\mysql-5.5.8-win32

set PATH=%PATH%;%PHP53_HOME%;%MYSQL_HOME%\bin;%SERVER_TOOLS%;

rem ======================== web configurations - begin ========================
set PHP_INI=%DIT_HOME%\conf\php
set MY_INI=%DIT_HOME%\conf\mysql

set WEB_ROOT=%ROOT_PATH%\www
set PMA_ROOT=%DIT_HOME%\phpMyAdmin
set CLOUD_ROOT=%DIT_HOME%\public
set WEB_ROOT=%WEB_ROOT:\=\\%
set PMA_ROOT=%PMA_ROOT:\=\\%
set CLOUD_ROOT=%CLOUD_ROOT:\=\\%
set SERVER_LOGS=%SERVER_LOGS:\=\\%

set WEB_PORT=80
set CLOUD_PORT=8331
set PMA_PORT=8351
set PHP52_PORT=9342
set PHP53_PORT=9000
set MYSQL_PORT=3306
rem ======================== web configurations - end   ========================

echo Usages:
echo     nginx ( example: nginx start )  - nginx command line
echo     apache ( example: apache start ) - apache command line
echo.


echo Enjoy DIT!
echo.

cd %ROOT_PATH%

if "%1" equ "inline" (
    if "%2" neq "" exit /b 1
    cmd /k
)

:call_faild
echo.
echo Error, faild type to call script!
echo.
exit /b 1