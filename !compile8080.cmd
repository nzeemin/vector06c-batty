@echo off
if exist batty0.bin del batty0.bin
if exist batty.bin del batty.bin
if exist batty0.lst del batty0.lst
if exist batty0.exp del batty0.exp
if exist batty0.inc del batty0.inc
if exist batty.lst del batty.lst
if exist batty.rom del batty.rom

rem Define ESCchar to use in ANSI escape sequences
rem https://stackoverflow.com/questions/2048509/how-to-echo-with-different-colors-in-the-windows-command-line
for /F "delims=#" %%E in ('"prompt #$E# & for %%E in (1) do rem"') do set "ESCchar=%%E"

@echo on
tools\sjasmplus --nologo --msg=war --i8080 batty0.asm --lst=batty0.lst --exp=batty0.inc
@if errorlevel 1 goto Failed
@echo off

dir /-c batty0.bin|findstr /R /C:"batty0.bin"

@echo on
tools\sjasmplus --nologo batty.asm --raw=batty8080.bin --i8080 --nofakes --lst=batty8080.lst
@if errorlevel 1 goto Failed
@echo off

dir /-c batty8080.bin|findstr /R /C:"batty8080.bin"

copy /b batty0.bin+batty8080.bin batty.rom >nul
@if errorlevel 1 goto Failed

dir /-c batty.rom|findstr /R /C:"batty.rom"

echo %ESCchar%[92mSUCCESS%ESCchar%[0m
exit

:Failed
@echo off
echo %ESCchar%[91mFAILED%ESCchar%[0m
exit /b
