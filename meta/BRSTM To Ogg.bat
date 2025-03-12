@echo off
REM Check if a file was dragged and dropped
if "%~1"=="" (
    echo Please drag and drop a BRSTM file onto this script.
    pause
    exit /b
)

REM Set input file and derive output file
set "input_file=%~1"
set "output_file=%~dpn1.ogg"


REM Prompt user for volume level
:volume_prompt
set /p volume="Enter volume level (0-1, fractional): "
if %volume% LSS 0 (
    echo Please enter a value between 0 and 1.
    goto metadata_prompt
)
if %volume% GTR 1 (
    echo Please enter a value between 0 and 1.
    goto metadata_prompt
)

:metadata_prompt
REM Prompt user for tags
echo If developing for fangames, please research and answer the following information. While generally good for professional standards, for MaGMML games this will be *required* for submission.

echo

set /p TITLE="Set TITLE (Track Title) for the OGG file. This should be the official name of the song: "

set /p ALBUM="Set ALBUM (Album Title) for the OGG file. This should be the official name of whatever game or other medium the song was released as part of: "

set /p COMPOSER="Set COMPOSER for the OGG file. This should be the *original* composer(s) of the song: "

set /p ARTIST="Set ARTIST for the OGG file. This should generally be the remixer(s) of the song, but may have other applications. Leave blank if not applicable/same as composer: "

set /p COPYRIGHT="Set COPYRIGHT for the OGG file. This should be the copyright owner of the song, usually a game's publisher, though including developer is also recommended. Include even if same as COMPOSER: "

set /p DATE="Set DATE (Year) for the OGG file. This should be the date the medium the song was released came out, in the format YYYY-MM-DD. YYYY-MM or YYYY is also acceptable if a precise date cannot be found: "


REM Prompt user for quality level
:quality_prompt
set quality=5
set /p quality="Enter quality level (1-10). Blank defaults to 5: "
if %quality% LSS 1 (
    echo Please enter a value between 1 and 10.
    goto quality_prompt
)
if %quality% GTR 10 (
    echo Please enter a value between 1 and 10.
    goto quality_prompt
)

REM Change to the directory of the batch file
cd /d "%~dp0"

REM Call the Python script with arguments
python3 brstm2ogg/brstm2ogg.py "%input_file%" "%output_file%" %quality% VOLUME="%volume%" TITLE="%TITLE%" ALBUM="%ALBUM%" COMPOSER="%COMPOSER%" ARTIST="%ARTIST%" COPYRIGHT="%COPYRIGHT%" DATE="%DATE%"

REM Finish
echo Conversion complete. Output file: %output_file%
pause