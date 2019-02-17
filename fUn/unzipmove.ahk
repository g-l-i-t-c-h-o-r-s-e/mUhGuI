SplashTextOn, 400, 40, ,Unzipping FFMpeg, Moving,`nAnd Setting Up Enviroment Variable...
/*
===============ALSO EDITED BY PANDELA TO UPDATE CURRENT "PATH" ENVIROMENT VARIABLE TO POINT TO MUHGUI AND SHIT===============
           ,---,                                          ,--,    
           ,--.' |                                        ,--.'|    
           |  |  :                      .--.         ,--, |  | :    
  .--.--.  :  :  :                    .--,`|       ,'_ /| :  : '    
 /  /    ' :  |  |,--.  ,--.--.       |  |.   .--. |  | : |  ' |    
|  :  /`./ |  :  '   | /       \      '--`_ ,'_ /| :  . | '  | |    
|  :  ;_   |  |   /' :.--.  .-. |     ,--,'||  ' | |  . . |  | :    
 \  \    `.'  :  | | | \__\/: . .     |  | '|  | ' |  | | '  : |__  
  `----.   \  |  ' | : ," .--.; |     :  | |:  | : ;  ; | |  | '.'| 
 /  /`--'  /  :  :_:,'/  /  ,.  |   __|  : ''  :  `--'   \;  :    ; 
'--'.     /|  | ,'   ;  :   .'   \.'__/\_: |:  ,      .-./|  ,   /  
  `--'---' `--''     |  ,     .-./|   :    : `--`----'     ---`-'   
                      `--`---'     \   \  /                         
                                    `--`-'  
Zip/Unzip file(s)/folder(s)/wildcard pattern files
Requires: Autohotkey_L, Windows > XP
URL: http://www.autohotkey.com/forum/viewtopic.php?t=65401 
From: https://github.com/shajul/Autohotkey/blob/master/COM/Zip%20Unzip%20Natively%20(1%20file%20or%20folder).ahk
Credits: Sean for original idea
*/

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SetWorkingDir %A_ScriptDir%\..  ; Ensures a consistent starting directory, using previous folder instead via \..

GetZip := list_files(A_WorkingDir) ;Get FFMPEG zip filename
list_files(Directory)
{
 file =
  Loop %Directory%\*.zip*
 {
    files = %files%%A_LoopFileName%
 }
  return files
}

SplitPath, GetZip, name, dir, ext, name_no_ext, drive
global ItsName = % name_no_ext

PickedZip = %GetZip%

;; --------- 	VARIABLES HERE	-------------------------------------
sZip := A_WorkingDir "\" PickedZip          ;Source File
sUnz := A_WorkingDir . "\download\"      ;Directory to unzip files
FileCreateDir, download              ; make me download folder
Unz(sZip,sUnz) ; FUCKEN START IT
;; --------- 	END VARIABLES 	-------------------------------------

Unz(sZip, sUnz)
{
    fso := ComObjCreate("Scripting.FileSystemObject")
    If Not fso.FolderExists(sUnz)  ;http://www.autohotkey.com/forum/viewtopic.php?p=402574
       fso.CreateFolder(sUnz)
    psh  := ComObjCreate("Shell.Application")
    zippedItems := psh.Namespace( sZip ).items().count
    psh.Namespace( sUnz ).CopyHere( psh.Namespace( sZip ).items, 4|16 )
    Loop {
	;msgbox, %ItsName%
        sleep 100
        unzippedItems := psh.Namespace( sUnz ).items().count
        ;SplashTextOn, 400, 40, ,Unzipping, moving, and setting up enviroment variable
        IfEqual,unzippedItems,%unzippedItems% ; edited this to both be "unzippedItems" because the script just kept hanging.
		FileMove, %A_WorkingDir%\download\%ItsName%\bin\*.exe, %A_WorkingDir% ; move the ffmpeg binaries to the main folder
		sleep, 30
		FileRemoveDir, %A_WorkingDir%/download, 1 ; delete ffmpeg folder
		sleep, 30
        EnvUpdate
		
        SetWorkingDir %A_ScriptDir%\..
        EnvGet, CheckPathEnvVar, PATH
        NewPath = %A_WorkingDir%;%CheckPathEnvVar%
        runwait, %ComSpec% /c setx path "%NewPath%" ; append "muhgui-master" to the PATH windows enviroment variable, to enable your new ffmpeg binaries in command line.
		
        FileDelete,%A_WorkingDir%\fUn\debug\PATH-Enviroment-Variable-BACKUP.txt 
		Fileappend,%CheckPathEnvVar%,%A_WorkingDir%\fUn\debug\PATH-Enviroment-Variable-BACKUP.txt ; backup PATH enviroment variable
            break
    }
    ;SplashTextOff
}
FileDelete,%A_WorkingDir%\%PickedZip%
;; ----------- 	END FUNCTIONS   -------------------------------------
