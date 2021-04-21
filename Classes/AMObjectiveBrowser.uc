class AMObjectiveBrowser extends ObjectiveBrowser;

function NextPressed ()
{
	local TeamBrowser TB;
	
	HideWindow();
	TB = TeamBrowser(Root.CreateWindow(Class'AMTeamBrowser',100.0,100.0,200.0,200.0,Root,True));
	TB.LadderWindow = LadderWindow;
	TB.ObjectiveWindow = self;
	TB.LadderWindow = LadderWindow;
	TB.Ladder = Ladder;
	TB.Match = Match;
	TB.GameType = GameType;
	TB.Initialize();
}

function Initialize()
{
	local class<Bot> InitialMate;
	local int i;
	local int W, H;
	local float XWidth, YHeight, XMod, YMod, XPos, YPos, YOffset;
	local color TextColor;
	local AssaultInfo AI;
	
	GetPlayerOwner().ViewRotation.Pitch = 0;
	GetPlayerOwner().ViewRotation.Roll = 0;
	
	/*
		* Setup window parameters.
	*/
	
	bLeaveOnScreen = True;
	bAlwaysOnTop = True;
	class'UTLadderStub'.Static.GetStubClass().Static.SetupWinParams(Self, Root, W, H);
	
	XMod = 4*W;
	YMod = 3*H;
	
	/*
		* Load the background.
	*/
	
	BG1[0] = Texture(DynamicLoadObject(BGName1[0], Class'Texture'));
	BG1[1] = Texture(DynamicLoadObject(BGName1[1], Class'Texture'));
	BG1[2] = Texture(DynamicLoadObject(BGName1[2], Class'Texture'));
	BG1[3] = Texture(DynamicLoadObject(BGName1[3], Class'Texture'));
	BG2[0] = Texture(DynamicLoadObject(BGName2[0], Class'Texture'));
	BG2[1] = Texture(DynamicLoadObject(BGName2[1], Class'Texture'));
	BG2[2] = Texture(DynamicLoadObject(BGName2[2], Class'Texture'));
	BG2[3] = Texture(DynamicLoadObject(BGName2[3], Class'Texture'));
	BG3[0] = Texture(DynamicLoadObject(BGName3[0], Class'Texture'));
	BG3[1] = Texture(DynamicLoadObject(BGName3[1], Class'Texture'));
	BG3[2] = Texture(DynamicLoadObject(BGName3[2], Class'Texture'));
	BG3[3] = Texture(DynamicLoadObject(BGName3[3], Class'Texture'));
	
	/*
		* Create components.
	*/
	
	// Title
	XPos = 74.0/1024 * XMod;
	YPos = 69.0/768 * YMod;
	XWidth = 352.0/1024 * XMod;
	YHeight = 41.0/768 * YMod;
	Title1 = NotifyButton(CreateWindow(class'NotifyButton', XPos, YPos, XWidth, YHeight));
	Title1.Text = BrowserName;
	TextColor.R = 255;
	TextColor.G = 255;
	TextColor.B = 0;
	Title1.NotifyWindow = Self;
	Title1.SetTextColor(TextColor);
	Title1.MyFont = class'UTLadderStub'.Static.GetStubClass().Static.GetHugeFont(Root);
	Title1.bStretched = True;
	Title1.bDisabled = True;
	if (!Ladder.Default.bTeamGame)
	Title1.bDisabled = True;
	
	// Names
	TextColor.R = 0;
	TextColor.G = 128;
	TextColor.B = 255;
	XPos = 168.0/1024 * XMod;
	YPos = 255.0/768 * YMod;
	XWidth = 256.0/1024 * XMod;
	YHeight = 64.0/768 * YMod;
	YOffset = 48.0/768 * YMod;
	NumNames = class'AMLadderAS'.Static.GetObjectiveCount(Match, AI);
	
	for (i=0; i<NumNames; i++)
	{
		Names[i] = LadderButton(CreateWindow(class'LadderButton', XPos, YPos + i*YOffset, XWidth, YHeight));
		Names[i].MyFont = class'UTLadderStub'.Static.GetStubClass().Static.GetBigFont(Root);
		Names[i].NotifyWindow = Self;
		Names[i].SetTextColor(TextColor);
		Names[i].bStretched = True;
		Names[i].bDontSetLabel = True;
		Names[i].LabelWidth = 178.0/1024 * XMod;
		Names[i].LabelHeight = 49.0/768 * YMod;
		Names[i].OverSound = sound'LadderSounds.lcursorMove';
		Names[i].DownSound = sound'SpeechWindowClick';
		Names[i].Text = ObjectiveString@i+1;
	}
	
	Names[0].bBottom = True;
	Names[NumNames-1].bTop = True;
	
	// Back Button
	XPos = 192.0/1024 * XMod;
	YPos = 701.0/768 * YMod;
	XWidth = 64.0/1024 * XMod;
	YHeight = 64.0/768 * YMod;
	BackButton = NotifyButton(CreateWindow(class'NotifyButton', XPos, YPos, XWidth, YHeight));
	BackButton.DisabledTexture = Texture(DynamicLoadObject("UTMenu.LeftUp", Class'Texture'));
	BackButton.UpTexture = Texture(DynamicLoadObject("UTMenu.LeftUp", Class'Texture'));
	BackButton.DownTexture = Texture(DynamicLoadObject("UTMenu.LeftDown", Class'Texture'));
	BackButton.OverTexture = Texture(DynamicLoadObject("UTMenu.LeftOver", Class'Texture'));
	BackButton.NotifyWindow = Self;
	BackButton.Text = "";
	TextColor.R = 255;
	TextColor.G = 255;
	TextColor.B = 0;
	BackButton.SetTextColor(TextColor);
	BackButton.MyFont = class'UTLadderStub'.Static.GetStubClass().Static.GetBigFont(Root);
	BackButton.bStretched = True;
	BackButton.OverSound = sound'LadderSounds.lcursorMove';
	BackButton.DownSound = sound'LadderSounds.ladvance';
	
	// Next Button
	XPos = 256.0/1024 * XMod;
	YPos = 701.0/768 * YMod;
	XWidth = 64.0/1024 * XMod;
	YHeight = 64.0/768 * YMod;
	NextButton = NotifyButton(CreateWindow(class'NotifyButton', XPos, YPos, XWidth, YHeight));
	NextButton.DisabledTexture = Texture(DynamicLoadObject("UTMenu.RightUp", Class'Texture'));
	NextButton.UpTexture = Texture(DynamicLoadObject("UTMenu.RightUp", Class'Texture'));
	NextButton.DownTexture = Texture(DynamicLoadObject("UTMenu.RightDown", Class'Texture'));
	NextButton.OverTexture = Texture(DynamicLoadObject("UTMenu.RightOver", Class'Texture'));
	NextButton.NotifyWindow = Self;
	NextButton.Text = "";
	TextColor.R = 255;
	TextColor.G = 255;
	TextColor.B = 0;
	NextButton.SetTextColor(TextColor);
	NextButton.MyFont = class'UTLadderStub'.Static.GetStubClass().Static.GetBigFont(Root);
	NextButton.bStretched = True;
	NextButton.OverSound = sound'LadderSounds.lcursorMove';
	NextButton.DownSound = sound'LadderSounds.ladvance';
	
	// Obj Desc
	XPos = 529.0/1024 * XMod;
	YPos = 586.0/768 * YMod;
	XWidth = 385.0/1024 * XMod;
	YHeight = 113.0/768 * YMod;
	ObjDescArea = UTFadeTextArea(CreateWindow(Class<UWindowWindow>(DynamicLoadObject("UTMenu.UTFadeTextArea", Class'Class')), XPos, YPos, XWidth, YHeight));
	ObjDescArea.TextColor.R = 255;
	ObjDescArea.TextColor.G = 255;
	ObjDescArea.TextColor.B = 0;
	ObjDescArea.MyFont = class'UTLadderStub'.Static.GetStubClass().Static.GetSmallFont(Root);
	ObjDescArea.bAlwaysOnTop = True;
	ObjDescArea.bAutoScrolling = True;
	
	// DescScrollup
	XPos = 923.0/1024 * XMod;
	YPos = 590.0/768 * YMod;
	XWidth = 32.0/1024 * XMod;
	YHeight = 16.0/768 * YMod;
	DescScrollup = NotifyButton(CreateWindow(class'NotifyButton', XPos, YPos, XWidth, YHeight));
	DescScrollup.NotifyWindow = Self;
	DescScrollup.Text = "";
	DescScrollup.bStretched = True;
	DescScrollup.UpTexture = Texture(DynamicLoadObject("UTMenu.AroUup", Class'Texture'));
	DescScrollup.OverTexture = Texture(DynamicLoadObject("UTMenu.AroUovr", Class'Texture'));
	DescScrollup.DownTexture = Texture(DynamicLoadObject("UTMenu.AroUdwn", Class'Texture'));
	DescScrollup.MyFont = class'UTLadderStub'.Static.GetStubClass().Static.GetSmallFont(Root);
	DescScrollup.bAlwaysOnTop = True;
	
	// DescScrolldown
	XPos = 923.0/1024 * XMod;
	YPos = 683.0/768 * YMod;
	XWidth = 32.0/1024 * XMod;
	YHeight = 16.0/768 * YMod;
	DescScrolldown = NotifyButton(CreateWindow(class'NotifyButton', XPos, YPos, XWidth, YHeight));
	DescScrolldown.NotifyWindow = Self;
	DescScrolldown.Text = "";
	DescScrolldown.bStretched = True;
	DescScrolldown.UpTexture = Texture(DynamicLoadObject("UTMenu.AroDup", Class'Texture'));
	DescScrolldown.OverTexture = Texture(DynamicLoadObject("UTMenu.AroDovr", Class'Texture'));
	DescScrolldown.DownTexture = Texture(DynamicLoadObject("UTMenu.AroDdwn", Class'Texture'));
	DescScrolldown.MyFont = class'UTLadderStub'.Static.GetStubClass().Static.GetSmallFont(Root);
	DescScrolldown.bAlwaysOnTop = True;
	
	// StaticArea
	XPos = 608.0/1024 * XMod;
	YPos = 90.0/768 * YMod;
	XWidth = 320.0/1024 * XMod;
	YHeight = 319.0/768 * YMod;
	MapStatic = StaticArea(CreateWindow(class'StaticArea', XPos, YPos, XWidth, YHeight));
	MapStatic.VStaticScale = 300.0;
	
	Initialized = True;
	Root.Console.bBlackout = True;
	
	SelectedO = 0;
	SetMapShot(class'AMLadderAS'.Static.GetObjectiveShot(Match, 0, AI));
	AddObjDesc();
	StaticScale = 1.0;
}

function NameSelected(int i)
{
	local AssaultInfo AI;
	
	SelectedO = i;
	SetMapShot(class'AMLadderAS'.Static.GetObjectiveShot(Match, i, AI));
	AddObjDesc();
}

function AddObjDesc()
{
	local AssaultInfo AI;
	
	ObjDescArea.Clear();
	ObjDescArea.AddText(OrdersTransmissionText);
	ObjDescArea.AddText("---");
	ObjDescArea.AddText(class'AMLadderAS'.Static.GetObjectiveString(Match, SelectedO, AI));
}

defaultproperties
{
}
