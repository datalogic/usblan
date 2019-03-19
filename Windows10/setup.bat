echo OFF 
SET PATH="%CD%";%PATH%
SET DEBUGOPT=
SET LMOPT=
REM SET DEBUGOPT=/C
REM The ARG1 variable will be setup differently depending on how and where it is called from.
REM

REM File explorer quotes the string, so need to remove the quotes.
set ARG1=%~n1
for /f "useback tokens=*" %%a in ('%ARG1%') do set ARG1=%%~a
REM IF /i "debug" equ "%ARG1%" GOTO :DEBUG


REM ****************************************************************************
REM Copyright (c) 2011-2016 Belcarra Technologies 2005
REM 
REM This script uses DPInst to install the correct USBLAN driver.
REM
REM If this script is renamed to silent.bat the /sw switch is added to the 
REM DPInst call, this suppresses the Device Installation Wizard.
REM
REM If this script is renamed to debug.bat the /c switch is added to the DPinst
REM call, this causes debug output to be sent to the console window. The 
REM pause command is used so that the console window does not close until
REM the output can be viewed.
REM
REM Win 7 and Win 8
REM


REM ****************************************************************************
REM GET OS Version
REM

for /f "tokens=1,2,3 delims=[]" %%a in ('ver') do set OSVER=%%b
REM echo OSVER: %OSVER%

for /f "tokens=1,2 delims= " %%a in ("%OSVER%") do set OSVER=%%b
REM echo OSVER: %OSVER%

for /f "tokens=1,2,3 delims=." %%a in ("%OSVER%") do set VER=%%a.%%b
REM echo VER: %VER%

REM ****************************************************************************
REM Cascade through valid version numbers to determine OS.
REM
REM OS          OS Version  NDIS Version
REM
REM WinXP       NT 5.2      NDIS 5.1
REM Vista       NT 6.0      NDIS 6.0
REM VistaSP1    NT 6.0      NDIS 6.1
REM Win7        NT 6.1      NDIS 6.2
REM WIN8        NT 6.2      NDIS 6.3
REM WIN81       NT 6.3      NDIS 6.4
REM WIN10       NT 10.0     NDIS 

IF "%VER%"=="5.1" GOTO :XP
IF "%VER%"=="5.2" GOTO :VISTA
IF "%VER%"=="6.0" GOTO :VISTA

IF "%VER%"=="6.1" GOTO :WIN7
IF "%VER%"=="6.2" GOTO :WIN8
IF "%VER%"=="6.3" GOTO :WIN81
IF "%VER%"=="10.0" GOTO :WIN10

GOTO :win10

:XP
SET DRV=vista
SET LMOPT=/LM
IF NOT EXIST vista  GOTO :NODRIVERDIR
GOTO :OSFINIS

:VISTA
SET DRV=vista
IF NOT EXIST vista  GOTO :NODRIVERDIR
GOTO :OSFINIS

:WIN7
IF /i "win7up" equ "%ARG1%" GOTO :WIN7UP
SET DRV=win7
IF NOT EXIST win7  GOTO :NODRIVERDIR
GOTO :OSFINIS

:WIN7UP
SET DRV=win7up
IF NOT EXIST win7 up GOTO :NODRIVERDIR
GOTO :OSFINIS

:WIN8
SET DRV=win8
IF NOT EXIST win8  GOTO :NODRIVERDIR
GOTO :OSFINIS

:WIN81
SET DRV=win8
IF NOT EXIST win8  GOTO :NODRIVERDIR
GOTO :OSFINIS

:WIN10
SET DRV=win10
IF NOT EXIST win10  GOTO :NODRIVERDIR
GOTO :OSFINIS

:NODRIVERDIR

echo ***************************************************************************
echo * 
echo * ERROR!!!
echo * The driver subdirectory for %DRV% is Missing.
echo *
echo * Are you trying to install the incorrect version of the driver?
echo * There are two installation kits, one for Windows 10 and one for
echo * all older versions of Windows.
echo *
echo * Or are you trying to run setup.bat using the compressed folder tools?
echo *
echo * Please extract the driver kit to a new directory and run setup.bat 
echo * again.
echo *
echo ***************************************************************************
pause


GOTO :FINISHED

:OSFINIS



REM ****************************************************************************
REM Determine architecture so we can use the correct version of dpinst.
REM
REM This gets difficult as Cygwin does not properly copy the environment variables.
REM

REM PROCESSOR_ARCHITECTURE will be properly set for dos 
IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" GOTO :AMD64

REM PROCESSOR_ARCHITEW6432 will be properly set for cygwin
IF "%PROCESSOR_ARCHITEW6432%"=="AMD64" GOTO :AMD64

REM 32 BIT
SET DPINST=dpinst-x86.exe
GOTO :ARCHFINIS

:AMD64
REM 64 BIT
SET DPINST=dpinst-x64.exe
GOTO :ARCHFINIS
:ARCHFINIS


GOTO DRIVERDIRSOK

REM ****************************************************************************
REM Run DPInst with appropriate flags
REM
REM Use the 32 or 64 bit DPInst against the Ndis5 or Ndis6 driver kit
REM
REM N.B. Copying dpinst into the top directory eliminates problems
REM when the directory path has a directory name with an embedded space.
REM 

:DRIVERDIRSOK
echo on
%DPINST% %DEBUGOPT% %LMOPT% /path %DRV% 
GOTO :FINISHED

:FINISHED

