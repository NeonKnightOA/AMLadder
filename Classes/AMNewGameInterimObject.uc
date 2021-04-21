class AMNewGameInterimObject expands NewGameInterimObject;

function PostBeginPlay()
{
	local LadderInventory LadderObj;
	local int EmptySlot, j;
	
	EmptySlot = -1;
	for (j=0; j<5; j++)
	{
		if (class'AMSlotWindow'.Default.Saves[j] == "") {
			EmptySlot = j;
			break;
		}
	}
	
	if (EmptySlot < 0)
	{
		// Create "You must first free a slot..." dialog.
		TournamentConsole(PlayerPawn(Owner).Player.Console).Root.CreateWindow(class'FreeSlotsWindow', 100, 100, 200, 200);
		return;
	}
	
	// Create new game dialog.
	TournamentConsole(PlayerPawn(Owner).Player.Console).bNoDrawWorld = True;
	TournamentConsole(PlayerPawn(Owner).Player.Console).bLocked = True;
	UMenuRootWindow(TournamentConsole(PlayerPawn(Owner).Player.Console).Root).MenuBar.HideWindow();
	
	// Make them a ladder object.
	LadderObj = LadderInventory(PlayerPawn(Owner).FindInventoryType(class'LadderInventory'));
	
	if (LadderObj == None)
	{
		// Make them a ladder object.
		LadderObj = Spawn(class'LadderInventory');
		Log("Created a new LadderInventory.");
		LadderObj.GiveTo(PlayerPawn(Owner));
	}
	
	LadderObj.Reset();
	LadderObj.Slot = EmptySlot; // Find a free slot.
	class'AMManagerWindow'.Default.DOMDoorOpen[EmptySlot] = 0;
	class'AMManagerWindow'.Default.CTFDoorOpen[EmptySlot] = 0;
	class'AMManagerWindow'.Default.ASDoorOpen[EmptySlot] = 0;
	class'AMManagerWindow'.Default.ChalDoorOpen[EmptySlot] = 0;
	class'AMManagerWindow'.Static.StaticSaveConfig();
	Log("Assigned player a LadderInventory.");
	
	// Clear all slots.
	Owner.PlaySound(sound'LadderSounds.ladvance', SLOT_None, 0.1);
	Owner.PlaySound(sound'LadderSounds.ladvance', SLOT_Misc, 0.1);
	Owner.PlaySound(sound'LadderSounds.ladvance', SLOT_Pain, 0.1);
	Owner.PlaySound(sound'LadderSounds.ladvance', SLOT_Interact, 0.1);
	Owner.PlaySound(sound'LadderSounds.ladvance', SLOT_Talk, 0.1);
	Owner.PlaySound(sound'LadderSounds.ladvance', SLOT_Interface, 0.1);
	
	// Go to the character creation screen.
	TournamentConsole(PlayerPawn(Owner).Player.Console).Root.CreateWindow(Class<UWindowWindow>(DynamicLoadObject(GameWindowType, Class'Class')), 100, 100, 200, 200, TournamentConsole(PlayerPawn(Owner).Player.Console).Root, True);
}

defaultproperties
{
	GameWindowType="AMLadder.AMNewCharacterWindow"
}
