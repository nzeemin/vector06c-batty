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
tools\tasm -85 -b -i batty0.asm batty0.bin
@if errorlevel 1 goto Failed
@echo off

dir /-c batty0.bin|findstr /R /C:"batty0.bin"

powershell -Command "(gc batty0.exp) -replace '.EQU', 'EQU' | Out-File -encoding ASCII batty0.inc"
if exist batty0.exp del batty0.exp
@if errorlevel 1 goto Failed

@echo on
tools\sjasmplus --nobanner batty.asm --raw=batty.bin --target=Z80 --nofakes --lst=batty.lst
@if errorlevel 1 goto Failed
@echo off

dir /-c batty.bin|findstr /R /C:"batty.bin"

copy /b batty0.bin+batty.bin batty.rom >nul
@if errorlevel 1 goto Failed

dir /-c batty.rom|findstr /R /C:"batty.rom"

echo %ESCchar%[92mSUCCESS%ESCchar%[0m
exit

:Failed
@echo off
echo %ESCchar%[91mFAILED%ESCchar%[0m
pause
exit /b
