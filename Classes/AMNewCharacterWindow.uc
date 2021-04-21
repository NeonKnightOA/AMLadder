class AMNewCharacterWindow extends NewCharacterWindow config(AMLadder);

function BackPressed ()
{
	SwitchBack();
	Close();
}

function EscClose ()
{
	SwitchBack();
	Close();
}

function SwitchBack ()
{
	UTConsole(GetPlayerOwner().Player.Console).ManagerWindowClass = "UTMenu.ManagerWindow";
	UTConsole(GetPlayerOwner().Player.Console).UTLadderDMClass = "UTMenu.UTLadderDM";
	UTConsole(GetPlayerOwner().Player.Console).UTLadderDOMClass = "UTMenu.UTLadderDOM";
	UTConsole(GetPlayerOwner().Player.Console).UTLadderCTFClass = "UTMenu.UTLadderCTF";
	UTConsole(GetPlayerOwner().Player.Console).UTLadderASClass = "UTMenu.UTLadderAS";
	UTConsole(GetPlayerOwner().Player.Console).UTLadderChalClass = "UTMenu.UTLadderChal";
	UTConsole(GetPlayerOwner().Player.Console).InterimObjectType = "UTMenu.NewGameInterimObject";
	UTConsole(GetPlayerOwner().Player.Console).SlotWindowType = "UTMenu.SlotWindow";
	Log("Now Playing Original Unreal Tournament Ladder Game");
}

function StartLadder ()
{
	UTConsole(GetPlayerOwner().Player.Console).ManagerWindowClass = "AMLadder.AMManagerWindow";
	UTConsole(GetPlayerOwner().Player.Console).UTLadderDMClass = "AMLadder.AMLadderDMMenu";
	UTConsole(GetPlayerOwner().Player.Console).UTLadderDOMClass = "AMLadder.AMLadderDOMMenu";
	UTConsole(GetPlayerOwner().Player.Console).UTLadderCTFClass = "AMLadder.AMLadderCTFMenu";
	UTConsole(GetPlayerOwner().Player.Console).UTLadderASClass = "AMLadder.AMLadderASMenu";
	UTConsole(GetPlayerOwner().Player.Console).UTLadderChalClass = "AMLadder.AMLadderChalMenu";
	UTConsole(GetPlayerOwner().Player.Console).InterimObjectType = "AMLadder.AMNewGameInterimObject";
	UTConsole(GetPlayerOwner().Player.Console).SlotWindowType = "AMLadder.AMSlotWindow";
	Log("Now Playing NK Ladder Game");
}

function TeamPressed ()
{
	local string MeshName;
	
	PreferredTeam++;
	if (PreferredTeam == class'AMLadderLadder'.Default.NumTeams)
	PreferredTeam = 0;
	TeamButton.Text = Class'AMLadderLadder'.Default.LadderTeams[PreferredTeam].Default.TeamName;
	LadderObj.Team = Class'AMLadderLadder'.Default.LadderTeams[PreferredTeam];
	MaleClass = Class'AMLadderLadder'.Default.LadderTeams[PreferredTeam].Default.MaleClass;
	MaleSkin = Class'AMLadderLadder'.Default.LadderTeams[PreferredTeam].Default.MaleSkin;
	FemaleClass = Class'AMLadderLadder'.Default.LadderTeams[PreferredTeam].Default.FemaleClass;
	FemaleSkin = Class'AMLadderLadder'.Default.LadderTeams[PreferredTeam].Default.FemaleSkin;
	
	if ( (MaleClass == None) && (SexButton.Text ~= MaleText) )
	{
		TeamPressed();
	}
	
	if ( (FemaleClass == None) && (SexButton.Text ~= FemaleText) )
	{
		TeamPressed();
	}
	
	if ( SexButton.Text ~= MaleText )
	{
		IterateFaces(MaleSkin,GetPlayerOwner().GetItemName(string(MaleClass.Default.Mesh)));
		PreferredFace = 0;
		MeshName = MaleClass.Default.SelectionMesh;
		MeshWindow.SetMeshString(MeshName);
		MaleClass.static.SetMultiSkin(MeshWindow.MeshActor, MaleSkin, Faces[PreferredFace], 255);
		GetPlayerOwner().UpdateURL("Class",string(MaleClass),True);
		GetPlayerOwner().UpdateURL("Voice",MaleClass.Default.VoiceType,True);
		GetPlayerOwner().UpdateURL("Skin",MaleSkin,True);
		GetPlayerOwner().UpdateURL("Face",Faces[PreferredFace],True);
		FaceButton.Text = FaceDescs[PreferredFace];
		SexButton.Text = MaleText;
		PreferredSex = 0;
		LadderObj.Sex = "M";
		} else {
		IterateFaces(FemaleSkin,GetPlayerOwner().GetItemName(string(FemaleClass.Default.Mesh)));
		PreferredFace = 0;
		MeshName = FemaleClass.Default.SelectionMesh;
		MeshWindow.SetMeshString(MeshName);
		FemaleClass.static.SetMultiSkin(MeshWindow.MeshActor,FemaleSkin,Faces[PreferredFace],255);
		GetPlayerOwner().UpdateURL("Class",string(FemaleClass),True);
		GetPlayerOwner().UpdateURL("Voice",FemaleClass.Default.VoiceType,True);
		GetPlayerOwner().UpdateURL("Skin",FemaleSkin,True);
		GetPlayerOwner().UpdateURL("Face",Faces[PreferredFace],True);
		FaceButton.Text = FaceDescs[PreferredFace];
		SexButton.Text = FemaleText;
		PreferredSex = 1;
		LadderObj.Sex = "F";
	}
	
	TeamDescArea.Clear();
	TeamDescArea.AddText(TeamNameString @ LadderObj.Team.static.GetTeamName());
	TeamDescArea.AddText(" ");
	TeamDescArea.AddText(LadderObj.Team.static.GetTeamBio());
	SaveConfig();
}

function Created ()
{
	local string MeshName, SkinDesc, Temp;
	local int i;
	local int W, H;
	local float XWidth, YHeight, XMod, YMod, XPos, YPos;
	local color TextColor;
	
	Super.Created();
	
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
	
	// Check ladder object.
	LadderObj = LadderInventory(GetPlayerOwner().FindInventoryType(class'LadderInventory'));
	if (LadderObj == None)
	{
		Log("AMNewCharacterWindow: Player has no LadderInventory!!");
	}
	
	/*
		* Create components.
	*/
	
	MaleClass = class'AMLadderLadder'.Default.LadderTeams[PreferredTeam].Default.MaleClass;
	MaleSkin = class'AMLadderLadder'.Default.LadderTeams[PreferredTeam].Default.MaleSkin;
	
	FemaleClass = class'AMLadderLadder'.Default.LadderTeams[PreferredTeam].Default.FemaleClass;
	FemaleSkin = class'AMLadderLadder'.Default.LadderTeams[PreferredTeam].Default.FemaleSkin;
	
	IterateFaces(MaleSkin, GetPlayerOwner().GetItemName(string(MaleClass.Default.Mesh)));
	
	LadderObj.Face = PreferredFace;
	
	// MeshView
	XPos = 608.0/1024 * XMod;
	YPos = 88.0/768 * YMod;
	XWidth = 323.0/1024 * XMod;
	YHeight = 466.0/768 * YMod;
	MeshWindow = UMenuPlayerMeshClient(CreateWindow(class'UMenuPlayerMeshClient', XPos, YPos, XWidth, YHeight));
	MeshWindow.SetMeshString(MaleClass.Default.SelectionMesh);
	MeshWindow.ClearSkins();
	MaleClass.static.SetMultiSkin(MeshWindow.MeshActor, MaleSkin, MaleFace, 255);
	GetPlayerOwner().UpdateURL("Class", "Botpack."$string(MaleClass.Name), True);
	GetPlayerOwner().UpdateURL("Skin", MaleSkin, True);
	GetPlayerOwner().UpdateURL("Face", Faces[PreferredFace], True);
	GetPlayerOwner().UpdateURL("Team", "255", True);
	GetPlayerOwner().UpdateURL("Voice", MaleClass.Default.VoiceType, True);
	
	// Name Label
	XPos = 164.0/1024 * XMod;
	YPos = 263.0/768 * YMod;
	XWidth = 256.0/1024 * XMod;
	YHeight = 64.0/768 * YMod;
	NameLabel = NotifyButton(CreateWindow(class'NotifyButton', XPos, YPos, XWidth, YHeight));
	NameLabel.NotifyWindow = Self;
	NameLabel.Text = NameText;
	TextColor.R = 255;
	TextColor.G = 255;
	TextColor.B = 0;
	NameLabel.SetTextColor(TextColor);
	NameLabel.MyFont = class'UTLadderStub'.Static.GetStubClass().Static.GetBigFont(Root);
	NameLabel.bStretched = True;
	NameLabel.bDisabled = True;
	NameLabel.bDontSetLabel = True;
	NameLabel.LabelWidth = 178.0/1024 * XMod;
	NameLabel.LabelHeight = 49.0/768 * YMod;
	
	// Name Button
	XPos = 164.0/1024 * XMod;
	YPos = 295.0/768 * YMod;
	XWidth = 256.0/1024 * XMod;
	YHeight = 64.0/768 * YMod;
	NameButton = NotifyButton(CreateWindow(class'NotifyButton', XPos, YPos, XWidth, YHeight));
	NameButton.NotifyWindow = Self;
	TextColor.R = 255;
	TextColor.G = 255;
	TextColor.B = 0;
	NameButton.SetTextColor(TextColor);
	NameButton.MyFont = class'UTLadderStub'.Static.GetStubClass().Static.GetBigFont(Root);
	NameButton.bStretched = True;
	NameButton.bDisabled = True;
	NameButton.DisabledTexture = Texture(DynamicLoadObject("UTMenu.Plate3Plain", Class'Texture'));
	NameButton.bDontSetLabel = True;
	NameButton.LabelWidth = 178.0/1024 * XMod;
	NameButton.LabelHeight = 49.0/768 * YMod;
	NameButton.OverSound = sound'LadderSounds.lcursorMove';
	NameButton.DownSound = sound'SpeechWindowClick';
	
	// Name Edit
	XPos = 164.0/1024 * XMod;
	YPos = 295.0/768 * YMod;
	XWidth = 178.0/1024 * XMod;
	YHeight = 49.0/768 * YMod;
	NameEdit = NameEditBox(CreateWindow(class'NameEditBox', XPos, YPos, XWidth, YHeight));
	NameEdit.bDelayedNotify = True;
	NameEdit.SetValue(GetPlayerOwner().PlayerReplicationInfo.PlayerName);
	NameEdit.CharacterWindow = Self;
	NameEdit.bCanEdit = True;
	NameEdit.bShowCaret = True;
	NameEdit.bAlwaysOnTop = True;
	NameEdit.bSelectOnFocus = True;
	NameEdit.MaxLength = 20;
	NameEdit.TextColor.R = 255;
	NameEdit.TextColor.G = 255;
	NameEdit.TextColor.B = 0;
	
	// Sex Label
	XPos = 164.0/1024 * XMod;
	YPos = 338.0/768 * YMod;
	XWidth = 256.0/1024 * XMod;
	YHeight = 64.0/768 * YMod;
	SexLabel = NotifyButton(CreateWindow(class'NotifyButton', XPos, YPos, XWidth, YHeight));
	SexLabel.NotifyWindow = Self;
	SexLabel.Text = SexText;
	TextColor.R = 255;
	TextColor.G = 255;
	TextColor.B = 0;
	SexLabel.SetTextColor(TextColor);
	SexLabel.MyFont = class'UTLadderStub'.Static.GetStubClass().Static.GetBigFont(Root);
	SexLabel.bStretched = True;
	SexLabel.bDisabled = True;
	SexLabel.bDontSetLabel = True;
	SexLabel.LabelWidth = 178.0/1024 * XMod;
	SexLabel.LabelHeight = 49.0/768 * YMod;
	
	// Sex Button
	XPos = 164.0/1024 * XMod;
	YPos = 370.0/768 * YMod;
	XWidth = 256.0/1024 * XMod;
	YHeight = 64.0/768 * YMod;
	SexButton = NotifyButton(CreateWindow(class'NotifyButton', XPos, YPos, XWidth, YHeight));
	SexButton.NotifyWindow = Self;
	SexButton.Text = MaleText;
	TextColor.R = 255;
	TextColor.G = 255;
	TextColor.B = 0;
	SexButton.SetTextColor(TextColor);
	SexButton.MyFont = class'UTLadderStub'.Static.GetStubClass().Static.GetBigFont(Root);
	SexButton.bStretched = True;
	SexButton.UpTexture = Texture(DynamicLoadObject("UTMenu.Plate3Plain", Class'Texture'));
	SexButton.DownTexture = Texture(DynamicLoadObject("UTMenu.PlateYellow2", Class'Texture'));
	SexButton.OverTexture = Texture(DynamicLoadObject("UTMenu.Plate2", Class'Texture'));
	SexButton.bDontSetLabel = True;
	SexButton.LabelWidth = 178.0/1024 * XMod;
	SexButton.LabelHeight = 49.0/768 * YMod;
	SexButton.bIgnoreLDoubleclick = True;
	SexButton.OverSound = sound'LadderSounds.lcursorMove';
	SexButton.DownSound = sound'SpeechWindowClick';
	
	// Team Label
	XPos = 164.0/1024 * XMod;
	YPos = 413.0/768 * YMod;
	XWidth = 256.0/1024 * XMod;
	YHeight = 64.0/768 * YMod;
	TeamLabel = NotifyButton(CreateWindow(class'NotifyButton', XPos, YPos, XWidth, YHeight));
	TeamLabel.NotifyWindow = Self;
	TeamLabel.Text = TeamText;
	TextColor.R = 255;
	TextColor.G = 255;
	TextColor.B = 0;
	TeamLabel.SetTextColor(TextColor);
	TeamLabel.MyFont = class'UTLadderStub'.Static.GetStubClass().Static.GetBigFont(Root);
	TeamLabel.bStretched = True;
	TeamLabel.bDisabled = True;
	TeamLabel.bDontSetLabel = True;
	TeamLabel.LabelWidth = 178.0/1024 * XMod;
	TeamLabel.LabelHeight = 49.0/768 * YMod;
	
	// Team Button
	XPos = 164.0/1024 * XMod;
	YPos = 445.0/768 * YMod;
	XWidth = 256.0/1024 * XMod;
	YHeight = 64.0/768 * YMod;
	TeamButton = NotifyButton(CreateWindow(class'NotifyButton', XPos, YPos, XWidth, YHeight));
	TeamButton.NotifyWindow = Self;
	TextColor.R = 255;
	TextColor.G = 255;
	TextColor.B = 0;
	TeamButton.SetTextColor(TextColor);
	TeamButton.MyFont = class'UTLadderStub'.Static.GetStubClass().Static.GetBigFont(Root);
	TeamButton.bStretched = True;
	TeamButton.UpTexture = Texture(DynamicLoadObject("UTMenu.Plate3Plain", Class'Texture'));
	TeamButton.DownTexture = Texture(DynamicLoadObject("UTMenu.PlateYellow2", Class'Texture'));
	TeamButton.OverTexture = Texture(DynamicLoadObject("UTMenu.Plate2", Class'Texture'));
	TeamButton.bDontSetLabel = True;
	TeamButton.LabelWidth = 178.0/1024 * XMod;
	TeamButton.LabelHeight = 49.0/768 * YMod;
	TeamButton.bIgnoreLDoubleclick = True;
	if (PreferredTeam == class'AMLadderLadder'.Default.NumTeams)
	PreferredTeam = 0;
	TeamButton.Text = class'AMLadderLadder'.Default.LadderTeams[PreferredTeam].Default.TeamName;
	LadderObj.Team = class'AMLadderLadder'.Default.LadderTeams[PreferredTeam];
	TeamButton.OverSound = sound'LadderSounds.lcursorMove';
	TeamButton.DownSound = sound'SpeechWindowClick';
	
	// Face Label
	XPos = 164.0/1024 * XMod;
	YPos = 488.0/768 * YMod;
	XWidth = 256.0/1024 * XMod;
	YHeight = 64.0/768 * YMod;
	FaceLabel = NotifyButton(CreateWindow(class'NotifyButton', XPos, YPos, XWidth, YHeight));
	FaceLabel.NotifyWindow = Self;
	FaceLabel.Text = FaceText;
	TextColor.R = 255;
	TextColor.G = 255;
	TextColor.B = 0;
	FaceLabel.SetTextColor(TextColor);
	FaceLabel.MyFont = class'UTLadderStub'.Static.GetStubClass().Static.GetBigFont(Root);
	FaceLabel.bStretched = True;
	FaceLabel.bDisabled = True;
	FaceLabel.bDontSetLabel = True;
	FaceLabel.LabelWidth = 178.0/1024 * XMod;
	FaceLabel.LabelHeight = 49.0/768 * YMod;
	
	// Face Button
	XPos = 164.0/1024 * XMod;
	YPos = 520.0/768 * YMod;
	XWidth = 256.0/1024 * XMod;
	YHeight = 64.0/768 * YMod;
	FaceButton = NotifyButton(CreateWindow(class'NotifyButton', XPos, YPos, XWidth, YHeight));
	FaceButton.NotifyWindow = Self;
	FaceButton.Text = FaceDescs[PreferredFace];
	TextColor.R = 255;
	TextColor.G = 255;
	TextColor.B = 0;
	FaceButton.SetTextColor(TextColor);
	FaceButton.MyFont = class'UTLadderStub'.Static.GetStubClass().Static.GetBigFont(Root);
	FaceButton.bStretched = True;
	FaceButton.UpTexture = Texture(DynamicLoadObject("UTMenu.Plate3Plain", Class'Texture'));
	FaceButton.DownTexture = Texture(DynamicLoadObject("UTMenu.PlateYellow2", Class'Texture'));
	FaceButton.OverTexture = Texture(DynamicLoadObject("UTMenu.Plate2", Class'Texture'));
	FaceButton.bDontSetLabel = True;
	FaceButton.LabelWidth = 178.0/1024 * XMod;
	FaceButton.LabelHeight = 49.0/768 * YMod;
	FaceButton.bIgnoreLDoubleclick = True;
	FaceButton.OverSound = sound'LadderSounds.lcursorMove';
	FaceButton.DownSound = sound'SpeechWindowClick';
	
	// Skill Label
	XPos = 164.0/1024 * XMod;
	YPos = 563.0/768 * YMod;
	XWidth = 256.0/1024 * XMod;
	YHeight = 64.0/768 * YMod;
	SkillLabel = NotifyButton(CreateWindow(class'NotifyButton', XPos, YPos, XWidth, YHeight));
	SkillLabel.NotifyWindow = Self;
	SkillLabel.Text = SkillsText;
	TextColor.R = 255;
	TextColor.G = 255;
	TextColor.B = 0;
	SkillLabel.SetTextColor(TextColor);
	SkillLabel.MyFont = class'UTLadderStub'.Static.GetStubClass().Static.GetBigFont(Root);
	SkillLabel.bStretched = True;
	SkillLabel.bDisabled = True;
	SkillLabel.bDontSetLabel = True;
	SkillLabel.LabelWidth = 178.0/1024 * XMod;
	SkillLabel.LabelHeight = 49.0/768 * YMod;
	
	// Skill Button
	XPos = 164.0/1024 * XMod;
	YPos = 595.0/768 * YMod;
	XWidth = 256.0/1024 * XMod;
	YHeight = 64.0/768 * YMod;
	SkillButton = NotifyButton(CreateWindow(class'NotifyButton', XPos, YPos, XWidth, YHeight));
	SkillButton.NotifyWindow = Self;
	SkillButton.Text = SkillText[1];
	CurrentSkill = 1;
	TextColor.R = 255;
	TextColor.G = 255;
	TextColor.B = 0;
	SkillButton.SetTextColor(TextColor);
	SkillButton.MyFont = class'UTLadderStub'.Static.GetStubClass().Static.GetBigFont(Root);
	SkillButton.bStretched = True;
	SkillButton.UpTexture = Texture(DynamicLoadObject("UTMenu.Plate3Plain", Class'Texture'));
	SkillButton.DownTexture = Texture(DynamicLoadObject("UTMenu.PlateYellow2", Class'Texture'));
	SkillButton.OverTexture = Texture(DynamicLoadObject("UTMenu.Plate2", Class'Texture'));
	SkillButton.bDontSetLabel = True;
	SkillButton.LabelWidth = 178.0/1024 * XMod;
	SkillButton.LabelHeight = 49.0/768 * YMod;
	SkillButton.bIgnoreLDoubleclick = True;
	CurrentSkill = PreferredSkill;
	SkillButton.Text = SkillText[CurrentSkill];
	LadderObj.TournamentDifficulty = CurrentSkill;
	LadderObj.SkillText = SkillText[LadderObj.TournamentDifficulty];
	SkillButton.OverSound = sound'LadderSounds.lcursorMove';
	SkillButton.DownSound = sound'SpeechWindowClick';
	
	// Title Button
	XPos = 84.0/1024 * XMod;
	YPos = 69.0/768 * YMod;
	XWidth = 342.0/1024 * XMod;
	YHeight = 41.0/768 * YMod;
	TitleButton = NotifyButton(CreateWindow(class'NotifyButton', XPos, YPos, XWidth, YHeight));
	TitleButton.NotifyWindow = Self;
	TitleButton.Text = CCText;
	TextColor.R = 255;
	TextColor.G = 255;
	TextColor.B = 0;
	TitleButton.SetTextColor(TextColor);
	TitleButton.MyFont = class'UTLadderStub'.Static.GetStubClass().Static.GetHugeFont(Root);
	TitleButton.bStretched = True;
	
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
	
	// Team Desc
	XPos = 609.0/1024 * XMod;
	YPos = 388.0/768 * YMod;
	XWidth = 321.0/1024 * XMod;
	YHeight = 113.0/768 * YMod;
	TeamDescArea = UTFadeTextArea(CreateWindow(Class<UWindowWindow>(DynamicLoadObject("UTMenu.UTFadeTextArea", Class'Class')), XPos, YPos, XWidth, YHeight));
	TeamDescArea.TextColor.R = 255;
	TeamDescArea.TextColor.G = 255;
	TeamDescArea.TextColor.B = 0;
	TeamDescArea.MyFont = class'UTLadderStub'.Static.GetStubClass().Static.GetSmallFont(Root);
	TeamDescArea.bAlwaysOnTop = True;
	TeamDescArea.bMousePassThrough = True;
	TeamDescArea.bAutoScrolling = True;
	TeamDescArea.Clear();
	TeamDescArea.AddText(TeamNameString@LadderObj.Team.Static.GetTeamName());
	TeamDescArea.AddText(" ");
	TeamDescArea.AddText(LadderObj.Team.Static.GetTeamBio());
	
	// DescScrollup
	XPos = 715.0/1024 * XMod;
	YPos = 538.0/768 * YMod;
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
	XPos = 799.0/1024 * XMod;
	YPos = 538.0/768 * YMod;
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
	
	if (PreferredSex == 1)
	{
		LadderObj.Sex = "F";
		SexButton.Text = MaleText;
		} else {
		LadderObj.Sex = "M";
		SexButton.Text = FemaleText;
	}
	SexPressed();
	
	Initialized = True;
	Root.Console.bBlackout = True;
}

function NextPressed ()
{
	local int i;
	local ManagerWindow ManagerWindow;
	
	StartLadder();
	
	if ( LadderObj.Sex ~= "F" )
	{
		SexButton.Text = MaleText;
		} else {
		SexButton.Text = FemaleText;
	}
	
	SexPressed();
	
	LadderObj.DMRank = 0;
	LadderObj.DMPosition = -1;
	LadderObj.CTFRank = 0;
	LadderObj.CTFPosition = -1;
	LadderObj.DOMRank = 0;
	LadderObj.DOMPosition = -1;
	LadderObj.ASRank = 0;
	LadderObj.ASPosition = -1;
	LadderObj.ChalRank = 0;
	LadderObj.ChalPosition = 0;
	LadderObj = None;
	
	Close();
	ManagerWindow = ManagerWindow(Root.CreateWindow(Class'AMManagerWindow',100.0,100.0,200.0,200.0,Root,True));
}

defaultproperties
{
}
