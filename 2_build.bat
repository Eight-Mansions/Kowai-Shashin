:: Clear out the old files
del cd\working\DATA\SCN\*.DAT
del cd\working\DATA\SCN2\*.DAT
del exe\SLPS_034.54

:: Copy the new DAT files into the Working directory
xcopy /e /y ins\* cd\working\DATA\

:: Compress and copy the translated images in
python tools\KSImageCompressor.py graphics\TITLE graphics\orig\TITLE.DAT graphics\TITLE.DAT
copy graphics\TITLE.DAT cd\working\DATA\TITLE.DAT

:: Build the new exe using the assembly file
copy exe\orig\SLPS_034.54 exe\SLPS_034.54
tools\armips.exe code\kowai-shashin-assembly.asm
copy exe\SLPS_034.54 cd\working\SLPS_034.54

:: Combine everything into a final build
tools\psximager\psxbuild.exe cd\working.cat cd\kowai-shashin-working.bin>> cd\build.log
