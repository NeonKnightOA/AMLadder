//================================================================================
// AMMenuAMClientWindow.
//================================================================================

class AMMenuAMClientWindow extends UMenuPageWindow;

var UWindowSmallButton Ladder;
var UWindowSmallButton Resume;
var UWindowSmallButton MenuBar;
var float ControlOffset;
var int TotalSize;
var localized string StartTheLadder;
var localized string StartTheLadderHelp;
var localized string ResumeSavedLadder;
var localized string ResumeSavedLadderHelp;
var localized string ResetToDefaults;
var localized string ResetToDefaultsHelp;

function Created ()
{
	Super.Created();
	ControlOffset = 15.0;
	Ladder = UWindowSmallButton(CreateControl(class'UWindowSmallButton',35.0,ControlOffset,210.0,16.0));
	Ladder.SetText(StartTheLadder);
	/*Ladder.Align = 0;*/
	Ladder.SetFont(0);
	Ladder.SetHelpText(StartTheLadderHelp);
	ControlOffset += 25;
	Resume = UWindowSmallButton(CreateControl(class'UWindowSmallButton',35.0,ControlOffset,210.0,16.0));
	Resume.SetText(ResumeSavedLadder);
	/*Resume.Align = 0;*/
	Resume.SetFont(0);
	Resume.SetHelpText(ResumeSavedLadderHelp);
	ControlOffset += 25;
	MenuBar = UWindowSmallButton(CreateControl(class'UWindowSmallButton',35.0,ControlOffset,210.0,16.0));
	MenuBar.SetText(ResetToDefaults);
	/*MenuBar.Align = 0;*/
	MenuBar.SetFont(0);
	MenuBar.SetHelpText(ResetToDefaultsHelp);
	ControlOffset += 20;
	TotalSize = ControlOffset;
}

function Notify (UWindowDialogControl C, byte E)
{
	Super.Notify(C,E);
	
	switch (E)
	{
		case 2:
		switch (C)
		{
			case Ladder:
			InitConsole();
			GetPlayerOwner().ClientTravel("UT-Logo-Map.unr?Game=Botpack.LadderNewGame",TRAVEL_Absolute,True);
			break;
			case Resume:
			InitConsole();
			GetPlayerOwner().ClientTravel("UT-Logo-Map.unr?Game=Botpack.LadderLoadGame",TRAVEL_Absolute,True);
			break;
			case MenuBar:
			ResetConsole();
			break;
			default:
		}
		break;
		default:
	}
}

function AfterCreate ()
{
	DesiredWidth = TotalSize + 50;
	DesiredHeight = ControlOffset;
}

function InitConsole ()
{
	Log("Ladder Mode");
	UTConsole(GetPlayerOwner().Player.Console).ManagerWindowclass = "AMLadder.AMManagerWindow";
	UTConsole(GetPlayerOwner().Player.Console).UTLadderDMclass = "AMLadder.AMLadderDMMenu";
	UTConsole(GetPlayerOwner().Player.Console).UTLadderCTFclass = "AMLadder.AMLadderCTFMenu";
	UTConsole(GetPlayerOwner().Player.Console).UTLadderDOMclass = "AMLadder.AMLadderDOMMenu";
	UTConsole(GetPlayerOwner().Player.Console).UTLadderASclass = "AMLadder.AMLadderASMenu";
	UTConsole(GetPlayerOwner().Player.Console).UTLadderChalclass = "AMLadder.AMLadderChalMenu";
	UTConsole(GetPlayerOwner().Player.Console).InterimObjectType = "AMLadder.AMNewGameInterimObject";
	UTConsole(GetPlayerOwner().Player.Console).SlotWindowType = "AMLadder.AMSlotWindow";
}

function ResetConsole ()
{
	Log("Tournament Mode");
	UTConsole(GetPlayerOwner().Player.Console).ManagerWindowclass = "UTMenu.ManagerWindow";
	UTConsole(GetPlayerOwner().Player.Console).UTLadderDMclass = "UTMenu.UTLadderDM";
	UTConsole(GetPlayerOwner().Player.Console).UTLadderCTFclass = "UTMenu.UTLadderCTF";
	UTConsole(GetPlayerOwner().Player.Console).UTLadderDOMclass = "UTMenu.UTLadderDOM";
	UTConsole(GetPlayerOwner().Player.Console).UTLadderASclass = "UTMenu.UTLadderAS";
	UTConsole(GetPlayerOwner().Player.Console).UTLadderChalclass = "UTMenu.UTLadderChal";
	UTConsole(GetPlayerOwner().Player.Console).InterimObjectType = "UTMenu.NewGameInterimObject";
	UTConsole(GetPlayerOwner().Player.Console).SlotWindowType = "UTMenu.SlotWindow";
}

defaultproperties
{
	Ladder=None
	Resume=None
	MenuBar=None
	ControlOffset=0.000000
	TotalSize=0
	StartTheLadder="&Start the Ladder"
	StartTheLadderHelp="Select to start a new Ladder game!"
	ResumeSavedLadder="&Resume Saved Ladder"
	ResumeSavedLadderHelp="Select to resume a saved Ladder game."
	ResetToDefaults="Reset the Ladder to Default"
	ResetToDefaultsHelp="Select to reset Unreal Tournament's original Ladders"
}
