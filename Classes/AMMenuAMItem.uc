//================================================================================
// AMMenuAMItem.
//================================================================================

class AMMenuAMItem extends UMenuModMenuItem;

function Execute ()
{
	MenuItem.Owner.Root.CreateWindow(class'AMMenuAMWindow',100.0,100.0,200.0,200.0);
}

defaultproperties
{
	MenuCaption="Neon_&Knight's Ladder"
}
