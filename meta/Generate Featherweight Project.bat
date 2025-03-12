set /p id="Enter levels you want, spaced apart, without the .room.gmx extension: "
@echo off
>output.txt (
gmslur.exe -x -gp -uc -roomw "rmInit lvlCopyThisRoom lvlGameIntro rmCharacterSelect rmDisclaimer rmOptions rmRoomSelect rmTitleScreen %id%" -p ../MegamixEngine.project.gmx
)
@echo on
set /p id="Output made to output.txt"