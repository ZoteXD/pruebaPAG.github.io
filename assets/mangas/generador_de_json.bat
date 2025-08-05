@echo off
setlocal enabledelayedexpansion

set "CARPETA=%cd%"
set "CARPETA_URL=%CARPETA:*assets=assets%"
set "CARPETA_URL=%CARPETA_URL:\=/%"   :: Reemplaza \ por /

if exist "%CARPETA%\images.json" del "%CARPETA%\images.json"

echo [ > "%CARPETA%\images.json"
set first=1

for %%I in (*.jpg *.png *.webp) do (
    if !first! == 1 (
        echo   "/%CARPETA_URL%/%%~I" >> "%CARPETA%\images.json"
        set first=0
    ) else (
        echo , "/%CARPETA_URL%/%%~I" >> "%CARPETA%\images.json"
    )
)

echo ] >> "%CARPETA%\images.json"

echo Generado: %CARPETA%\images.json
pause
