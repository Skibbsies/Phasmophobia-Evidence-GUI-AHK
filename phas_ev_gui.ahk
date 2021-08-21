#NoEnv
; #Warn
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
#Persistent



; ----------------GLOBAL VARIABLES----------------

global EvidenceOne
global EvidenceTwo
global EvidenceThree

global ExcludedOne
global ExcludedTwo
global ExcludedThree

global AllElements
global NumElements

global GhostList

global GuiActive := true




; ----------------ARRAYS----------------

; Global arrays, containing evidence for each ghost and a list of ghosts.

global GhostProperties := {Spirit:["Fingerprints", "GhostWriting", "SpiritBox"], Wraith:["Fingerprints", "FreezingTemps", "SpiritBox"], Phantom:["FreezingTemps", "GhostOrbs", "EMF5"], Poltergeist:["Fingerprints", "GhostOrbs", "SpiritBox"], Banshee:["Fingerprints", "FreezingTemps", "EMF5"], Jinn:["EMF5", "GhostOrbs", "SpiritBox"], Mare:["FreezingTemps", "GhostOrbs", "SpiritBox"], Revenant:["Fingerprints", "GhostWriting", "EMF5"], Shade:["EMF5", "GhostWriting", "GhostOrbs"], Demon:["FreezingTemps", "GhostWriting", "SpiritBox"], Yurei:["FreezingTemps", "GhostWriting", "GhostOrbs"], Oni:["EMF5", "GhostWriting", "SpiritBox"], Hantu:["Fingerprints", "GhostOrbs", "GhostWriting"], Yokai:["SpiritBox", "GhostOrbs", "GhostWriting"], Evs:["Fingerprints", "GhostWriting", "SpiritBox", "FreezingTemps", "GhostOrbs", "EMF5"], GL:["Spirit", "Wraith", "Phantom", "Poltergeist", "Banshee", "Jinn", "Mare", "Revenant", "Shade", "Demon", "Yurei", "Oni", "Hantu", "Yokai"]}
global GhostPropertiesOriginal := {Spirit:["Fingerprints", "GhostWriting", "SpiritBox"], Wraith:["Fingerprints", "FreezingTemps", "SpiritBox"], Phantom:["FreezingTemps", "GhostOrbs", "EMF5"], Poltergeist:["Fingerprints", "GhostOrbs", "SpiritBox"], Banshee:["Fingerprints", "FreezingTemps", "EMF5"], Jinn:["EMF5", "GhostOrbs", "SpiritBox"], Mare:["FreezingTemps", "GhostOrbs", "SpiritBox"], Revenant:["Fingerprints", "GhostWriting", "EMF5"], Shade:["EMF5", "GhostWriting", "GhostOrbs"], Demon:["FreezingTemps", "GhostWriting", "SpiritBox"], Yurei:["FreezingTemps", "GhostWriting", "GhostOrbs"], Oni:["EMF5", "GhostWriting", "SpiritBox"], Hantu:["Fingerprints", "GhostOrbs", "GhostWriting"], Yokai:["SpiritBox", "GhostOrbs", "GhostWriting"], Evidences:["Fingerprints", "GhostWriting", "SpiritBox", "FreezingTemps", "GhostOrbs", "EMF5"], GL:["Spirit", "Wraith", "Phantom", "Poltergeist", "Banshee", "Jinn", "Mare", "Revenant", "Shade", "Demon", "Yurei", "Oni", "Hantu", "Yokai"]}

newGhostList := []
newGhostList.SetCapacity(GhostProperties.GL.GetCapacity())



; ----------------GUI HANDLING----------------

Gui, -Theme -Resize +AlwaysOnTop +ToolWindow
Gui, Color, Black
Gui, Font, s14, Arial

Gui, Add, Text, cRed, Phasmophobia Evidence GUI

Gui, Font, s10, Arial

Gui, Add, Text, cYellow, A tool to help identify ghost types.

Gui, Add, Tab3, w350 h280 cWhite, How To Use|Journal



; ----------------TAB 1----------------

Gui, Tab, 1

Gui, Add, Text, cWhite, The Evidence Checker tab consists of six drop down `nboxes, and a few buttons. `nDifferent evidence can be included `n(and excluded with the bottom set of drop downs), `nwhich will return the ghost type.
Gui, Add, Text, cFuchsia, F2 CAN BE USED TO TOGGLE THIS GUI IN-GAME.
Gui, Add, Text, cPurple, Ctrl+R can be used to reload this program.



; ----------------TAB 2----------------

Gui, Tab, 2

Gui, Add, Text, cWhite, Evidence Found:

Gui, Add, DropDownList, vEvidenceOne gReturnGhost Choose1 cGreen, None|Fingerprints|GhostWriting|SpiritBox|FreezingTemps|GhostOrbs|EMF5
Gui, Add, DropDownList, vEvidenceTwo gReturnGhost Choose1 cGreen, None|Fingerprints|GhostWriting|SpiritBox|FreezingTemps|GhostOrbs|EMF5
Gui, Add, DropDownList, vEvidenceThree gReturnGhost Choose1 cGreen, None|Fingerprints|GhostWriting|SpiritBox|FreezingTemps|GhostOrbs|EMF5

Gui, Add, Text, cWhite, Evidence Excluded:

Gui, Add, DropDownList, vExcludedOne gReturnGhost Choose1 cRed, None|Fingerprints|GhostWriting|SpiritBox|FreezingTemps|GhostOrbs|EMF5
Gui, Add, DropDownList, vExcludedTwo gReturnGhost Choose1 cRed, None|Fingerprints|GhostWriting|SpiritBox|FreezingTemps|GhostOrbs|EMF5
Gui, Add, DropDownList, vExcludedThree gReturnGhost Choose1 cRed, None|Fingerprints|GhostWriting|SpiritBox|FreezingTemps|GhostOrbs|EMF5

Gui, Font, s10
Gui, Add, Text, x200 y100 w500 h50 cWhite, Potential Ghost Types:
Gui, Add, Text, x200 y140 w500 h500 vGhostList cTeal,

ReturnGhost() ; Present to pre-load the ghost list.

Gui, Show, x0 y0 w380 h370, Main Menu

; Menu, Tray, Icon, %A_ScriptDir%\phas.ico, 1, 2

return



; ################ HOTKEYS ################

F2::
if (GuiActive = true) {
	Gui, Hide
	
	GuiActive := false
} else if (GuiActive = false) {
	GuiActive := true
	
	Gui, Show, x0 y0 w380 h370, Main Menu
} return

^R::
Reload
return



; ################ LABELS & FUNCTIONS ################

GuiClose: ; Closes the GUI on the escape button being clicked.
ExitApp
return

; Evidence Checker

ClearInput: ; Submits and saves user input.
Gui, Submit, NoHide

GhostProperties.GL.1 := GhostPropertiesOriginal.GL.1
GhostProperties.GL.2 := GhostPropertiesOriginal.GL.2
GhostProperties.GL.3 := GhostPropertiesOriginal.GL.3
GhostProperties.GL.4 := GhostPropertiesOriginal.GL.4
GhostProperties.GL.5 := GhostPropertiesOriginal.GL.5
GhostProperties.GL.6 := GhostPropertiesOriginal.GL.6
GhostProperties.GL.7 := GhostPropertiesOriginal.GL.7
GhostProperties.GL.8 := GhostPropertiesOriginal.GL.8
GhostProperties.GL.9 := GhostPropertiesOriginal.GL.9
GhostProperties.GL.10 := GhostPropertiesOriginal.GL.10
GhostProperties.GL.11 := GhostPropertiesOriginal.GL.11
GhostProperties.GL.12 := GhostPropertiesOriginal.GL.12
GhostProperties.GL.13 := GhostPropertiesOriginal.GL.13
GhostProperties.GL.14 := GhostPropertiesOriginal.GL.14
return

ButtonGhostsList: ; Prints a list of potential ghost types that the user is dealing with.
MsgBox, 4096, Ghost Type List, Potential Ghost Types: `n `n%GhostElements%
return

ReturnGhost() { ; The main function that decides which ghost is present. Ghosts that have been excluded will return as "Disproved".
	Gui, Submit, NoHide
	
	GoSub, ClearInput
	
	if (ExcludedOne = GhostProperties.Evs.1 || ExcludedTwo = GhostProperties.Evs.1 || ExcludedThree = GhostProperties.Evs.1)
	{
		GhostProperties.GL.1 := ""
		GhostProperties.GL.2 := ""
		GhostProperties.GL.4 := ""
		GhostProperties.GL.5 := ""
		GhostProperties.GL.8 := ""
		GhostProperties.GL.13 := ""
	}
	
	if (ExcludedOne = GhostProperties.Evs.2 || ExcludedTwo = GhostProperties.Evs.2 || ExcludedThree = GhostProperties.Evs.2)
	{
		GhostProperties.GL.1 := ""
		GhostProperties.GL.8 := ""
		GhostProperties.GL.9 := ""
		GhostProperties.GL.10 := ""
		GhostProperties.GL.11 := ""
		GhostProperties.GL.12 := ""
		GhostProperties.GL.13 := ""
		GhostProperties.GL.14 := ""
	}
	
	if (ExcludedOne = GhostProperties.Evs.3 || ExcludedTwo = GhostProperties.Evs.3 || ExcludedThree = GhostProperties.Evs.3)
	{
		GhostProperties.GL.1 := ""
		GhostProperties.GL.2 := ""
		GhostProperties.GL.4 := ""
		GhostProperties.GL.6 := ""
		GhostProperties.GL.7 := ""
		GhostProperties.GL.10 := ""
		GhostProperties.GL.12 := ""
		GhostProperties.GL.14 := ""
	}
	
	if (ExcludedOne = GhostProperties.Evs.4 || ExcludedTwo = GhostProperties.Evs.4 || ExcludedThree = GhostProperties.Evs.4)
	{
		GhostProperties.GL.2 := ""
		GhostProperties.GL.3 := ""
		GhostProperties.GL.5 := ""
		GhostProperties.GL.7 := ""
		GhostProperties.GL.10 := ""
		GhostProperties.GL.11 := ""
	}
	
	if (ExcludedOne = GhostProperties.Evs.5 || ExcludedTwo = GhostProperties.Evs.5 || ExcludedThree = GhostProperties.Evs.5)
	{
		GhostProperties.GL.3 := ""
		GhostProperties.GL.4 := ""
		GhostProperties.GL.6 := ""
		GhostProperties.GL.7 := ""
		GhostProperties.GL.9 := ""
		GhostProperties.GL.11 := ""
		GhostProperties.GL.13 := ""
		GhostProperties.GL.14 := ""
	}
	
	if (ExcludedOne = GhostProperties.Evs.6 || ExcludedTwo = GhostProperties.Evs.6 || ExcludedThree = GhostProperties.Evs.6)
	{
		GhostProperties.GL.3 := ""
		GhostProperties.GL.5 := ""
		GhostProperties.GL.6 := ""
		GhostProperties.GL.8 := ""
		GhostProperties.GL.9 := ""
		GhostProperties.GL.12 := ""
	}
	
	
	if (EvidenceOne = GhostProperties.Evs.1 || EvidenceTwo = GhostProperties.Evs.1 || EvidenceThree = GhostProperties.Evs.1)
	{
		GhostProperties.GL.3 := ""
		GhostProperties.GL.6 := ""
		GhostProperties.GL.7 := ""
		GhostProperties.GL.9 := ""
		GhostProperties.GL.10 := ""
		GhostProperties.GL.11 := ""
		GhostProperties.GL.12 := ""
		GhostProperties.GL.14 := ""
	}
	
	if (EvidenceOne = GhostProperties.Evs.2 || EvidenceTwo = GhostProperties.Evs.2 || EvidenceThree = GhostProperties.Evs.2)
	{
		GhostProperties.GL.2 := ""
		GhostProperties.GL.3 := ""
		GhostProperties.GL.4 := ""
		GhostProperties.GL.5 := ""
		GhostProperties.GL.6 := ""
		GhostProperties.GL.7 := ""
	}
	
	if (EvidenceOne = GhostProperties.Evs.3 || EvidenceTwo = GhostProperties.Evs.3 || EvidenceThree = GhostProperties.Evs.3)
	{
		GhostProperties.GL.3 := ""
		GhostProperties.GL.5 := ""
		GhostProperties.GL.8 := ""
		GhostProperties.GL.9 := ""
		GhostProperties.GL.11 := ""
		GhostProperties.GL.13 := ""
	}
	
	if (EvidenceOne = GhostProperties.Evs.4 || EvidenceTwo = GhostProperties.Evs.4 || EvidenceThree = GhostProperties.Evs.4)
	{
		GhostProperties.GL.1 := ""
		GhostProperties.GL.4 := ""
		GhostProperties.GL.6 := ""
		GhostProperties.GL.8 := ""
		GhostProperties.GL.9 := ""
		GhostProperties.GL.12 := ""
		GhostProperties.GL.13 := ""
		GhostProperties.GL.14 := ""
	}
	
	if (EvidenceOne = GhostProperties.Evs.5 || EvidenceTwo = GhostProperties.Evs.5 || EvidenceThree = GhostProperties.Evs.5)
	{
		GhostProperties.GL.1 := ""
		GhostProperties.GL.2 := ""
		GhostProperties.GL.5 := ""
		GhostProperties.GL.8 := ""
		GhostProperties.GL.10 := ""
		GhostProperties.GL.12 := ""
	}
	
	if (EvidenceOne = GhostProperties.Evs.6 || EvidenceTwo = GhostProperties.Evs.6 || EvidenceThree = GhostProperties.Evs.6)
	{
		GhostProperties.GL.1 := ""
		GhostProperties.GL.2 := ""
		GhostProperties.GL.4 := ""
		GhostProperties.GL.7 := ""
		GhostProperties.GL.10 := ""
		GhostProperties.GL.11 := ""
		GhostProperties.GL.13 := ""
		GhostProperties.GL.14 := ""
	}
	
	global GhostElements := ""
	global GNElements := ObjLength(GhostProperties.GL)
	
	Loop % GhostProperties.GL.length()
		GhostElements := GhostElements . GhostProperties.GL[A_Index] . "`n"
		GuiControl, Text, GhostList, %GhostElements%
	return
}
