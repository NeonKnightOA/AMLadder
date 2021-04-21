class AMKillGameQueryWindow extends KillGameQueryWindow;

function BeginPlay ()
{
	ClientClass = Class'AMKillGameQueryClient';
}

defaultproperties
{
	WindowTitle="Delete Ladder Game?"
}
