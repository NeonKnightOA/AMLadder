//================================================================================
// AMKillGameQueryClient.
//================================================================================

class AMKillGameQueryClient extends KillGameQueryClient;

function YesPressed ()
{
	if ( SlotWindow != None )
	{
		SlotWindow.Saves[SlotIndex] = "";
		SlotWindow.SaveConfig();
		SlotWindow.SlotButton[SlotIndex].Text = class'AMSlotWindow'.Default.EmptyText;
		class'AMManagerWindow'.Default.DOMDoorOpen[SlotIndex] = 0;
		class'AMManagerWindow'.Default.CTFDoorOpen[SlotIndex] = 0;
		class'AMManagerWindow'.Default.ASDoorOpen[SlotIndex] = 0;
		class'AMManagerWindow'.Default.ChalDoorOpen[SlotIndex] = 0;
		class'AMManagerWindow'.Default.TrophyDoorOpen[SlotIndex] = 0;
		class'AMManagerWindow'.StaticSaveConfig();
	}
	Close();
}

defaultproperties
{
	SlotWindow=None
}
