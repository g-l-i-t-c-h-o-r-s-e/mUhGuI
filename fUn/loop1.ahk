#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
toggle = 0
#MaxThreadsPerHotkey 2

F5::
    Toggle := !Toggle
     While Toggle{
        Send, {rbutton}
        sleep 35
    }
return
F12::ExitApp