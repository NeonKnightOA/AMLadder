class AMLadderDMMenu extends AMLadder;

function Created()
{
	Super.Created();
	
	if (LadderObj.DMPosition == -1) {
		LadderObj.DMPosition = 1;
		SelectedMatch = 0;
	}
	else
	{
		SelectedMatch = LadderObj.DMPosition;
	}
	
	SetupLadder(LadderObj.DMPosition, LadderObj.DMRank);
}

function FillInfoArea(int i)
{
	MapInfoArea.Clear();
	MapInfoArea.AddText(MapText$" "$LadderObj.CurrentLadder.Static.GetMapTitle(i));
	MapInfoArea.AddText(FragText$" "$LadderObj.CurrentLadder.Static.GetFragLimit(i));
	MapInfoArea.AddText(LadderObj.CurrentLadder.Static.GetDesc(i));
}

function NextPressed()
{
	local EnemyBrowser EB;
	local string MapName;
	
	if (PendingPos > ArrowPos)
	{
		return;
	}
	
	if (SelectedMatch == 0)
	{
		MapName = LadderObj.CurrentLadder.Default.MapPrefix$Ladder.Static.GetMap(0);
		CloseUp();
		StartMap(MapName, 0, "Botpack.TrainingDM");
	}
	else
	{
		HideWindow();
		EB = EnemyBrowser(Root.CreateWindow(class'AMEnemyBrowser', 100, 100, 200, 200, Root, True));
		EB.LadderWindow = Self;
		EB.Ladder = LadderObj.CurrentLadder;
		EB.Match = SelectedMatch;
		EB.GameType = GameType;
		EB.Initialize();
	}
}

function StartMap(string StartMap, int Rung, string GameType)
{
	local Class<GameInfo> GameClass;
	
	GameClass = Class<GameInfo>(DynamicLoadObject(GameType, Class'Class'));
	GameClass.Static.ResetGame();
	
	StartMap = StartMap
	$"?Game="$GameType
	$"?Mutator="
	$"?Tournament="$Rung
	$"?Name="$GetPlayerOwner().PlayerReplicationInfo.PlayerName
	$"?Team=255";
	
	Root.Console.CloseUWindow();
	GetPlayerOwner().ClientTravel(StartMap, TRAVEL_Absolute, True);
}

function EvaluateMatch(optional bool bTrophyVictory)
{
	local int Pos;
	local string MapName;
	
	if (LadderObj.PendingPosition > LadderObj.DMPosition)
	{
		PendingPos = LadderObj.PendingPosition;
		LadderObj.DMPosition = LadderObj.PendingPosition;
	}
	
	if (LadderObj.PendingRank > LadderObj.DMRank)
	{
		LadderObj.DMRank = LadderObj.PendingRank;
		LadderObj.PendingRank = 0;
	}
	
	LadderPos = LadderObj.DMPosition;
	LadderRank = LadderObj.DMRank;
	
	if (LadderObj.DMRank == 6)
	{
		Super.EvaluateMatch(True);
	}
	else
	{
		Super.EvaluateMatch();
	}
}

function CheckOpenCondition()
{
	Super.CheckOpenCondition();
}

defaultproperties
{
	GameType="Botpack.DeathMatchPlus"
	TrophyMap="EOL_DeathMatch.unr"
	LadderName="Deathmatch"
	Ladder=Class'AMLadder.AMLadderDM'
	LadderTrophy=Texture'UTMenu.Skins.TrophyDM'
}
