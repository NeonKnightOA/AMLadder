//================================================================================
// AMMenuAMWindow.
//================================================================================

class AMMenuAMWindow extends UMenuFramedWindow;

function Created ()
{
	bStatusBar = False;
	bSizable = True;
	Super.Created();
	MinWinWidth = 200.0;
	MinWinHeight = 100.0;
	SetSizePos();
}

function SetSizePos ()
{
	local float W;
	local float H;
	
	GetDesiredDimensions(W,H);
    
	if ( Root.WinHeight < 400 )
	{
		SetSize(290.0,Root.WinHeight / 2);
	}
	else
	{
		SetSize(290.0,Root.WinHeight / 2);
	}
	
	WinLeft = Root.WinWidth / 2 - WinWidth / 2;
	WinTop = Root.WinHeight / 2 - WinHeight / 2;
}

function ResolutionChanged (float W, float H)
{
	SetSizePos();
	Super.ResolutionChanged(W,H);
}

function Resized ()
{
	if ( WinWidth != 290 )
	{
		WinWidth = 290.0;
	}
    
	Super.Resized();
}

defaultproperties
{
	ClientClass=Class'AMLadder.AMMenuAMClientWindow'
	WindowTitle="Neon_Knight's Ladder"
}
