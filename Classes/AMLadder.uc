class AMLadder extends UTLadder;

// Called after individual ladders evaluate.
function EvaluateMatch(optional bool bTrophyVictory)
{
	local string SaveString;
	local int Team, i;
	
	// Save the game.
	if (LadderObj != None)
	{
		SaveString = string(LadderObj.TournamentDifficulty);
		
		for (i=0; i<class'AMLadderLadder'.Default.NumTeams; i++)
		{
			if (class'AMLadderLadder'.Default.LadderTeams[i] == LadderObj.Team)
			{
				Team = i;
			}
		}
		
		SaveString = SaveString$"\\"$Team;
		SaveString = SaveString$"\\"$LadderObj.DMRank;
		SaveString = SaveString$"\\"$LadderObj.DMPosition;
		SaveString = SaveString$"\\"$LadderObj.DOMRank;
		SaveString = SaveString$"\\"$LadderObj.DOMPosition;
		SaveString = SaveString$"\\"$LadderObj.CTFRank;
		SaveString = SaveString$"\\"$LadderObj.CTFPosition;
		SaveString = SaveString$"\\"$LadderObj.ASRank;
		SaveString = SaveString$"\\"$LadderObj.ASPosition;
		SaveString = SaveString$"\\"$LadderObj.ChalRank;
		SaveString = SaveString$"\\"$LadderObj.ChalPosition;
		SaveString = SaveString$"\\"$LadderObj.Sex;
		SaveString = SaveString$"\\"$LadderObj.Face;
		SaveString = SaveString$"\\"$GetPlayerOwner().PlayerReplicationInfo.PlayerName;
		class'AMSlotWindow'.Default.Saves[LadderObj.Slot] = SaveString;
		class'AMSlotWindow'.Static.StaticSaveConfig();
		
		if (LadderObj.PendingPosition > 7)
		{
			SelectedMatch = LadderObj.PendingPosition;
			BaseMatch = LadderObj.PendingPosition - 7;
			ArrowPos = LadderObj.PendingPosition - 1;
			PendingPos = LadderObj.PendingPosition;
		}
		
		LadderObj.PendingPosition = 0;
		
		if (bTrophyVictory)
		{
			bTrophyTravelPending = True;
		}
		
		SelectedMatch = LadderPos;
		SetMapShot(LadderPos);
		FillInfoArea(LadderPos);
	}
}

function EscClose()
{
	BackPressed();
}

function BackPressed()
{
	Root.CreateWindow(class'AMManagerWindow', 100, 100, 200, 200, Root, True);
	Close();
}

function ShowWindow()
{
	LadderObj.CurrentLadder = Ladder;
	Super.ShowWindow();
}

defaultproperties
{
}
