class AMLadderDOMMenu extends AMLadder;

function Created()
{
	Super.Created();
	
	if (LadderObj.DOMPosition == -1) {
		LadderObj.DOMPosition = 1;
		SelectedMatch = 0;
	}
	else
	{
		SelectedMatch = LadderObj.DOMPosition;
	}
	SetupLadder(LadderObj.DOMPosition, LadderObj.DOMRank);
}

function FillInfoArea(int i)
{
	MapInfoArea.Clear();
	MapInfoArea.AddText(MapText$" "$LadderObj.CurrentLadder.Static.GetMapTitle(i));
	MapInfoArea.AddText(TeamScoreText$" "$LadderObj.CurrentLadder.Static.GetGoalTeamScore(i));
	MapInfoArea.AddText(LadderObj.CurrentLadder.Static.GetDesc(i));
}

function NextPressed()
{
	local TeamBrowser TB;
	local string MapName;
	
	if (PendingPos > ArrowPos)
	{
		return;
	}
	
	if (SelectedMatch == 0)
	{
		MapName = LadderObj.CurrentLadder.Default.MapPrefix$Ladder.Static.GetMap(0);
		CloseUp();
		StartMap(MapName, 0, "Botpack.TrainingDOM");
	}
	else
	{
		if (LadderObj.CurrentLadder.Default.DemoDisplay[SelectedMatch] == 1)
		{
			return;
		}
		
		HideWindow();
		TB = TeamBrowser(Root.CreateWindow(class'AMTeamBrowser', 100, 100, 200, 200, Root, True));
		TB.LadderWindow = Self;
		TB.Ladder = LadderObj.CurrentLadder;
		TB.Match = SelectedMatch;
		TB.GameType = GameType;
		TB.Initialize();
	}
}

function EvaluateMatch(optional bool bTrophyVictory)
{
	/* local int Pos;
	local string MapName; */
	
	if (LadderObj.PendingPosition > LadderObj.DOMPosition)
	{
		PendingPos = LadderObj.PendingPosition;
		LadderObj.DOMPosition = LadderObj.PendingPosition;
	}
	
	if (LadderObj.PendingRank > LadderObj.DOMRank)
	{
		LadderObj.DOMRank = LadderObj.PendingRank;
		LadderObj.PendingRank = 0;
	}
	
	LadderPos = LadderObj.DOMPosition;
	LadderRank = LadderObj.DOMRank;
	
	if (LadderObj.DOMRank == 6)
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
	GameType="Botpack.Domination"
	TrophyMap="EOL_Domination.unr"
	LadderName="Domination"
	Ladder=Class'AMLadder.AMLadderDOM'
	LadderTrophy=Texture'UTMenu.Skins.TrophyDOM'
}
