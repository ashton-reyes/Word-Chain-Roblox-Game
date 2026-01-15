local MediumLists = {
	ListNames = {
		"Market",
		"Forest",
		"Castle",
		"Ocean",
		"Desert",
		"Airport",
		"Kitchen",
		"Library",
		"Harbor",
		"Village",
		"Mountain",
		"Hospital",
		"Theater",
		"Farm",
		"Office",
		"Factory",
		"Stadium",
		"Museum",
		"Galaxy",
		"Subway",
	},

	Market = {
		Order = {"Stall", "Fruit", "Buyer", "Money"},
		Stall = "S _ _ _ _",
		Fruit = "F _ _ _ _",
		Buyer = "B _ _ _ _",
		Money = "M _ _ _ _",
	},

	Forest = {
		Order = {"Trail", "River", "Stone", "Bridge"},
		Trail = "T _ _ _ _",
		River = "R _ _ _ _",
		Stone = "S _ _ _ _",
		Bridge = "B _ _ _ _ _",
	},

	Castle = {
		Order = {"Tower", "Guard", "Shield", "Sword"},
		Tower = "T _ _ _ _",
		Guard = "G _ _ _ _",
		Shield = "S _ _ _ _ _",
		Sword = "S _ _ _ _",
	},

	Ocean = {
		Order = {"Wave", "Shell", "Beach", "Towel"},
		Wave = "W _ _ _",
		Shell = "S _ _ _ _",
		Beach = "B _ _ _ _",
		Towel = "T _ _ _ _",
	},

	Desert = {
		Order = {"Dune", "Camel", "Water", "Oasis"},
		Dune = "D _ _ _",
		Camel = "C _ _ _ _",
		Water = "W _ _ _ _",
		Oasis = "O _ _ _ _",
	},

	Airport = {
		Order = {"Runway", "Plane", "Pilot", "Ticket"},
		Runway = "R _ _ _ _ _",
		Plane = "P _ _ _ _",
		Pilot = "P _ _ _ _",
		Ticket = "T _ _ _ _ _",
	},

	Kitchen = {
		Order = {"Stove", "Pan", "Bread", "Toast"},
		Stove = "S _ _ _ _",
		Pan = "P _ _",
		Bread = "B _ _ _ _",
		Toast = "T _ _ _ _",
	},

	Library = {
		Order = {"Shelf", "Book", "Page", "Story"},
		Shelf = "S _ _ _ _",
		Book = "B _ _ _",
		Page = "P _ _ _",
		Story = "S _ _ _ _",
	},

	Harbor = {
		Order = {"Dock", "Boat", "Rope", "Anchor"},
		Dock = "D _ _ _",
		Boat = "B _ _ _",
		Rope = "R _ _ _",
		Anchor = "A _ _ _ _ _",
	},

	Village = {
		Order = {"Street", "Lamp", "Door", "Chair"},
		Street = "S _ _ _ _ _",
		Lamp = "L _ _ _",
		Door = "D _ _ _",
		Chair = "C _ _ _ _",
	},

	Mountain = {
		Order = {"Cliff", "Rock", "Trail", "Summit"},
		Cliff = "C _ _ _ _",
		Rock = "R _ _ _",
		Trail = "T _ _ _ _",
		Summit = "S _ _ _ _ _",
	},

	Hospital = {
		Order = {"Nurse", "Bed", "Chart", "Cure"},
		Nurse = "N _ _ _ _",
		Bed = "B _ _",
		Chart = "C _ _ _ _",
		Cure = "C _ _ _",
	},

	Theater = {
		Order = {"Stage", "Actor", "Scene", "Applause"},
		Stage = "S _ _ _ _",
		Actor = "A _ _ _ _",
		Scene = "S _ _ _ _",
		Applause = "A _ _ _ _ _ _ _",
	},

	Farm = {
		Order = {"Field", "Wheat", "Bread", "Meal"},
		Field = "F _ _ _ _",
		Wheat = "W _ _ _ _",
		Bread = "B _ _ _ _",
		Meal = "M _ _ _",
	},

	Office = {
		Order = {"Desk", "Paper", "File", "Folder"},
		Desk = "D _ _ _",
		Paper = "P _ _ _ _",
		File = "F _ _ _",
		Folder = "F _ _ _ _ _",
	},

	Factory = {
		Order = {"Machine", "Gear", "Metal", "Product"},
		Machine = "M _ _ _ _ _ _",
		Gear = "G _ _ _",
		Metal = "M _ _ _ _",
		Product = "P _ _ _ _ _ _",
	},

	Stadium = {
		Order = {"Seat", "Crowd", "Cheer", "Trophy"},
		Seat = "S _ _ _",
		Crowd = "C _ _ _ _",
		Cheer = "C _ _ _ _",
		Trophy = "T _ _ _ _ _",
	},

	Museum = {
		Order = {"Hall", "Frame", "Painting", "Artist"},
		Hall = "H _ _ _",
		Frame = "F _ _ _ _",
		Painting = "P _ _ _ _ _ _ _",
		Artist = "A _ _ _ _ _",
	},

	Galaxy = {
		Order = {"Star", "Planet", "Moon", "Orbit"},
		Star = "S _ _ _",
		Planet = "P _ _ _ _ _",
		Moon = "M _ _ _",
		Orbit = "O _ _ _ _",
	},

	Subway = {
		Order = {"Tunnel", "Train", "Door", "Station"},
		Tunnel = "T _ _ _ _ _",
		Train = "T _ _ _ _",
		Door = "D _ _ _",
		Station = "S _ _ _ _ _ _",
	},
}

return MediumLists
