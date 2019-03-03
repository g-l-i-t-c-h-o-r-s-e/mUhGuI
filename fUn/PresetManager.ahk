#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

PresetsConfigs1()
{
	iniRead, PresetVar, Configuration.ini, MainPresetsList, SelPreset
    global	Presets := PresetVar
	
	
	Gui, wao:Destroy
	Gui, wao:Color, 884488
	Gui, wao:Show, w220 h147,Main Presets
	Gui, wao:Add, ComboBox, w200 vSelPreset, %PresetVar%
	Gui, wao:Add, Button, x33 w150 h50 gLoadMainPreset, Load Preset
	Gui, wao:Add, Button, x66 gSubmitMainConfig, Save Settings
	Gui, wao:Add, Checkbox, x1 y116 vPlsNoFolder,Disable New Folder [When Preset Loaded]
	Gui, wao:Add, Checkbox, x1 y130 vPlsNoInput,Disable Preset Input File
	WinSet, AlwaysOnTop,, Main,
	WinMove, Main,, 0 +10, 0 +10
}

PresetsConfigs2()
{
	iniRead, PresetVar, Configuration.ini, SonificationPresetsList, SelPreset
    global	Presets := PresetVar
	
	Gui, wao:Destroy
	Gui, wao:Color, 884488
	Gui, wao:Show, w220 h147,A/V Sonification Presets
	Gui, wao:Add, ComboBox, w200 vSelPreset, %PresetVar%
	Gui, wao:Add, Button, x33 w150 h50 gLoadSoniPreset, Load Preset
	Gui, wao:Add, Button, x66 gSubmitSonificationConfig, Save Settings
	Gui, wao:Add, Checkbox, x1 y116 vPlsNoFolder,Disable New Folder [When Preset Loaded]
    Gui, wao:Add, Checkbox, x1 y130 vPlsNoInput,Disable Preset Input File
	WinSet, AlwaysOnTop,, A/V,
	WinMove, A/V,, 0 +10, 0 +10
}

GetPresetWindow:
ifWinActive, WARNING!!!
 {
  PresetsConfigs1()
 return
 }

ifWinActive, ITSHAPPENING
 {
  PresetsConfigs2()
 return
 }
Return
 
 
SubmitMainConfig:
 Gui, Submit, NoHide
 GuiControlGet, PresetName,, SelPreset
 GuiControlGet, Slider1Var,, aDecSmplr8
 GuiControlGet, ComboBoxVal,, ComboBox1

 iniWrite, %Comments%, Configuration.ini, %SelPreset% , Comments
 iniWrite, %Slider1Var%, Configuration.ini, %SelPreset% , Slider1
 iniWrite, %ComboBoxVal%, Configuration.ini, %SelPreset% , ComboBox1

ifNotInString, Presets, %SelPreset%
{
   msgbox, Adding New Preset!
   Presets := Presets . "|"PresetName
  }
 
 splitList := StrReplace(Presets, "`n", "|")
 msgbox, %Presets%
 GuiControl,, SelPreset, |%splitList%
 GuiControl, Choose, SelPreset, %PresetName%
 iniWrite, %Presets%, Configuration.ini, MainPresetsList , SelPreset


LoadMainPreset:
 Gui, Submit, Nohide
 iniRead, commentsVar, Configuration.ini, %SelPreset% , Comments
 iniRead, Slider1Var, Configuration.ini, %SelPreset% , Slider1
 iniRead, ComboBoxVal, Configuration.ini, %SelPreset% , ComboBox1

 GuiControl,, Comments, %commentsVar%
 GuiControl,, aDecSmplr8, %Slider1Var%
 GuiControl, Choose, SelPreset, %PresetVar%
 GuiControl, Choose, ComboBox1, %ComboBoxVal%
 return

 ;Get GUI Elements contents, and assign to new variables.
SubmitSonificationConfig:
 Gui, Submit, NoHide
 MeFileInput := NewerInput
 GuiControlGet, PresetName,, SelPreset
 GuiControlGet, vCompressorVar,3:,vCompressor
 GuiControlGet, AencodercodecVar,3:, Aencodercodec
 GuiControlGet, BentACodecVar,3:, BentAcodec
 GuiControlGet, BentVCodecVar,3:, BentVcodec
 GuiControlGet, AFiltersVar,3:, AFilters
 GuiControlGet, vFiltersVar,3:, vFilters
 GuiControlGet, aEncParamVar,3:, aEncParam
 GuiControlGet, vEncParamVar,3:, vEncParam
 GuiControlGet, OutputFmtVar,3:, OutputFmt
 GuiControlGet, InputFmtVar,3:, InputFmt
 GuiControlGet, EncFmtVar,3:, EncFmt
 GuiControlGet, DecFmtVar,3:, DecFmt
 GuiControlGet, Effect1Var,3:, Effect1
 GuiControlGet, Effect2Var,3:, Effect2
 GuiControlGet, Effect3Var,3:, Effect3
 GuiControlGet, FXParam1Var,3:, FXParam1
 GuiControlGet, FXParam2Var,3:, FXParam2
 GuiControlGet, FXParam3Var,3:, FXParam3
 GuiControlGet, vDecSmplr8Var,3:, vDecSmplr8
 GuiControlGet, aDecSmplr8Var,3:, aDecSmplr8
 GuiControlGet, GlobalResVar,3:, GlobalRes
 GuiControlGet, ChanCount1Var,3:, ChanCount1
 GuiControlGet, ChanCount2Var,3:, ChanCount2
 GuiControlGet, ChanCount3Var,3:, ChanCount3
 GuiControlGet, ChanCount4Var,3:, ChanCount4
 GuiControlGet, LePixFmtInVar,3:, LePixFmtIn
 GuiControlGet, LePixFmtOutVar,3:, LePixFmtOut
 GuiControlGet, LeSoxVar,3:, SoxVar
 GuiControlGet, LeNibbleVar,3:, NibbleVar
 GuiControlGet, LeBitVar,3:, BitVar
 
ifNotInString, Presets, %SelPreset%
{
 If RegExMatch(NewerInput,"(jpg|png|jpeg|bmp|wmv|avi|mp4|gif)")
  {
 PresetName := PresetName . " (v)"
  }
 If RegExMatch(NewerInput,"(mp3|mp2|wav|flac|aic)")
  {
 PresetName := PresetName . " (a)"
  }
   msgbox, Adding New Preset!
   Presets := Presets . "|"PresetName
}
SelPreset := PresetName
splitList := StrReplace(Presets, "`n", "|")
GuiControl,, SelPreset, |%splitList%
GuiControl, Choose, SelPreset, %PresetName%
iniWrite, %Presets%, Configuration.ini, SonificationPresetsList , SelPreset
 
 ;Write GUI Elements into Config.
 iniWrite, %MeFileInput%, Configuration.ini, %SelPreset% , InputFileVar
 iniWrite, %vCompressorVar%, Configuration.ini, %SelPreset% , vCompressorVar
 iniWrite, %AencodercodecVar%, Configuration.ini, %SelPreset% , AencodercodecVar
 iniWrite, %BentACodecVar%, Configuration.ini, %SelPreset% , BentACodecVar
 iniWrite, %BentVCodecVar%, Configuration.ini, %SelPreset% , BentVCodecVar
 iniWrite, %AFiltersVar%, Configuration.ini, %SelPreset% , AFiltersVar
 iniWrite, %vFiltersVar%, Configuration.ini, %SelPreset% , vFiltersVar
 iniWrite, %aEncParamVar%, Configuration.ini, %SelPreset% , aEncParamVar
 iniWrite, %vEncParamVar%, Configuration.ini, %SelPreset% , vEncParamVar
 iniWrite, %OutputFmtVar%, Configuration.ini, %SelPreset% , OutputFmtVar
 iniWrite, %InputFmtVar%, Configuration.ini, %SelPreset% , InputFmtVar
 iniWrite, %EncFmtVar%, Configuration.ini, %SelPreset% , EncFmtVar
 iniWrite, %DecFmtVar%, Configuration.ini, %SelPreset% , DecFmtVar
 iniWrite, %Effect1Var%, Configuration.ini, %SelPreset% , Effect1Var
 iniWrite, %Effect2Var%, Configuration.ini, %SelPreset% , Effect2Var
 iniWrite, %Effect3Var%, Configuration.ini, %SelPreset% , Effect3Var
 iniWrite, %FXParam1Var%, Configuration.ini, %SelPreset% , FXParam1Var
 iniWrite, %FXParam2Var%, Configuration.ini, %SelPreset% , FXParam2Var
 iniWrite, %FXParam3Var%, Configuration.ini, %SelPreset% , FXParam3Var
 iniWrite, %vDecSmplr8Var%, Configuration.ini, %SelPreset% , vDecSmplr8Var
 iniWrite, %aDecSmplr8Var%, Configuration.ini, %SelPreset% , aDecSmplr8Var
 iniWrite, %GlobalResVar%, Configuration.ini, %SelPreset% , GlobalResVar
 iniWrite, %ChanCount1Var%, Configuration.ini, %SelPreset% , ChanCount1Var
 iniWrite, %ChanCount2Var%, Configuration.ini, %SelPreset% , ChanCount2Var
 iniWrite, %ChanCount3Var%, Configuration.ini, %SelPreset% , ChanCount3Var
 iniWrite, %ChanCount4Var%, Configuration.ini, %SelPreset% , ChanCount4Var
 iniWrite, %LePixFmtInVar%, Configuration.ini, %SelPreset% , LePixFmtInVar
 iniWrite, %LePixFmtOutVar%, Configuration.ini, %SelPreset% , LePixFmtOutVar
 iniWrite, %LeSoxVar%, Configuration.ini, %SelPreset% , LeSoxVar
 iniWrite, %LeNibbleVar%, Configuration.ini, %SelPreset% , LeNibbleVar
 iniWrite, %LeBitVar%, Configuration.ini, %SelPreset% , LeBitVar

Return


LoadSoniPreset:
Gui, Submit, Nohide
iniRead, InputFileVar, Configuration.ini, %SelPreset% , InputFileVar
PlsDo := ""

If (PlsnoInput = 1)
  {
 NewerInput := NewerInput
  }

If (PlsNoInput = 0)
  {
 global NewerInput := InputFileVar
  }

If (PlsNoFolder = 1)
  {
 PlsDo = no
  }

If (PlsNoFolder = 0)
  {
 PlsDo = MakeNewFolder
  }

If RegExMatch(NewerInput,"(jpg|png|jpeg|bmp|wmv|avi|mp4|gif)")
 {
 If (PlsnoInput = 0)
   {
  msgbox, Preset Video or Image Detected!`n Your File Input is:`n%NewerInput%
   }
DirectoryVal = SonifyVideo
gosub %PlsDo%
NewFolder = %NewFolder%
FileCreateDir, OUTPUT\SonifyVideo
FileCreateDir, %NewFolder%
 }
else
If RegExMatch(NewerInput,"(mp3|wav)")
{
If (PlsnoInput = 0)
{
msgbox, Audio Detected!`n Your File Input is:`n%NewerInput%
}
DirectoryVal = SonifyAudio
gosub %PlsDo%
NewFolder = %NewFolder%
FileCreateDir, OUTPUT\SonifyAudio
FileCreateDir, %NewFolder%
}

;Save GUI Elements into the config
iniRead, vCompressor, Configuration.ini, %SelPreset% , vCompressorVar
iniRead, AencodercodecVar, Configuration.ini, %SelPreset% , AencodercodecVar
iniRead, BentACodecVar, Configuration.ini, %SelPreset% , BentACodecVar
iniRead, BentVCodecVar, Configuration.ini, %SelPreset% , BentVCodecVar
iniRead, AFiltersVar, Configuration.ini, %SelPreset% , AFiltersVar
iniRead, VFiltersVar, Configuration.ini, %SelPreset% , VFiltersVar
iniRead, aEncParamVar, Configuration.ini, %SelPreset% , aEncParamVar
iniRead, vEncParamVar, Configuration.ini, %SelPreset% , vEncParamVar
iniRead, OutputFmtVar, Configuration.ini, %SelPreset% , OutputFmtVar
iniRead, InputFmtVar, Configuration.ini, %SelPreset% , InputFmtVar
iniRead, EncFmtVar, Configuration.ini, %SelPreset% , EncFmtVar
iniRead, DecFmtVar, Configuration.ini, %SelPreset% , DecFmtVar
iniRead, Effect1Var, Configuration.ini, %SelPreset% , Effect1Var
iniRead, Effect2Var, Configuration.ini, %SelPreset% , Effect2Var
iniRead, Effect3Var, Configuration.ini, %SelPreset% , Effect3Var
iniRead, FXParam1Var, Configuration.ini, %SelPreset% , FXParam1Var
iniRead, FXParam2Var, Configuration.ini, %SelPreset% , FXParam2Var
iniRead, FXParam3Var, Configuration.ini, %SelPreset% , FXParam3Var
iniRead, vDecSmplr8Var, Configuration.ini, %SelPreset% , vDecSmplr8Var
iniRead, aDecSmplr8Var, Configuration.ini, %SelPreset% , aDecSmplr8Var
iniRead, GlobalResVar, Configuration.ini, %SelPreset% , GlobalResVar
iniRead, ChanCount1Var, Configuration.ini, %SelPreset% , ChanCount1Var
iniRead, ChanCount2Var, Configuration.ini, %SelPreset% , ChanCount2Var
iniRead, ChanCount3Var, Configuration.ini, %SelPreset% , ChanCount3Var
iniRead, ChanCount4Var, Configuration.ini, %SelPreset% , ChanCount4Var
iniRead, LePixFmtInVar, Configuration.ini, %SelPreset% , LePixFmtInVar
iniRead, LePixFmtOutVar, Configuration.ini, %SelPreset% , LePixFmtOutVar
iniRead, LeSoxVar, Configuration.ini, %SelPreset% , LeSoxVar
iniRead, LeNibbleVar, Configuration.ini, %SelPreset% , LeNibbleVar
iniRead, LeBitVar, Configuration.ini, %SelPreset% , LeBitVar

;Assign GUI Elements to their corresponding controllers
GuiControl, 3:Choose, vCompressor, %vCompressor%
GuiControl, 3:Choose, Aencodercodec, %AencodercodecVar%
GuiControl, 3:Choose, BentACodec, %BentACodecVar%
GuiControl, 3:Choose, BentVCodec, %BentVCodecVar%
GuiControl, 3:, AFilters, %AFiltersVar%
GuiControl, 3:, VFilters, %VFiltersVar%
GuiControl, 3:, aEncParam, %aEncParamVar%
GuiControl, 3:, vEncParam, %vEncParamVar%
GuiControl, 3:, OutputFmt, %OutputFmtVar%
GuiControl, 3:, InputFmt, %InputFmtVar%
GuiControl, 3:, EncFmt, %EncFmtVar%
GuiControl, 3:, DecFmt, %DecFmtVar%	
GuiControl, 3:Choose, Effect1, %Effect1Var%
GuiControl, 3:Choose, Effect2, %Effect2Var%
GuiControl, 3:Choose, Effect3, %Effect3Var%
GuiControl, 3:, FXParam1, %FXParam1Var%
GuiControl, 3:, FXParam2, %FXParam2Var%
GuiControl, 3:, FXParam3, %FXParam3Var%
GuiControl, 3:, vDecSmplr8, %vDecSmplr8Var%
GuiControl, 3:, aDecSmplr8, %aDecSmplr8Var%
GuiControl, 3:, GlobalRes, %GlobalResVar%
GuiControl, 3:Choose, ChanCount1, %ChanCount1Var%
GuiControl, 3:Choose, ChanCount2, %ChanCount2Var%
GuiControl, 3:Choose, ChanCount3, %ChanCount3Var%
GuiControl, 3:Choose, ChanCount4, %ChanCount4Var%
GuiControl, 3:Choose, LePixFmtIn, %LePixFmtInVar%
GuiControl, 3:Choose, LePixFmtOut, %LePixFmtOutVar%
GuiControl, 3:, SoxVar, %LeSoxVar%
GuiControl, 3:, NibbleVar, %LeNibbleVar%
GuiControl, 3:, BitVar, %LeBitVar%
return
