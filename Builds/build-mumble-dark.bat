@echo off

pip install -r requirements.txt

set ThemeDir=mumble-theme
set IconsDir=mumble-icons
set ThemeName=mumble-dark

pushd %ThemeDir%\source
    qtsass -o ..\dark.qss dark.scss
popd

python fill-icons.py nowshed #4B9CD3 %IconsDir%

rem for /r icons/nowshed/ %%i in (*.svg) do powershell -Command "(gc %%~dpnxi) -replace '#4285f4', '#6a1b9a' | Out-File -encoding ASCII %IconsDir%/%%~nxi"

python make-resource.py -base-dir %ThemeDir% ^
                        -find-files ^
                        -config dark-config.json ^
                        -icons-dir %IconsDir% ^
                        -output %ThemeName% ^
                        -style dark.qss 

rd /q /s %IconsDir%

rem python make-resource.py -base-dir %ThemeDir% -find-files -config dark-config.json -icons-dir icons\nowshed -output mumble-dark-nowshed -style dark.qss 
