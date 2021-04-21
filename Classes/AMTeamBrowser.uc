class AMTeamBrowser extends TeamBrowser;

function NextPressed()
{
	local EnemyBrowser EB;
	
	HideWindow();
	EB = EnemyBrowser(Root.CreateWindow(class'AMEnemyBrowser', 100, 100, 200, 200, Root, True));
	EB.LadderWindow = LadderWindow;
	EB.TeamWindow = Self;
	EB.Ladder = Ladder;
	EB.Match = Match;
	EB.GameType = GameType;
	EB.Initialize();
}

defaultproperties
{
	ObjectiveWindow=None
}
