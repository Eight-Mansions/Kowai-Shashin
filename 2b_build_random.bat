:: Clear out the previous exe
del exe\SLPS_034.54

:: Build the new exe using the assembly file
copy exe\orig\SLPS_034.54 exe\SLPS_034.54
tools\armips.exe code\kowai-shashin-assembly-random-edition.asm
tools\atlas exe\SLPS_034.54 trans\exe_translations.txt >> exe_random_error.txt
copy exe\SLPS_034.54 cd\working\SLPS_034.54

:: Combine everything into a final build
tools\psximager\psxbuild.exe cd\working.cat cd\kowai-shashin-working-random.bin>> cd\build.log
