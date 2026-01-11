local EasyLists = {
	ListNames = {
		"Beach",
		"Coffee",
		"Rain",
		"Water",
		"Tree",
		"Sky",
		"Snow",
		"Sun",
		"Road",
		"Book",
		"Phone",
		"Street",
		"Music",
		"School",
		"River",
		"Garden",
		"Train",
		"Fire",
		"Park",
	},

	Beach = {
		Order = {"Ball", "Game", "Night"},
		Ball = "B _ _ _",
		Game = "G _ _ _",
		Night = "N _ _ _ _",
	},

	Coffee = {
		Order = {"Shop", "Owner", "Manual"},
		Shop = "S _ _ _",
		Owner = "O _ _ _ _",
		Manual = "M _ _ _ _ _",
	},

	Rain = {
		Order = {"Drop", "Ship", "Yard"},
		Drop = "D _ _ _",
		Ship = "S _ _ _",
		Yard = "Y _ _ _",
	},

	Water = {
		Order = {"Bottle", "Flip", "Phone"},
		Bottle = "B _ _ _ _ _",
		Flip = "F _ _ _",
		Phone = "P _ _ _ _",
	},

	Tree = {
		Order = {"House", "Party", "Animal"},
		House = "H _ _ _ _",
		Party = "P _ _ _ _",
		Animal = "A _ _ _ _ _",
	},

	Snow = {
		Order = {"Fall", "Season", "Finale"},
		Fall = "F _ _ _",
		Season = "S _ _ _ _ _",
		Finale = "F _ _ _ _ _",
	},

	Fire = {
		Order = {"Truck", "Stop", "Sign"},
		Truck = "T _ _ _ _",
		Stop = "S _ _ _",
		Sign = "S _ _ _",
	},

	Park = {
		Order = {"Bench", "Light", "House"},
		Bench = "B _ _ _ _",
		Light = "L _ _ _ _",
		House = "H _ _ _ _",
	},

	Sky = {
		Order = {"Light", "House", "Plant"},
		Light = "L _ _ _ _",
		House = "H _ _ _ _",
		Plant = "P _ _ _ _",
	},

	Sun = {
		Order = {"Light", "Rise", "Set"},
		Light = "L _ _ _ _",
		Rise = "R _ _ _",
		Set = "S _ _",
	},

	Road = {
		Order = {"Sign", "Light", "House"},
		Sign = "S _ _ _",
		Light = "L _ _ _ _",
		House = "H _ _ _ _",
	},

	Book = {
		Order = {"Store", "Case", "Mark"},
		Store = "S _ _ _ _",
		Case = "C _ _ _",
		Mark = "M _ _ _",
	},

	Phone = {
		Order = {"Call", "Book", "Case"},
		Call = "C _ _ _",
		Book = "B _ _ _",
		Case = "C _ _ _",
	},

	Street = {
		Order = {"Light", "Sign", "Shop"},
		Light = "L _ _ _ _",
		Sign = "S _ _ _",
		Shop = "S _ _ _",
	},

	Music = {
		Order = {"Box", "Room", "Store"},
		Box = "B _ _",
		Room = "R _ _ _",
		Store = "S _ _ _ _",
	},

	School = {
		Order = {"Book", "Yard", "Bus"},
		Book = "B _ _ _",
		Yard = "Y _ _ _",
		Bus = "B _ _",
	},

	River = {
		Order = {"Bank", "Stone", "Boat"},
		Bank = "B _ _ _",
		Stone = "S _ _ _ _",
		Boat = "B _ _ _",
	},

	Garden = {
		Order = {"Gate", "Light", "Path"},
		Gate = "G _ _ _",
		Light = "L _ _ _ _",
		Path = "P _ _ _",
	},

	Train = {
		Order = {"Stop", "Track", "Sign"},
		Stop = "S _ _ _",
		Track = "T _ _ _ _",
		Sign = "S _ _ _",
	},
}

return EasyLists
