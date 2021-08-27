#NoEnv
; #Warn
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance Force

; Global Variables

global EvidenceOne
global EvidenceTwo
global EvidenceThree

global ExcludedOne
global ExcludedTwo
global ExcludedThree

global AllElements
global NumElements

global GhostList
global EvidenceList

global GuiActive := true


; Global arrays, containing evidence for each ghost and a list of ghosts.

global GhostProperties := {Spirit:["EMF5", "Writing", "Box"], Wraith:["EMF5", "DOTS", "Box"], Phantom:["Box", "DOTS", "Prints"], Poltergeist:["Prints", "Writing", "Box"], Banshee:["Prints", "Orbs", "DOTS"], Jinn:["EMF5", "Prints", "FreezingTemps"], Mare:["Writing", "Orbs", "Box"], Revenant:["Orbs", "Writing", "FreezingTemps"], Shade:["EMF5", "Writing", "FreezingTemps"], Demon:["FreezingTemps", "Writing", "Prints"], Yurei:["FreezingTemps", "DOTS", "Orbs"], Oni:["EMF5", "FreezingTemps", "DOTS"], Hantu:["Prints", "Orbs", "FreezingTemps"], Yokai:["Box", "Orbs", "DOTS"], Goryo:["EMF5", "Prints", "DOTS"], Myling:["EMF5", "Prints", "Writing"], Evs:["Prints", "Writing", "Box", "FreezingTemps", "Orbs", "EMF5", "DOTS"], Ev:["Prints", "Writing", "Box", "FreezingTemps", "Orbs", "EMF5", "DOTS"], GL:["Spirit", "Wraith", "Phantom", "Poltergeist", "Banshee", "Jinn", "Mare", "Revenant", "Shade", "Demon", "Yurei", "Oni", "Hantu", "Yokai", "Goryo", "Myling"]}
global GhostPropertiesOriginal := {Spirit:["EMF5", "Writing", "Box"], Wraith:["EMF5", "DOTS", "Box"], Phantom:["Box", "DOTS", "Prints"], Poltergeist:["Prints", "Writing", "Box"], Banshee:["Prints", "Orbs", "DOTS"], Jinn:["EMF5", "Prints", "FreezingTemps"], Mare:["Writing", "Orbs", "Box"], Revenant:["Orbs", "Writing", "FreezingTemps"], Shade:["EMF5", "Writing", "FreezingTemps"], Demon:["FreezingTemps", "Writing", "Prints"], Yurei:["FreezingTemps", "DOTS", "Orbs"], Oni:["EMF5", "FreezingTemps", "DOTS"], Hantu:["Prints", "Orbs", "FreezingTemps"], Yokai:["Box", "Orbs", "DOTS"], Goryo:["EMF5", "Prints", "DOTS"], Myling:["EMF5", "Prints", "Writing"], Evs:["Prints", "Writing", "Box", "FreezingTemps", "Orbs", "EMF5", "DOTS"], Ev:["Prints", "Writing", "Box", "FreezingTemps", "Orbs", "EMF5", "DOTS"], GL:["Spirit", "Wraith", "Phantom", "Poltergeist", "Banshee", "Jinn", "Mare", "Revenant", "Shade", "Demon", "Yurei", "Oni", "Hantu", "Yokai", "Goryo", "Myling"]}

newGhostList := []
newGhostList.SetCapacity(GhostProperties.GL.GetCapacity())


; Initialising the GUI

Gui, -Theme -Resize +AlwaysOnTop +ToolWindow
Gui, Color, Black
Gui, Font, s14, Arial

Gui, Add, Text, cRed, Phasmophobia Evidence GUI

Gui, Font, s10, Arial

Gui, Add, Text, cYellow, A tool to help identify ghost types.

Gui, Add, Tab3, w350 h280 cWhite, How To Use|Journal


; How to use

Gui, Tab, 1

Gui, Add, Text, cWhite, The Evidence Checker tab consists of six drop down `nboxes, and a few buttons. `nDifferent evidence can be included `n(and excluded with the bottom set of drop downs), `nwhich will return the ghost type.
Gui, Add, Text, cFuchsia, F2 CAN BE USED TO TOGGLE THIS GUI IN-GAME.


; Evidence Checker - input fields that the user can interact with to return the ghost type they're dealing with.

Gui, Tab, 2

Gui, Add, Text, cWhite, Evidence Found:

Gui, Add, DropDownList, vEvidenceOne gReturnGhost Choose1 cGreen Sort, -|Prints|Writing|Box|FreezingTemps|Orbs|EMF5|DOTS
Gui, Add, DropDownList, vEvidenceTwo gReturnGhost Choose1 cGreen Sort, -|Prints|Writing|Box|FreezingTemps|Orbs|EMF5|DOTS
Gui, Add, DropDownList, vEvidenceThree gReturnGhost Choose1 cGreen Sort, -|Prints|Writing|Box|FreezingTemps|Orbs|EMF5|DOTS

Gui, Add, Text, cWhite, Evidence Excluded:

Gui, Add, DropDownList, vExcludedOne gReturnGhost Choose1 cRed Sort, -|Prints|Writing|Box|FreezingTemps|Orbs|EMF5|DOTS
Gui, Add, DropDownList, vExcludedTwo gReturnGhost Choose1 cRed Sort, -|Prints|Writing|Box|FreezingTemps|Orbs|EMF5|DOTS
Gui, Add, DropDownList, vExcludedThree gReturnGhost Choose1 cRed Sort, -|Prints|Writing|Box|FreezingTemps|Orbs|EMF5|DOTS


Gui, Font, s10
Gui, Add, Text, x200 y100 w500 h50 cWhite, Types:
Gui, Add, Text, x275 y100 w500 h50 cWhite, Evidence:
Gui, Font, s9
Gui, Add, Text, x200 y120 w70 h500 vGhostList cAqua,
Gui, Add, Text, x275 y120 w100 h500 vEvidenceList cRed,

ReturnGhost()

Gui, Show, x0 y0 w380 h370, Main Menu

; Menu, Tray, Icon, %A_ScriptDir%\Phas\phas.ico, 1, 2

return

F2::
if (GuiActive = true) {
	Gui, Hide
	
	GuiActive := false
} else if (GuiActive = false) {
	GuiActive := true
	
	Gui, Show, x0 y0 w380 h370, Main Menu
} return

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
GhostProperties.GL.15 := GhostPropertiesOriginal.GL.15
GhostProperties.GL.16 := GhostPropertiesOriginal.GL.16

GhostProperties.Ev.1 := GhostPropertiesOriginal.Ev.1
GhostProperties.Ev.2 := GhostPropertiesOriginal.Ev.2
GhostProperties.Ev.3 := GhostPropertiesOriginal.Ev.3
GhostProperties.Ev.4 := GhostPropertiesOriginal.Ev.4
GhostProperties.Ev.5 := GhostPropertiesOriginal.Ev.5
GhostProperties.Ev.6 := GhostPropertiesOriginal.Ev.6
GhostProperties.Ev.7 := GhostPropertiesOriginal.Ev.7
return



ReturnGhost() { ; The main function that decides which ghost is present. Ghosts that have been excluded will return as "Disproved".
	Gui, Submit, NoHide
	
	GoSub, ClearInput
	
	if (ExcludedOne = GhostProperties.Evs.1 || ExcludedTwo = GhostProperties.Evs.1 || ExcludedThree = GhostProperties.Evs.1)
	{
		GhostProperties.GL.3 := ""
		GhostProperties.GL.4 := ""
		GhostProperties.GL.5 := ""
		GhostProperties.GL.6 := ""
		GhostProperties.GL.10 := ""
		GhostProperties.GL.13 := ""
		GhostProperties.GL.15 := ""
		GhostProperties.GL.16 := ""
	}
	
	if (ExcludedOne = GhostProperties.Evs.2 || ExcludedTwo = GhostProperties.Evs.2 || ExcludedThree = GhostProperties.Evs.2)
	{
		GhostProperties.GL.1 := ""
		GhostProperties.GL.4 := ""
		GhostProperties.GL.7 := ""
		GhostProperties.GL.8 := ""
		GhostProperties.GL.9 := ""
		GhostProperties.GL.10 := ""
		GhostProperties.GL.16 := ""
	}
	
	if (ExcludedOne = GhostProperties.Evs.3 || ExcludedTwo = GhostProperties.Evs.3 || ExcludedThree = GhostProperties.Evs.3)
	{
		GhostProperties.GL.1 := ""
		GhostProperties.GL.2 := ""
		GhostProperties.GL.3 := ""
		GhostProperties.GL.4 := ""
		GhostProperties.GL.7 := ""
		GhostProperties.GL.14 := ""
	}
	
	if (ExcludedOne = GhostProperties.Evs.4 || ExcludedTwo = GhostProperties.Evs.4 || ExcludedThree = GhostProperties.Evs.4)
	{
		GhostProperties.GL.6 := ""
		GhostProperties.GL.8 := ""
		GhostProperties.GL.9 := ""
		GhostProperties.GL.10 := ""
		GhostProperties.GL.11 := ""
		GhostProperties.GL.12 := ""
		GhostProperties.GL.13 := ""
	}
	
	if (ExcludedOne = GhostProperties.Evs.5 || ExcludedTwo = GhostProperties.Evs.5 || ExcludedThree = GhostProperties.Evs.5)
	{
		GhostProperties.GL.5 := ""
		GhostProperties.GL.7 := ""
		GhostProperties.GL.8 := ""
		GhostProperties.GL.11 := ""
		GhostProperties.GL.13 := ""
		GhostProperties.GL.14 := ""
	}
	
	if (ExcludedOne = GhostProperties.Evs.6 || ExcludedTwo = GhostProperties.Evs.6 || ExcludedThree = GhostProperties.Evs.6)
	{
		GhostProperties.GL.1 := ""
		GhostProperties.GL.2 := ""
		GhostProperties.GL.6 := ""
		GhostProperties.GL.9 := ""
		GhostProperties.GL.12 := ""
		GhostProperties.GL.15 := ""
		GhostProperties.GL.16 := ""
	}
	
	if (ExcludedOne = GhostProperties.Evs.7 || ExcludedTwo = GhostProperties.Evs.7 || ExcludedThree = GhostProperties.Evs.7)
	{
		GhostProperties.GL.2 := ""
		GhostProperties.GL.3 := ""
		GhostProperties.GL.5 := ""
		GhostProperties.GL.11 := ""
		GhostProperties.GL.12 := ""
		GhostProperties.GL.14 := ""
		GhostProperties.GL.15 := ""
	}
	
	
	
	if (EvidenceOne = GhostProperties.Evs.1 || EvidenceTwo = GhostProperties.Evs.1 || EvidenceThree = GhostProperties.Evs.1)
	{
		GhostProperties.GL.1 := ""
		GhostProperties.GL.2 := ""
		GhostProperties.GL.7 := ""
		GhostProperties.GL.8 := ""
		GhostProperties.GL.9 := ""
		GhostProperties.GL.11 := ""
		GhostProperties.GL.12 := ""
		GhostProperties.GL.14 := ""
	}
	
	if (EvidenceOne = GhostProperties.Evs.2 || EvidenceTwo = GhostProperties.Evs.2 || EvidenceThree = GhostProperties.Evs.2)
	{
		GhostProperties.GL.2 := ""
		GhostProperties.GL.3 := ""
		GhostProperties.GL.5 := ""
		GhostProperties.GL.6 := ""
		GhostProperties.GL.11 := ""
		GhostProperties.GL.12 := ""
		GhostProperties.GL.13 := ""
		GhostProperties.GL.14 := ""
		GhostProperties.GL.15 := ""
		
		GhostProperties.Ev.2 := ""
		GhostProperties.Ev.7 := ""
	}
	
	if (EvidenceOne = GhostProperties.Evs.3 || EvidenceTwo = GhostProperties.Evs.3 || EvidenceThree = GhostProperties.Evs.3)
	{
		GhostProperties.GL.5 := ""
		GhostProperties.GL.6 := ""
		GhostProperties.GL.8 := ""
		GhostProperties.GL.9 := ""
		GhostProperties.GL.10 := ""
		GhostProperties.GL.11 := ""
		GhostProperties.GL.12 := ""
		GhostProperties.GL.13 := ""
		GhostProperties.GL.15 := ""
		GhostProperties.GL.16 := ""
		
		GhostProperties.Ev.3 := ""
		GhostProperties.Ev.4 := ""
	}
	
	if (EvidenceOne = GhostProperties.Evs.4 || EvidenceTwo = GhostProperties.Evs.4 || EvidenceThree = GhostProperties.Evs.4)
	{
		GhostProperties.GL.1 := ""
		GhostProperties.GL.2 := ""
		GhostProperties.GL.3 := ""
		GhostProperties.GL.4 := ""
		GhostProperties.GL.5 := ""
		GhostProperties.GL.7 := ""
		GhostProperties.GL.14 := ""
		GhostProperties.GL.15 := ""
		GhostProperties.GL.16 := ""
		
		GhostProperties.Ev.3 := ""
		GhostProperties.Ev.4 := ""
	}
	
	if (EvidenceOne = GhostProperties.Evs.5 || EvidenceTwo = GhostProperties.Evs.5 || EvidenceThree = GhostProperties.Evs.5)
	{
		GhostProperties.GL.1 := ""
		GhostProperties.GL.2 := ""
		GhostProperties.GL.3 := ""
		GhostProperties.GL.4 := ""
		GhostProperties.GL.6 := ""
		GhostProperties.GL.9 := ""
		GhostProperties.GL.10 := ""
		GhostProperties.GL.12 := ""
		GhostProperties.GL.15 := ""
		GhostProperties.GL.16 := ""
		
		GhostProperties.Ev.6 := ""
		GhostProperties.Ev.5 := ""
	}
	
	if (EvidenceOne = GhostProperties.Evs.6 || EvidenceTwo = GhostProperties.Evs.6 || EvidenceThree = GhostProperties.Evs.6)
	{
		GhostProperties.GL.3 := ""
		GhostProperties.GL.4 := ""
		GhostProperties.GL.5 := ""
		GhostProperties.GL.7 := ""
		GhostProperties.GL.8 := ""
		GhostProperties.GL.10 := ""
		GhostProperties.GL.11 := ""
		GhostProperties.GL.13 := ""
		GhostProperties.GL.14 := ""
		
		GhostProperties.Ev.5 := ""
		GhostProperties.Ev.6 := ""
	}
	
	if (EvidenceOne = GhostProperties.Evs.7 || EvidenceTwo = GhostProperties.Evs.7 || EvidenceThree = GhostProperties.Evs.7)
	{
		GhostProperties.GL.1 := ""
		GhostProperties.GL.4 := ""
		GhostProperties.GL.6 := ""
		GhostProperties.GL.7 := ""
		GhostProperties.GL.8 := ""
		GhostProperties.GL.9 := ""
		GhostProperties.GL.10 := ""
		GhostProperties.GL.13 := ""
		GhostProperties.GL.16 := ""
		
		GhostProperties.Ev.2 := ""
		GhostProperties.Ev.7 := ""
	}
	
	global GhostElements := ""
	
	Loop % GhostProperties.GL.length()
		GhostElements := GhostElements . GhostProperties.GL[A_Index] . "`n"
		GuiControl, Text, GhostList, %GhostElements%
	
	global GhostEvidence := ""
	
	Loop % GhostProperties.Ev.length()
		GhostEvidence := GhostEvidence . GhostProperties.Ev[A_Index] . "`n"
		GuiControl, Text, EvidenceList, %GhostEvidence%
}
