@echo off
set filename=Kowai-Shashin-English-v1.0
set file_type=BIN
set patch_file=kowai-shashin-patch.xdelta3
set vn_patch_file=kowai-shashin-vn-patch.xdelta3
set random_patch_file=kowai-shashin-random-patch.xdelta3

pushd %~dp0
if "%~1"=="" goto :NOISO

echo Patching %file_type%...
patch_data\xdelta.exe -d -f -s "%~1" patch_data\%patch_file% %filename%.bin

patch_data\xdelta.exe -d -f -s "%~1" patch_data\%vn_patch_file% %filename%-VN-Edition.bin

patch_data\xdelta.exe -d -f -s "%~1" patch_data\%random_patch_file% %filename%-Random-Edition.bin

if errorlevel 1 goto :XDELTAERR
goto :FIN

:NOISO
echo To patch %file_type% don't run this bat file.
echo Simply drag and drop %file_type% on it and the patch process will start.
goto :EXIT

:XDELTAERR
echo.
echo Something went wrong while patching files.
echo You might be trying to patch the wrong %file_type%, try using a different one.
goto :EXIT

:FIN
echo FILE "%filename%.bin" BINARY>%filename%.cue
echo   TRACK 01 MODE2/2352>>%filename%.cue
echo     INDEX 01 00:00:00>>%filename%.cue
echo.

echo FILE "%filename%-VN-Edition.bin" BINARY>%filename%-VN-Edition.cue
echo   TRACK 01 MODE2/2352>>%filename%-VN-Edition.cue
echo     INDEX 01 00:00:00>>%filename%-VN-Edition.cue
echo.

echo FILE "%filename%-Random-Edition.bin" BINARY>%filename%-Random-Edition.cue
echo   TRACK 01 MODE2/2352>>%filename%-Random-Edition.cue
echo     INDEX 01 00:00:00>>%filename%-Random-Edition.cue
echo.

echo Success!
echo ---
echo The following %file_type% files were created next to the bat file:
echo * %filename%(.bin/.cue)
echo * %filename%-VN-Edition(.bin/.cue)
echo * %filename%-Random-Edition(.bin/.cue)
echo ---
echo Load up the .cue file for the version you wish to play and enjoy!
goto :EXIT

:EXIT
popd
echo Press any key to close this window
pause >nul
exit
