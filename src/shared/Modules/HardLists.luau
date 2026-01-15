local HardLists = {
	ListNames = {
		"Laboratory",
		"Underwater",
		"Volcano",
		"Spaceship",
		"Jungle",
		"AncientRuins",
		"CyberCity",
		"WinterTown",
		"TimeTravel",
		"HauntedHouse",
		"PirateCove",
		"MusicStudio",
		"Bakery",
		"SpaceStation",
		"AmusementPark",
		"Battlefield",
		"Rainforest",
		"SkyIsland",
		"Underground",
		"Tournament",
	},

	Laboratory = {
		Order = {"Beaker", "Potion", "Fumes", "Hazard", "Antidote"},
		Beaker = "B _ _ _ _ _",
		Potion = "P _ _ _ _ _",
		Fumes = "F _ _ _ _",
		Hazard = "H _ _ _ _ _ _",
		Antidote = "A _ _ _ _ _ _ _",
	},

	Underwater = {
		Order = {"Coral", "Reef", "Current", "Whirlpool", "Abyss"},
		Coral = "C _ _ _ _",
		Reef = "R _ _ _",
		Current = "C _ _ _ _ _ _",
		Whirlpool = "W _ _ _ _ _ _ _ _",
		Abyss = "A _ _ _ _",
	},

	Volcano = {
		Order = {"Crater", "Magma", "Eruption", "Ashfall", "Landslide"},
		Crater = "C _ _ _ _ _",
		Magma = "M _ _ _ _",
		Eruption = "E _ _ _ _ _ _ _",
		Ashfall = "A _ _ _ _ _ _",
		Landslide = "L _ _ _ _ _ _ _ _",
	},

	Spaceship = {
		Order = {"Cockpit", "Control", "Thruster", "Landing", "Reentry"},
		Cockpit = "C _ _ _ _ _ _",
		Control = "C _ _ _ _ _ _",
		Thruster = "T _ _ _ _ _ _ _",
		Landing = "L _ _ _ _ _ _",
		Reentry = "R _ _ _ _ _ _",
	},

	Jungle = {
		Order = {"Vines", "Panther", "Prowl", "Ambush", "Echo"},
		Vines = "V _ _ _ _",
		Panther = "P _ _ _ _ _ _",
		Prowl = "P _ _ _ _",
		Ambush = "A _ _ _ _ _",
		Echo = "E _ _ _",
	},

	AncientRuins = {
		Order = {"Relic", "Tablet", "Inscription", "Legend", "Myth"},
		Relic = "R _ _ _ _",
		Tablet = "T _ _ _ _ _",
		Inscription = "I _ _ _ _ _ _ _ _ _ _",
		Legend = "L _ _ _ _ _",
		Myth = "M _ _ _",
	},

	CyberCity = {
		Order = {"Neon", "Circuit", "Firewall", "Override", "Glitch"},
		Neon = "N _ _ _",
		Circuit = "C _ _ _ _ _ _",
		Firewall = "F _ _ _ _ _ _ _",
		Override = "O _ _ _ _ _ _ _",
		Glitch = "G _ _ _ _ _",
	},

	WinterTown = {
		Order = {"Snowfall", "Blizzard", "Icicle", "Frozen", "Sleigh"},
		Snowfall = "S _ _ _ _ _ _ _",
		Blizzard = "B _ _ _ _ _ _ _",
		Icicle = "I _ _ _ _ _",
		Frozen = "F _ _ _ _ _",
		Sleigh = "S _ _ _ _ _",
	},

	TimeTravel = {
		Order = {"Hourglass", "Timeline", "Paradox", "Loop", "Era"},
		Hourglass = "H _ _ _ _ _ _ _ _",
		Timeline = "T _ _ _ _ _ _ _",
		Paradox = "P _ _ _ _ _ _",
		Loop = "L _ _ _",
		Era = "E _ _",
	},

	HauntedHouse = {
		Order = {"Cobweb", "Whisper", "Phantom", "Nightmare", "Curse"},
		Cobweb = "C _ _ _ _ _",
		Whisper = "W _ _ _ _ _ _",
		Phantom = "P _ _ _ _ _ _",
		Nightmare = "N _ _ _ _ _ _ _ _",
		Curse = "C _ _ _ _",
	},

	PirateCove = {
		Order = {"Treasure", "Map", "Compass", "Shipwreck", "Rum"},
		Treasure = "T _ _ _ _ _ _ _",
		Map = "M _ _",
		Compass = "C _ _ _ _ _ _",
		Shipwreck = "S _ _ _ _ _ _ _ _",
		Rum = "R _ _",
	},

	MusicStudio = {
		Order = {"Headphones", "Microphone", "Record", "Playback", "Remix"},
		Headphones = "H _ _ _ _ _ _ _ _",
		Microphone = "M _ _ _ _ _ _ _ _ _",
		Record = "R _ _ _ _ _",
		Playback = "P _ _ _ _ _ _ _",
		Remix = "R _ _ _ _",
	},

	Bakery = {
		Order = {"Dough", "Oven", "Pastry", "Sprinkle", "Glaze"},
		Dough = "D _ _ _ _",
		Oven = "O _ _ _",
		Pastry = "P _ _ _ _ _",
		Sprinkle = "S _ _ _ _ _ _ _",
		Glaze = "G _ _ _ _",
	},

	SpaceStation = {
		Order = {"Module", "Docking", "Oxygen", "Orbiting", "Solar"},
		Module = "M _ _ _ _ _",
		Docking = "D _ _ _ _ _ _ _",
		Oxygen = "O _ _ _ _ _",
		Orbiting = "O _ _ _ _ _ _ _",
		Solar = "S _ _ _ _",
	},

	AmusementPark = {
		Order = {"Carousel", "Rollercoaster", "Ticket", "Fireworks", "Parade"},
		Carousel = "C _ _ _ _ _ _ _",
		Rollercoaster = "R _ _ _ _ _ _ _ _ _ _ _",
		Ticket = "T _ _ _ _ _",
		Fireworks = "F _ _ _ _ _ _ _ _",
		Parade = "P _ _ _ _ _",
	},

	Battlefield = {
		Order = {"Trenches", "Grenade", "Barricade", "Victory", "Medal"},
		Trenches = "T _ _ _ _ _ _ _",
		Grenade = "G _ _ _ _ _ _",
		Barricade = "B _ _ _ _ _ _ _ _",
		Victory = "V _ _ _ _ _ _",
		Medal = "M _ _ _ _",
	},

	Rainforest = {
		Order = {"Canopy", "Mist", "Monsoon", "Endangered", "Vine"},
		Canopy = "C _ _ _ _ _",
		Mist = "M _ _ _",
		Monsoon = "M _ _ _ _ _ _",
		Endangered = "E _ _ _ _ _ _ _ _",
		Vine = "V _ _ _",
	},

	SkyIsland = {
		Order = {"Floating", "Bridge", "Temple", "Guardian", "Relic"},
		Floating = "F _ _ _ _ _ _ _",
		Bridge = "B _ _ _ _ _",
		Temple = "T _ _ _ _ _",
		Guardian = "G _ _ _ _ _ _ _",
		Relic = "R _ _ _ _",
	},

	Underground = {
		Order = {"Tunnel", "Miner", "Lantern", "Treasure", "Echo"},
		Tunnel = "T _ _ _ _ _",
		Miner = "M _ _ _ _",
		Lantern = "L _ _ _ _ _",
		Treasure = "T _ _ _ _ _ _ _",
		Echo = "E _ _ _",
	},

	Tournament = {
		Order = {"Bracket", "Quarterfinal", "Semifinal", "Champion", "Ceremony"},
		Bracket = "B _ _ _ _ _ _",
		Quarterfinal = "Q _ _ _ _ _ _ _ _ _ _",
		Semifinal = "S _ _ _ _ _ _ _ _",
		Champion = "C _ _ _ _ _ _ _",
		Ceremony = "C _ _ _ _ _ _ _",
	},
}

return HardLists
