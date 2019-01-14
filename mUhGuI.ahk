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
WinSetTitle, %pid%,,NOKILL

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

GameIndex := 6
loop, read, fUn\soxfx.txt
{
Game%A_Index% := A_LoopReadLine
Game6 = %A_Index%
}
 
Loop,%Game6%
    List7 .= Game%A_Index%  . "|"

	
;convert clipboard into a dynamic variable and then apply transform to start GUI with clipboard input
clipboardnew = "%clipboard%"
transform, clipboardnew, Deref, %clipboardnew%
InputBox, UserInput, m̶̨̙̖̻͉̦̅̄̈͐̐͌Ë̸̱̣̹͖͎̅̓̀̆̃͠m̶̜͓̲̀̿̍͐̚E̵̐͠, Update clipboard with the desired file and restart the GUI..., , x400 y357 w70 h70,,,,,,-i %clipboardnew%
Gui, Add, DropDownList,  x478 y357 w100 h88 vDecoderchoice Choose140, %List6%
Gui, Add, DropDownList,  x378 y357 w110 h88 vEncoderchoice Choose66, %List%
Gui, Add, Text,x404 y389 w190 h20 ,uR vIdeO eNcOdErS n' dEcOdErS
Gui, Add, Text, x122 y389 w170 h20 , uR aUdIo dEcOdErS n' eNcOdErS
Gui, Add, DropDownList,  x200 y357 w115 h88 vADecoderchoice Choose129, %List3%
Gui, Add, Button, x326 y367 w40 h20  gSaveMe,Save
;Gui, Add, Button, x356 y367 w40 h20  gPreset,Pre
Gui, Add, Button, x302 y387 w90 h40  gChoose,Use Settings <3
Gui, Add, Button, x77 y361 w8 h52  gMeme,KMS
Gui, Add, Button, x57 y361 w8 h52  gMeme2,PLS
Gui, Add, Button, x97 y361 w8 h52  gSaveIt,SAVE
Gui, Add, DropDownList,  x110 y357 w100 h88 vAEncoderchoice Choose55, %List2%
Gui, Add, DropDownList,  x53 y418 w68 h88 vPixfmt Choose20, %List4%
Gui, Add, DropDownList,  x578 y418 w68 h88 vPixfmtdec Choose20, %List5%
Gui,Show,,WARNING!!! MAY CAUSE SEIZURES HEARING LOSS AND MENTAL ILLNESS!!! :'D
Gui, Add, Edit, x410 y409 w140 h20 vDecoderSetting,-ar 4000 -af volume=0.5
Gui, Add, Edit, x132 y409 w150 h20 vEncoderSetting,-ar 8000 -strict -2 -f avi
Gui, Add, Button, x592 y362 w38 h22  gInput,Input
Gui, Show
return
OK:
return

lel:
PlayStream := "ffplay -vcodec %Decoderchoice% -acodec %ADecoderchoice% -vf format=%Pixfmtdec% %DecoderSetting% -i udp://127.0.0.1:1337?overrun_nonfatal=1"
transform, PlayStream, Deref, %PlayStream%
Run, cmd.exe
sleep, 666
Send, %PlayStream% {Enter}
return

kek:
SendStream := "ffmpeg -re %UserInput% -vcodec %Encoderchoice% -acodec %AEncoderchoice% -vf format=%Pixfmt% %EncoderSetting% udp://127.0.0.1:1337"
transform, SendStream, Deref, %SendStream%
Run, cmd.exe
sleep, 666
Send, %SendStream% {Enter}
return

why:
Gui,Submit, Nohide
Run, cmd.exe
sleep, 666
Send, ffplay %UserInput% {Enter}
return

; Added native file browser, input flag and double quotes for filenames with spaces in them
Input:
FileSelectFile, UserInput
AddQuoteToInput = "
AddFFMpegInputFlagToCommand := "-i "
UserInput = %AddFFMpegInputFlagToCommand%%AddQuoteToInput%%UserInput%%AddQuoteToInput%
return

SaveMe:
AppendMe = `n%SendStream%`n%PlayStream%`n`n
transform, AppendMe, Deref, %AppendMe%
Fileappend,%AppendMe%,fUn\output\clip.txt
Gui,Submit, Nohide
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

Meme:
Gui,Submit, Nohide
Gui, 3:Color, 884488, -caption
Gui, 3:Add, Button, gFugvideo x302 y279 w130 h60 , fUcKiNg dO iT
; Fixed dropdownlist default values
Gui, 3:Add, DropDownList, x42 y239 w130 h21 VvCompressor Choose68, %List%
Gui, 3:Add, DropDownList, x302 y239 w130 h21 vBentAcodec Choose55, %List2%
Gui, 3:Add, DropDownList, x42 y199 w130 h21 VAencodercodec Choose55, %List2%
Gui, 3:Add, DropDownList, x302 y199 w130 h20 Choose68, %List%
Gui, 3:Add, Edit, x302 y259 w130 h20 vAFilters , -af flanger,flanger
Gui, 3:Add, Edit, x42 y259 w130 h20 VvFilters , -vf vflip`,hflip
; removed sample rate boxes for now
Gui, 3:Add, Edit, x42 y219 w130 h20 VaEncParam , -ss 00:01:30
Gui, 3:Add, Edit, x302 y219 w130 h20 VvEncParam, -ss 00:00:30
; Modified Boxes
Gui, 3:Add, Edit, x432 y279 w40 h20 vOutputFmt , -f u8
Gui, 3:Add, Edit, x432 y199 w40 h20 VInputFmt , -f u8
Gui, 3:Add, Edit, x2 y199 w40 h20 VEncFmt , -f u8
Gui, 3:Add, Edit, x2 y279 w40 h20 VDecFmt , -f u8
Gui, 3:Add, Text, x52 y169 w100 h30 , Audio Bending Here
Gui, 3:Add, Text, x322 y169 w100 h30 , Video Bending Here
Gui, 3:Add, Button, gFugAudio x42 y279 w130 h60 , fUcKiNg dO iT
; Added gInput here
Gui, 3:Add, Button, gInput x2 y219 w40 h60 gInputa, Sauce
Gui, 3:Add, Button, x432 y219 w40 h60 gInputv,Sauce
Gui, 3:Add, DropDownList, x192 y209 w90 h10 VEffect1 Choose31, %List7%
Gui, 3:Add, Edit, x182 y229 w110 h20 VFXParam1 , -n 9001
Gui, 3:Add, Text, x212 y189 w40 h20 , SOX FX
Gui, 3:Add, DropDownList, x192 y249 w90 h20 VEffect2 , %List7%
Gui, 3:Add, Edit, x182 y269 w110 h20 VFXParam2 , 0.8 0.88 60 0.4
Gui, 3:Add, DropDownList, x192 y289 w90 h10 VEffect3 , %List7%
; Added Volume Slider
Gui, 3:Add, Slider, x62 y359 w100 h20 Tooltip VFugAudioVol TickInterval2 Range0-10, 1
Gui, 3:Add, Text, x2 y339 w60 h20 , Sample R8
Gui, 3:Add, Slider, x312 y339 w100 h20 Tooltip VvDecSmplr8 TickInterval2 Range666-88100, 8000
Gui, 3:Add, Slider, x312 y359 w100 h20 , 25
Gui, 3:Add, Text, x422 y339 w60 h20 , Sample R8
Gui, 3:Add, Slider, x62 y339 w100 h20 Tooltip VaDecSmplr8 TickInterval2 Range666-88100, 44100
Gui, 3:Add, Text, x2 y359 w60 h20 , Volume
Gui, 3:Add, Text, x422 y359 w60 h20 , Volume
Gui, 3:Add, Button, x2 y159 w40 h40 gSaveFugAudio,Save
Gui, 3:Add, Button, x432 y159 w40 h40 gSaveFugVideo,Save
Gui, 3:Add, GroupBox, x12 y9 w440 h60 , *notices GUI* oWo Wats This?~
Gui, 3:Add, Text, x32 y29 w410 h30 , Pretty much a groovy way to kinda trick ffmpeg to sonify video`, compress audio data with video codecs`, process audio with video effects`, etc in real time... (and with SOX)
Gui, 3:Add, Button, x282 y249 w10 h20 , ?
Gui, 3:Add, Button, x182 y249 w10 h20 , ?
; Added Channel Count
Gui, 3:Add, DropDownList, x2 y319 w40 h21 vChanCount2 Choose2, 1|2|3|4|5||6|7|8|9|10
Gui, 3:Add, DropDownList, x2 y299 w40 h20 vChanCount1 Choose2, 1|2|3|4|5||6|7|8|9|10
Gui, 3:Add, DropDownList, x432 y299 w40 h20  vChanCount4 Choose2, 1|2|3|4|5||6|7|8|9|10
Gui, 3:Add, DropDownList, x432 y319 w40 h21 vChanCount3 Choose2, 1|2|3|4|5||6|7|8|9|10
Gui, 3:Add, Edit, x182 y309 w110 h20 VFXParam3 , 17
;Added Checkbox for SOX
Gui, 3:Add, Checkbox, x195 y330 w110 h20 vSoxVar gEnableSox, Enable Sox?
Gui, 3:Add, Button, gBack2 x2 y379 w470 h10 , bAcKBaCkbAcKBacKbAcKBaCkbAcKBaCkbAcKBacKbAcKBaCkbAcKBaCkbAcKBacKbAcK
Gui, 3:Add, Edit, x202 y159 w70 h20 VGlobalRes , -s 640x360
Gui, 3:Add, GroupBox, x192 y129 w90 h60 , Global Resolution
; Yeah you like that dontcha bitch ;)
Gui, 3:Show, x328 y144 h395 w477, ITSHAPPENINGITSHAPPENINGITSHAPPENINGITSHAPPENINGITSHAPPENINGITSHAPPENINGITSHAPPENING
Gui, 3:-Sysmenu
Return

Back2:
Gui, 1:Show
Gui, 3:Destroy
Return

SaveIt:
Gui,Submit, Nohide
Run, cmd.exe
sleep, 666
Send, ffmpeg -vcodec %Decoderchoice% -an  -i udp://127.0.0.1:1337?overrun_nonfatal=1 -vcodec ffvhuff -f avi -y fUn/ayylmao.avi -f nut - | ffplay - {Enter}
return
	  
Meme2:
Gui, 2:Color, 884488, -caption
Gui, 2:Add, Button, gBack x2 y16 w20 h410 , bAcKBaCkbAcKBacKbAcKBaCkbAcKBaCkbAcKBacKbAcKBaCkbAcKBaCkbAcKBacKbAcKBaCk
Gui, 2:Add, Button, gUDP4 x442 y9 w90 h30 , DO IT
Gui, 2:Add, Button, gUDP3 x332 y9 w90 h30 , DO IT
Gui, 2:Add, Button, gUDP2 x222 y9 w90 h30 , DO IT
Gui, 2:Add, Button, gUDP1 x112 y9 w90 h30 , DO IT
Gui, 2:Add, Edit, x332 y39 w90 h20 vUDPvset3, -b:v 8888 -f avi
Gui, 2:Add, Edit, x222 y39 w90 h20 vUDPvset2, -b:v 8888 -f avi
Gui, 2:Add, Edit, x112 y39 w90 h20 vUDPvset1, -b:v 8888 -f avi
Gui, 2:Add, Edit, x442 y39 w90 h20 vUDPvset4, -b:v 8888 -f avi
Gui, 2:Add, DropDownList, x112 y59 w90 h20 vUDPvcodec1 Choose9, %List%
Gui, 2:Add, DropDownList, x222 y59 w90 h21 vUDPvcodec2 Choose10, %List%
Gui, 2:Add, DropDownList, x332 y59 w90 h21 vUDPvcodec3 Choose11, %List%
Gui, 2:Add, DropDownList, x442 y59 w90 h21 vUDPvcodec4 Choose12, %List%
Gui, 2:Add, Edit, x442 y79 w90 h20 vUDPaset4, -af volume=0.5
Gui, 2:Add, DropDownList, x442 y99 w90 h21 vUDPacodec1 Choose17, %List2%
Gui, 2:Add, Edit, x332 y79 w90 h20 vUDPaset3, -af volume=0.5
Gui, 2:Add, DropDownList, x332 y99 w90 h21 vUDPacodec2 Choose18, %List2%
Gui, 2:Add, Edit, x222 y79 w90 h20 vUDPaset2, -af volume=0.5
Gui, 2:Add, DropDownList, x222 y99 w90 h21 vUDPacodec3 Choose19, %List2%
Gui, 2:Add, Edit, x112 y79 w90 h20 vUDPaset1, -af volume=0.5
Gui, 2:Add, DropDownList, x112 y99 w90 h21 vUDPacodec4 Choose20, %List2%
Gui, 2:Add, Button, gUDP8 x442 y149 w90 h30 , DO IT
Gui, 2:Add, Button, gUDP7 x332 y149 w90 h30 , DO IT
Gui, 2:Add, Button, gUDP6 x222 y149 w90 h30 , DO IT
Gui, 2:Add, Button, gUDP5 x112 y149 w90 h30 , DO IT
Gui, 2:Add, Edit, x442 y179 w90 h20 vUDPvset5, -b:v 8888 -f avi
Gui, 2:Add, DropDownList, x442 y199 w90 h20 vUDPvcodec5 Choose13, %List%
Gui, 2:Add, Edit, x442 y219 w90 h20 vUDPaset8, -af volume=0.5
Gui, 2:Add, DropDownList, x442 y239 w90 h21 vUDPacodec5 Choose20, %List2%
Gui, 2:Add, Edit, x332 y179 w90 h20 vUDPvset6, -b:v 8888 -f avi
Gui, 2:Add, DropDownList, x332 y199 w90 h21 vUDPvcodec6 Choose14, %List%
Gui, 2:Add, Edit, x332 y219 w90 h20 vUDPaset7, -af volume=0.5
Gui, 2:Add, DropDownList, x332 y239 w90 h21 vUDPacodec6 Choose20, %List2%
Gui, 2:Add, Edit, x222 y179 w90 h20 vUDPvset7, -b:v 8888 -f avi
Gui, 2:Add, Edit, x222 y219 w90 h20 vUDPaset6, -af volume=0.5
Gui, 2:Add, DropDownList, x222 y199 w90 h21 vUDPvcodec7 Choose15, %List%
Gui, 2:Add, DropDownList, x222 y239 w90 h21 vUDPacodec7 Choose20, %List2%
Gui, 2:Add, Edit, x112 y179 w90 h20 vUDPvset8, -b:v 8888 -f avi
Gui, 2:Add, DropDownList, x112 y199 w90 h21 vUDPvcodec8 Choose16, %List%
Gui, 2:Add, Edit, x112 y219 w90 h20 vUDPaset5, -af volume=0.5
Gui, 2:Add, DropDownList, x112 y239 w90 h20 vUDPacodec8 Choose20, %List2%
Gui, 2:Add, GroupBox, x162 y279 w290 h140 , oWo Wats This?
Gui, 2:Add, Text, x172 y309 w270 h90 , Spawn multiple FFMpeg instances that stream your stuff to udp://127.0.0.1:1337. Try mixing different codecs and formats into eachother for rad results :')                                                                                                                                        -f nut`, -f rawvideo`, -f alaw`, or -f mulaw                                     may help if -f avi breaks or fails
; im gay lol
Gui, 2:-Sysmenu
Gui, 2:Show,W555 h444 , HERE COME DAT BOI... O SHIT WADDUP??!?!?!!!???!??!?!!!?!??!?!?!!?!?!??!?!??!?!!!?!?!?!??!?!!!??!??!?!?!?!?!?!
Return


Back:
Gui, 1:Show
Gui, 2:Destroy
Return

FugVideo:
transform, AllowSox, Deref, %AllowSox%
Gui,Submit, Nohide
Run, %ComSpec%,,,pid2
sleep, 666
Send, ffmpeg %UserInput% %vEncParam% -f rawvideo -pix_fmt %Pixfmt% %GlobalRes% - %AllowSox% | ffmpeg %InputFmt% -ar %vDecSmplr8% -ac %ChanCount4% -i - %GlobalRes% -codec %BentAcodec% %AFilters% %OutputFmt% -ac %ChanCount3% -ar %vDecSmplr8% - | ffplay -f rawvideo %GlobalRes% -pix_fmt %Pixfmtdec% -i - {Enter}
return

SaveFugVideo:
transform, AllowSox, Deref, %AllowSox%
sfv := "ffmpeg %UserInput% %vEncParam% -f rawvideo -pix_fmt %Pixfmt% %GlobalRes% - %AllowSox% | ffmpeg %InputFmt% -ar %vDecSmplr8% -ac %ChanCount4%  -i - %GlobalRes% -codec %BentAcodec% %AFilters% %OutputFmt% -ac %ChanCount3% -ar %vDecSmplr8% - | ffmpeg -f rawvideo %GlobalRes% -pix_fmt %Pixfmtdec% -i - -c:v h263p -q:v 0 -y fUn/output/test.avi"
transform, sfv, Deref, %sfv%
Gui,Submit, Nohide
Run, %ComSpec%,,,pid2
sleep, 666
Send, %sfv% {Enter}
AppendMe1 = %sfv%`n`n
Fileappend,%AppendMe1%,fUn\output\clip.txt
return

FugAudio:
Gui,Submit, Nohide
Run, cmd.exe
sleep, 666
Send, ffmpeg %UserInput% -acodec %Aencodercodec% %aEncParam% %EncFmt% -ac %ChanCount1% -ar %aDecSmplr8% - | ffmpeg -f rawvideo %GlobalRes% -pix_fmt %Pixfmt% -i - -vcodec %VCompressor% %GlobalRes% %VFilters% -f rawvideo - | ffplay -ar %aDecSmplr8% %DecFmt% -ac %ChanCount2% -i - -af volume=%FugAudioVol% {Enter}
return

SaveFugAudio:
sfa := "ffmpeg %UserInput% -acodec %Aencodercodec% %aEncParam% %EncFmt% -ac %ChanCount1% -ar %aDecSmplr8% - | ffmpeg -f rawvideo %GlobalRes% -pix_fmt %Pixfmt% -i - -vcodec %VCompressor% %GlobalRes% %VFilters% -f rawvideo - | ffmpeg -ar %aDecSmplr8% %DecFmt% -ac %ChanCount2% -i - -af volume=%FugAudioVol% -y fUn/output/test.wav"
transform, sfa, Deref, %sfa%
Gui,Submit, Nohide
Run, cmd.exe
sleep, 666
Send, %sfa% {Enter}
AppendMe = %sfa%`n`n
Fileappend,%AppendMe%,fUn\output\clip.txt
return

;Added new input boxes
Inputv:
InputBox, UserInput, m̶̨̙̖̻͉̦̅̄̈͐̐͌Ë̸̱̣̹͖͎̅̓̀̆̃͠m̶̜͓̲̀̿̍͐̚E̵̐͠, Pls Use -i And Enter Input File Path 4 Now..., , x400 y357 w70 h70,,,,,,-f lavfi -i testsrc2
return

Inputa:
InputBox, UserInput, m̶̨̙̖̻͉̦̅̄̈͐̐͌Ë̸̱̣̹͖͎̅̓̀̆̃͠m̶̜͓̲̀̿̍͐̚E̵̐͠, Pls Use -i And Enter Input File Path 4 Now..., , x400 y357 w70 h70,,,,,,-f lavfi -i "sine=frequency=55:sample_rate=888:duration=30"
return

UDP1:
Gui,Submit, Nohide
Run, cmd.exe
sleep, 666
Send, ffmpeg -re %UserInput% -vcodec %UDPvcodec1% %UDPvset1% -acodec %UDPacodec4% %UDPaset1% udp://127.0.0.1:1337 {Enter}
return

UDP2:
Gui,Submit, Nohide
Run, cmd.exe
sleep, 666
Send, ffmpeg -re %UserInput% -vcodec %UDPvcodec2% %UDPvset2% -acodec %UDPacodec3% %UDPaset2% udp://127.0.0.1:1337 {Enter}
return

UDP3:
Gui,Submit, Nohide
Run, cmd.exe
sleep, 666
Send, ffmpeg -re %UserInput% -vcodec %UDPvcodec3% %UDPvset3% -acodec %UDPacodec2% %UDPaset3% udp://127.0.0.1:1337 {Enter}
return

UDP4:
Gui,Submit, Nohide
Run, cmd.exe
sleep, 666
Send, ffmpeg -re %UserInput% -vcodec %UDPvcodec4% %UDPvset4% -acodec %UDPacodec1% %UDPaset4% udp://127.0.0.1:1337 {Enter}
return

UDP5:
Gui,Submit, Nohide
Run, cmd.exe
sleep, 666
Send, ffmpeg -re %UserInput% -vcodec %UDPvcodec8% %UDPvset8% -acodec %UDPacodec8% %UDPaset5% udp://127.0.0.1:1337 {Enter}
return

UDP6:
Gui,Submit, Nohide
Run, cmd.exe
sleep, 666
Send, ffmpeg -re %UserInput% -vcodec %UDPvcodec7% %UDPvset7% -acodec %UDPacodec7% %UDPaset6% udp://127.0.0.1:1337 {Enter}
return

UDP7:
Gui,Submit, Nohide
Run, cmd.exe
sleep, 666
Send, ffmpeg -re %UserInput% -vcodec %UDPvcodec6% %UDPvset6% -acodec %UDPacodec6% %UDPaset7% udp://127.0.0.1:1337 {Enter}
return

UDP8:
Gui,Submit, Nohide
Run, cmd.exe
sleep, 666
Send, ffmpeg -re %UserInput% -vcodec %UDPvcodec5% %UDPvset5% -acodec %UDPacodec5% %UDPaset8% udp://127.0.0.1:1337 {Enter}
return


;Moved EnableSox down here because of GUI issues lmao idek what im doing anymore
EnableSox:
GuiControlGet, SoxVar
if SoxVar = 0
AllowSox := ""
else
AllowSox := "| sox -V1 -t raw -b 8 --encoding unsigned-integer -c 1 -r 44.1k - -b 8 --encoding unsigned-integer -c 1 -t raw - %Effect1% %FXParam1% %Effect2% %FXParam2% %Effect3% %FXParam3%"
; This transform option here allows variables within this local string
transform, AllowSox, Deref, %AllowSox%
Gui,Submit, Nohide
return


	  
F8::Send, FFmpeg %UserInput% -vcodec %Encoderchoice% -acodec %AEncoderchoice% -vf format=%Pixfmt% %EncoderSetting% | ffplay -vcodec %Decoderchoice% -acodec %ADecoderchoice% -vf format=%Pixfmtdec% %DecoderSetting% -i - {Enter}
F7::
Send, cd fUn {Enter}
Sleep 500, 
Send, "ffmglitch-Input Version.bat" {Enter}
F6:: ; TESTING CLIPBOARD SHIT
AppendMe = %clipboard%`n`n
Fileappend,%AppendMe%,fUn\output\clip.txt
return
F9::Run, fUn/ShittyWebcam.exe,,Hide ; orginally made by a friend to corrupt my streams in realtime ; sends random udp data to 127.0.0.1:1337 ; Will release sauce once we find it
F10::Process,Close, ShittyWebcam.exe
return
F11::Process,Close, ffplay.exe ; get that shit outta here
; If '%ComSpec%' doesnt work as a variable try using 'C:\Windows\system32\cmd.exe' instead
SetTitleMatchMode, 2
F12::
WinClose, %ComSpec%
return
toggle = 0
#MaxThreadsPerHotkey 2

F5:: ; Use with FFplay or pReViEw with a databent compressed video for best results. Also try having the video paused when doing so ;3
    Toggle := !Toggle
     While Toggle{
        Send, {rbutton}
        sleep 35
    }
return
$!F12:: ; Added the cmd.exe pid to the emergency exit hotkey to fix hanging processes
Process, Close, %pid%
ExitApp
return

; Be sure to close cmd.exe later.
OnExit, Exiting

; If cmd.exe exits prematurely, fall through to ExitApp below.
Process, WaitClose, %pid%

 
GuiEscape:
ButtonOK:
Exiting:
OnExit
Process, Close, %pid% ; May be a bit forceful? No effect if it already closed.
ExitApp
