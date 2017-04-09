#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
; Styles we want to remove from the console window:
WS_POPUP := 0x80000000
WS_CAPTION := 0xC00000
WS_THICKFRAME := 0x40000
WS_EX_CLIENTEDGE := 0x200

; Styles we want to add to the console window:
WS_CHILD := 0x40000000

; Styles we want to add to the Gui:
WS_CLIPCHILDREN := 0x2000000

; Flags for SetWindowPos:
SWP_NOACTIVATE := 0x10
SWP_SHOWWINDOW := 0x40
SWP_NOSENDCHANGING := 0x400

; Create Gui and get window ID.
Gui, +LastFound +%WS_CLIPCHILDREN%
GuiWindow := WinExist()

; Launch hidden cmd.exe and store process ID in pid.
Run, %ComSpec%,, Hide, pid

; Wait for console window to be created, store its ID.
DetectHiddenWindows, On
WinWait, ahk_pid %pid%
ConsoleWindow := WinExist()

; Get size of console window, excluding caption and borders:
VarSetCapacity(ConsoleRect, 16)
DllCall("GetClientRect", "uint", ConsoleWindow, "uint", &ConsoleRect)
ConsoleWidth := NumGet(ConsoleRect, 8)
ConsoleHeight:= NumGet(ConsoleRect, 12)

; Apply necessary style changes.
WinSet, Style, % -(WS_POPUP|WS_CAPTION|WS_THICKFRAME)
WinSet, Style, +%WS_CHILD%
WinSet, ExStyle, -%WS_EX_CLIENTEDGE%

; Put the console into the Gui.
DllCall("SetParent", "uint", ConsoleWindow, "uint", GuiWindow)

; Move and resize console window. Note that if SWP_NOSENDCHANGING
; is omitted, it incorrectly readjusts the size of its client area.
DllCall("SetWindowPos", "uint", ConsoleWindow, "uint", 0
    , "int", 3, "int", 3, "int", ConsoleWidth, "int", ConsoleHeight
    , "uint", SWP_NOACTIVATE|SWP_SHOWWINDOW|SWP_NOSENDCHANGING)

; Add a button below the console.
Gui, Add, Button, x8 y360 w38 h30  glel,ffplay
Gui, Add, Button, x8 y399 w38 h40 gkek,stream
Gui, Add, Button, x585 y390 w53 h22 gwhy,pReViEw
Gui, Color, 884488

; Show the Gui. Specify width since auto-sizing won't account for the console.
Gui, Show, % "W" ConsoleWidth+14

GameIndex := 0
loop, read, fUn\vcodecs.txt
{
Game%A_Index% := A_LoopReadLine
Game0 = %A_Index%
}
 
Loop,%Game0%
    List .= Game%A_Index%  . "|" 

GameIndex := 1
loop, read, fUn\acodecs.txt
{
Game%A_Index% := A_LoopReadLine
Game1 = %A_Index%
}
 
Loop,%Game1%
    List2 .= Game%A_Index%  . "|" 
	
GameIndex := 2
loop, read, fUn\adecoders.txt
{
Game%A_Index% := A_LoopReadLine
Game2 = %A_Index%
}
 
Loop,%Game2%
    List3 .= Game%A_Index%  . "|" 	
	
GameIndex := 3
loop, read, fUn\pixfmts.txt
{
Game%A_Index% := A_LoopReadLine
Game3 = %A_Index%
}
 
Loop,%Game3%
    List4 .= Game%A_Index%  . "|" 		
	
GameIndex := 4
loop, read, fUn\pixfmts.txt
{
Game%A_Index% := A_LoopReadLine
Game4 = %A_Index%
}
 
Loop,%Game4%
    List5 .= Game%A_Index%  . "|" 

GameIndex := 5
loop, read, fUn\vdecoders.txt
{
Game%A_Index% := A_LoopReadLine
Game5 = %A_Index%
}
 
Loop,%Game5%
    List6 .= Game%A_Index%  . "|" 	

InputBox, UserInput, m̶̨̙̖̻͉̦̅̄̈͐̐͌Ë̸̱̣̹͖͎̅̓̀̆̃͠m̶̜͓̲̀̿̍͐̚E̵̐͠, Pls Use -i And Enter Input File Path 4 Now..., , x400 y357 w70 h70,,,,,,-i
Gui, Add, DropDownList,  x478 y357 w100 h88 vDecoderchoice Choose1, %List6%
Gui, Add, DropDownList,  x378 y357 w110 h88 vEncoderchoice Choose1, %List%
Gui, Add, Text,x404 y389 w190 h20 ,uR vIdeO eNcOdErS n' dEcOdErS
Gui, Add, Text, x122 y389 w170 h20 , uR aUdIo dEcOdErS n' eNcOdErS
Gui, Add, DropDownList,  x200 y357 w115 h88 vADecoderchoice Choose2, %List3%
Gui, Add, Button, x302 y387 w90 h40  gChoose,Use Settings <3
Gui, Add, Button, x77 y361 w8 h52  gMeme,KMS
Gui, Add, Button, x57 y361 w8 h52  gMeme2,PLS
Gui, Add, DropDownList,  x110 y357 w100 h88 vAEncoderchoice Choose2, %List2%
Gui, Add, DropDownList,  x53 y418 w68 h88 vPixfmt Choose3, %List4%
Gui, Add, DropDownList,  x578 y418 w68 h88 vPixfmtdec Choose4, %List5%
Gui,Show,,WARNING!!! MAY CAUSE SEIZURES HEARING LOSS AND MENTAL ILLNESS!!! :'D
Gui, Add, Edit, x410 y409 w140 h20 vDecoderSetting,-ar 4000 -af volume=0.5
Gui, Add, Edit, x132 y409 w150 h20 vEncoderSetting,-ar 8000 -strict -2 -f avi -
Gui, Add, Button, x592 y362 w38 h22  gInput,Input
Gui, Show
return
OK:
return

Choose:
Gui,Submit, Nohide
MsgBox, 

(

Video Decoder = %Decoderchoice% 
Video Encoder = %Encoderchoice%  
Audio Decoder = %ADecoderchoice%  
Audio Encoder = %AEncoderchoice%
Encoder Params  = %EncoderSetting%
Decoder Params = %DecoderSetting%
Encoder Pixel Format = %Pixfmt%
Decoder Pixel Format = %Pixfmtdec%
)
return

lel:
Gui,Submit, Nohide
Run, cmd.exe
sleep, 666
Send, ffplay -vcodec %Decoderchoice% -acodec %ADecoderchoice% -vf format=%Pixfmtdec% %DecoderSetting% -i udp://127.0.0.1:1337?overrun_nonfatal=1 {Enter}
return

kek:
Gui,Submit, Nohide
Run, cmd.exe
sleep, 666
Send, ffmpeg -re %UserInput% -vcodec %Encoderchoice% -acodec %AEncoderchoice% -vf format=%Pixfmt% %EncoderSetting% udp://127.0.0.1:1337 {Enter}
return

why:
Gui,Submit, Nohide
Run, cmd.exe
sleep, 666
Send, ffplay %UserInput% {Enter}
return

Input:
InputBox, UserInput, m̶̨̙̖̻͉̦̅̄̈͐̐͌Ë̸̱̣̹͖͎̅̓̀̆̃͠m̶̜͓̲̀̿̍͐̚E̵̐͠, Pls Use -i And Enter Input File Path 4 Now..., , x400 y357 w70 h70,,,,,,-f lavfi -i "sine=frequency=55:sample_rate=888:duration=30"
return

Meme:
Gui,Submit, Nohide
Msgbox,

(
A Few Examples:

r210 + avrp
dvvideo + vp5
v308 + kgv1
cavs + bfi
pcm_alaw + sipr
mp3 + pcm_zork 
adpcm_ima_wav + pcm_zork

	  )
Meme2:
; o3o s00n
	  
F8::Send, FFmpeg %UserInput% -vcodec %Encoderchoice% -acodec %AEncoderchoice% -vf format=%Pixfmt% %EncoderSetting% | ffplay -vcodec %Decoderchoice% -acodec %ADecoderchoice% -vf format=%Pixfmtdec% %DecoderSetting% -i - {Enter}
F7::
Send, cd fUn {Enter}
Sleep 500, 
Send, "ffmglitch-Input Version.bat" {Enter}
F6::Fileappend,%clipboardall%,C:\clip.txt
F9::Run, fUn/ShittyWebcam.exe,,Hide ; orginally made by a friend to corrupt my streams in realtime ; sends random udp data to 127.0.0.1:1337 ; Will release sauce once we find it
F10::Process,Close, ShittyWebcam.exe
F11::Process,Close, ffplay.exe ; get that shit outta here
toggle = 0
#MaxThreadsPerHotkey 2

F5:: ; Use with FFplay or pReViEw with a databent compressed video for best results. Also try having the video paused when doing so ;3
    Toggle := !Toggle
     While Toggle{
        Send, {rbutton}
        sleep 35
    }
return
$!F12::ExitApp

; Be sure to close cmd.exe later.
OnExit, Exiting

; If cmd.exe exits prematurely, fall through to ExitApp below.
Process, WaitClose, %pid%

 
GuiEsape:
GuiClose:
ButtonOK:
Exiting:
OnExit
Process, Close, %pid% ; May be a bit forceful? No effect if it already closed.
ExitApp