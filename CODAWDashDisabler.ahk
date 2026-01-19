#Requires AutoHotkey v1.1.33+
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Persistent
#SingleInstance force  ; Allow only a single instance of the script to run.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

DOUBLE_PRESS_MAX_TIME := 250
aFlag := 0
dFlag := 0
aLastPressedTick := A_TickCount
dLastPressedTick := A_TickCount

#IfWinActive, ahk_exe s1_sp64_ship.exe
~a up::
aFlag := 0
;OutputDebug, "aFlag set to 0"
return

~d up::
dFlag := 0
;OutputDebug, "dFlag set to 0"
return
#IfWinActive

#If WinActive("ahk_exe s1_sp64_ship.exe") && !aFlag
$a::
aTimeSinceLastA := A_TickCount - aLastPressedTick
aTimeSinceLastD := A_TickCount - dLastPressedTick
;OutputDebug, % "aTimeSinceLastA: " . aTimeSinceLastA
;OutputDebug, % "aTimeSinceLastD: " . aTimeSinceLastD

isDoublePress := (aTimeSinceLastA > 0 && aTimeSinceLastA < DOUBLE_PRESS_MAX_TIME)
              || (A_PriorHotkey == "$d" && aTimeSinceLastD > 0 && aTimeSinceLastD < DOUBLE_PRESS_MAX_TIME)

if (isDoublePress)
{
    ;OutputDebug, "double press"

    ; Delay the keystroke until DOUBLE_PRESS_MAX_TIME is reached
    timeLeftUntilDoublePressMaxTime := DOUBLE_PRESS_MAX_TIME - A_TimeSincePriorHotkey
    ;OutputDebug, % "timeLeftUntilDoublePressMaxTime: " . timeLeftUntilDoublePressMaxTime
    Sleep, timeLeftUntilDoublePressMaxTime
}

if GetKeyState("a", "P")
{
    Send, {a down}
    aLastPressedTick := A_TickCount
    aFlag := 1
    ;OutputDebug, "aFlag set to 1"
}

return
#If

#If WinActive("ahk_exe s1_sp64_ship.exe") && !dFlag
$d::
aTimeSinceLastA := A_TickCount - aLastPressedTick
aTimeSinceLastD := A_TickCount - dLastPressedTick
;OutputDebug, % "aTimeSinceLastA: " . aTimeSinceLastA
;OutputDebug, % "aTimeSinceLastD: " . aTimeSinceLastD

isDoublePress := (aTimeSinceLastD > 0 && aTimeSinceLastD < DOUBLE_PRESS_MAX_TIME)
              || (A_PriorHotkey == "$a" && aTimeSinceLastA > 0 && aTimeSinceLastA < DOUBLE_PRESS_MAX_TIME)

if (isDoublePress)
{
    ;OutputDebug, "double press"

    ; Delay the keystroke until DOUBLE_PRESS_MAX_TIME is reached
    timeLeftUntilDoublePressMaxTime := DOUBLE_PRESS_MAX_TIME - A_TimeSincePriorHotkey
    ;OutputDebug, % "timeLeftUntilDoublePressMaxTime: " . timeLeftUntilDoublePressMaxTime
    Sleep, timeLeftUntilDoublePressMaxTime
}

if GetKeyState("d", "P")
{
    Send, {d down}
    dLastPressedTick := A_TickCount
    dFlag := 1
    ;OutputDebug, "dFlag set to 1"
}

return
#If

!F10::ExitApp ; ALT+F10