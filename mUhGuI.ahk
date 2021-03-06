#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


GetFFMPEG() ;Executes if User doesnt have ffmpeg or mUhGuI in PATH env variable.
{
Gui, 14:Add, Button, x68 y65 w70 h24 gPrefer, Preferred
Gui, 14:Add, Button, x247 y65 w54 h24 gRecent, Latest
Gui, 14:Add, Text, x5 y5 w358 h27, `n           It looks like you dont have ffmpeg, pls select a version bb <3
Gui, 14:Show, w368 h96,START YOUR ENGINES!!!
Gui, 14:-Sysmenu
return

Prefer:
Gui, 14:Destroy
global FFMPegVersion = "https://ffmpeg.zeranoe.com/builds/win64/static/ffmpeg-3.3.2-win64-static.zip"
return

Recent:
Gui, 14:Destroy
global FFMPegVersion = "https://ffmpeg.zeranoe.com/builds/win64/static/ffmpeg-latest-win64-static.zip"
return
}

FileCreateDir, fUn\debug
EnvGet, CheckPathEnvVar, PATH
If !RegExMatch(CheckPathEnvVar,"(ffmpeg|mUhGuI)") ; check if PATH enviroment variable contains ffmpeg or mUhGuI
{
GetFFMPEG()
WinWaitClose, START YOUR ENGINES!!!
url = %FFMPegVersion%
SplitPath, url, name, dir, ext, name_no_ext, drive
F1=%A_ScriptDir%\%name_no_ext%.%ext%
SplashTextOn, 400, 40, ,Now downloading`n%name_no_ext%
urldownloadtofile,%url%,%f1%
SplashTextOff
msgbox, 262208,Download ,Download Complete...

runwait, %A_ScriptDir%/fUn/unzipmove.ahk ; run external ahk to perform actions to properly setup FFMpeg
}
else

Quote := chr(0x22) ; Damn Windows not letting me escape characters
ActivateBinaryVar = 0 ; NEED THIS
global GuiColor = 884488
global comb := "m|e|m|e"


;Seelect random video codec and randomize variable values for hex editing the background image.
FileDelete, %A_ScriptDir%\fUn\background.bmp
 Random, randNum, 10, 99
  Random, randNum2, 1000, 9999
   Random, randNum3, 1, 30
  Random, randNum4, 10, 99
 Random, randNum5, 1000, 9999
Array := ["msvideo1", "jpegls -pred median", "libxavs", "libvpx", "libtheora", "zmbv", "libopenjpeg", "cinepak", "utvideo", "libvpx-vp9 -tile-columns 0 -pix_fmt gbrp", "libvpx-vp9 -tile-columns 0 -pix_fmt yuv444p", "wmv2", "png", "asv1", "asv2", "vc2"]
 Random, randint, 1, % Array.MaxIndex()
  Codec := Array[randint]
   Array2 := ["%randNum2%", "%randNum%"]
  Random, randint, 1, % Array2.MaxIndex()
 RANDUMB1 := Array2[randint]
transform, RANDUMB1, Deref, %RANDUMB1%

;Make Backround via atagens "chexr" command line hex editor.
makeBack :=
(
"ffmpeg -ss %randNum3% -f lavfi -i testsrc2=s=640x360 -f avi -q:v 0 -vcodec %Codec%  -frames 1 -vf eq=contrast=-1 outpls.fuk -y && chexr outpls.fuk %randNum4% %RANDUMB1% bentpls.fuk && ffmpeg -f avi  -i bentpls.fuk %A_ScriptDir%\fUn\background.bmp -y"
)
transform, makeBack, Deref, %makeBack%
runwait, cmd.exe /c %makeBack%,,Hide, pid

RetryBackground:
ifNotExist, %A_ScriptDir%\fUn\background.bmp
   {
Random, randNum, 10, 99
Random, randNum2, 1000, 9999
Random, randNum3, 1, 30
Random, randNum4, 10, 99
Random, randNum5, 1000, 9999

Random, randint, 1, % Array.MaxIndex()
Codec := Array[randint]
Array2 := ["%randNum2%", "%randNum%"]
Random, randint, 1, % Array2.MaxIndex()
RANDUMB1 := Array2[randint]

makeBack :=
(
"ffmpeg -ss %randNum3% -f lavfi -i testsrc2=s=640x360 -f avi -q:v 0 -vcodec %Codec%  -frames 1 -vf eq=contrast=-1 outpls.fuk -y && chexr outpls.fuk %randNum4% %RANDUMB1% bentpls.fuk && ffmpeg -f avi  -i bentpls.fuk %A_ScriptDir%\fUn\background.bmp -y"
)
transform, RANDUMB1, Deref, %RANDUMB1%
transform, makeBack, Deref, %makeBack%
;;;msgbox, RETRYING`nCodec=%Codec%`nHex Target=%randNum4%`nHex Replace=%RANDUMB1% ;Display Codec and Hex Values at startup
runwait, cmd.exe /c %makeBack%,,Hide, pid
ifNotExist, %A_ScriptDir%\fUn\background.bmp
   {
    gosub, RetryBackground
   return ; need this return here for bug issues
 }
}
FileDelete, %A_ScriptDir%\outpls.fuk
FileDelete, %A_ScriptDir%\bentpls.fuk

;Make ComboBox arrays, fuk u Skitty my indentation looks pretty
ArrayListIndex := 0
 loop, read, fUn\vcodecs.txt
 {
  ArrayList%A_Index% := A_LoopReadLine
   ArrayList0 = %A_Index%
    }
     Loop,%ArrayList0%
      List .= ArrayList%A_Index%  . "|" 

       ArrayListIndex := 1
       loop, read, fUn\acodecs.txt
        {
         ArrayList%A_Index% := A_LoopReadLine
          ArrayList1 = %A_Index%
           }
            Loop,%ArrayList1%
             List2 .= ArrayList%A_Index%  . "|" 
	
              ArrayListIndex := 2
               loop, read, fUn\adecoders.txt
                {
                 ArrayList%A_Index% := A_LoopReadLine
                  ArrayList2 = %A_Index%
                   }
                    Loop,%ArrayList2%
                     List3 .= ArrayList%A_Index%  . "|" 	
	
                      ArrayListIndex := 3
                       loop, read, fUn\pixfmts.txt
                        {
                         ArrayList%A_Index% := A_LoopReadLine
                          ArrayList3 = %A_Index%
                           }
                            Loop,%ArrayList3%
                             List4 .= ArrayList%A_Index%  . "|" 		
	
                             ArrayListIndex := 4
                             loop, read, fUn\pixfmts.txt
                             {
                            ArrayList%A_Index% := A_LoopReadLine
                           ArrayList4 = %A_Index%
                          }
                         Loop,%ArrayList4%
                        List5 .= ArrayList%A_Index%  . "|" 

                       ArrayListIndex := 5
                      loop, read, fUn\vdecoders.txt
                     {
                   ArrayList%A_Index% := A_LoopReadLine
                  ArrayList5 = %A_Index%
                 }
                Loop,%ArrayList5%
               List6 .= ArrayList%A_Index%  . "|"
 
              ArrayListIndex := 6
             loop, read, fUn\soxfx.txt
            {
           ArrayList%A_Index% := A_LoopReadLine
          ArrayList6 = %A_Index%
         }
        Loop,%ArrayList6%
       List7 .= ArrayList%A_Index%  . "|"
	
      ArrayListIndex := 7
     loop, read, fUn\afilters.txt
    {
   ArrayList%A_Index% := A_LoopReadLine
  ArrayList7 = %A_Index%
 } 
Loop,%ArrayList7%
List8 .= ArrayList%A_Index%  . "|"


; if advapi32\MD5Init doesnt exist use a native Binary function instead. (For Window 10 Issues, although it seems Windows 10 supports this MD5 function now???)
data = %A_Sec%%A_Min%%A_Hour%
makefilename := MD5(data,StrLen(data))
MD5( ByRef V, L=0 ) {
 VarSetCapacity( MD5_CTX,104,0 ), DllCall( "advapi32\MD5Init", Str,MD5_CTX ) 
 DllCall( "advapi32\MD5Update", Str,MD5_CTX, Str,V, UInt,L ? L : VarSetCapacity(V) ) 
 DllCall( "advapi32\MD5Final", Str,MD5_CTX ) 
 Loop % StrLen( Hex:="123456789ABCDEF0" ) 
  N := NumGet( MD5_CTX,87+A_Index,"Char"), MD5 .= SubStr(Hex,N>>4,1) . SubStr(Hex,N&15,1)
  if ErrorLevel {
  msgbox, `n(This may be unstable)`nOh shiet you're on windows 10?`n(Or you're missing Windows MD5 shit)`nFalling back to Binary filename method.
  ;if (Var > 2) Break, BinaryPls
  ;goSub BinaryPls
  global ActivateBinaryVar = 1 ;THIS IS THE SWEET SPOT FOR ENABLING BINARY FILENAME SYSTEM, if not manually i guess.
  }
  else  
Return MD5
}

;THIS BE THE BINARY FUNCTIONZ
TxtToBin(txt) {
 Loop Parse, txt
  Loop 2
   bin := bin (Asc(A_LoopField) >> (2 - A_Index) & 1)
   StringTrimLeft, bin, bin, 10
  global makefilename = bin
Return Bin
}

;Process, Close, ffmpeg.exe ;close backgound image glitching process
Process, Close, %pid% ;close backgound image glitching process
;Process, Close, cmd.exe ;close backgound image glitching process
Process, Close, chexr.exe ;close backgound image glitching process

Gui, Color, %GuiColor%
clipboardnew = "%clipboard%" ;convert clipboard into a dynamic variable and then apply transform to start GUI with clipboard input
transform, clipboardnew, Deref, %clipboardnew%
InputBox, UserInput, m̶̨̙̖̻͉̦̅̄̈͐̐͌Ë̸̱̣̹͖͎̅̓̀̆̃͠m̶̜͓̲̀̿̍͐̚E̵̐͠, UPDATE CLIPBOARD WITH DESIRED INPUT AND RESTART...`nBackground Image Variables:`nCodec=%Codec%`nHex Target=%randNum4%`nHex Replace=%RANDUMB1%, , x400 y357 w70 h70,,,,,,-i %clipboardnew%
Gui, Add, Button, x8 y360 w38 h30  gPlayMyStream,ffplay
Gui, Add, Button, x8 y399 w38 h40 gSendMyStream,stream
Gui, Add, Button, x585 y390 w53 h22 gPreviewPls,pReViEw
Gui, Add, Button, x592 y362 w38 h22  gInput,Input
Gui, Add, ComboBox,  x478 y357 w100 h88 vDecoderchoice Choose140, %List6%
Gui, Add, ComboBox,  x378 y357 w110 h88 vEncoderchoice Choose66, %List%
Gui, Add, Text, +BackgroundTrans x404 y389 w190 h20 , Video Encoders && Decoders
Gui, Add, Text, +BackgroundTrans x122 y389 w170 h20 , Audio Decoders && Encoders
Gui, Add, ComboBox,  x200 y357 w115 h88 vADecoderchoice Choose157, %List3%
Gui, Add, ComboBox,  x110 y357 w100 h88 vAEncoderchoice Choose68, %List2%
Gui Add, Picture, x-1 y-13 w659 h340 +BackgroundTrans , %A_ScriptDir%\fUn\background.bmp
Gui Add, Picture, x-11 y-12 w659 h325 +BackgroundTrans, %A_ScriptDir%\fUn\overlay.png
Gui, Show,,WARNING!!! MAY CAUSE SEIZURES HEARING LOSS AND MENTAL ILLNESS!!! :'D ;Gui Bug Fix
Gui, +Resize +MinSize666x462 +MaxSize666x462 ;Gui Bug Fix
WinMove, WARNING!!! MAY CAUSE SEIZURES HEARING LOSS AND MENTAL ILLNESS!!! :'D,,, , 10,10 ;Gui Bug Fix
Gui, Add, Button, x326 y367 w40 h20  gSaveMe,Save
;Gui, Add, Button, x356 y367 w40 h20  gPreset,Pre
Gui, Add, Button, x302 y387 w90 h40  gChoose,[DEPRICATED]`nMore Soon
Gui, Add, Button, x325 y427 w40 h15 gLocalGlitch,LOCAL
Gui, Add, Button, x77 y361 w8 h52  gAudioAndVideoSonification,KMS
Gui, Add, Button, x32 y342 w52 h14  gMultiChannel,MULTI
Gui, Add, CheckBox, x2 y342 w10 h14 vDebugVar gEnableDebugMode, test
Gui, Add, CheckBox, x2 y330 w10 h14 vEnableCleanUpModeVar gEnableCleanUpMode, test
Gui, Add, CheckBox, x15 y330 w10 h14 vEnableBinaryVar gEnableBinaryMode, test
Gui, Add, Button, x57 y361 w8 h52  gUDPOverload,PLS
Gui, Add, Button, x97 y361 w8 h52  gSaveIt,SAVE
Gui, Add, ComboBox,  x53 y418 w68 h88 vPixfmt Choose29, %List4%
Gui, Add, ComboBox,  x578 y418 w68 h88 vPixfmtdec Choose29, %List5%
Gui, Add, Edit, x410 y409 w140 h20 vDecoderSetting,-ar 4000 -af volume=0.5
Gui, Add, Edit, x132 y409 w150 h20 vEncoderSetting,-ar 8000 -f avi -s 640x360
gosub GetPresetWindow
goto wao
Return

BinaryPls:
;DOITVAR = BinaryPls
BinArray = A,B,C,D,E,F,G,H,I,J,K,L,N,M,O,P,Q,R,S,T,U,V,W,X,Y,Z,1,2,3,4,5,6,7,8,9
Sort, BinArray, Random D,
BinStr := RegExReplace(BinArray, ",")
Text = %BinStr%
Bin := TxtToBin(Text)
makefilename := TxtToBin(Text)
return

EnableCleanUpMode:
GuiControlGet, EnableCleanUpModeVar
if (EnableCleanUpModeVar = 0) {
msgbox, Clean Up Mode Disabled!
}
else {
}
if (EnableCleanUpModeVar = 1) {
msgbox, Clean Up Mode Enabled!
}
else {
;no
}
return

MakeNewFolder:
array = A,B,C,D,E,F,G,H,I,J,K,L,N,M,O,P,Q,R,S,T,U,V,W,X,Y,Z,1,2,3,4,5,6,7,8,9
Sort, array, Random D,
mystr := RegExReplace(array, ",")
StringTrimLeft, RandyNums, mystr, 20
NewFolder := "OUTPUT/%DirectoryVal%/%RandyNums%" ;;ADDED GLOBAL HERE WARNING
transform, NewFolder, Deref, %NewFolder%
{
;WinGetPos X, Y, Width, Height, A
MaxX := A_ScreenWidth - 550
MaxY := A_ScreenHeight - 90
Splashimage,,b w600 h50 x%MaxX% y%MaxY% CWsilver m9 b fs10 zh0,New Folder Is: %NewFolder%
;msgbox, New Folder Is: %NewFolder%
sleep, 500
}
splashimage,off

return

EnableDebugMode:
GuiControlGet, DebugVar
BatchCommand := ""
transform, BatchCommand, Deref, %BatchCommand%
commandval := "msgbox, WAOOOO!!!!!!"

if (DebugVar = 0) {
BatchCommand := ""
;IsBatch := ""
msgbox, Debug Mode Disabled!
}
else {
}
if (DebugVar = 1) {
;IsBatch := "echo"
;BatchCommand := " > run.bat"
msgbox, Debug Mode Enabled!
global comb := "up|down|down|left|right|left|right|b|a|enter"
}
else {
;no
}
return

EnableBinaryMode:
GuiControlGet, EnableBinaryVar

if (EnableBinaryVar = 0) {
ActivateBinaryVar = 0
msgbox, Binary Filename Mode Disabled!
}
else {
}
if (EnableBinaryVar = 1) {
ActivateBinaryVar = 1
msgbox, Binary Filename Mode Enabled!
}
else {
;no
}
return


OpenLocation:
Destination := StrReplace(NewFolder, "/", "\")
ExpPath := "%A_ScriptDir%\%Destination%"
transform, ExpPath, Deref, %ExpPath%
if !(hWnd := WinExist(ExpPath)) ; Fixes issue with too many explorer windows being opened <3
  run, % "explorer.exe /e," ExpPath,,,pid3
else
{
  WinGet MMX, MinMax, ahk_id %hWnd%
  if (hWnd = WinExist("A"))
  WinClose, ahk_id %hWnd%
else
{
  if (MMX = -1)
      WinMaximize, ahk_id %hWnd%
  if (MMX = 1)
      WinMinimize, ahk_id %hWnd%
  if (MMX = 0)
      WinActivate, ahk_id %hWnd%

	  }
}
If (WinExist("<3"))
{
 WinWait, OUTPUT
 WinSet, AlwaysOnTop,, OUTPUT,
 sleep, 500
 WinActivate, OUTPUT
 }
return

EnableAudio:
if (AudioVar = 0) {
AttemptAudio := ""
Gui, Submit, Nohide
}
else {
AttemptAudio := "ffplay -vn %UserInput%"
transform, AttemptAudio, Deref, %AttemptAudio%
msgbox, %AttemptAudio%
}
Gui, Submit, Nohide
return

wao:
{
#IfWinActive, WARNING!!! MAY CAUSE SEIZURES HEARING LOSS AND MENTAL ILLNESS!!
~up::
Loop, parse, comb, |
{
input, var,T.900,{%a_loopfield%}
if inStr(ErrorLevel, "Timeout")
return
}
msgbox, You Must Construct Additional Pylons...
gosub pls
return
}
#IfWinActive

pls:
loop {
random, RanNumb, 1000, 999999
gui 1:color, %RanNumb%
gui 2:color, %RanNumb%
gui 3:color, %RanNumb%
gui 4:color, %RanNumb%
gui 5:color, %RanNumb%
gui 6:color, %RanNumb%
gui 7:color, %RanNumb%
gui 8:color, %RanNumb%
gui 9:color, %RanNumb%
gui 10:color, %RanNumb%
gui 11:color, %RanNumb%
gui 12:color, %RanNumb%
gui 13:color, %RanNumb%
gui wao:color, %RanNumb%
;GuiControl,,aDecSmplr8, %aDecSmplr8%
sleep, 100
}
return


SaveIt:
Gui,Submit, Nohide
Run, cmd.exe
sleep, 666
Send, ffmpeg -vcodec %Decoderchoice% -an  -i udp://127.0.0.1:1337?overrun_nonfatal=1 -vcodec ffvhuff -f avi -y fUn/ayylmao.avi -f nut - | ffplay - {Enter}
return
	  

LocalGlitch:
Gui, Submit, Nohide
SendStream := " %NewerInput% -vcodec %Encoderchoice% -acodec %AEncoderchoice% -vf format=%Pixfmt% %EncoderSetting% - | "
transform, SendStream, Deref, %SendStream%
PlayStream := "ffplay -vcodec %Decoderchoice% -acodec %ADecoderchoice% -vf format=%Pixfmtdec% %DecoderSetting% -i - "
transform, PlayStream, Deref, %PlayStream%
extension = gif
;;;AllowLoop := ""
IfInString, UserInput, %extension% ; check if file extension is gif, if so use alternate loop option
{
loopit := "-ignore_loop 0"
Run, cmd.exe /k "ffmpeg %loopit% %SendStream%%PlayStream%"
}
else {
loopit := ""
Run, cmd.exe /k "ffmpeg %loopit% %SendStream%%PlayStream%"
}
sleep, 88
AppendMePls = `nffmpeg %SendStream%%PlayStream%`n
transform, AppendMePls, Deref, %AppendMePls%
Fileappend,%AppendMePls%,fUn\debug\log.txt
return

PlayMyStream:
Gui,Submit, Nohide
PlayStream := "ffplay -vcodec %Decoderchoice% -acodec %ADecoderchoice% -vf format=%Pixfmtdec% %DecoderSetting% -i udp://127.0.0.1:1337?overrun_nonfatal=1"
transform, PlayStream, Deref, %PlayStream%
Run, cmd.exe
sleep, 666
Send, %PlayStream% {Enter}
return

SendMyStream:
Gui,Submit, Nohide
SendStream := "ffmpeg -re %UserInput% -vcodec %Encoderchoice% -acodec %AEncoderchoice% -vf format=%Pixfmt% %EncoderSetting% udp://127.0.0.1:1337"
transform, SendStream, Deref, %SendStream%
Run, cmd.exe
sleep, 666
Send, %SendStream% {Enter}
return

PreviewPls:
Gui,Submit, Nohide
extension = gif
AllowLoop := "-loop 0"
IfInString, UserInput, %extension% ; check if file extension is gif, if so use alternate loop option
{
Gui,Submit, Nohide
AllowLoop := "-ignore_loop 0"
Run, cmd.exe /k "ffplay %AllowLoop% %NewerInput%"
;newinput3 := UserInput ; this might also cause bug!!!!!!!!!!!!!!!!!!!!!!!!!!!
}
else {
Run, cmd.exe /k "ffplay %AllowLoop% %NewerInput%"
}
return

; Added native file browser, input flag and double quotes for filenames with spaces in them
Input:
Gui, Submit, Nohide
FileSelectFile, UserInput
Plusss := chr(43)
AddFFMpegInputFlagToCommand := "-i "
;UserInput := StrReplace(UserInput, "!", "{!}")
UserInput := StrReplace(UserInput, "`+", Plusss)
;UserInput := StrReplace(UserInput, "-", "{-}")
NewerInput = %AddFFMpegInputFlagToCommand%%Quote%%UserInput%%Quote%
GuiControl, 3:, aEncParam, -ss 00:00:00 ;Reset Audio Encoder Param to avoid duration conflict
GuiControl, 3:, vEncParam, -ss 00:00:00 ;Reset Video Encoder Param to avoid duration conflict
Gui, 13:Destroy ; quick fix for closing the "Sauce" input windows.
;GuiControlGet, PlsNoNewFolderVar,13:, PlsNoNewFolder
iniWrite, %PlsNoNewFolder%, Configuration.ini, NoNewFolder , PlsNoNewFolderVar ;quick fix to save a checkbox config

return

SaveMe:
AppendMe = `n%SendStream%`n%PlayStream%`n`n
transform, AppendMe, Deref, %AppendMe%
Fileappend,%AppendMe%,fUn\debug\log.txt
Gui,Submit, Nohide
msgbox, Saved to output/log.txt
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

AudioAndVideoSonification:
 {
   DirectoryVal = SonifyBatch
  gosub MakeNewFolder
FileCreateDir, OUTPUT\SonifyBatch
FileCreateDir, %NewFolder%
 }
 {
   DirectoryVal = SonifyVideo
 gosub MakeNewFolder
FileCreateDir, OUTPUT\SonifyVideo
FileCreateDir, %NewFolder%
 }

 {
   DirectoryVal = SonifyAudioBatch
  gosub MakeNewFolder
FileCreateDir, OUTPUT\SonifyAudioBatch
FileCreateDir, %NewFolder%
 }

 {
   DirectoryVal = SonifyAudio
 gosub MakeNewFolder
FileCreateDir, OUTPUT\SonifyAudio
FileCreateDir, %NewFolder%
 }
Gui,Submit, Nohide
Gui, 3:Color, %GuiColor%, -caption
Gui, 3:Add, Button, gFugvideo x302 y279 w130 h60 , fUcKiNg dO iT
; Fixed ComboBox default values
Gui, 3:Add, ComboBox, x42 y239 w130 h500 VvCompressor Choose68, %List%
Gui, 3:Add, ComboBox, x42 y199 w130 h500 VAencodercodec Choose55, %List2%
Gui, 3:Add, ComboBox, x302 y239 w130 h500 vBentAcodec Choose55, %List2%
Gui, 3:Add, ComboBox, x302 y199 w130 h500 vBentVcodec Choose68, %List%
Gui, 3:Add, Edit, x302 y259 w130 h20 vAFilters , -af flanger,flanger
Gui, 3:Add, Edit, x42 y259 w130 h20 VvFilters , -vf vflip`,hflip
; removed sample rate boxes for now
Gui, 3:Add, Edit, x42 y219 w130 h20 VaEncParam , -ss 00:00:00
Gui, 3:Add, Edit, x302 y219 w130 h20 VvEncParam, -ss 00:00:00
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
Gui, 3:Add, ComboBox, x192 y209 w90 h500 VEffect1 Choose31, %List7%
Gui, 3:Add, Edit, x182 y229 w110 h20 VFXParam1 , -n 9001
Gui, 3:Add, Text, x212 y189 w40 h20 , SOX FX
Gui, 3:Add, ComboBox, x192 y249 w90 h500 VEffect2 , %List7%
Gui, 3:Add, Edit, x182 y269 w110 h20 VFXParam2 , ;0.8 0.88 60 0.4
Gui, 3:Add, Edit, x182 y309 w110 h20 VFXParam3 , ;17
Gui, 3:Add, ComboBox, x192 y289 w90 h500 VEffect3 , %List7%
; Added Volume Slider
Gui, 3:Add, Slider, x62 y359 w100 h20 Tooltip VFugAudioVol TickInterval2 Range0-10, 1
Gui, 3:Add, Text, x2 y339 w60 h20 , Sample R8
Gui, 3:Add, Slider, x312 y339 w100 h20 Tooltip VvDecSmplr8 TickInterval2 Range666-88100, 8000
Gui, 3:Add, Slider, x312 y359 w100 h20 , 25
Gui, 3:Add, Text, x422 y339 w60 h20 , Sample R8
Gui, 3:Add, Slider, x62 y339 w100 h20 Tooltip VaDecSmplr8 TickInterva500 Range1000-199999, 44100
Gui, 3:Add, Text, x2 y359 w60 h20 , Volume
Gui, 3:Add, Text, x422 y359 w60 h20 , Volume
Gui, 3:Add, Button, x2 y142 w40 h35 gPLSBATCH2, batch
Gui, 3:Add, Button, x2 y177 w40 h22 gSaveFugAudio,Save
Gui, 3:Add, Button, x432 y177 w40 h22 gSaveFugVideo,Save
Gui, 3:Add, Button, x197 y137 w65 h20 gGetResolution, Get Res
Gui, 3:Add, Edit, x197 y159 w80 h20 VGlobalRes , -s 640x360
Gui, 3:Add, Button, x264 y137 w13 h13 gSwapRes,
Gui, 3:Add, Button, x432 y142 w40 h35 gPLSBATCH, batch
Gui, 3:Add, Checkbox, right x412 y115 w60 h23 0x80 vBatchMatchResVar, Match Res?
Gui, 3:Add, Checkbox, right x396 y90 h23 0x80 vFullSCreenVar gIsFullscreen, Fullscreen?
Gui, 3:Add, GroupBox, x12 y9 w440 h60 , *notices GUI* oWo Wats This?~
Gui, 3:Add, Text, x32 y29 w410 h30 , Pretty much a groovy way to kinda trick ffmpeg to sonify video`, compress audio data with video codecs`, process audio with video effects`, etc in real time... (and with SOX)
Gui, 3:Add, Button, x282 y249 w10 h20 , ?
Gui, 3:Add, Button, x182 y249 w10 h20 gFrei0rPreset1, ?
; Added Channel Count
Gui, 3:Add, ComboBox, x2 y319 w40 h200 vChanCount2 Choose2, 1|2|3|4|5||6|7|8|9|10|11|12|13|14|15|16|17|18|19|20
Gui, 3:Add, ComboBox, x2 y299 w40 h200 vChanCount1 Choose2, 1|2|3|4|5||6|7|8|9|10|11|12|13|14|15|16|17|18|19|20
Gui, 3:Add, ComboBox, x432 y299 w40 h200 vChanCount4 Choose3, 1|2|3|4|5||6|7|8|9|10|11|12|13|14|15|16|17|18|19|20
Gui, 3:Add, ComboBox, x432 y319 w40 h200 vChanCount3 Choose3, 1|2|3|4|5||6|7|8|9|10|11|12|13|14|15|16|17|18|19|20
;Added Checkbox for SOX
Gui, 3:Add, Checkbox, x195 y330 w102 h12 vSoxVar gEnableSox, Enable Sox?
Gui, 3:Add, Checkbox, x195 y342 w102 h12 vNibbleVar gEnableNibble, Reverse Nibbles? 
Gui, 3:Add, Checkbox, x195 y354 w102 h12 vBitVar gEnableBits, Reverse Bits?
Gui, 3:Add, Button, gBack2 x2 y379 w470 h10 , bAcKBaCkbAcKBacKbAcKBaCkbAcKBaCkbAcKBacKbAcKBaCkbAcKBaCkbAcKBacKbAcK
Gui, 3:Add, GroupBox, x192 y122 w90 h65 , Global Resolution
Gui, 3:Add, ComboBox, x177 y99 h500 vLePixFmtIn Choose4, %list4%
Gui, 3:Add, ComboBox, x177 y77 h500 vLePixFmtOut Choose4, %list4%
Gui, 3:Show, x328 y144 h395 w477, ITSHAPPENINGITSHAPPENINGITSHAPPENINGITSHAPPENINGITSHAPPENINGITSHAPPENINGITSHAPPENING
Gui, 3:-Sysmenu
Gui, 1:Hide
gosub GetPresetWindow
Return

Frei0rPreset1:
Gui, Submit, Nohide
GuiControl,, vFilters, -vf frei0r=pixeliz0r:0.002:0.002
return

Inputv:
DirectoryVal = SonifyVideo
iniRead, NoNewFolder, Configuration.ini, NoNewFolder, PlsNoNewFolderVar
IsNewFolder = MakeNewFolder
if (NoNewFolder = 1) 
{
IsNewFolder = no
}

gosub %IsNewFolder%

FileCreateDir, OUTPUT\SonifyVideo
FileCreateDir, %NewFolder%


Gui, Submit, Nohide
clipboardnew = -i "%clipboard%" ;convert clipboard into a dynamic variable and then apply transform to start GUI with clipboard input
transform, clipboardnew, Deref, %clipboardnew%
Gui, 13:Add, Edit, x5 y36 w358 h24 vInputVvar, %clipboardnew%
Gui, 13:Add, Button, x68 y65 w70 h24 gInput, Select File
Gui, 13:Add, Button, x247 y65 w54 h24 gDefaultInputV, Default
Gui, 13:Add, Checkbox, x145 y65 vPlsNoNewFolder,Disable`nNew Folder
GuiControl, 13:, PlsNoNewFolder, %NoNewFolder%
Gui, 13:Add, Text, x5 y5 w358 h27, Pls Use -i And Enter Input File Path 4 Now...
OnMessage(0x100, "OnKeyDown")
OnKeyDown(wParam)
{
if (A_Gui = 13 && wParam = 13) ;Close GUI after hitting ENTER Key 
{
 Gui, Submit, Nohide
 GuiControlGet, InputVvar
 GuiControlGet, IsANewFolder,13:, PlsNoNewFolder
 global NewerInput = InputVvar
iniWrite, %IsANewFolder%, Configuration.ini, NoNewFolder , PlsNoNewFolderVar ;quick fix to save a checkbox config
 Gui, 13:Destroy
}
}
Gui, 13:Show, w368 h96,
Return

DefaultInputV:
Gui, Submit, Nohide
GuiControl,, InputVvar, -f lavfi -i testsrc2=s=640x360
iniWrite, %PlsNoNewFolder%, Configuration.ini, NoNewFolder , PlsNoNewFolderVar ;quick fix to save a checkbox config
Return

Inputa:
Gui, Submit, Nohide
DirectoryVal = SonifyAudio
iniRead, NoNewFolder, Configuration.ini, NoNewFolder, PlsNoNewFolderVar
IsNewFolder = MakeNewFolder
if (NoNewFolder = 1) 
{
IsNewFolder = no
}

gosub %IsNewFolder%
FileCreateDir, OUTPUT\SonifyAudio
FileCreateDir, %NewFolder%

Gui, Submit, Nohide
clipboardnew = -i "%clipboard%" ;convert clipboard into a dynamic variable and then apply transform to start GUI with clipboard input
transform, clipboardnew, Deref, %clipboardnew%
Gui, 13:Add, Edit, x5 y36 w358 h24 vInputAvar, %clipboardnew%
Gui, 13:Add, Button, x68 y65 w70 h24 gInput, Select File
Gui, 13:Add, Button, x247 y65 w54 h24 gDefaultInputA, Default
Gui, 13:Add, Checkbox, x145 y65 vPlsNoNewFolder,Disable`nNew Folder
GuiControl, 13:, PlsNoNewFolder, %NoNewFolder%
Gui, 13:Add, Text, x5 y5 w358 h27, Pls Use -i And Enter Input File Path 4 Now...
OnMessage(0x100, "OnKeyDown2")
OnKeyDown2(wParam)
{
if (A_Gui = 13 && wParam = 13) ;Close GUI after hitting ENTER Key 
{
 Gui, Submit, Nohide
 GuiControlGet, InputAvar
  GuiControlGet, IsANewFolder,13:, PlsNoNewFolder
 global NewerInput = InputAvar
iniWrite, %IsANewFolder%, Configuration.ini, NoNewFolder , PlsNoNewFolderVar ;quick fix to save a checkbox config
 Gui, 13:Destroy
}
}
Gui, Submit, Nohide
Gui, 13:Show, w368 h96
Return

DefaultInputA:
Gui, Submit, Nohide
GuiControl,, InputAvar, -f lavfi -i "sine=frequency=55:sample_rate=888:duration=30"
Return

Back2:
Gui, 1:Show
Gui, 3:Destroy
gosub, GetPresetWindow
Return

UDPOverload:
Gui, 2:Color, %GuiColor%, -caption
Gui, 2:Add, Button, gBack x2 y16 w20 h410 , bAcKBaCkbAcKBacKbAcKBaCkbAcKBaCkbAcKBacKbAcKBaCkbAcKBaCkbAcKBacKbAcKBaCk
Gui, 2:Add, Button, gUDP4 x442 y9 w90 h30 , DO IT
Gui, 2:Add, Button, gUDP3 x332 y9 w90 h30 , DO IT
Gui, 2:Add, Button, gUDP2 x222 y9 w90 h30 , DO IT
Gui, 2:Add, Button, gUDP1 x112 y9 w90 h30 , DO IT
Gui, 2:Add, Edit, x332 y39 w90 h20 vUDPvset3, -b:v 8888 -f avi
Gui, 2:Add, Edit, x222 y39 w90 h20 vUDPvset2, -b:v 8888 -f avi
Gui, 2:Add, Edit, x112 y39 w90 h20 vUDPvset1, -b:v 8888 -f avi
Gui, 2:Add, Edit, x442 y39 w90 h20 vUDPvset4, -b:v 8888 -f avi
Gui, 2:Add, ComboBox, x112 y59 w90 h20 vUDPvcodec1 Choose9, %List%
Gui, 2:Add, ComboBox, x222 y59 w90 h21 vUDPvcodec2 Choose10, %List%
Gui, 2:Add, ComboBox, x332 y59 w90 h21 vUDPvcodec3 Choose11, %List%
Gui, 2:Add, ComboBox, x442 y59 w90 h21 vUDPvcodec4 Choose12, %List%
Gui, 2:Add, Edit, x442 y79 w90 h20 vUDPaset4, -af volume=0.5
Gui, 2:Add, ComboBox, x442 y99 w90 h21 vUDPacodec1 Choose17, %List2%
Gui, 2:Add, Edit, x332 y79 w90 h20 vUDPaset3, -af volume=0.5
Gui, 2:Add, ComboBox, x332 y99 w90 h21 vUDPacodec2 Choose18, %List2%
Gui, 2:Add, Edit, x222 y79 w90 h20 vUDPaset2, -af volume=0.5
Gui, 2:Add, ComboBox, x222 y99 w90 h21 vUDPacodec3 Choose19, %List2%
Gui, 2:Add, Edit, x112 y79 w90 h20 vUDPaset1, -af volume=0.5
Gui, 2:Add, ComboBox, x112 y99 w90 h21 vUDPacodec4 Choose20, %List2%
Gui, 2:Add, Button, gUDP8 x442 y149 w90 h30 , DO IT
Gui, 2:Add, Button, gUDP7 x332 y149 w90 h30 , DO IT
Gui, 2:Add, Button, gUDP6 x222 y149 w90 h30 , DO IT
Gui, 2:Add, Button, gUDP5 x112 y149 w90 h30 , DO IT
Gui, 2:Add, Edit, x442 y179 w90 h20 vUDPvset5, -b:v 8888 -f avi
Gui, 2:Add, ComboBox, x442 y199 w90 h20 vUDPvcodec5 Choose13, %List%
Gui, 2:Add, Edit, x442 y219 w90 h20 vUDPaset8, -af volume=0.5
Gui, 2:Add, ComboBox, x442 y239 w90 h21 vUDPacodec5 Choose20, %List2%
Gui, 2:Add, Edit, x332 y179 w90 h20 vUDPvset6, -b:v 8888 -f avi
Gui, 2:Add, ComboBox, x332 y199 w90 h21 vUDPvcodec6 Choose14, %List%
Gui, 2:Add, Edit, x332 y219 w90 h20 vUDPaset7, -af volume=0.5
Gui, 2:Add, ComboBox, x332 y239 w90 h21 vUDPacodec6 Choose20, %List2%
Gui, 2:Add, Edit, x222 y179 w90 h20 vUDPvset7, -b:v 8888 -f avi
Gui, 2:Add, Edit, x222 y219 w90 h20 vUDPaset6, -af volume=0.5
Gui, 2:Add, ComboBox, x222 y199 w90 h21 vUDPvcodec7 Choose15, %List%
Gui, 2:Add, ComboBox, x222 y239 w90 h21 vUDPacodec7 Choose20, %List2%
Gui, 2:Add, Edit, x112 y179 w90 h20 vUDPvset8, -b:v 8888 -f avi
Gui, 2:Add, ComboBox, x112 y199 w90 h21 vUDPvcodec8 Choose16, %List%
Gui, 2:Add, Edit, x112 y219 w90 h20 vUDPaset5, -af volume=0.5
Gui, 2:Add, ComboBox, x112 y239 w90 h20 vUDPacodec8 Choose20, %List2%
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


EnableNibble:
Gui, Submit, Nohide
GuiControlGet, NibbleVar
if (NibbleVar = 0) {
GibNibble =
}
else {
}
if (NibbleVar = 1) {
GibNibble = --reverse-nibbles
}
else {
;no
}
return

EnableBits:
Gui, Submit, Nohide
GuiControlGet, BitVar
if (BitVar = 0) {
GibBit =
}
else {
}
if (BitVar = 1) {
GibBit = --reverse-bits
}
else {
;no
}
return


EnableSox:
GuiControlGet, SoxVar
if SoxVar = 0
AllowSox := ""
else
AllowSox := "| sox -V1 -t raw -b 8 --encoding unsigned-integer -c 1 -r 44.1k - -b 8 --encoding unsigned-integer -c 1 -t raw %GibNibble% %GibBit% - %Effect1% %FXParam1% %Effect2% %FXParam2% %Effect3% %FXParam3%"
; This transform option here allows variables within this local string
transform, AllowSox, Deref, %AllowSox%
Gui,Submit, Nohide
return


FugVideo:
Gui, Submit, Nohide
extension = gif
NewerInput := StrReplace(NewerInput, "{!}", "!")
IfInString, NewerInput, %extension% ; check if file extension is gif, if so use alternate loop option
{
loopit := "-ignore_loop 0"
}
else {
loopit := ""
}
gosub EnableSox
gosub, EnableSox ;DONT FORGET ABOUT THESE HANDY FUNCTIONS, FIXED CHECKBOX BUG
transform, AllowSox, Deref, %AllowSox%
Run, %ComSpec%,,,pid2
sleep, 666
Sendraw, ffmpeg %loopit% %NewerInput% %vEncParam% -f rawvideo -c:v %BentVcodec% -pix_fmt %LePixFmtIn% %GlobalRes% - %AllowSox% | ffmpeg %InputFmt% -ar %vDecSmplr8% -ac %ChanCount4% -i - %GlobalRes% -codec %BentAcodec% %AFilters% %OutputFmt% -ac %ChanCount3% -ar %vDecSmplr8% - | ffplay -f rawvideo %GlobalRes% -pix_fmt %LePixFmtOut% -i - %IsFS%
sleep, 60
Send, {Enter}
return

SaveFugVideo:
Gui,Submit, Nohide
gosub EnableSox
data = %A_Sec%%A_Min%%A_Hour%
makefilename := MD5(data,StrLen(data))
;NewerInput := StrReplace(NewerInput, "{+}", "+") ;OLD METHOD
sfv := "ffmpeg %NewerInput% %vEncParam% -f rawvideo -c:v %BentVcodec% -pix_fmt %LePixFmtIn% %GlobalRes% - %AllowSox% | ffmpeg %InputFmt% -ar %vDecSmplr8% -ac %ChanCount4%  -i - %GlobalRes% -codec %BentAcodec% %AFilters% %OutputFmt% -ac %ChanCount3% -ar %vDecSmplr8% - | ffmpeg -f rawvideo %GlobalRes% -pix_fmt %LePixFmtOut% -i - -c:v h263p -q:v 0 -y %NewFolder%/%makefilename%.avi %NewFolder%/%makefilename%.gif"
if NewerInput contains png,jpg,bmp,tiff,jpeg,targa,xwd
{
msgbox, Image Input Detected!
transform, AllowSox, Deref, %AllowSox%
sfv := "ffmpeg %NewerInput% %vEncParam% -f rawvideo -c:v %BentVcodec% -pix_fmt %LePixFmtIn% %GlobalRes% - %AllowSox% | ffmpeg %InputFmt% -ar %vDecSmplr8% -ac %ChanCount4%  -i - %GlobalRes% -codec %BentAcodec% %AFilters% %OutputFmt% -ac %ChanCount3% -ar %vDecSmplr8% - | ffmpeg -f rawvideo %GlobalRes% -pix_fmt %LePixFmtOut% -i - -y %NewFolder%/%makefilename%.bmp"
}
else

transform, AllowSox, Deref, %AllowSox%
transform, sfv, Deref, %sfv%
;Gui,Submit, Nohide
Runwait, %ComSpec% /c %sfv%,,,pid2
AppendMe1 = %sfv%`n`n
Fileappend,%AppendMe1%,fUn\debug\log.txt
gosub OpenLocation
return

PLSRESBB:
	  ;msgbox, fuckme it worked
         ffprobe := "ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 %ALF% | clip"
		 transform, ffprobe, Deref, %ffprobe%
		 runwait, %ComSpec% /c %ffprobe%
		 StringReplace, clipboard, clipboard, `r`n, %A_Space%, All ;Remove linebreak from clipboard
		 NewRes = `-s %clipboard%
		 transform, NewRes, Deref, %NewRes%
		 Return

PLSRESBB2:
	  ;msgbox, fuckme it worked
         ffprobe := "ffprobe %aEncParam% -i %Quote%%ALF%%Quote% -show_entries format=duration -v quiet -of csv=s=x:p=0 | clip"
		 transform, ffprobe, Deref, %ffprobe%
		 msgbox, %ffprobe%
		 runwait, %ComSpec% /c %ffprobe%
		 StringReplace, clipboard, clipboard, `r`n, %A_Space%, All ;Remove linebreak from clipboard
		 Duration := clipboard
		 size := (Duration*705)
		 msgbox, %size% Size!
		 width := (size/24)
		 width := floor(width)
		 msgbox, %width% Width!
		 height = 1000
		 NewRes = `-s %width%x%height%
		 transform, NewRes, Deref, %NewRes%
		 msgbox, %NewRes% New
		 Return

PLSBATCH:
Gui,Submit, Nohide
if (BatchMatchResVar = 0) {
NewRes = %GlobalRes%
transform, NewRes, Deref, %NewRes%
MatchRes = no
}
if (BatchMatchResVar = 1) {
MatchRes = PLSRESBB
msgbox, Matching input/output resolution with original files!
PercentVar = `%
}
else
#EscapeChar `
PercentVar = `%

Gui, Submit, Nohide
DirectoryVal = SonifyBatch
gosub MakeNewFolder

FileCreateDir, OUTPUT\SonifyBatch
FileCreateDir, %NewFolder%

Percent = `%
FileSelectFolder, leFolder,,3 ; select the input folder
if errorlevel {
msgbox, You Didnt Select Anything lol
return
}
gosub EnableSox
data = %A_Sec%%A_Min%%A_Hour%
makefilename := MD5(data,StrLen(data))

;ButtonCancel:
;GuiEsscape:
;Gui, hide
;return

   Loop,%leFolder%\*.*,0,1
      {
	global ALF = A_LoopFileFullPath
	  SplitPath, ALF, name, dir, ext, name_no_ext, drive
	  transform, ALF, Deref, %ALF%
	  If RegExMatch(ext,"(jpg|png|tiff|targa|xwd|bmp|tga|jpeg|apng|svg|pdf|txt)")
	     {
         gosub %MatchRes%
		 ;msgbox, IMAGE INPUT DETECTED :0
		 global ext = ext

		 BatchCommand := "ffmpeg -i %ALF% %vEncParam% -f rawvideo -c:v %BentVcodec% -pix_fmt %LePixFmtIn% -frames 1 %NewRes% - %AllowSox% | ffmpeg %InputFmt% -ar %vDecSmplr8% -ac %ChanCount4%  -i - %NewRes% -codec %BentAcodec% %AFilters% %OutputFmt% -ac %ChanCount3% -ar %vDecSmplr8% - | ffmpeg -f rawvideo %NewRes% -pix_fmt %LePixFmtOut% -i - -y %Quote%%A_ScriptDir%/%NewFolder%/%name_no_ext%.bmp%Quote%"
		 transform, ALF, Deref, %ALF%
         transform, AllowSox, Deref, %AllowSox%
         transform, BatchCommand, Deref, %BatchCommand%

		 Splashimage,,b w600 h50 x100 Y400 CWsilver m9 b fs10 zh0,Sonifying Image...`n%name_no_ext%
		 runwait,%comspec% /c %BatchCommand%
		  
		 AppendMe1 = %BatchCommand%`n`n
         Fileappend,%AppendMe1%,fUn\debug\log.txt
		 Splashimage,off
		 }
  	  If RegExMatch(ext,"(webm|gif|avi|nut|mkv|wmv)")
	  {
         gosub %MatchRes%
		 global ext = ext

		 BatchCommand := "ffmpeg -i %ALF% %vEncParam% -f rawvideo -c:v %BentVcodec% -pix_fmt %LePixFmtIn% %NewRes% - %AllowSox% | ffmpeg %InputFmt% -ar %vDecSmplr8% -ac %ChanCount4%  -i - %NewRes% -codec %BentAcodec% %AFilters% %OutputFmt% -ac %ChanCount3% -ar %vDecSmplr8% - | ffmpeg -f rawvideo %NewRes% -pix_fmt %LePixFmtOut% -i - -y %Quote%%A_ScriptDir%/%NewFolder%/%name_no_ext%.%ext%%Quote%"
		 transform, ALF, Deref, %ALF%
         transform, AllowSox, Deref, %AllowSox%
         transform, BatchCommand, Deref, %BatchCommand%
	 
		 Splashimage,,b w600 h50 x100 Y400 CWsilver m9 b fs10 zh0,Sonifying Video...`n%name_no_ext%
		 runwait,%comspec% /c %BatchCommand%
		  
		 AppendMe1 = %BatchCommand%`n`n
         Fileappend,%AppendMe1%,fUn\debug\log.txt
		 Splashimage,off
	  }	 	 
	  }
	 if ErrorLevel {
	 msgbox, fuck you did it now, didnt you?
	 }
gosub OpenLocation
return

PLSBATCH2:
Gui,Submit, Nohide
if (BatchMatchResVar = 0) {
NewRes = %GlobalRes%
transform, NewRes, Deref, %NewRes%
MatchRes = no
}
if (BatchMatchResVar = 1) {
MatchRes = PLSRESBB2
msgbox, Matching input/output resolution with original files!
PercentVar = `%
}
else
#EscapeChar `
PercentVar = `%

Gui, Submit, Nohide
DirectoryVal = SonifyAudioBatch
gosub MakeNewFolder

FileCreateDir, OUTPUT\%DirectoryVal%
FileCreateDir, %NewFolder%

Percent = `%
FileSelectFolder, leFolder,,3 ; select the input folder
if errorlevel {
msgbox, You Didnt Select Anything lol
return
}
gosub EnableSox
data = %A_Sec%%A_Min%%A_Hour%
makefilename := MD5(data,StrLen(data))

;ButtonCancel:
;GuiEsscape:
;Gui, hide
;return

   Loop,%leFolder%\*.*,0,1
      {
	global ALF = A_LoopFileFullPath
	  SplitPath, ALF, name, dir, ext, name_no_ext, drive
	  transform, ALF, Deref, %ALF%
	  If RegExMatch(ext,"(flac|aic|ogg|wav|mp2|mp3|mp4|avi|nut)")
	     {
         gosub %MatchRes%
		 ;msgbox, AUDIO INPUT DETECTED :0
		 global ext = ext
Gui, Submit, Nohide
         BatchCommand := "ffmpeg -i %Quote%%ALF%%Quote% -acodec %Aencodercodec% %aEncParam% %EncFmt% -ac %ChanCount1% -ar %aDecSmplr8% - | ffmpeg -f rawvideo %NewRes% -pix_fmt %LePixFmtIn% -i - -vcodec %VCompressor% %NewRes% %VFilters% -f rawvideo -pix_fmt %LePixFmtOut% - | ffmpeg -ar %aDecSmplr8% %DecFmt% -ac %ChanCount2% -i - -af volume=%FugAudioVol% -y %Quote%%A_ScriptDir%/%NewFolder%/%name_no_ext%.mp3%Quote%"
		 transform, ALF, Deref, %ALF%
         transform, AllowSox, Deref, %AllowSox%
         transform, BatchCommand, Deref, %BatchCommand%

		 Splashimage,,b w600 h50 x100 Y400 CWsilver m9 b fs10 zh0,Sonifying Image...`n%name_no_ext%
		 runwait,%comspec% /c %BatchCommand%
		  
		 AppendMe1 = %BatchCommand%`n`n
         Fileappend,%AppendMe1%,fUn\debug\log.txt
		 Splashimage,off
		 }
  	  If RegExMatch(ext,"(u8|s8|u16le|u16be|s16le|s16be|u32le|u32be|s32le|s32be)")
	  {
	  msgbox, testing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	  return
         gosub %MatchRes%
		 global ext = ext

         BatchCommand := "ffmpeg -i %Quote%%ALF%%Quote% -acodec %Aencodercodec% %aEncParam% %EncFmt% -ac %ChanCount1% -ar %aDecSmplr8% - | ffmpeg -f rawvideo %NewRes% -pix_fmt %LePixFmtIn% -i - -vcodec %VCompressor% %NewRes% %VFilters% -f rawvideo -pix_fmt %LePixFmtOut% - | ffmpeg -ar %aDecSmplr8% %DecFmt% -ac %ChanCount2% -i - -af volume=%FugAudioVol% -y %Quote%%A_ScriptDir%/%NewFolder%/%name_no_ext%.mp3%Quote%"
		 transform, ALF, Deref, %ALF%
         transform, AllowSox, Deref, %AllowSox%
         transform, BatchCommand, Deref, %BatchCommand%
	 
		 Splashimage,,b w600 h50 x100 Y400 CWsilver m9 b fs10 zh0,Sonifying Video...`n%name_no_ext%
		 runwait,%comspec% /c %BatchCommand%
		  
		 AppendMe1 = %BatchCommand%`n`n
         Fileappend,%AppendMe1%,fUn\debug\log.txt
		 Splashimage,off
	  }	 	 
	  }
	 if ErrorLevel {
	 msgbox, fuck you did it now, didnt you?
	 }
gosub OpenLocation
return


FugAudio:
Gui,Submit, Nohide
Run, cmd.exe
sleep, 666
Send, ffmpeg %aEncParam% %NewerInput% -acodec %Aencodercodec% %EncFmt% -ac %ChanCount1% -ar %aDecSmplr8% - | ffmpeg -f rawvideo %GlobalRes% -pix_fmt %LePixFmtIn% -i - -vcodec %VCompressor% %GlobalRes% %VFilters% -f rawvideo -pix_fmt %LePixFmtOut% - | ffplay -ar %aDecSmplr8% %DecFmt% -ac %ChanCount2% -i - -af volume=%FugAudioVol% {Enter}
return

SaveFugAudio:
Gui,Submit, Nohide
data = %A_Sec%%A_Min%%A_Hour%
makefilename := MD5(data,StrLen(data))
;NewerInput := StrReplace(NewerInput, "{+}", "+")
sfa := "ffmpeg %aEncParam% %NewerInput% -acodec %Aencodercodec% %EncFmt% -ac %ChanCount1% -ar %aDecSmplr8% - | ffmpeg -f rawvideo %GlobalRes% -pix_fmt %LePixFmtIn% -i - -vcodec %VCompressor% %GlobalRes% %VFilters% -f rawvideo -pix_fmt %LePixFmtOut% - | ffmpeg -ar %aDecSmplr8% %DecFmt% -ac %ChanCount2% -i - -af volume=%FugAudioVol% -y %NewFolder%/%makefilename%.wav"
transform, sfa, Deref, %sfa%
Runwait, %ComSpec% /c %sfa%,,,pid2
AppendMe = %sfa%`n`n
Fileappend,%AppendMe%,fUn\debug\log.txt
Process, Close, %pid3%
gosub OpenLocation
return

IsFullscreen:
if (FullScreenVar = 1)
{
IsFS =
}

if (FullScreenVar = 0)
{
IsFS = -fs
}
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



MultiChannel:
GuiControlGet, DebugVar ; FIXES THE BATCH ENABLE BUG
Gui, 4:Color, %GuiColor%, -caption
Gui 4:Add, Button, x80 y24 w15 h89 gBack3, back
Gui 4:Add, Button, x80 y5 w15 h15 gExitMulti, x
Gui 4:Add, Radio, x4 y5 w75 h23 g3chan, 3 Channel
Gui 4:Add, Radio, x4 y28 w75 h23 g4chan, 4 Channel
Gui 4:Add, Radio, x4 y51 w75 h23 g6Chan, 6 Channel
Gui 4:Add, Radio, x4 y74 w75 h23 g8Chan, 8 Channel
Gui 4:Add, Radio, x4 y97 w75 h23 g12Chan, 1̶2̶ ̶C̶h̶a̶n̶n̶e̶l̶
Gui 4:Add, Radio, x4 y120 w75 h23 g16Chan, 1̶6̶ ̶C̶h̶a̶n̶n̶e̶l̶
Gui 4:Show, w100 h147, Pick Your Poison <3
Gui, 4:-Sysmenu
Return

ExitMulti:
Gui, 1:Show
Gui, 4:Destroy
Gui, 5:Destroy
Gui, 6:Destroy
Gui, 7:Destroy
Gui, 8:Destroy
Gui, 9:Destroy
Gui, 10:Destroy
Gui, 11:Destroy
Gui, 12:Destroy
Return



;========================================================================

3Chan:
;Start this tab with default channel layout, see Shuffle
3ChLayout0 = 3
3ChLayout1 = FL
3ChLayout2 = FR
3ChLayout3 = LFE
;
Gui, 10:Color, %GuiColor%, -caption
Gui 10:Add, Button, x139 y245 w110 h42 gDo3Chan, COMMENCE MAGIC
Gui 10:Add, Button, x139 y287 w44 h23 gSave3ChPls, SAVE
Gui 10:Add, Button, x183 y287 w66 h23 g3ChInput, INPUT
Gui 10:Add, ComboBox, x8 y8 w120 vCh1af Choose47, %List8%
Gui 10:Add, ComboBox, x8 y32 w120 Choose20 vCh2af, %List8%
Gui 10:Add, ComboBox, x8 y56 w120 Choose20 vCh3af, %List8%
Gui 10:Add, Edit, x128 y8 w120 h21 vCh1afVal, 0.1:1:1:1:0.01:0.1
Gui 10:Add, Edit, x128 y32 w120 h21 vCh2afVal
Gui 10:Add, Edit, x128 y56 w120 h21 vCh3afVal
;;Gui 10:Add, Edit, x128 y104 w120 h21 vCh5afVal
;;Gui 10:Add, Edit, x128 y128 w120 h21 vCh6afVal
Gui 10:Add, ComboBox, x11 y284 w120 vPixFmtIn Choose4, %list4%
Gui 10:Add, ComboBox, x11 y260 w120 vPixFmtOut Choose4, %list4%
Gui 10:Add, Button, x154 y222 w80 h23 gRender3Chan, RENDER
Gui 10:Add, GroupBox, x30 y183 w84 h56, Resolution
Gui 10:Add, Edit, x39 y210 w66 h24 v3ChanRes, -s 640x360
Gui 10:Add, GroupBox, x5 y241 w132 h69, In/Out Colorspace
Gui 10:Add, GroupBox, x71 y137 w58 h46, Framerate
Gui 10:Add, GroupBox, x7 y137 w58 h46, Format
Gui 10:Add, Edit, x16 y156 w39 h22 v3ChanFmt, -f u8
Gui 10:Add, Edit, x81 y156 w39 h21 v3ChanFR, -r 24
Gui 10:Add, Slider, x-2 y86 w262 h28 +0x40 +Tooltip Range666-88100 v3ChanSR8, 8000
Gui, 10:Add, button, x185 y210 w12 h12 v3chShuffleVar gShuffle3ch,
Gui, 10:Add, button, x205 y210 w12 h12 v3chGetResVar gGetResolution,
Gui, 10:Add, button, x165 y210 w12 h12 vLocationVar gOpenLocation,
Gui, 10:Add, Checkbox, x144 y140 w102 h12 vLoopVar gEnableLoop, Enable Loop?
Gui, 10:Add, Checkbox, x144 y152 w102 h12 vAudioVar gEnableAudio, "Sync" Audio?
GuiControl, 10:Disable, AudioVar
Gui 10:Add, CheckBox, x144 y164 w102 h12 vFrameVar, Save Frames?
Gui 10:Add, CheckBox, x144 y176 w102 h12, idk?
Gui 10:Show, w256 h317, <3 <3 <3
Return

3ChInput:
DirectoryVal = MultiChannel
gosub MakeNewFolder

FileCreateDir, OUTPUT\MultiChannel
FileCreateDir, %NewFolder%\frames

gosub, Input
AllowLoop := ""
Gui,Submit, Nohide
return

Do3Chan:
Gui,Submit, Nohide ; put submit here first
Do3Ch := 
(
"ffmpeg %3ChanFmt% -ar %3ChanSR8% -ac 1 -i %NewFolder%/c-1.meme %3ChanFmt% -ar %3ChanSR8% -ac 1 -i %NewFolder%/c-2.meme %3ChanFmt% -ar %3ChanSR8% -ac 1 -i %NewFolder%/c-3.meme ^
-filter_complex %Quote%[0:a]%Ch1af%=%Ch1afVal%[ch1];[1:a]%Ch2af%=%Ch2afVal%[ch2];[2:a]%Ch3af%=%Ch3afVal%[ch3];[ch1][ch2][ch3]join=inputs=3:channel_layout=2.1:map=0.0-%3ChLayout1%|1.0-%3ChLayout2%|2.0-%3ChLayout3%:[a]%Quote% -map [a] %3ChanFmt% -ar %3ChanSR8% -ac 3 - | ffplay -f rawvideo -pix_fmt %PixFmtOut% %3ChanRes% -i - -fs "
)
if (DebugVar = 0) {
transform, Do3Ch, Deref, %Do3ch%
Run, cmd.exe
sleep, 666
Send, %Do3Ch%
Sleep, 88
Send {Enter}
sleep, 100
AppendMePls = `n`n%Do3Ch%`n`n
transform, AppendMePls, Deref, %AppendMePls%
Fileappend,%AppendMePls%,fUn\debug\log.txt
Gui,Submit, Nohide
}
else {
;msgbox, wao2 %DebugVar%
}
if (DebugVar = 1) {
transform, Do3Ch, Deref, %Do3Ch%
FileDelete, fUn\debug\runme.bat
;Fileappend,%Do3Ch%,fUn\debug\runme.bat
file := FileOpen( "fUn\debug\poop.bat", 1)
file.Write(Do3Ch)
file.Close()
sleep, 100
Run, cmd.exe /k fUn\debug\poop.bat
}
else {
;no
}
Return


Render3Chan:
gosub, EnableLoop
Gui,Submit, Nohide
GuiControlGet, LoopVar
3ChanRender := 
(
"ffmpeg %AllowLoop% %newinput3% -f rawvideo -pix_fmt %PixFmtIn% %3ChanRes% %3ChanFR% -y %NewFolder%/output.raw && ^
ffmpeg %3ChanFmt% -ar %3ChanSR8% -ac 3 -i %NewFolder%/output.raw -y ^
-filter_complex %Quote%channelsplit=channel_layout=2.1[1][2][3]%Quote% ^
-map %Quote%[1]%Quote% %3ChanFmt% -ar %3ChanSR8% -ac 1 %NewFolder%/c-1.meme ^
-map %Quote%[2]%Quote% %3ChanFmt% -ar %3ChanSR8% -ac 1 %NewFolder%/c-2.meme ^
-map %Quote%[3]%Quote% %3ChanFmt% -ar %3ChanSR8% -ac 1 %NewFolder%/c-3.meme"
)
if (DebugVar = 0) {
transform, 3ChanRender, Deref, %3ChanRender%
Run, cmd.exe
Sleep, 88
Sendraw, %3ChanRender%
Sleep, 88
Send, {Enter}
sleep, 100
AppendMePls = `n`n%3ChanRender%`n`n
transform, AppendMePls, Deref, %AppendMePls%
Fileappend,%AppendMePls%,fUn\debug\log.txt
Gui,Submit, Nohide
}
else {
;msgbox, wao2 %DebugVar%
}
if (DebugVar = 1) {
transform, 3ChanRender, Deref, %3ChanRender%
;IsBatch := "echo"
;BatchCommand := " > run.bat"
FileDelete, fUn\debug\runme.bat
Fileappend,%3ChanRender%,fUn\debug\runme.bat
Run, cmd.exe /k fUn\debug\runme.bat
}
else {
;no
}
Return

Save3ChPls:
if (ActivateBinaryVar = 0) {
data = %A_Sec%%A_Min%%A_Hour%
makefilename := MD5(data,StrLen(data))
DOITVAR = no
}
if (ActivateBinaryVar = 1) {
DOITVAR = BinaryPls
PercentVar = `%
}
else
#EscapeChar `
PercentVar = `%
goSub %DOITVAR%

OutputVar := ; START WITH DEFAULT VARIABLE
(
"-c:v huffyuv %NewFolder%/%makefilename%.avi %NewFolder%/%makefilename%.gif -s 320x180 %NewFolder%/%makefilename%-Res.gif -y && ^
ffplay %NewFolder%/%makefilename%.avi -loop 9001"
)
transform, OutputVar, Deref, %OutputVar% ; MAKE SURE YOU PUT THESE TRANSFORMS IN THE RIGHT PLACE, WASTED 2 HOURS ON THIS

GuiControlGet, LoopVar
GuiControlGet, FrameVar
Gui, Submit, Nohide
if UserInput contains png,jpg,bmp,tiff,jpeg,targa,xwd
{
msgbox, 
(
Image Input Detected!!!
Make sure you hit Render without Enable Loop on
if you wanted a static image.
)
OutputVar :=
(
" %NewFolder%/%makefilename%.xwd %NewFolder%/%makefilename%.bmp -y  && ffplay %NewFolder%/%makefilename%.xwd -fs"
)
transform, OutputVar, Deref, %OutputVar% ; MAKE SURE YOU PUT THESE TRANSFORMS IN THE RIGHT PLACE, WASTED 2 HOURS ON THIS
}
else if UserInput contains webm,mp4,mkv,avi,nut,wmv,
{
;msgbox, Video Detected.
OutputVar :=
(
"-c:v ffvhuff %NewFolder%/%makefilename%.avi %NewFolder%/%makefilename%.gif -s 320x180 %NewFolder%/%makefilename%-Res.gif -y && ^
ffplay %NewFolder%/%makefilename%.avi -loop 9001"
)
transform, OutputVar, Deref, %OutputVar% ; MAKE SURE YOU PUT THESE TRANSFORMS IN THE RIGHT PLACE, WASTED 2 HOURS ON THIS
}
else {
;nothing for now
}
if (LoopVar = 0) {

}
else {
;no
}
if (LoopVar = 1) {
msgbox, 
(
Loop Mode Enabled!
Make sure you Rendered with Loop Enabled first
if this is an an image.
)
OutputVar :=
(
"-c:v huffyuv %NewFolder%/%makefilename%.avi %NewFolder%/%makefilename%.gif -s 320x180 %NewFolder%/%makefilename%-Res.gif -y && ^
ffplay %NewFolder%/%makefilename%.avi -loop 9001"
)
transform, OutputVar, Deref, %OutputVar% ; MAKE SURE YOU PUT THESE TRANSFORMS IN THE RIGHT PLACE, WASTED 2 HOURS ON THIS
}
else {
}
if (FrameVar = 1) {
msgbox, 
(
Exporting as Frames!!! :>
)
OutputVar :=
(
"-f image2 %NewFolder%/frames/frame%PercentVar%04d.png -y"
)
transform, OutputVar, Deref, %OutputVar% ; MAKE SURE YOU PUT THESE TRANSFORMS IN THE RIGHT PLACE, WASTED 2 HOURS ON THIS
}
else {
;no
}

Save3Ch := 
(
"ffmpeg %3ChanFmt% -ar %3ChanSR8% -ac 1 -i %NewFolder%/c-1.meme %3ChanFmt% -ar %3ChanSR8% -ac 1 -i %NewFolder%/c-2.meme %3ChanFmt% -ar %3ChanSR8% -ac 1 -i %NewFolder%/c-3.meme ^
-filter_complex %Quote%[0:a]%Ch1af%=%Ch1afVal%[ch1];[1:a]%Ch2af%=%Ch2afVal%[ch2];[2:a]%Ch3af%=%Ch3afVal%[ch3];[ch1][ch2][ch3]join=inputs=3:channel_layout=2.1:map=0.0-%3ChLayout1%|1.0-%3ChLayout2%|2.0-%3ChLayout3%:[a]%Quote% -map [a] %3ChanFmt% -ar %3ChanSR8% -ac 3 - | ffmpeg -f rawvideo -pix_fmt %PixFmtOut% %3ChanRes% %3ChanFR% -i - %OutputVar% "
)
Gui, Submit, Nohide
if (DebugVar = 0) {
transform, Save3Ch, Deref, %Save3ch%
Run, cmd.exe
sleep, 666
Send, %Save3Ch%
sleep, 88
Send {Enter}
sleep, 100
AppendMePls = `n`n%Save3Ch%`n`n
transform, AppendMePls, Deref, %AppendMePls%
Fileappend,%AppendMePls%,fUn\debug\log.txt
Gui,Submit, Nohide
}
else {
;nah
}
if (DebugVar = 1) {
transform, Save3Ch, Deref, %Save3Ch%
FileDelete, fUn\debug\runme.bat
;Fileappend,%Do3Ch%,fUn\debug\runme.bat
file := FileOpen( "fUn\debug\poop.bat", 1)
file.Write(Save3Ch)
file.Close()
sleep, 100
Run, cmd.exe /k fUn\debug\poop.bat
}
else {
;no
}
Gui, Submit, Nohide
Return

Shuffle3ch:
Gui, Submit, Nohide
Loop % 3ChLayout0-1 {
Random i, A_Index, 3ChLayout0
n := 3ChLayout%i%, 3ChLayout%i% := 3ChLayout%A_Index%, 3ChLayout%A_Index% := n
}
MsgBox,
(
Channels Shuffled! 

Layout Order is now:
Channel 1: %3ChLayout1%
Channel 2: %3ChLayout2%
Channel 3: %3ChLayout3%
)
return


;=====================================================================================================================================

4Chan:
;Start this tab with default channel layout, see
4ChLayout0 = 4
4ChLayout1 = FL
4ChLayout2 = FR
4ChLayout3 = FC
4ChLayout4 = BC
;
Gui, 9:Color, %GuiColor%, -caption
Gui 9:Add, Button, x139 y266 w110 h42 gDo4Chan, COMMENCE MAGIC
Gui 9:Add, Button, x139 y308 w44 h23 gSave4ChPls, SAVE
Gui 9:Add, Button, x183 y308 w66 h23 g4ChInput, INPUT
Gui 9:Add, ComboBox, x8 y8 w120 vCh1af Choose47, %List8%
Gui 9:Add, ComboBox, x8 y32 w120 Choose20 vCh2af, %List8%
Gui 9:Add, ComboBox, x8 y56 w120 Choose20 vCh3af, %List8%
Gui 9:Add, ComboBox, x8 y80 w120 Choose20 vCh4af, %List8%
;;Gui 9:Add, ComboBox, x8 y104 w120 Choose20 vCh5af, %List8%
;;Gui 9:Add, ComboBox, x8 y128 w120 vCh6af Choose20, %List8%
Gui 9:Add, Edit, x128 y8 w120 h21 vCh1afVal, 0.1:1:1:1:1:0.1
Gui 9:Add, Edit, x128 y32 w120 h21 vCh2afVal
Gui 9:Add, Edit, x128 y56 w120 h21 vCh3afVal
Gui 9:Add, Edit, x128 y80 w120 h21 vCh4afVal
;;Gui 9:Add, Edit, x128 y104 w120 h21 vCh5afVal
;;Gui 9:Add, Edit, x128 y128 w120 h21 vCh6afVal
Gui 9:Add, ComboBox, x11 y305 w120 vPixFmtIn Choose32, %list4%
Gui 9:Add, ComboBox, x11 y281 w120 vPixFmtOut Choose32, %list4%
Gui 9:Add, Button, x154 y243 w80 h23 gRender4Chan, RENDER
Gui 9:Add, GroupBox, x30 y204 w84 h56, Resolution
Gui 9:Add, Edit, x39 y231 w66 h24 v4ChanRes, -s 640x360
Gui 9:Add, GroupBox, x5 y262 w132 h69, In/Out Colorspace
Gui 9:Add, GroupBox, x71 y158 w58 h46, Framerate
Gui 9:Add, GroupBox, x7 y158 w58 h46, Format
Gui 9:Add, Edit, x16 y177 w39 h22 v4ChanFmt, -f u8
Gui 9:Add, Edit, x81 y177 w39 h21 v4ChanFR, -r 24
Gui 9:Add, Slider, x-2 y107 w262 h28 +0x40 +Tooltip Range666-88100 v4ChanSR8, 8000
Gui, 9:Add, button, x185 y231 w12 h12 v4chShuffleVar gShuffle4ch,
Gui, 9:Add, button, x205 y231 w12 h12 v4chGetResVar gGetResolution,
Gui, 9:Add, button, x165 y231 w12 h12 vLocationVar gOpenLocation,
Gui, 9:Add, Checkbox, x144 y161 w102 h12 vLoopVar gEnableLoop, Enable Loop?
Gui, 9:Add, Checkbox, x144 y173 w102 h12 vAudioVar gEnableAudio, "Sync" Audio?
GuiControl, 9:Disable, AudioVar
Gui 9:Add, CheckBox, x144 y185 w102 h12 vFrameVar, Save Frames?
Gui 9:Add, CheckBox, x144 y197 w102 h12, idk?
Gui 9:Show, w256 h337, <3 <3 <3
Return

4ChInput:
DirectoryVal = MultiChannel
gosub MakeNewFolder

FileCreateDir, OUTPUT\MultiChannel
FileCreateDir, %NewFolder%\frames

gosub, Input
AllowLoop := ""
Gui,Submit, Nohide
return

Do4Chan:
Gui,Submit, Nohide ; put submit here first
Do4Ch := 
(
"ffmpeg %4ChanFmt% -ar %4ChanSR8% -ac 1 -i %NewFolder%/c-1.meme %4ChanFmt% -ar %4ChanSR8% -ac 1 -i %NewFolder%/c-2.meme %4ChanFmt% -ar %4ChanSR8% -ac 1 -i %NewFolder%/c-3.meme ^
%4ChanFmt% -ar %4ChanSR8% -ac 1 -i %NewFolder%/c-4.meme ^
-filter_complex %Quote%[0:a]%Ch1af%=%Ch1afVal%[ch1];[1:a]%Ch2af%=%Ch2afVal%[ch2];[2:a]%Ch3af%=%Ch3afVal%[ch3];[3:a]%Ch4af%=%Ch4afVal%[ch4];[ch1][ch2][ch3][ch4]join=inputs=4:channel_layout=4.0:map=0.0-%4ChLayout1%|1.0-%4ChLayout2%|2.0-%4ChLayout3%|3.0-%4ChLayout4%:[a]%Quote% -map [a] %4ChanFmt% -ar %4ChanSR8% -ac 4 - | ffplay -f rawvideo -pix_fmt %PixFmtOut% %4ChanRes% -i - -fs "
)
if (DebugVar = 0) {
transform, Do4Ch, Deref, %Do4ch%
Run, cmd.exe
sleep, 666
Send, %Do4Ch%
Sleep, 88
Send {Enter}
sleep, 100
AppendMePls = `n`n%Do4Ch%`n`n
transform, AppendMePls, Deref, %AppendMePls%
Fileappend,%AppendMePls%,fUn\debug\log.txt
Gui,Submit, Nohide
}
else {
;msgbox, wao2 %DebugVar%
}
if (DebugVar = 1) {
transform, Do4Ch, Deref, %Do4Ch%
FileDelete, fUn\debug\runme.bat
;Fileappend,%Do4Ch%,fUn\debug\runme.bat
file := FileOpen( "fUn\debug\poop.bat", 1)
file.Write(Do4Ch)
file.Close()
sleep, 100
Run, cmd.exe /k fUn\debug\poop.bat
}
else {
;no
}
Return


Render4Chan:
gosub, EnableLoop
Gui,Submit, Nohide
GuiControlGet, LoopVar
4ChanRender := 
(
"ffmpeg %AllowLoop% %newinput3% -f rawvideo -pix_fmt %PixFmtIn% %4ChanRes% %4ChanFR% -y %NewFolder%/output.raw && ^
ffmpeg %4ChanFmt% -ar %4ChanSR8% -ac 4 -i %NewFolder%/output.raw -y ^
-filter_complex %Quote%channelsplit=channel_layout=4.0[1][2][3][4]%Quote% ^
-map %Quote%[1]%Quote% %4ChanFmt% -ar %4ChanSR8% -ac 1 %NewFolder%/c-1.meme ^
-map %Quote%[2]%Quote% %4ChanFmt% -ar %4ChanSR8% -ac 1 %NewFolder%/c-2.meme ^
-map %Quote%[3]%Quote% %4ChanFmt% -ar %4ChanSR8% -ac 1 %NewFolder%/c-3.meme ^
-map %Quote%[4]%Quote% %4ChanFmt% -ar %4ChanSR8% -ac 1 %NewFolder%/c-4.meme"
)
if (DebugVar = 0) {
transform, 4ChanRender, Deref, %4ChanRender%
Run, cmd.exe
Sleep, 88
Sendraw, %4ChanRender%
Sleep, 88
Send, {Enter}
sleep, 100
AppendMePls = `n`n%4ChanRender%`n`n
transform, AppendMePls, Deref, %AppendMePls%
Fileappend,%AppendMePls%,fUn\debug\log.txt
Gui,Submit, Nohide
}
else {
;msgbox, wao2 %DebugVar%
}
if (DebugVar = 1) {
transform, 4ChanRender, Deref, %4ChanRender%
;IsBatch := "echo"
;BatchCommand := " > run.bat"
FileDelete, fUn\debug\runme.bat
Fileappend,%4ChanRender%,fUn\debug\runme.bat
Run, cmd.exe /k fUn\debug\runme.bat
}
else {
;no
}
Return

Save4ChPls:
if (ActivateBinaryVar = 0) {
data = %A_Sec%%A_Min%%A_Hour%
makefilename := MD5(data,StrLen(data))
DOITVAR = no
}
if (ActivateBinaryVar = 1) {
DOITVAR = BinaryPls
PercentVar = `%
}
else
#EscapeChar `
PercentVar = `%
goSub %DOITVAR%

OutputVar := ; START WITH DEFAULT VARIABLE
(
"-c:v huffyuv %NewFolder%/%makefilename%.avi %NewFolder%/%makefilename%.gif -s 320x180 %NewFolder%/%makefilename%-Res.gif -y && ^
ffplay %NewFolder%/%makefilename%.avi -loop 9001"
)
transform, OutputVar, Deref, %OutputVar% ; MAKE SURE YOU PUT THESE TRANSFORMS IN THE RIGHT PLACE, WASTED 2 HOURS ON THIS

GuiControlGet, LoopVar
GuiControlGet, FrameVar
Gui, Submit, Nohide
if UserInput contains png,jpg,bmp,tiff,jpeg,targa,xwd
{
msgbox, 
(
Image Input Detected!!!
Make sure you hit Render without Enable Loop on
if you wanted a static image.
)
OutputVar :=
(
" %NewFolder%/%makefilename%.xwd %NewFolder%/%makefilename%.bmp -y  && ffplay %NewFolder%/%makefilename%.xwd -fs"
)
transform, OutputVar, Deref, %OutputVar% ; MAKE SURE YOU PUT THESE TRANSFORMS IN THE RIGHT PLACE, WASTED 2 HOURS ON THIS
}
else if UserInput contains webm,mp4,mkv,avi,nut,wmv,
{
;msgbox, Video Detected.
OutputVar :=
(
"-c:v huffyuv %NewFolder%/%makefilename%.avi %NewFolder%/%makefilename%.gif -s 320x180 %NewFolder%/%makefilename%-Res.gif -y && ^
ffplay %NewFolder%/%makefilename%.avi -loop 9001"
)
transform, OutputVar, Deref, %OutputVar% ; MAKE SURE YOU PUT THESE TRANSFORMS IN THE RIGHT PLACE, WASTED 2 HOURS ON THIS
}
else {
;nothing for now
}
if (LoopVar = 0) {

}
else {
;no
}
if (LoopVar = 1) {
msgbox, 
(
Loop Mode Enabled!
Make sure you Rendered with Loop Enabled first
if this is an an image.
)
OutputVar :=
(
"-c:v huffyuv %NewFolder%/%makefilename%.avi %NewFolder%/%makefilename%.gif -s 320x180 %NewFolder%/%makefilename%-Res.gif -y && ^
ffplay %NewFolder%/%makefilename%.avi -loop 9001"
)
transform, OutputVar, Deref, %OutputVar% ; MAKE SURE YOU PUT THESE TRANSFORMS IN THE RIGHT PLACE, WASTED 2 HOURS ON THIS
}
else {
}
if (FrameVar = 1) {
msgbox, 
(
Exporting as Frames!!! :>
)
OutputVar :=
(
"-f image2 %NewFolder%/frames/frame%PercentVar%04d.png -y"
)
transform, OutputVar, Deref, %OutputVar% ; MAKE SURE YOU PUT THESE TRANSFORMS IN THE RIGHT PLACE, WASTED 2 HOURS ON THIS
}
else {
;no
}

Save4Ch := 
(
"ffmpeg %4ChanFmt% -ar %4ChanSR8% -ac 1 -i %NewFolder%/c-1.meme %4ChanFmt% -ar %4ChanSR8% -ac 1 -i %NewFolder%/c-2.meme %4ChanFmt% -ar %4ChanSR8% -ac 1 -i %NewFolder%/c-3.meme ^
%4ChanFmt% -ar %4ChanSR8% -ac 1 -i %NewFolder%/c-4.meme ^
-filter_complex %Quote%[0:a]%Ch1af%=%Ch1afVal%[ch1];[1:a]%Ch2af%=%Ch2afVal%[ch2];[2:a]%Ch3af%=%Ch3afVal%[ch3];[3:a]%Ch4af%=%Ch4afVal%[ch4];[ch1][ch2][ch3][ch4]join=inputs=4:channel_layout=4.0:map=0.0-%4ChLayout1%|1.0-%4ChLayout2%|2.0-%4ChLayout3%|3.0-%4ChLayout4%:[a]%Quote% ^
-map [a] %4ChanFmt% -ar %4ChanSR8% -ac 4 - | ffmpeg -f rawvideo -pix_fmt %PixFmtOut% %4ChanRes% %4ChanFR% -i - %OutputVar% "
)
Gui, Submit, Nohide
if (DebugVar = 0) {
transform, Save4Ch, Deref, %Save4ch%
Run, cmd.exe
sleep, 666
Send, %Save4Ch%
sleep, 88
Send {Enter}
sleep, 100
AppendMePls = `n`n%Save4Ch%`n`n
transform, AppendMePls, Deref, %AppendMePls%
Fileappend,%AppendMePls%,fUn\debug\log.txt
Gui,Submit, Nohide
}
else {
;nah
}
if (DebugVar = 1) {
transform, Save4Ch, Deref, %Save4Ch%
FileDelete, fUn\debug\runme.bat
;Fileappend,%Do4Ch%,fUn\debug\runme.bat
file := FileOpen( "fUn\debug\poop.bat", 1)
file.Write(Save4Ch)
file.Close()
sleep, 100
Run, cmd.exe /k fUn\debug\poop.bat
}
else {
;no
}
Gui, Submit, Nohide
Return

Shuffle4ch:
Gui, Submit, Nohide
Loop % 4ChLayout0-1 {
Random i, A_Index, 4ChLayout0
n := 4ChLayout%i%, 4ChLayout%i% := 4ChLayout%A_Index%, 4ChLayout%A_Index% := n
}
MsgBox,
(
Channels Shuffled! 

Layout Order is now:
Channel 1: %4ChLayout1%
Channel 2: %4ChLayout2%
Channel 3: %4ChLayout3%
Channel 4: %4ChLayout4%
)
return


;=========================================================================================================

6Chan:
;Start this tab with default channel layout, see
6ChLayout0 = 6
6ChLayout1 = FL
6ChLayout2 = FR
6ChLayout3 = FC
6ChLayout4 = LFE
6ChLayout5 = SL
6ChLayout6 = SR
;
Gui, 7:Color, %GuiColor%, -caption
Gui 7:Add, Button, x139 y310 w110 h42 gDo6Chan, COMMENCE MAGIC
Gui 7:Add, Button, x139 y352 w44 h23 gSave6ChPls, SAVE
Gui 7:Add, Button, x183 y352 w66 h23 g6ChInput, INPUT
Gui 7:Add, ComboBox, x8 y8 w120 vCh1af Choose47, %List8%
Gui 7:Add, ComboBox, x8 y32 w120 Choose20 vCh2af, %List8%
Gui 7:Add, ComboBox, x8 y56 w120 Choose20 vCh3af, %List8%
Gui 7:Add, ComboBox, x8 y80 w120 Choose20 vCh4af, %List8%
Gui 7:Add, ComboBox, x8 y104 w120 Choose20 vCh5af, %List8%
Gui 7:Add, ComboBox, x8 y128 w120 vCh6af Choose20, %List8%
Gui 7:Add, Edit, x128 y8 w120 h21 vCh1afVal, 0.1:1:0:1:0.1:0.1 ;old ones ;0.1:1:1:1:0.1:0.5 ;0.1:1:1:1:1:0.1
Gui 7:Add, Edit, x128 y32 w120 h21 vCh2afVal
Gui 7:Add, Edit, x128 y56 w120 h21 vCh3afVal
Gui 7:Add, Edit, x128 y80 w120 h21 vCh4afVal
Gui 7:Add, Edit, x128 y104 w120 h21 vCh5afVal
Gui 7:Add, Edit, x128 y128 w120 h21 vCh6afVal
Gui 7:Add, ComboBox, x11 y349 w120 vPixFmtIn Choose111, %list4%
Gui 7:Add, ComboBox, x11 y325 w120 vPixFmtOut Choose111, %list4%
Gui 7:Add, Button, x154 y287 w80 h23 gRender6Chan, RENDER
Gui 7:Add, GroupBox, x30 y248 w84 h56, Resolution
Gui 7:Add, Edit, x39 y275 w66 h24 v6ChanRes, -s 640x360
Gui 7:Add, GroupBox, x5 y306 w132 h69, In/Out Colorspace
Gui 7:Add, GroupBox, x71 y202 w58 h46, Framerate
Gui 7:Add, GroupBox, x7 y202 w58 h46, Format
Gui 7:Add, Edit, x16 y221 w39 h22 v6ChanFmt, -f u8
Gui 7:Add, Edit, x81 y221 w39 h21 v6ChanFR, -r 24
Gui 7:Add, Slider, x-2 y151 w262 h28 +0x40 +Tooltip Range666-88100 v6ChanSR8, 88100
Gui, 7:Add, button, x185 y275 w12 h12 v6chShuffleVar gShuffle6ch,
Gui, 7:Add, button, x205 y275 w12 h12 v6chGetResVar gGetResolution,
Gui, 7:Add, button, x165 y275 w12 h12 vLocationVar gOpenLocation,
Gui, 7:Add, Checkbox, x144 y205 w102 h12 vLoopVar gEnableLoop, Enable Loop?
Gui, 7:Add, Checkbox, x144 y217 w102 h12 vAudioVar gEnableAudio, "Sync" Audio?
GuiControl, 7:Disable, AudioVar
Gui 7:Add, CheckBox, x144 y229 w102 h12 vFrameVar, Save Frames?
Gui 7:Add, CheckBox, x144 y241 w102 h12, idk?
;Gui Add, GroupBox, x4 y153 w58 h46, Format
Gui 7:Show, w256 h382, <3 <3 <3
Return



6ChInput:
DirectoryVal = MultiChannel
gosub MakeNewFolder

FileCreateDir, OUTPUT\MultiChannel
FileCreateDir, %NewFolder%\frames

gosub, Input
AllowLoop := ""
Gui,Submit, Nohide
return

Do6Chan:
Gui,Submit, Nohide ; put submit here first
Do6Ch := 
(
"ffmpeg %6ChanFmt% -ar %6ChanSR8% -ac 1 -i %NewFolder%/c-1.meme %6ChanFmt% -ar %6ChanSR8% -ac 1 -i %NewFolder%/c-2.meme %6ChanFmt% -ar %6ChanSR8% -ac 1 -i %NewFolder%/c-3.meme ^
%6ChanFmt% -ar %6ChanSR8% -ac 1 -i %NewFolder%/c-4.meme %6ChanFmt% -ar %6ChanSR8% -ac 1 -i %NewFolder%/c-5.meme %6ChanFmt% -ar %6ChanSR8% -ac 1 -i %NewFolder%/c-6.meme ^
-filter_complex %Quote%[0:a]%Ch1af%=%Ch1afVal%[ch1];[1:a]%Ch2af%=%Ch2afVal%[ch2];[2:a]%Ch3af%=%Ch3afVal%[ch3];[3:a]%Ch4af%=%Ch4afVal%[ch4];[4:a]%Ch5af%=%Ch5afVal%[ch5];[5:a]%Ch6af%=%Ch6afVal%[ch6];[ch1][ch2][ch3][ch4][ch5][ch6]join=inputs=6:channel_layout=5.1(side):map=0.0-%6ChLayout1%|1.0-%6ChLayout2%|2.0-%6ChLayout3%|3.0-%6ChLayout4%|4.0-%6ChLayout5%|5.0-%6ChLayout6%:[a]%Quote% -map [a] %6ChanFmt% -ar %6ChanSR8% -ac 6 - | ffplay -f rawvideo -pix_fmt %PixFmtOut% %6ChanRes% -i - -fs "
)
if (DebugVar = 0) {
transform, Do6Ch, Deref, %Do6ch%
Run, cmd.exe
sleep, 666
Send, %Do6Ch%
Sleep, 88
Send {Enter}
sleep, 100
AppendMePls = `n`n%Do6Ch%`n`n
transform, AppendMePls, Deref, %AppendMePls%
Fileappend,%AppendMePls%,fUn\debug\log.txt
Gui,Submit, Nohide
}
else {
;msgbox, wao2 %DebugVar%
}
if (DebugVar = 1) {
transform, Do6Ch, Deref, %Do6Ch%
FileDelete, fUn\debug\runme.bat
;Fileappend,%Do6Ch%,fUn\debug\runme.bat
file := FileOpen( "fUn\debug\poop.bat", 1)
file.Write(Do6Ch)
file.Close()
sleep, 100
Run, cmd.exe /k fUn\debug\poop.bat
}
else {
;no
}
Return


Render6Chan:
gosub, EnableLoop
Gui,Submit, Nohide
GuiControlGet, LoopVar
6ChanRender := 
(
"ffmpeg %AllowLoop% %newinput3% -f rawvideo -pix_fmt %PixFmtIn% %6ChanRes% %6ChanFR% -y %NewFolder%/output.raw && ^
ffmpeg %6ChanFmt% -ar %6ChanSR8% -ac 6 -i %NewFolder%/output.raw -y ^
-filter_complex %Quote%channelsplit=channel_layout=5.1(side)[1][2][3][4][5][6]%Quote% ^
-map %Quote%[1]%Quote% %6ChanFmt% -ar %6ChanSR8% -ac 1 %NewFolder%/c-1.meme ^
-map %Quote%[2]%Quote% %6ChanFmt% -ar %6ChanSR8% -ac 1 %NewFolder%/c-2.meme ^
-map %Quote%[3]%Quote% %6ChanFmt% -ar %6ChanSR8% -ac 1 %NewFolder%/c-3.meme ^
-map %Quote%[4]%Quote% %6ChanFmt% -ar %6ChanSR8% -ac 1 %NewFolder%/c-4.meme ^
-map %Quote%[5]%Quote% %6ChanFmt% -ar %6ChanSR8% -ac 1 %NewFolder%/c-5.meme ^
-map %Quote%[6]%Quote% %6ChanFmt% -ar %6ChanSR8% -ac 1 %NewFolder%/c-6.meme"
)
if (DebugVar = 0) {
transform, 6ChanRender, Deref, %6ChanRender%
Run, cmd.exe
Sleep, 88
Sendraw, %6ChanRender%
Sleep, 88
Send, {Enter}
sleep, 100
AppendMePls = `n`n%6ChanRender%`n`n
transform, AppendMePls, Deref, %AppendMePls%
Fileappend,%AppendMePls%,fUn\debug\log.txt
Gui,Submit, Nohide
}
else {
;msgbox, wao2 %DebugVar%
}
if (DebugVar = 1) {
transform, 6ChanRender, Deref, %6ChanRender%
;IsBatch := "echo"
;BatchCommand := " > run.bat"
FileDelete, fUn\debug\runme.bat
Fileappend,%6ChanRender%,fUn\debug\runme.bat
Run, cmd.exe /k fUn\debug\runme.bat
}
else {
;no
}
Return

Save6ChPls:
if (ActivateBinaryVar = 0) {
data = %A_Sec%%A_Min%%A_Hour%
makefilename := MD5(data,StrLen(data))
DOITVAR = no
}
if (ActivateBinaryVar = 1) {
DOITVAR = BinaryPls
PercentVar = `%
}
else
#EscapeChar `
PercentVar = `%
goSub %DOITVAR%

OutputVar := ; START WITH DEFAULT VARIABLE
(
"-c:v huffyuv %NewFolder%/%makefilename%.avi %NewFolder%/%makefilename%.gif -s 320x180 %NewFolder%/%makefilename%-Res.gif -y && ^
ffplay %NewFolder%/%makefilename%.avi -loop 9001"
)
transform, OutputVar, Deref, %OutputVar% ; MAKE SURE YOU PUT THESE TRANSFORMS IN THE RIGHT PLACE, WASTED 2 HOURS ON THIS

GuiControlGet, LoopVar
GuiControlGet, FrameVar
Gui, Submit, Nohide
if UserInput contains png,jpg,bmp,tiff,jpeg,targa,xwd
{
msgbox, 
(
Image Input Detected!!!
Make sure you hit Render without Enable Loop on
if you wanted a static image.
)
OutputVar :=
(
" %NewFolder%/%makefilename%.xwd %NewFolder%/%makefilename%.bmp -y  && ffplay %NewFolder%/%makefilename%.xwd -fs"
)
transform, OutputVar, Deref, %OutputVar% ; MAKE SURE YOU PUT THESE TRANSFORMS IN THE RIGHT PLACE, WASTED 2 HOURS ON THIS
}
else if UserInput contains webm,mp4,mkv,avi,nut,wmv,
{
;msgbox, Video Detected.
OutputVar :=
(
"-c:v huffyuv %NewFolder%/%makefilename%.avi %NewFolder%/%makefilename%.gif -s 320x180 %NewFolder%/%makefilename%-Res.gif -y && ^
ffplay %NewFolder%/%makefilename%.avi -loop 9001"
)
transform, OutputVar, Deref, %OutputVar% ; MAKE SURE YOU PUT THESE TRANSFORMS IN THE RIGHT PLACE, WASTED 2 HOURS ON THIS
}
else {
;nothing for now
}
if (LoopVar = 0) {

}
else {
;no
}
if (LoopVar = 1) {
msgbox, 
(
Loop Mode Enabled!
Make sure you Rendered with Loop Enabled first
if this is an an image.
)
OutputVar :=
(
"-c:v huffyuv %NewFolder%/%makefilename%.avi %NewFolder%/%makefilename%.gif -s 320x180 %NewFolder%/%makefilename%-Res.gif -y && ^
ffplay %NewFolder%/%makefilename%.avi -loop 9001"
)
transform, OutputVar, Deref, %OutputVar% ; MAKE SURE YOU PUT THESE TRANSFORMS IN THE RIGHT PLACE, WASTED 2 HOURS ON THIS
}
else {
}
if (FrameVar = 1) {
msgbox, 
(
Exporting as Frames!!! :>
)
OutputVar :=
(
"-f image2 %NewFolder%/frames/frame%PercentVar%04d.png -y && ffplay -loop 0 -f image2 -i %NewFolder%/frames/frame%PercentVar%04d.png"
)
transform, OutputVar, Deref, %OutputVar% ; MAKE SURE YOU PUT THESE TRANSFORMS IN THE RIGHT PLACE, WASTED 2 HOURS ON THIS
}
else {
;no
}

Save6Ch := 
(
"ffmpeg %6ChanFmt% -ar %6ChanSR8% -ac 1 -i %NewFolder%/c-1.meme %6ChanFmt% -ar %6ChanSR8% -ac 1 -i %NewFolder%/c-2.meme %6ChanFmt% -ar %6ChanSR8% -ac 1 -i %NewFolder%/c-3.meme ^
%6ChanFmt% -ar %6ChanSR8% -ac 1 -i %NewFolder%/c-4.meme %6ChanFmt% -ar %6ChanSR8% -ac 1 -i %NewFolder%/c-5.meme %6ChanFmt% -ar %6ChanSR8% -ac 1 -i %NewFolder%/c-6.meme ^
-filter_complex %Quote%[0:a]%Ch1af%=%Ch1afVal%[ch1];[1:a]%Ch2af%=%Ch2afVal%[ch2];[2:a]%Ch3af%=%Ch3afVal%[ch3];[3:a]%Ch4af%=%Ch4afVal%[ch4];[4:a]%Ch5af%=%Ch5afVal%[ch5];[5:a]%Ch6af%=%Ch6afVal%[ch6];[ch1][ch2][ch3][ch4][ch5][ch6]join=inputs=6:channel_layout=5.1(side):map=0.0-%6ChLayout1%|1.0-%6ChLayout2%|2.0-%6ChLayout3%|3.0-%6ChLayout4%|4.0-%6ChLayout5%|5.0-%6ChLayout6%:[a]%Quote% ^
-map [a] %6ChanFmt% -ar %6ChanSR8% -ac 6 - | ffmpeg -f rawvideo -pix_fmt %PixFmtOut% %6ChanRes% %6ChanFR% -i - %OutputVar% "
)
Gui, Submit, Nohide
if (DebugVar = 0) {
transform, Save6Ch, Deref, %Save6ch%
Run, cmd.exe
sleep, 666
Send, %Save6Ch%
sleep, 88
Send {Enter}
sleep, 100
AppendMePls = `n`nSave6Ch`n`n ;fixed append here, remove percent signs
transform, AppendMePls, Deref, %AppendMePls%
Fileappend,%AppendMePls%,fUn\debug\log.txt
Gui,Submit, Nohide
}
if (DebugVar = 1) {
transform, Save6Ch, Deref, %Save6Ch%
FileDelete, fUn\debug\runme.bat
;Fileappend,%Do6Ch%,fUn\debug\runme.bat
file := FileOpen( "fUn\debug\poop.bat", 1)
file.Write(Save6Ch)
file.Close()
sleep, 100
Run, cmd.exe /k fUn\debug\poop.bat
;gosub OpenLocation
}
Gui, Submit, Nohide
WinWaitActive, OUTPUT
{
 gosub, OpenLocation
}
Return

Shuffle6ch:
Gui, Submit, Nohide
Loop % 6ChLayout0-1 {
Random i, A_Index, 6ChLayout0
n := 6ChLayout%i%, 6ChLayout%i% := 6ChLayout%A_Index%, 6ChLayout%A_Index% := n
}
MsgBox,
(
Channels Shuffled! 

Layout Order is now:
Channel 1: %6ChLayout1%
Channel 2: %6ChLayout2%
Channel 3: %6ChLayout3%
Channel 4: %6ChLayout4%
Channel 5: %6ChLayout5%
Channel 6: %6ChLayout6%
)
return

GetResolution:
Gui, Submit, Nohide
ResInput = %NewerInput%
If RegExMatch(ResInput,"(flac|aic|ogg|wav|mp2|mp3)") {
runwait, %ComSpec% /c ffmpeg %aEncParam% %ResInput% -acodec %Aencodercodec% %EncFmt% -ac %ChanCount1% -ar %aDecSmplr8% -y testmepls.u8

bitratepls := "ffprobe -show_entries format=bit_rate -v quiet -of csv=s=x:p=0 %EncFmt% -ac %ChanCount1% -ar %aDecSmplr8% -i testmepls.u8"
		 transform, bitratepls, Deref, %bitratepls%
		 ;run, %ComSpec% /c echo "%bitratepls%" | clip
		 
Bitrate := ComObjCreate("WScript.Shell").Exec(bitratepls).StdOut.ReadAll() ;Execute ffprobe and save stdout to variable!

         StringReplace, Bitrate, Bitrate, `r`n, %A_Space%, All ;Remove linebreak from bitrate
         transform, Bitrate, Deref, %Bitrate%
		 StringTrimRight, Bitrate2, Bitrate, 4 ; Cut Bitrate length to what ffmpeg normally displays it as because im retarded.
		 
respls := "ffprobe %EncFmt% -ac %ChanCount1% -ar %aDecSmplr8% -i testmepls.u8 -show_entries format=duration -v quiet -of csv=s=x:p=0 | clip"

		 transform, respls, Deref, %respls%
		 runwait, %ComSpec% /c %respls%
		 StringReplace, clipboard, clipboard, `r`n, %A_Space%, All ;Remove linebreak from clipboard
		 Duration := clipboard
		 
Duration := floor(Duration) ;Convert duration to integer
size := (Duration*Bitrate2) ;Multiply Duration by bitrate
width := (size/24) ;Divide width by bits per pixel, bgr24 in this case
width := floor(width) ;Convert float to integer
OriginalWidth := width ;Save Original width value
;;;StringLen, Length, width ;old method
;;;Length := (Length -2) ;Subtract two from the width strings total length ; old method

lemath := 10**(StrLen(width)-1) ;Count string length; ** is the same as saying "exponents" and the -1 at the end makes the string always one digit less, for now.
width := Floor(width / lemath) * lemath

height = 1000
;global swappedRes := -s %width%x%height% ; huehuehue

         GuiControl,, GlobalRes, -s %width%x%height%
;global SEX := clipboard
         msgbox, Kind of Converted Audio duration To Resolution -s %width%x%height%`nOriginal Width was %OriginalWidth% Before being rounded down.`nBitrate Is Now: %Bitrate2%`nOriginally: %Bitrate%

		 ;msgbox, Bitrate %Bitrate%
		 ;runwait, %ComSpec% /c %respls%
		 FileDelete, testmepls.u8
		 return
}
else

ResInput = %NewerInput%
respls = "ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 %ResInput% | clip"
transform, respls, Deref, %respls%
runwait, cmd.exe /c %respls% ,,Hide

StringReplace, clipboard, clipboard, `r`n, %A_Space%, All ;Remove linebreak from clipboard
GuiControl,, 6ChanRes, -s %clipboard%
GuiControl,, 8ChanRes, -s %clipboard%
GuiControl,, 4ChanRes, -s %clipboard%
GuiControl,, 3ChanRes, -s %clipboard%
GuiControl,, GlobalRes, -s %clipboard%
;global SEX := clipboard

msgbox, Using Input File Resolution %clipboard%
return

SwapRes:
Swapped = %height%x%width%

GuiControl,, GlobalRes, -s %Swapped%
Return

Back3:
Gui, 1:Show
Gui, 4:Destroy
Return

;========================SONI-8============================

8Chan:
;
8ChLayout0 = 8
8ChLayout1 = FL
8ChLayout2 = FR
8ChLayout3 = FC
8ChLayout4 = LFE
8ChLayout5 = BL
8ChLayout6 = BR
8ChLayout7 = SL
8ChLayout8 = SR
;
Gui, 8:Color, %GuiColor%, -caption
Gui 8:Add, Button, x139 y363 w110 h42 gDo8Chan, COMMENCE MAGIC
Gui 8:Add, Button, x139 y405 w44 h23 gSave8ChPls, SAVE
Gui 8:Add, Button, x183 y405 w66 h23 g8ChInput, INPUT
Gui 8:Add, ComboBox, x8 y8 w120 vCh1af Choose47, %List8%
Gui 8:Add, ComboBox, x8 y32 w120 Choose20 vCh2af, %List8%
Gui 8:Add, ComboBox, x8 y56 w120 Choose20 vCh3af, %List8%
Gui 8:Add, ComboBox, x8 y80 w120 Choose20 vCh4af, %List8%
Gui 8:Add, ComboBox, x8 y104 w120 Choose20 vCh5af, %List8%
Gui 8:Add, ComboBox, x8 y128 w120 vCh6af Choose20, %List8%
Gui 8:Add, ComboBox, x8 y152 w120 vCh7af Choose20, %List8%
Gui 8:Add, ComboBox, x8 y176 w120 vCh8af Choose20, %List8%
Gui 8:Add, Edit, x128 y8 w120 h21 vCh1afVal, 0.1:1:1:10:0.1:0.5 ;0.1:1:1:1:1:0.1
Gui 8:Add, Edit, x128 y32 w120 h21 vCh2afVal
Gui 8:Add, Edit, x128 y56 w120 h21 vCh3afVal
Gui 8:Add, Edit, x128 y80 w120 h21 vCh4afVal
Gui 8:Add, Edit, x128 y104 w120 h21 vCh5afVal
Gui 8:Add, Edit, x128 y128 w120 h21 vCh6afVal
Gui 8:Add, Edit, x128 y152 w120 h21 vCh7afVal
Gui 8:Add, Edit, x128 y176 w120 h21 vCh8afVal
Gui 8:Add, ComboBox, x11 y402 w120 vPixFmtIn Choose168, %list4%
Gui 8:Add, ComboBox, x11 y378 w120 vPixFmtOut Choose168, %list4%
Gui 8:Add, Button, x154 y340 w80 h23 gRender8Chan, RENDER
Gui 8:Add, GroupBox, x30 y301 w84 h56, Resolution
Gui 8:Add, Edit, x39 y328 w66 h24 v8ChanRes, -s 640x360
Gui 8:Add, GroupBox, x5 y359 w132 h69, In/Out Colorspace
Gui 8:Add, GroupBox, x71 y255 w58 h46, Framerate
Gui 8:Add, GroupBox, x7 y255 w58 h46, Format
Gui 8:Add, Edit, x16 y274 w39 h22 v8ChanFmt, -f u8
Gui 8:Add, Edit, x81 y274 w39 h21, -r 24
Gui 8:Add, Slider, x-2 y204 w262 h28 ToolTip v8chanSR8 Range666-88100, 8000
Gui 8:Add, CheckBox, x144 y258 w102 h12 vLoopVar gEnableLoop, Enable Loop?
Gui 8:Add, CheckBox, x144 y270 w102 h12 vAudioVar, "Sync" Audio?
GuiControl, 8:Disable, AudioVar
Gui 8:Add, CheckBox, x144 y282 w102 h12 vFrameVar, Save Frames?
Gui 8:Add, CheckBox, x144 y294 w102 h12, idk?
Gui 8:Add, Button, x185 y328 w12 h12 v8chShuffleVar gShuffle8ch,
Gui 8:Add, Button, x205 y328 w12 h12 v6chGetResVar gGetResolution,
Gui 8:Add, Button, x165 y328 w12 h12 gOpenLocation
Gui 8:Show, w258 h433, <3 <3 <3
Return


8chInput:
DirectoryVal = MultiChannel
gosub MakeNewFolder

FileCreateDir, OUTPUT\MultiChannel
FileCreateDir, %NewFolder%\frames

gosub, Input
AllowLoop := ""
Gui,Submit, Nohide
return

Do8chan:
Gui,Submit, Nohide ; put submit here first
Do8ch := 
(
"ffmpeg %8chanFmt% -ar %8chanSR8% -ac 1 -i %NewFolder%/c-1.meme %8chanFmt% -ar %8chanSR8% -ac 1 -i %NewFolder%/c-2.meme %8chanFmt% -ar %8chanSR8% -ac 1 -i %NewFolder%/c-3.meme ^
%8chanFmt% -ar %8chanSR8% -ac 1 -i %NewFolder%/c-4.meme %8chanFmt% -ar %8chanSR8% -ac 1 -i %NewFolder%/c-5.meme %8chanFmt% -ar %8chanSR8% -ac 1 -i %NewFolder%/c-6.meme ^
%8chanFmt% -ar %8chanSR8% -ac 1 -i %NewFolder%/c-7.meme %8chanFmt% -ar %8chanSR8% -ac 1 -i %NewFolder%/c-8.meme ^
-filter_complex %Quote%[0:a]%Ch1af%=%Ch1afVal%[ch1];[1:a]%Ch2af%=%Ch2afVal%[ch2];[2:a]%Ch3af%=%Ch3afVal%[ch3];[3:a]%Ch4af%=%Ch4afVal%[ch4];[4:a]%Ch5af%=%Ch5afVal%[ch5];[5:a]%Ch6af%=%Ch6afVal%[ch6];[6:a]%Ch7af%=%Ch7afVal%[ch7];[7:a]%Ch8af%=%Ch8afVal%[ch8];[ch1][ch2][ch3][ch4][ch5][ch6][ch7][ch8]join=inputs=8:channel_layout=7.1:map=0.0-%8chLayout1%|1.0-%8chLayout2%|2.0-%8chLayout3%|3.0-%8chLayout4%|4.0-%8chLayout5%|5.0-%8chLayout6%|6.0-%8chLayout7%|7.0-%8chLayout8%:[a]%Quote% -map [a] %8chanFmt% -ar %8chanSR8% -ac 8 - | ffplay -f rawvideo -pix_fmt %PixFmtOut% %8chanRes% -i - -fs "
)
if (DebugVar = 0) {
transform, Do8ch, Deref, %Do8ch%
Run, cmd.exe
sleep, 666
Send, %Do8ch%
Sleep, 88
Send {Enter}
sleep, 100
AppendMePls = `n`n%Do8ch%`n`n
transform, AppendMePls, Deref, %AppendMePls%
Fileappend,%AppendMePls%,fUn\debug\log.txt
Gui,Submit, Nohide
}
else {
;msgbox, wao2 %DebugVar%
}
if (DebugVar = 1) {
transform, Do8ch, Deref, %Do8ch%
FileDelete, fUn\debug\runme.bat
;Fileappend,%Do8ch%,fUn\debug\runme.bat
file := FileOpen( "fUn\debug\poop.bat", 1)
file.Write(Do8ch)
file.Close()
sleep, 100
Run, cmd.exe /k fUn\debug\poop.bat
}
else {
;no
}
Return


Render8chan:
gosub, EnableLoop
Gui,Submit, Nohide
8chanRender := 
(
"ffmpeg %AllowLoop% %newinput3% -f rawvideo -pix_fmt %PixFmtIn% %8chanRes% %8chanFR% -y %NewFolder%/output.raw && ^
ffmpeg %8chanFmt% -ar %8chanSR8% -ac 8 -i %NewFolder%/output.raw -y ^
-filter_complex %Quote%channelsplit=channel_layout=7.1[1][2][3][4][5][6][7][8]%Quote% ^
-map %Quote%[1]%Quote% %8chanFmt% -ar %8chanSR8% -ac 1 %NewFolder%/c-1.meme ^
-map %Quote%[2]%Quote% %8chanFmt% -ar %8chanSR8% -ac 1 %NewFolder%/c-2.meme ^
-map %Quote%[3]%Quote% %8chanFmt% -ar %8chanSR8% -ac 1 %NewFolder%/c-3.meme ^
-map %Quote%[4]%Quote% %8chanFmt% -ar %8chanSR8% -ac 1 %NewFolder%/c-4.meme ^
-map %Quote%[5]%Quote% %8chanFmt% -ar %8chanSR8% -ac 1 %NewFolder%/c-5.meme ^
-map %Quote%[6]%Quote% %8chanFmt% -ar %8chanSR8% -ac 1 %NewFolder%/c-6.meme ^
-map %Quote%[7]%Quote% %8chanFmt% -ar %8chanSR8% -ac 1 %NewFolder%/c-7.meme ^
-map %Quote%[8]%Quote% %8chanFmt% -ar %8chanSR8% -ac 1 %NewFolder%/c-8.meme"
)
if (DebugVar = 0) {
transform, 8chanRender, Deref, %8chanRender%
Run, cmd.exe
Sleep, 88
Sendraw, %8chanRender%
Sleep, 88
Send, {Enter}
sleep, 100
AppendMePls = `n`n%8chanRender%`n`n
transform, AppendMePls, Deref, %AppendMePls%
Fileappend,%AppendMePls%,fUn\debug\log.txt
Gui,Submit, Nohide
}
else {
;msgbox, wao2 %DebugVar%
}
if (DebugVar = 1) {
transform, 8chanRender, Deref, %8chanRender%
;IsBatch := "echo"
;BatchCommand := " > run.bat"
FileDelete, fUn\debug\runme.bat
Fileappend,%8chanRender%,fUn\debug\runme.bat
Run, cmd.exe /k fUn\debug\runme.bat
}
else {
;no
}
Return

Save8chPls:
if (ActivateBinaryVar = 0) {
data = %A_Sec%%A_Min%%A_Hour%
makefilename := MD5(data,StrLen(data))
DOITVAR = no
}
if (ActivateBinaryVar = 1) {
DOITVAR = BinaryPls
PercentVar = `%
}
else
#EscapeChar `
PercentVar = `%
goSub %DOITVAR%

OutputVar := ; START WITH DEFAULT VARIABLE
(
"-c:v huffyuv %NewFolder%/%makefilename%.avi %NewFolder%/%makefilename%.gif -s 320x180 %NewFolder%/%makefilename%-Res.gif -y && ^
ffplay %NewFolder%/%makefilename%.avi -loop 9001"
)
transform, OutputVar, Deref, %OutputVar% ; MAKE SURE YOU PUT THESE TRANSFORMS IN THE RIGHT PLACE, WASTED 2 HOURS ON THIS

GuiControlGet, LoopVar
GuiControlGet, FrameVar
Gui, Submit, Nohide
if UserInput contains png,jpg,bmp,tiff,jpeg,targa,xwd
{
msgbox, 
(
Image Input Detected!!!
Make sure you hit Render without Enable Loop on
if you wanted a static image.
)
OutputVar :=
(
" %NewFolder%/%makefilename%.xwd %NewFolder%/%makefilename%.bmp -y  && ffplay %NewFolder%/%makefilename%.xwd -fs"
)
transform, OutputVar, Deref, %OutputVar% ; MAKE SURE YOU PUT THESE TRANSFORMS IN THE RIGHT PLACE, WASTED 2 HOURS ON THIS
}
else if UserInput contains webm,mp4,mkv,avi,nut,wmv,
{
;msgbox, Video Detected.
OutputVar :=
(
"-c:v huffyuv %NewFolder%/%makefilename%.avi %NewFolder%/%makefilename%.gif -s 320x180 %NewFolder%/%makefilename%-Res.gif -y && ^
ffplay %NewFolder%/%makefilename%.avi -loop 9001"
)
transform, OutputVar, Deref, %OutputVar% ; MAKE SURE YOU PUT THESE TRANSFORMS IN THE RIGHT PLACE, WASTED 2 HOURS ON THIS
}
else {
;nothing for now
}
if (LoopVar = 0) {

}
else {
;no
}
if (LoopVar = 1) {
msgbox, 
(
Loop Mode Enabled!
Make sure you Rendered with Loop Enabled first
if this is an an image.
)
OutputVar :=
(
"-c:v huffyuv %NewFolder%/%makefilename%.avi %NewFolder%/%makefilename%.gif -s 320x180 %NewFolder%/%makefilename%-Res.gif -y && ^
ffplay %NewFolder%/%makefilename%.avi -loop 9001"
)
transform, OutputVar, Deref, %OutputVar% ; MAKE SURE YOU PUT THESE TRANSFORMS IN THE RIGHT PLACE, WASTED 2 HOURS ON THIS
}
else {
}
if (FrameVar = 1) {
msgbox, 
(
Exporting as Frames!!! :>
)
OutputVar :=
(
"-f image2 %NewFolder%/frames/frame%PercentVar%04d.png -y"
)
transform, OutputVar, Deref, %OutputVar% ; MAKE SURE YOU PUT THESE TRANSFORMS IN THE RIGHT PLACE, WASTED 2 HOURS ON THIS
}
else {
;no
}

Save8ch := 
(
"ffmpeg %8chanFmt% -ar %8chanSR8% -ac 1 -i %NewFolder%/c-1.meme %8chanFmt% -ar %8chanSR8% -ac 1 -i %NewFolder%/c-2.meme %8chanFmt% -ar %8chanSR8% -ac 1 -i %NewFolder%/c-3.meme ^
%8chanFmt% -ar %8chanSR8% -ac 1 -i %NewFolder%/c-4.meme %8chanFmt% -ar %8chanSR8% -ac 1 -i %NewFolder%/c-5.meme %8chanFmt% -ar %8chanSR8% -ac 1 -i %NewFolder%/c-6.meme ^
%8chanFmt% -ar %8chanSR8% -ac 1 -i %NewFolder%/c-7.meme %8chanFmt% -ar %8chanSR8% -ac 1 -i %NewFolder%/c-8.meme ^
-filter_complex %Quote%[0:a]%Ch1af%=%Ch1afVal%[ch1];[1:a]%Ch2af%=%Ch2afVal%[ch2];[2:a]%Ch3af%=%Ch3afVal%[ch3];[3:a]%Ch4af%=%Ch4afVal%[ch4];[4:a]%Ch5af%=%Ch5afVal%[ch5];[5:a]%Ch6af%=%Ch6afVal%[ch6];[6:a]%Ch7af%=%Ch7afVal%[ch7];[7:a]%Ch6af%=%Ch8afVal%[ch8];[ch1][ch2][ch3][ch4][ch5][ch6][ch7][ch8]join=inputs=8:channel_layout=7.1:map=0.0-%8chLayout1%|1.0-%8chLayout2%|2.0-%8chLayout3%|3.0-%8chLayout4%|4.0-%8chLayout5%|5.0-%8chLayout6%|6.0-%8chLayout7%|7.0-%8chLayout8%:[a]%Quote% -map [a] %8chanFmt% -ar %8chanSR8% -ac 8 - | ffmpeg -f rawvideo -pix_fmt %PixFmtOut% %8chanRes% %8chanFR% -i - %OutputVar% "
)
Gui, Submit, Nohide
if (DebugVar = 0) {
transform, Save8ch, Deref, %Save8ch%
Run, cmd.exe
sleep, 666
Send, %Save8ch%
sleep, 88
Send {Enter}
sleep, 100
AppendMePls = `n`n%Save8ch%`n`n
transform, AppendMePls, Deref, %AppendMePls%
Fileappend,%AppendMePls%,fUn\debug\log.txt
Gui,Submit, Nohide
}
else {
;nah
}
if (DebugVar = 1) {
transform, Save8ch, Deref, %Save8ch%
FileDelete, fUn\debug\runme.bat
;Fileappend,%Do8ch%,fUn\debug\runme.bat
file := FileOpen( "fUn\debug\poop.bat", 1)
file.Write(Save8ch)
file.Close()
sleep, 100
Run, cmd.exe /k fUn\debug\poop.bat
}
else {
;no
}
Gui, Submit, Nohide
Return

Shuffle8ch:
Gui, Submit, Nohide
Loop % 8chLayout0-1 {
Random i, A_Index, 8chLayout0
n := 8chLayout%i%, 8chLayout%i% := 8chLayout%A_Index%, 8chLayout%A_Index% := n
}
MsgBox,
(
Channels Shuffled! 

Layout Order is now:
Channel 1: %8chLayout1%
Channel 2: %8chLayout2%
Channel 3: %8chLayout3%
Channel 4: %8chLayout4%
Channel 5: %8chLayout5%
Channel 6: %8chLayout6%
Channel 7: %8chLayout7%
Channel 8: %8chLayout8%
)

Return

msgbox, wao
;=============================================================================================================

12Chan:
;
12ChLayout0 = 8
12ChLayout1 = FL
12ChLayout2 = FR
12ChLayout3 = FC
12ChLayout4 = LFE
12ChLayout5 = BL
12ChLayout6 = BR
12ChLayout7 = SL
12ChLayout8 = SR
;
Gui, 11:Color, %GuiColor%, -caption
Gui 11:Add, Button, x139 y462 w110 h42 gDo12Chan, COMMENCE MAGIC
Gui 11:Add, Button, x139 y504 w44 h23 gSave12ChPls, SAVE
Gui 11:Add, Button, x183 y504 w66 h23 g12ChInput, INPUT
Gui 11:Add, ComboBox, x8 y8 w120 vCh1af Choose20, %List8%
Gui 11:Add, ComboBox, x8 y32 w120 Choose20 vCh2af, %List8%
Gui 11:Add, ComboBox, x8 y56 w120 Choose20 vCh3af, %List8%
Gui 11:Add, ComboBox, x8 y80 w120 Choose20 vCh4af, %List8%
Gui 11:Add, ComboBox, x8 y104 w120 Choose20 vCh5af, %List8%
Gui 11:Add, ComboBox, x8 y128 w120 vCh6af Choose20, %List8%
Gui 11:Add, ComboBox, x8 y152 w120 vCh7af Choose20, %List8%
Gui 11:Add, ComboBox, x8 y176 w120 vCh8af Choose20, %List8%
Gui 11:Add, ComboBox, x8 y200 w120 vCh9af Choose20, %List8%
Gui 11:Add, ComboBox, x8 y224 w120 vCh10af Choose20, %List8%
Gui 11:Add, ComboBox, x8 y248 w120 vCh11af Choose20, %List8%
Gui 11:Add, ComboBox, x8 y272 w120 vCh12af Choose20, %List8%
Gui 11:Add, Edit, x128 y8 w120 h21 vCh1afVal,
Gui 11:Add, Edit, x128 y32 w120 h21 vCh2afVal
Gui 11:Add, Edit, x128 y56 w120 h21 vCh3afVal
Gui 11:Add, Edit, x128 y80 w120 h21 vCh4afVal
Gui 11:Add, Edit, x128 y104 w120 h21 vCh5afVal
Gui 11:Add, Edit, x128 y128 w120 h21 vCh6afVal
Gui 11:Add, Edit, x128 y152 w120 h21 vCh7afVal
Gui 11:Add, Edit, x128 y176 w120 h21 vCh8afVal
Gui 11:Add, Edit, x128 y200 w120 h21 vCh9afVal
Gui 11:Add, Edit, x128 y224 w120 h21 vCh10afVal
Gui 11:Add, Edit, x128 y248 w120 h21 vCh11afVal
Gui 11:Add, Edit, x128 y272 w120 h21 vCh12afVal
Gui 11:Add, ComboBox, x11 y501 w120 vPixFmtIn Choose168, %list4%
Gui 11:Add, ComboBox, x11 y477 w120 vPixFmtOut Choose168, %list4%
Gui 11:Add, Button, x154 y439 w80 h23 gRender12Chan, RENDER
Gui 11:Add, GroupBox, x30 y400 w84 h56, Resolution
Gui 11:Add, Edit, x39 y427 w66 h24 v12ChanRes, -s 640x360
Gui 11:Add, GroupBox, x5 y458 w132 h69, In/Out Colorspace
Gui 11:Add, GroupBox, x71 y354 w58 h46, Framerate
Gui 11:Add, GroupBox, x7 y354 w58 h46, Format
Gui 11:Add, Edit, x16 y373 w39 h22 v12ChanFmt, -f u8
Gui 11:Add, Edit, x81 y373 w39 h21, -r 24
Gui 11:Add, Slider, x-2 y303 w262 h28 ToolTip v12chanSR8 Range666-88100, 8000
Gui 11:Add, CheckBox, x144 y357 w102 h12 vLoopVar gEnableLoop, Enable Loop?
Gui 11:Add, CheckBox, x144 y369 w102 h12 vAudioVar, "Sync" Audio?
GuiControl, 11:Disable, AudioVar
Gui 11:Add, CheckBox, x144 y381 w102 h12 vFrameVar, Save Frames?
Gui 11:Add, CheckBox, x144 y393 w102 h12, idk?
Gui 11:Add, Button, x185 y427 w12 h12 v12chShuffleVar gShuffle12ch,
Gui 11:Add, Button, x205 y427 w12 h12 v12chGetResVar gGetResolution,
Gui 11:Add, Button, x165 y427 w12 h12 gOpenLocation
Gui, 11:-Sysmenu
Gui 11:Show, w258 h534, <3 <3 <3
Return


12chInput:
DirectoryVal = MultiChannel
gosub MakeNewFolder

FileCreateDir, OUTPUT\MultiChannel
FileCreateDir, %NewFolder%\frames

gosub, Input
AllowLoop := ""
Gui,Submit, Nohide
return

Do12chan:
Gui,Submit, Nohide ; put submit here first
Do12ch := 
(
"ffmpeg -loglevel debug %12chanFmt% -ar %12chanSR8% -ac 1 -i %NewFolder%/c-1.meme %12chanFmt% -ar %12chanSR8% -ac 1 -i %NewFolder%/c-2.meme %12chanFmt% -ar %12chanSR8% -ac 1 -i %NewFolder%/c-3.meme ^
%12chanFmt% -ar %12chanSR8% -ac 1 -i %NewFolder%/c-4.meme %12chanFmt% -ar %12chanSR8% -ac 1 -i %NewFolder%/c-5.meme %12chanFmt% -ar %12chanSR8% -ac 1 -i %NewFolder%/c-6.meme ^
%12chanFmt% -ar %12chanSR8% -ac 1 -i %NewFolder%/c-7.meme %12chanFmt% -ar %12chanSR8% -ac 1 -i %NewFolder%/c-8.meme %12chanFmt% -ar %12chanSR8% -ac 1 -i %NewFolder%/c-9.meme ^
%12chanFmt% -ar %12chanSR8% -ac 1 -i %NewFolder%/c-10.meme %12chanFmt% -ar %12chanSR8% -ac 1 -i %NewFolder%/c-11.meme %12chanFmt% -ar %12chanSR8% -ac 1 -i %NewFolder%/c-12.meme ^
-filter_complex %Quote%[0:a]%Ch1af%=%Ch1afVal%[ch1];[1:a]%Ch2af%=%Ch2afVal%[ch2];[2:a]%Ch3af%=%Ch3afVal%[ch3];[3:a]%Ch4af%=%Ch4afVal%[ch4];[4:a]%Ch5af%=%Ch5afVal%[ch5];[5:a]%Ch6af%=%Ch6afVal%[ch6];[6:a]%Ch7af%=%Ch7afVal%[ch7];[7:a]%Ch8af%=%Ch8afVal%[ch8];[8:a]%Ch9af%=%Ch9afVal%[ch9];[9:a]%Ch10af%=%Ch10afVal%[ch10];[10:a]%Ch11af%=%Ch11afVal%[ch11];[11:a]%Ch12af%=%Ch12afVal%[ch12];[ch1][ch2][ch3][ch4][ch5][ch6][ch7][ch8][ch9][ch10][ch11][ch12]amerge=inputs=12[a]%Quote% -map [a] %12chanFmt% -ar %12chanSR8% -ac 12 - | ffplay -f rawvideo -pix_fmt %PixFmtOut% %12chanRes% -i - -fs "
)
if (DebugVar = 0) {
transform, Do12ch, Deref, %Do12ch%
Run, cmd.exe
sleep, 666
Send, %Do12ch%
Sleep, 88
Send {Enter}
sleep, 100
AppendMePls = `n`n%Do12ch%`n`n
transform, AppendMePls, Deref, %AppendMePls%
Fileappend,%AppendMePls%,fUn\debug\log.txt
Gui,Submit, Nohide
}
else {
;msgbox, wao2 %DebugVar%
}
if (DebugVar = 1) {
transform, Do12ch, Deref, %Do12ch%
FileDelete, fUn\debug\runme.bat
;Fileappend,%Do12ch%,fUn\debug\runme.bat
file := FileOpen( "fUn\debug\poop.bat", 1)
file.Write(Do12ch)
file.Close()
sleep, 100
Run, cmd.exe /k fUn\debug\poop.bat
}
else {
;no
}
Return


Render12chan: ;FFMpeg doesnt have channel layout, use this method instead.
gosub, EnableLoop
Gui,Submit, Nohide
12chanRender := 
(
"ffmpeg %AllowLoop% %newinput3% -f rawvideo -pix_fmt %PixFmtIn% %12chanRes% %12chanFR% -y %NewFolder%/output.raw && ^
ffmpeg %12chanFmt% -ar %12chanSR8% -ac 12 -i %NewFolder%/output.raw -y ^
 -filter_complex %Quote%[0:a]pan=mono|c0=c0[a0];[0:a]pan=mono|c0=c1[a1];[0:a]pan=mono|c0=c2[a2];[0:a]pan=mono|c0=c3[a3];[0:a]pan=mono|c0=c4[a4];[0:a]pan=mono|c0=c5[a5];[0:a]pan=mono|c0=c6[a6];[0:a]pan=mono|c0=c7[a7];[0:a]pan=mono|c0=c8[a8];[0:a]pan=mono|c0=c9[a9];[0:a]pan=mono|c0=c10[a10];[0:a]pan=mono|c0=c11[a11]%Quote% ^
-map 0 -map -0:a ^
-map %Quote%[a0]%Quote% %12chanFmt% -ar %12chanSR8% -ac 1 %NewFolder%/c-1.meme ^
-map %Quote%[a1]%Quote% %12chanFmt% -ar %12chanSR8% -ac 1 %NewFolder%/c-2.meme ^
-map %Quote%[a2]%Quote% %12chanFmt% -ar %12chanSR8% -ac 1 %NewFolder%/c-3.meme ^
-map %Quote%[a3]%Quote% %12chanFmt% -ar %12chanSR8% -ac 1 %NewFolder%/c-4.meme ^
-map %Quote%[a4]%Quote% %12chanFmt% -ar %12chanSR8% -ac 1 %NewFolder%/c-5.meme ^
-map %Quote%[a5]%Quote% %12chanFmt% -ar %12chanSR8% -ac 1 %NewFolder%/c-6.meme ^
-map %Quote%[a6]%Quote% %12chanFmt% -ar %12chanSR8% -ac 1 %NewFolder%/c-7.meme ^
-map %Quote%[a7]%Quote% %12chanFmt% -ar %12chanSR8% -ac 1 %NewFolder%/c-8.meme ^
-map %Quote%[a8]%Quote% %12chanFmt% -ar %12chanSR8% -ac 1 %NewFolder%/c-9.meme ^
-map %Quote%[a9]%Quote% %12chanFmt% -ar %12chanSR8% -ac 1 %NewFolder%/c-10.meme ^
-map %Quote%[a10]%Quote% %12chanFmt% -ar %12chanSR8% -ac 1 %NewFolder%/c-11.meme ^
-map %Quote%[a11]%Quote% %12chanFmt% -ar %12chanSR8% -ac 1 %NewFolder%/c-12.meme "
)
if (DebugVar = 0) {
transform, 12chanRender, Deref, %12chanRender%
Run, cmd.exe
Sleep, 88
Sendraw, %12chanRender%
Sleep, 88
Send, {Enter}
sleep, 100
AppendMePls = `n`n%12chanRender%`n`n
transform, AppendMePls, Deref, %AppendMePls%
Fileappend,%AppendMePls%,fUn\debug\log.txt
Gui,Submit, Nohide
}
else {
;msgbox, wao2 %DebugVar%
}
if (DebugVar = 1) {
transform, 12chanRender, Deref, %12chanRender%
;IsBatch := "echo"
;BatchCommand := " > run.bat"
FileDelete, fUn\debug\runme.bat
Fileappend,%12chanRender%,fUn\debug\runme.bat
Run, cmd.exe /k fUn\debug\runme.bat
}
else {
;no
}
Return

Save12chPls:
if (ActivateBinaryVar = 0) {
data = %A_Sec%%A_Min%%A_Hour%
makefilename := MD5(data,StrLen(data))
DOITVAR = no
}
if (ActivateBinaryVar = 1) {
DOITVAR = BinaryPls
PercentVar = `% ; Must have this here also for some reason
}
else
#EscapeChar `
PercentVar = `%
goSub %DOITVAR%

OutputVar := ; START WITH DEFAULT VARIABLE
(
"-c:v huffyuv %NewFolder%/%makefilename%.avi %NewFolder%/%makefilename%.gif -s 320x180 %NewFolder%/%makefilename%-Res.gif -y && ^
ffplay %NewFolder%/%makefilename%.avi -loop 9001"
)
transform, OutputVar, Deref, %OutputVar% ; MAKE SURE YOU PUT THESE TRANSFORMS IN THE RIGHT PLACE, WASTED 2 HOURS ON THIS

GuiControlGet, LoopVar
GuiControlGet, FrameVar
Gui, Submit, Nohide
if NewerInput contains png,jpg,bmp,tiff,jpeg,targa,xwd
{
msgbox, 
(
Image Input Detected!!!
Make sure you hit Render without Enable Loop on
if you wanted a static image.
)
OutputVar :=
(
" %NewFolder%/%makefilename%.xwd %NewFolder%/%makefilename%.bmp -y  && ffplay %NewFolder%/%makefilename%.xwd -fs"
)
transform, OutputVar, Deref, %OutputVar% ; MAKE SURE YOU PUT THESE TRANSFORMS IN THE RIGHT PLACE, WASTED 2 HOURS ON THIS
}
else if NewerInput contains webm,mp4,mkv,avi,nut,wmv,
{
;msgbox, Video Detected.
OutputVar :=
(
"-c:v huffyuv %NewFolder%/%makefilename%.avi %NewFolder%/%makefilename%.gif -s 320x180 %NewFolder%/%makefilename%-Res.gif -y && ^
ffplay %NewFolder%/%makefilename%.avi -loop 9001"
)
transform, OutputVar, Deref, %OutputVar% ; MAKE SURE YOU PUT THESE TRANSFORMS IN THE RIGHT PLACE, WASTED 2 HOURS ON THIS
}
else {
;nothing for now
}
if (LoopVar = 0) {

}
else {
;no
}
if (LoopVar = 1) {
msgbox, 
(
Loop Mode Enabled!
Make sure you Rendered with Loop Enabled first
if this is an an image.
)
OutputVar :=
(
"-c:v huffyuv %NewFolder%/%makefilename%.avi %NewFolder%/%makefilename%.gif -s 320x180 %NewFolder%/%makefilename%-Res.gif -y && ^
ffplay %NewFolder%/%makefilename%.avi -loop 9001"
)
transform, OutputVar, Deref, %OutputVar% ; MAKE SURE YOU PUT THESE TRANSFORMS IN THE RIGHT PLACE, WASTED 2 HOURS ON THIS
}
else {
}
if (FrameVar = 1) {
msgbox, 
(
Exporting as Frames!!! :>
)
OutputVar :=
(
"-f image2 %NewFolder%/frames/frame%PercentVar%04d.png -y"
)
transform, OutputVar, Deref, %OutputVar% ; MAKE SURE YOU PUT THESE TRANSFORMS IN THE RIGHT PLACE, WASTED 2 HOURS ON THIS
}
else {
;no
}


Save12ch := 
(
"ffmpeg %12chanFmt% -ar %12chanSR8% -ac 1 -i %NewFolder%/c-1.meme %12chanFmt% -ar %12chanSR8% -ac 1 -i %NewFolder%/c-2.meme %12chanFmt% -ar %12chanSR8% -ac 1 -i %NewFolder%/c-3.meme ^
%12chanFmt% -ar %12chanSR8% -ac 1 -i %NewFolder%/c-4.meme %12chanFmt% -ar %12chanSR8% -ac 1 -i %NewFolder%/c-5.meme %12chanFmt% -ar %12chanSR8% -ac 1 -i %NewFolder%/c-6.meme ^
%12chanFmt% -ar %12chanSR8% -ac 1 -i %NewFolder%/c-7.meme %12chanFmt% -ar %12chanSR8% -ac 1 -i %NewFolder%/c-8.meme %12chanFmt% -ar %12chanSR8% -ac 1 -i %NewFolder%/c-9.meme ^
%12chanFmt% -ar %12chanSR8% -ac 1 -i %NewFolder%/c-10.meme %12chanFmt% -ar %12chanSR8% -ac 1 -i %NewFolder%/c-11.meme %12chanFmt% -ar %12chanSR8% -ac 1 -i %NewFolder%/c-12.meme ^
-filter_complex %Quote%[0:a]%Ch1af%=%Ch1afVal%[ch1];[1:a]%Ch2af%=%Ch2afVal%[ch2];[2:a]%Ch3af%=%Ch3afVal%[ch3];[3:a]%Ch4af%=%Ch4afVal%[ch4];[4:a]%Ch5af%=%Ch5afVal%[ch5];[5:a]%Ch6af%=%Ch6afVal%[ch6];[6:a]%Ch7af%=%Ch7afVal%[ch7];[7:a]%Ch8af%=%Ch8afVal%[ch8];[8:a]%Ch8af%=%Ch8afVal%[ch9];[9:a]%Ch10af%=%Ch10afVal%[ch10];[10:a]%Ch6af%=%Ch11afVal%[ch11];[11:a]%Ch6af%=%Ch12afVal%[ch12];[ch1][ch2][ch3][ch4][ch5][ch6][ch7][ch8][ch9][ch10][ch11][ch12]amerge=inputs=12[a]%Quote% -map [a] %12chanFmt% -ar %12chanSR8% -ac 12 - | ffmpeg -f rawvideo -pix_fmt %PixFmtOut% %12chanRes% %12chanFR% -i - %OutputVar% "
)
Gui, Submit, Nohide
if (DebugVar = 0) {
transform, Save12ch, Deref, %Save12ch%
Run, cmd.exe
sleep, 666
Send, %Save12ch%
sleep, 88
Send {Enter}
sleep, 100
AppendMePls = `n`n%Save12ch%`n`n
transform, AppendMePls, Deref, %AppendMePls%
Fileappend,%AppendMePls%,fUn\debug\log.txt
Gui,Submit, Nohide
}
else {
;nah
}
if (DebugVar = 1) {
transform, Save12ch, Deref, %Save12ch%
FileDelete, fUn\debug\runme.bat
;Fileappend,%Do12ch%,fUn\debug\runme.bat
file := FileOpen( "fUn\debug\poop.bat", 1)
file.Write(Save12ch)
file.Close()
sleep, 100
Run, cmd.exe /k fUn\debug\poop.bat
}
else {
;no
}
Gui, Submit, Nohide
Return

Shuffle12ch:
Gui, Submit, Nohide
Loop % 12chLayout0-1 {
Random i, A_Index, 12chLayout0
n := 12chLayout%i%, 12chLayout%i% := 12chLayout%A_Index%, 12chLayout%A_Index% := n
}
MsgBox,
(
Channels Shuffled! 

Layout Order is now:
Channel 1: %12chLayout1%
Channel 2: %12chLayout2%
Channel 3: %12chLayout3%
Channel 4: %12chLayout4%
Channel 5: %12chLayout5%
Channel 6: %12chLayout6%
Channel 7: %12chLayout7%
Channel 8: %12chLayout8%
)

Return

msgbox, wao

;=============================================END============================================================


16chan:
16ChLayout0 = 16
16ChLayout1 = FL
16ChLayout2 = FR
16ChLayout3 = FC
16ChLayout4 = BL
16ChLayout5 = BR
16ChLayout6 = BC
16ChLayout7 = SL
16ChLayout8 = SR
16ChLayout9 = TFL
16ChLayout10 = TFC
16ChLayout11 = TFR
16ChLayout12 = TBL
16ChLayout13 = TBC
16ChLayout14 = TBR
16ChLayout15 = WL
16ChLayout16 = WR
;
Gui 12:Color, %GuiColor%, -caption
Gui 12:Add, Button, x139 y562 w110 h42 gDo16Chan, COMMENCE MAGIC
Gui 12:Add, Button, x139 y604 w44 h23 gSave16ChPls, SAVE
Gui 12:Add, Button, x183 y604 w66 h23 g6ChInput, INPUT
Gui 12:Add, ComboBox, x8 y8 w120 vCh1af Choose47, %List8%
Gui 12:Add, ComboBox, x8 y32 w120 Choose20 vCh2af, %List8%
Gui 12:Add, ComboBox, x8 y56 w120 Choose20 vCh3af, %List8%
Gui 12:Add, ComboBox, x8 y80 w120 Choose20 vCh4af, %List8%
Gui 12:Add, ComboBox, x8 y104 w120 Choose20 vCh5af, %List8%
Gui 12:Add, ComboBox, x8 y128 w120 Choose20 vCh6af, %List8%
Gui 12:Add, ComboBox, x8 y152 w120 Choose20 vCh7af, %List8%
Gui 12:Add, ComboBox, x8 y176 w120 Choose20 vCh8af, %List8%
Gui 12:Add, ComboBox, x8 y200 w120 Choose20 vCh9af, %List8%
Gui 12:Add, ComboBox, x8 y224 w120 Choose20 vCh10af, %List8%
Gui 12:Add, ComboBox, x8 y248 w120 Choose20 vCh11af, %List8%
Gui 12:Add, ComboBox, x8 y272 w120 Choose20 vCh12af, %List8%
Gui 12:Add, ComboBox, x8 y296 w120 Choose20 vCh13af, %List8%
Gui 12:Add, ComboBox, x8 y320 w120 Choose20 vCh14af, %List8%
Gui 12:Add, ComboBox, x8 y344 w120 Choose20 vCh15af, %List8%
Gui 12:Add, ComboBox, x8 y368 w120 Choose20 vCh16af, %List8%
Gui 12:Add, ComboBox, x11 y601 w120 vPixFmtIn Choose111, %list4%
Gui 12:Add, ComboBox, x11 y577 w120 vPixFmtOut Choose111, %list4%
Gui 12:Add, Button, x154 y539 w80 h23 gRender16Chan, RENDER
Gui 12:Add, GroupBox, x30 y500 w84 h56, Resolution
Gui 12:Add, Edit, x39 y527 w66 h24 v16ChanRes, -s 640x360
Gui 12:Add, GroupBox, x5 y558 w132 h69, In/Out Colorspace
Gui 12:Add, GroupBox, x71 y454 w58 h46, Framerate
Gui 12:Add, GroupBox, x7 y454 w58 h46, Format
Gui 12:Add, Edit, x16 y473 w39 h22 v16ChanFmt, -f u8
Gui 12:Add, Edit, x81 y473 w39 h21 v16ChanFR, -r 24
Gui 12:Add, Slider, x-2 y403 w262 h28 +0x40 +Tooltip Range666-88100 v16ChanSR8, 88100
Gui 12:Add, CheckBox, x144 y457 w102 h12 vLoopVar gEnableLoop, Enable Loop?
Gui 12:Add, CheckBox, x144 y469 w102 h12 vAudioVar gEnableAudio, "Sync" Audio?
GuiControl, 12:Disable, AudioVar
Gui 12:Add, CheckBox, x144 y481 w102 h12 vFrameVar, Save Frames?
Gui 12:Add, CheckBox, x144 y493 w102 h12, idk?
Gui 12:Add, Button, x185 y527 w12 h12 v16chShuffleVar gShuffle16ch,
Gui 12:Add, Button, x205 y527 w12 h12 v16chGetResVar gGetResolution,
Gui 12:Add, Button, x165 y527 w12 h12 vLocationVar gOpenLocation,
Gui 12:Add, Edit, x128 y8 w120 h21 vCh1afVal
Gui 12:Add, Edit, x128 y32 w120 h21 vCh2afVal
Gui 12:Add, Edit, x128 y56 w120 h21 vCh3afVal
Gui 12:Add, Edit, x128 y80 w120 h21 vCh4afVal
Gui 12:Add, Edit, x128 y104 w120 h21 vCh5afVal
Gui 12:Add, Edit, x128 y128 w120 h21 vCh6afVal
Gui 12:Add, Edit, x128 y152 w120 h21 vCh7afVal
Gui 12:Add, Edit, x128 y176 w120 h21 vCh8afVal
Gui 12:Add, Edit, x128 y200 w120 h21 vCh9afVal
Gui 12:Add, Edit, x128 y224 w120 h21 vCh10afVal
Gui 12:Add, Edit, x128 y248 w120 h21 vCh11afVal
Gui 12:Add, Edit, x128 y272 w120 h21 vCh12afVal
Gui 12:Add, Edit, x128 y296 w120 h21 vCh13afVal
Gui 12:Add, Edit, x128 y320 w120 h21 vCh14afVal
Gui 12:Add, Edit, x128 y344 w120 h21 vCh15afVal
Gui 12:Add, Edit, x128 y368 w120 h21 vCh16afVal

Gui 12:Show, w258 h635, <3 <3 <3
Return


16chInput:
DirectoryVal = MultiChannel
gosub MakeNewFolder

FileCreateDir, OUTPUT\MultiChannel
FileCreateDir, %NewFolder%\frames

gosub, Input
AllowLoop := ""
Gui,Submit, Nohide
return

Do16chan:
Gui,Submit, Nohide ; put submit here first
Do16Ch := 
(
"ffmpeg %16chanFmt% -ar %16chanSR8% -ac 1 -i %NewFolder%/c-1.meme %16chanFmt% -ar %16chanSR8% -ac 1 -i %NewFolder%/c-2.meme %16chanFmt% -ar %16chanSR8% -ac 1 -i %NewFolder%/c-3.meme ^
%16chanFmt% -ar %16chanSR8% -ac 1 -i %NewFolder%/c-4.meme %16chanFmt% -ar %16chanSR8% -ac 1 -i %NewFolder%/c-5.meme %16chanFmt% -ar %16chanSR8% -ac 1 -i %NewFolder%/c-6.meme ^
%16chanFmt% -ar %16chanSR8% -ac 1 -i %NewFolder%/c-7.meme %16chanFmt% -ar %16chanSR8% -ac 1 -i %NewFolder%/c-8.meme %16chanFmt% -ar %16chanSR8% -ac 1 -i %NewFolder%/c-9.meme ^
%16chanFmt% -ar %16chanSR8% -ac 1 -i %NewFolder%/c-10.meme %16chanFmt% -ar %16chanSR8% -ac 1 -i %NewFolder%/c-11.meme %16chanFmt% -ar %16chanSR8% -ac 1 -i %NewFolder%/c-12.meme ^
%16chanFmt% -ar %16chanSR8% -ac 1 -i %NewFolder%/c-13.meme %16chanFmt% -ar %16chanSR8% -ac 1 -i %NewFolder%/c-14.meme %16chanFmt% -ar %16chanSR8% -ac 1 -i %NewFolder%/c-15.meme %16chanFmt% -ar %16chanSR8% -ac 1 -i %NewFolder%/c-16.meme ^
-filter_complex %Quote%[0:a]%Ch1af%=%Ch1afVal%[ch1];[1:a]%Ch2af%=%Ch2afVal%[ch2];[2:a]%Ch3af%=%Ch3afVal%[ch3];[3:a]%Ch4af%=%Ch4afVal%[ch4];[4:a]%Ch5af%=%Ch5afVal%[ch5];[5:a]%Ch6af%=%Ch6afVal%[ch6];[6:a]%Ch7af%=%Ch7afVal%[ch7];[7:a]%Ch8af%=%Ch8afVal%[ch8];[8:a]%Ch9af%=%Ch9afVal%[ch9];[9:a]%Ch10af%=%Ch10afVal%[ch10];[10:a]%Ch11af%=%Ch11afVal%[ch11];[11:a]%Ch12af%=%Ch12afVal%[ch12];[12:a]%Ch13af%=%Ch13afVal%[ch13];[13:a]%Ch14af%=%Ch14afVal%[ch14];[14:a]%Ch15af%=%Ch15afVal%[ch15];[15:a]%Ch16af%=%Ch16afVal%[ch16];[ch1][ch2][ch3][ch4][ch5][ch6][ch7][ch8][ch9][ch10][ch11][ch12][ch13][ch14][ch15][ch16]join=inputs=16:channel_layout=hexadecagonal:map=0.0-%16chLayout1%|1.0-%16chLayout2%|2.0-%16chLayout3%|3.0-%16chLayout4%|4.0-%16chLayout5%|5.0-%16chLayout6%|6.0-%16chLayout7%|7.0-%16chLayout8%|8.0-%16chLayout9%|9.0-%16chLayout10%|10.0-%16chLayout11%|11.0-%16chLayout12%|12.0-%16chLayout13%|13.0-%16chLayout14%|14.0-%16chLayout15%|15.0-%16chLayout16%:[a]%Quote% -map [a] %16chanFmt% -ar %16chanSR8% -ac 16 - | ffplay -f rawvideo -pix_fmt %PixFmtOut% %16chanRes% -i - -fs "
)
if (DebugVar = 0) {
transform, Do16ch, Deref, %Do16ch%
Run, cmd.exe
sleep, 666
Send, %Do16ch%
Sleep, 88
Send {Enter}
sleep, 100
AppendMePls = `n`n%Do16ch%`n`n
transform, AppendMePls, Deref, %AppendMePls%
Fileappend,%AppendMePls%,fUn\debug\log.txt
Gui,Submit, Nohide
}
else {
;msgbox, wao2 %DebugVar%
}
if (DebugVar = 1) {
transform, Do16ch, Deref, %Do16ch%
FileDelete, fUn\debug\runme.bat
;Fileappend,%Do16ch%,fUn\debug\runme.bat
file := FileOpen( "fUn\debug\poop.bat", 1)
file.Write(Do16ch)
file.Close()
sleep, 100
Run, cmd.exe /k fUn\debug\poop.bat
}
else {
;no
}
Return


Render16chan:
gosub, EnableLoop
Gui,Submit, Nohide
16chanRender := 
(
"ffmpeg %AllowLoop% %newinput3% -f rawvideo -pix_fmt %PixFmtIn% %16chanRes% %16chanFR% -y %NewFolder%/output.raw && ^
ffmpeg %16chanFmt% -ar %16chanSR8% -ac 16 -i %NewFolder%/output.raw -y ^
-filter_complex %Quote%channelsplit=channel_layout=hexadecagonal[1][2][3][4][5][6][7][8][9][10][11][12][13][14][15][16]%Quote% ^
-map %Quote%[1]%Quote% %16chanFmt% -ar %16chanSR8% -ac 1 %NewFolder%/c-1.meme ^
-map %Quote%[2]%Quote% %16chanFmt% -ar %16chanSR8% -ac 1 %NewFolder%/c-2.meme ^
-map %Quote%[3]%Quote% %16chanFmt% -ar %16chanSR8% -ac 1 %NewFolder%/c-3.meme ^
-map %Quote%[4]%Quote% %16chanFmt% -ar %16chanSR8% -ac 1 %NewFolder%/c-4.meme ^
-map %Quote%[5]%Quote% %16chanFmt% -ar %16chanSR8% -ac 1 %NewFolder%/c-5.meme ^
-map %Quote%[6]%Quote% %16chanFmt% -ar %16chanSR8% -ac 1 %NewFolder%/c-6.meme ^
-map %Quote%[7]%Quote% %16chanFmt% -ar %16chanSR8% -ac 1 %NewFolder%/c-7.meme ^
-map %Quote%[8]%Quote% %16chanFmt% -ar %16chanSR8% -ac 1 %NewFolder%/c-8.meme ^
-map %Quote%[9]%Quote% %16chanFmt% -ar %16chanSR8% -ac 1 %NewFolder%/c-9.meme ^
-map %Quote%[10]%Quote% %16chanFmt% -ar %16chanSR8% -ac 1 %NewFolder%/c-10.meme ^
-map %Quote%[11]%Quote% %16chanFmt% -ar %16chanSR8% -ac 1 %NewFolder%/c-11.meme ^
-map %Quote%[12]%Quote% %16chanFmt% -ar %16chanSR8% -ac 1 %NewFolder%/c-12.meme ^
-map %Quote%[13]%Quote% %16chanFmt% -ar %16chanSR8% -ac 1 %NewFolder%/c-13.meme ^
-map %Quote%[14]%Quote% %16chanFmt% -ar %16chanSR8% -ac 1 %NewFolder%/c-14.meme ^
-map %Quote%[15]%Quote% %16chanFmt% -ar %16chanSR8% -ac 1 %NewFolder%/c-15.meme ^
-map %Quote%[16]%Quote% %16chanFmt% -ar %16chanSR8% -ac 1 %NewFolder%/c-16.meme"
)
if (DebugVar = 0) {
transform, 16chanRender, Deref, %16chanRender%
Run, cmd.exe
Sleep, 88
Sendraw, %16chanRender%
Sleep, 88
Send, {Enter}
sleep, 100
AppendMePls = `n`n%16chanRender%`n`n
transform, AppendMePls, Deref, %AppendMePls%
Fileappend,%AppendMePls%,fUn\debug\log.txt
Gui,Submit, Nohide
}
else {
;msgbox, wao2 %DebugVar%
}
if (DebugVar = 1) {
transform, 16chanRender, Deref, %16chanRender%
;IsBatch := "echo"
;BatchCommand := " > run.bat"
FileDelete, fUn\debug\runme.bat
Fileappend,%16chanRender%,fUn\debug\runme.bat
Run, cmd.exe /k fUn\debug\runme.bat
}
else {
;no
}
Return

Save16chPls:
if (ActivateBinaryVar = 0) {
data = %A_Sec%%A_Min%%A_Hour%
makefilename := MD5(data,StrLen(data))
DOITVAR = no
}
if (ActivateBinaryVar = 1) {
DOITVAR = BinaryPls
PercentVar = `%
}
else
#EscapeChar `
PercentVar = `%
goSub %DOITVAR%

OutputVar := ; START WITH DEFAULT VARIABLE
(
"-c:v huffyuv %NewFolder%/%makefilename%.avi %NewFolder%/%makefilename%.gif -s 320x180 %NewFolder%/%makefilename%-Res.gif -y && ^
ffplay %NewFolder%/%makefilename%.avi -loop 9001"
)
transform, OutputVar, Deref, %OutputVar% ; MAKE SURE YOU PUT THESE TRANSFORMS IN THE RIGHT PLACE, WASTED 2 HOURS ON THIS

GuiControlGet, LoopVar
GuiControlGet, FrameVar
Gui, Submit, Nohide
if UserInput contains png,jpg,bmp,tiff,jpeg,targa,xwd
{
msgbox, 
(
Image Input Detected!!!
Make sure you hit Render without Enable Loop on
if you wanted a static image.
)
OutputVar :=
(
" %NewFolder%/%makefilename%.xwd %NewFolder%/%makefilename%.bmp -y  && ffplay %NewFolder%/%makefilename%.xwd -fs"
)
transform, OutputVar, Deref, %OutputVar% ; MAKE SURE YOU PUT THESE TRANSFORMS IN THE RIGHT PLACE, WASTED 2 HOURS ON THIS
}
else if UserInput contains webm,mp4,mkv,avi,nut,wmv,
{
;msgbox, Video Detected.
OutputVar :=
(
"-c:v huffyuv %NewFolder%/%makefilename%.avi %NewFolder%/%makefilename%.gif -s 320x180 %NewFolder%/%makefilename%-Res.gif -y && ^
ffplay %NewFolder%/%makefilename%.avi -loop 9001"
)
transform, OutputVar, Deref, %OutputVar% ; MAKE SURE YOU PUT THESE TRANSFORMS IN THE RIGHT PLACE, WASTED 2 HOURS ON THIS
}
else {
;nothing for now
}
if (LoopVar = 0) {

}
else {
;no
}
if (LoopVar = 1) {
msgbox, 
(
Loop Mode Enabled!
Make sure you Rendered with Loop Enabled first
if this is an an image.
)
OutputVar :=
(
"-c:v huffyuv %NewFolder%/%makefilename%.avi %NewFolder%/%makefilename%.gif -s 320x180 %NewFolder%/%makefilename%-Res.gif -y && ^
ffplay %NewFolder%/%makefilename%.avi -loop 9001"
)
transform, OutputVar, Deref, %OutputVar% ; MAKE SURE YOU PUT THESE TRANSFORMS IN THE RIGHT PLACE, WASTED 2 HOURS ON THIS
}
else {
}
if (FrameVar = 1) {
msgbox, 
(
Exporting as Frames!!! :>
)
OutputVar :=
(
"-f image2 %NewFolder%/frames/frame%PercentVar%04d.png -y"
)
transform, OutputVar, Deref, %OutputVar% ; MAKE SURE YOU PUT THESE TRANSFORMS IN THE RIGHT PLACE, WASTED 2 HOURS ON THIS
}
else {
;no
}

Save16ch := 
(
"ffmpeg %16chanFmt% -ar %16chanSR8% -ac 1 -i %NewFolder%/c-1.meme %16chanFmt% -ar %16chanSR8% -ac 1 -i %NewFolder%/c-2.meme %16chanFmt% -ar %16chanSR8% -ac 1 -i %NewFolder%/c-3.meme ^
%16chanFmt% -ar %16chanSR8% -ac 1 -i %NewFolder%/c-4.meme %16chanFmt% -ar %16chanSR8% -ac 1 -i %NewFolder%/c-5.meme %16chanFmt% -ar %16chanSR8% -ac 1 -i %NewFolder%/c-6.meme ^
%16chanFmt% -ar %16chanSR8% -ac 1 -i %NewFolder%/c-7.meme %16chanFmt% -ar %16chanSR8% -ac 1 -i %NewFolder%/c-8.meme %16chanFmt% -ar %16chanSR8% -ac 1 -i %NewFolder%/c-9.meme ^
%16chanFmt% -ar %16chanSR8% -ac 1 -i %NewFolder%/c-10.meme %16chanFmt% -ar %16chanSR8% -ac 1 -i %NewFolder%/c-11.meme %16chanFmt% -ar %16chanSR8% -ac 1 -i %NewFolder%/c-12.meme ^
%16chanFmt% -ar %16chanSR8% -ac 1 -i %NewFolder%/c-13.meme %16chanFmt% -ar %16chanSR8% -ac 1 -i %NewFolder%/c-14.meme %16chanFmt% -ar %16chanSR8% -ac 1 -i %NewFolder%/c-15.meme %16chanFmt% -ar %16chanSR8% -ac 1 -i %NewFolder%/c-16.meme ^
-filter_complex %Quote%[0:a]%Ch1af%=%Ch1afVal%[ch1];[1:a]%Ch2af%=%Ch2afVal%[ch2];[2:a]%Ch3af%=%Ch3afVal%[ch3];[3:a]%Ch4af%=%Ch4afVal%[ch4];[4:a]%Ch5af%=%Ch5afVal%[ch5];[5:a]%Ch6af%=%Ch6afVal%[ch6];[6:a]%Ch7af%=%Ch7afVal%[ch7];[7:a]%Ch8af%=%Ch8afVal%[ch8];[8:a]%Ch9af%=%Ch9afVal%[ch9];[9:a]%Ch10af%=%Ch10afVal%[ch10];[10:a]%Ch11af%=%Ch11afVal%[ch11];[11:a]%Ch12af%=%Ch12afVal%[ch12];[12:a]%Ch13af%=%Ch13afVal%[ch13];[13:a]%Ch14af%=%Ch14afVal%[ch14];[14:a]%Ch15af%=%Ch15afVal%[ch15];[15:a]%Ch16af%=%Ch16afVal%[ch16];[ch1][ch2][ch3][ch4][ch5][ch6][ch7][ch8][ch9][ch10][ch11][ch12][ch13][ch14][ch15][ch16]join=inputs=16:channel_layout=hexadecagonal:map=0.0-%16chLayout1%|1.0-%16chLayout2%|2.0-%16chLayout3%|3.0-%16chLayout4%|4.0-%16chLayout5%|5.0-%16chLayout6%|6.0-%16chLayout7%|7.0-%16chLayout8%|8.0-%16chLayout9%|9.0-%16chLayout10%|10.0-%16chLayout11%|11.0-%16chLayout12%|12.0-%16chLayout13%|13.0-%16chLayout14%|14.0-%16chLayout15%|15.0-%16chLayout16%:[a]%Quote% -map [a] %16chanFmt% -ar %16chanSR8% -ac 16 - | ffmpeg -f rawvideo -pix_fmt %PixFmtOut% %16chanRes% %16chanFR% -i - %OutputVar% "
)
Gui, Submit, Nohide
if (DebugVar = 0) {
transform, Save16ch, Deref, %Save16ch%
Run, cmd.exe
sleep, 666
Send, %Save16ch%
sleep, 88
Send {Enter}
sleep, 100
AppendMePls = `n`n%Save16ch%`n`n
transform, AppendMePls, Deref, %AppendMePls%
Fileappend,%AppendMePls%,fUn\debug\log.txt
Gui,Submit, Nohide
}
else {
;nah
}
if (DebugVar = 1) {
transform, Save16ch, Deref, %Save16ch%
FileDelete, fUn\debug\runme.bat
;Fileappend,%Do16ch%,fUn\debug\runme.bat
file := FileOpen( "fUn\debug\poop.bat", 1)
file.Write(Save16ch)
file.Close()
sleep, 100
Run, cmd.exe /k fUn\debug\poop.bat
}
else {
;no
}
Gui, Submit, Nohide
Return

Shuffle16ch:
Gui, Submit, Nohide
Loop % 16chLayout0-1 {
Random i, A_Index, 16chLayout0
n := 16chLayout%i%, 16chLayout%i% := 16chLayout%A_Index%, 16chLayout%A_Index% := n
}
MsgBox,
(
Channels Shuffled! 

Layout Order is now:
Channel 1: %16chLayout1%
Channel 2: %16chLayout2%
Channel 3: %16chLayout3%
Channel 4: %16chLayout4%
Channel 5: %16chLayout5%
Channel 6: %16chLayout6%
Channel 7: %16chLayout7%
Channel 8: %16chLayout8%
Channel 9: %16chLayout9%
Channel 10: %16chLayout10%
Channel 11: %16chLayout11%
Channel 12: %16chLayout12%
Channel 13: %16chLayout13%
Channel 14: %16chLayout14%
Channel 15: %16chLayout15%
Channel 16: %16chLayout16%
)

Return

;==========================================================
no:
;empty subroutine
return

EnableLoop:
Gui, Submit, Nohide
GuiControlGet, LoopVar
extension = gif
newinput := NewerInput
newinput2 := NewerInput
newinput3 := NewerInput
AllowLoop := "-stream_loop -1"
if NewerInput contains gif
{
AllowLoop := "-ignore_loop 0"
;newinput3 := UserInput ; this might also cause bug!!!!!!!!!!!!!!!!!!!!!!!!!!!
}
else if NewerInput contains jpeg,jpg
{
AllowLoop := "-loop 1"
}
else {
AllowLoop := "-f lavfi -i %Quote%movie=%UserInput2%:loop=0, setpts=N/(FRAME_RATE*TB)%Quote%"
UserInput2 := StrReplace(newinput2, "\", "/")
UserInput2 := StrReplace(UserInput2, "C:", "")
UserInput2 := StrReplace(UserInput2, "-i", "")
UserInput2 := StrReplace(UserInput2, """", "'") ; Replace "  with ' for compatibility for filenames with spaces
newinput3 := "" ; This variable is important to clearing original userinput variable if loop is enabled.
}
if (LoopVar = 0) {
AllowLoop := ""
newinput3 := NewerInput ; This variable is important to reseting userinput if loop is disabled.
}
else {
;newinput3 := UserInput ; here was last change, this causes bug!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
}
transform, AllowLoop, Deref, %AllowLoop%
Gui, Submit, Nohide
return

;=========================================================================================================


;F8::Send, FFmpeg %UserInput% -vcodec %Encoderchoice% -acodec %AEncoderchoice% -vf format=%Pixfmt% %EncoderSetting% | ffplay -vcodec %Decoderchoice% -acodec %ADecoderchoice% -vf format=%Pixfmtdec% %DecoderSetting% -i - {Enter}
F7::
Send, cd fUn {Enter}
Sleep 500, 
Send, "ffmglitch-Input Version.bat" {Enter}
F6:: ; TESTING CLIPBOARD SHIT
AppendMe = %clipboard%`n`n
Fileappend,%AppendMe%,fUn\debug\log.txt
return
F9::Run, fUn/ShittyWebcam.exe,,Hide ; orginally made by a friend to corrupt my streams in realtime ; sends random udp data to 127.0.0.1:1337 ; Will release sauce once we find it
F10::Process,Close, ShittyWebcam.exe
return
F11::Process,Close, ffplay.exe ; get that shit outta here
; If '%ComSpec%' doesnt work as a variable try using 'C:\Windows\system32\cmd.exe' instead
SetTitleMatchMode, 2
F12::
WinClose, %ComSpec%
Process,Close, ffplay.exe
;Process,Close, ffmpeg.exe
return
toggle = 0
#MaxThreadsPerHotkey 2

CapsLock & F1:: ; Use with FFplay or pReViEw with a databent compressed video for best results. Also try having the video paused when doing so ;3

    Toggle := !Toggle
     While Toggle{
        Send, {rbutton}
        sleep 35
    }
return
$!F12:: ; Added the cmd.exe pid to the emergency exit hotkey to fix hanging processes
if (EnableCleanUpModeVar = 1) {
msgbox,  Deleting OUTPUT Directory Contents...
FileRemoveDir, OUTPUT\MultiChannel, 1
FileRemoveDir, OUTPUT\SonifyVideo, 1
FileRemoveDir, OUTPUT\SonifyAudio, 1
FileRemoveDir, OUTPUT\SonifyBatch, 1
FileRemoveDir, OUTPUT\SonifyAudioBatch, 1
}
else {
}
Process, Close, %pid%
ExitApp
return

; Be sure to close cmd.exe later.
OnExit, Exiting

; If cmd.exe exits prematurely, fall through to ExitApp below.
Process, WaitClose, %pid%


GuiClose:
GoSub, GuiEscape
return
2GuiClose:
return
3GuiClose:
Gui, 4:Destroy
return
4GuiClose:
Gui, 4:Destroy
return
5GuiClose:
Gui, 5:Destroy
return
6GuiClose:
Gui, 6:Destroy
return
7GuiClose:
Gui, 7:Destroy
return
8GuiClose:
Gui, 8:Destroy
return
9GuiClose:
Gui, 9:Destroy
return
10GuiClose:
Gui, 10:Destroy
return
11GuiClose:
Gui, 11:Destroy
return
12GuiClose:
Gui, 12:Destroy
return
13GuiClose:
{
GuiControlGet, IsANewFolder,13:, PlsNoNewFolder
iniWrite, %IsANewFolder%, Configuration.ini, NoNewFolder , PlsNoNewFolderVar ;quick fix to save a checkbox config
}
Gui, 13:Destroy
return

#Include fUn/PresetManager.ahk

GuiEscape:
ButtonOK:
Exiting:
OnExit
if (EnableCleanUpModeVar = 1) {
FileDelete, %A_ScriptDir%/OUTPUT
}
Process, Close, %pid% ; May be a bit forceful? No effect if it already closed.
ExitApp
