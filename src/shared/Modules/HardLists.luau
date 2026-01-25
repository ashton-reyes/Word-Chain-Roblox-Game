local HardLists = {
	ListNames = {
		"Fire",
		"Water",
		"Light",
		"Thunder",
		"Silver",
		"Star",
		"Golden",
		"Master",
		"Super",
		"Under",
		"Over",
		"Cross",
		"Double",
		"Single",
		"First",
		"Last",
		"Fast",
		"Slow",
		"Quick",
		"Dead",
		"Live",
		"Cold",
		"Hot",
		"Wild",
		"Free",
		"Open",
		"Close",
		"High",
		"Low",
		"Dark",
		"Bright",
	},

	Fire = {
		Order = {"Fly", "Ball", "Park", "Bench", "Mark"},
		Fly = "F _ _",
		Ball = "B _ _ _",
		Park = "P _ _ _",
		Bench = "B _ _ _ _",
		Mark = "M _ _ _"
	},

	Water = {
		Order = {"Slide", "Show", "Case", "Study", "Hall"},
		Slide = "S _ _ _ _",
		Show = "S _ _ _",
		Case = "C _ _ _",
		Study = "S _ _ _ _",
		Hall = "H _ _ _"
	},

	Light = {
		Order = {"House", "Hold", "Over", "Turn", "Around"},
		House = "H _ _ _ _",
		Hold = "H _ _ _",
		Over = "O _ _ _",
		Turn = "T _ _ _",
		Around = "A _ _ _ _ _"
	},

	Thunder = {
		Order = {"Storm", "Front", "Line", "Drive", "Through"},
		Storm = "S _ _ _ _",
		Front = "F _ _ _ _",
		Line = "L _ _ _",
		Drive = "D _ _ _ _",
		Through = "T _ _ _ _ _ _"
	},

	Silver = {
		Order = {"Screen", "Shot", "Gun", "Powder", "Room"},
		Screen = "S _ _ _ _ _",
		Shot = "S _ _ _",
		Gun = "G _ _",
		Powder = "P _ _ _ _ _",
		Room = "R _ _ _"
	},
	
	Star = {
		Order = {"Light", "Weight", "Loss", "Leader", "Board"},
		Light = "L _ _ _ _",
		Weight = "W _ _ _ _ _",
		Loss = "L _ _ _",
		Leader = "L _ _ _ _ _",
		Board = "B _ _ _ _",
	},

	Golden = {
		Order = {"Gate", "Keeper", "Box", "Spring", "Break"},
		Gate = "G _ _ _",
		Keeper = "K _ _ _ _ _",
		Box = "B _ _",
		Spring = "S _ _ _ _ _",
		Break = "B _ _ _ _"
	},

	Master = {
		Order = {"Mind", "Set", "Back", "Fire", "Place"},
		Mind = "M _ _ _",
		Set = "S _ _",
		Back = "B _ _ _",
		Fire = "F _ _ _",
		Place = "P _ _ _ _"
	},

	Super = {
		Order = {"Star", "Fish", "Bowl", "Game", "Show"},
		Star = "S _ _ _",
		Fish = "F _ _ _",
		Bowl = "B _ _ _",
		Game = "G _ _ _",
		Show = "S _ _ _"
	},

	Under = {
		Order = {"Cover", "Charge", "Card", "Board", "Room"},
		Cover = "C _ _ _ _",
		Charge = "C _ _ _ _ _",
		Card = "C _ _ _",
		Board = "B _ _ _ _",
		Room = "R _ _ _"
	},

	Over = {
		Order = {"Load", "Time", "Keeper", "Ring", "Side"},
		Load = "L _ _ _",
		Time = "T _ _ _",
		Keeper = "K _ _ _ _ _",
		Ring = "R _ _ _",
		Side = "S _ _ _"
	},

	Cross = {
		Order = {"Walk", "Way", "Point", "Blank", "Check"},
		Walk = "W _ _ _",
		Way = "W _ _",
		Point = "P _ _ _ _",
		Blank = "B _ _ _ _",
		Check = "C _ _ _ _"
	},

	Double = {
		Order = {"Take", "Over", "Head", "Master", "Plan"},
		Take = "T _ _ _",
		Over = "O _ _ _",
		Head = "H _ _ _",
		Master = "M _ _ _ _ _",
		Plan = "P _ _ _"
	},

	Single = {
		Order = {"Track", "Record", "Player", "Piano", "Key"},
		Track = "T _ _ _ _",
		Record = "R _ _ _ _ _",
		Player = "P _ _ _ _ _",
		Piano = "P _ _ _ _",
		Key = "K _ _"
	},

	First = {
		Order = {"Class", "Action", "Figure", "Head", "Band"},
		Class = "C _ _ _ _",
		Action = "A _ _ _ _ _",
		Figure = "F _ _ _ _ _",
		Head = "H _ _ _",
		Band = "B _ _ _"
	},

	Last = {
		Order = {"Call", "Sign", "Post", "Office", "Space"},
		Call = "C _ _ _",
		Sign = "S _ _ _",
		Post = "P _ _ _",
		Office = "O _ _ _ _ _",
		Space = "S _ _ _ _"
	},

	Fast = {
		Order = {"Lane", "Change", "Over", "Night", "Stand"},
		Lane = "L _ _ _",
		Change = "C _ _ _ _ _",
		Over = "O _ _ _",
		Night = "N _ _ _ _",
		Stand = "S _ _ _ _"
	},

	Slow = {
		Order = {"Motion", "Picture", "Frame", "Work", "Shop"},
		Motion = "M _ _ _ _ _",
		Picture = "P _ _ _ _ _ _",
		Frame = "F _ _ _ _",
		Work = "W _ _ _",
		Shop = "S _ _ _"
	},

	Quick = {
		Order = {"Sand", "Paper", "Back", "Stage", "Hand"},
		Sand = "S _ _ _",
		Paper = "P _ _ _ _",
		Back = "B _ _ _",
		Stage = "S _ _ _ _",
		Hand = "H _ _ _"
	},

	Dead = {
		Order = {"Line", "Dancing", "Queen", "Size", "Chart"},
		Line = "L _ _ _",
		Dancing = "D _ _ _ _ _ _",
		Queen = "Q _ _ _ _",
		Size = "S _ _ _",
		Chart = "C _ _ _ _"
	},

	Live = {
		Order = {"Wire", "Frame", "Rate", "Card", "Trick"},
		Wire = "W _ _ _",
		Frame = "F _ _ _ _",
		Rate = "R _ _ _",
		Card = "C _ _ _",
		Trick = "T _ _ _ _"
	},

	Cold = {
		Order = {"Shoulder", "Blade", "Runner", "Bean", "Bag"},
		Shoulder = "S _ _ _ _ _ _ _",
		Blade = "B _ _ _ _",
		Runner = "R _ _ _ _ _",
		Bean = "B _ _ _",
		Bag = "B _ _"
	},

	Hot = {
		Order = {"Head", "Quarter", "Back", "Yard", "Stick"},
		Head = "H _ _ _",
		Quarter = "Q _ _ _ _ _ _",
		Back = "B _ _ _",
		Yard = "Y _ _ _",
		Stick = "S _ _ _ _"
	},

	Wild = {
		Order = {"Card", "Sharp", "Shooter", "Star", "Dust"},
		Card = "C _ _ _",
		Sharp = "S _ _ _ _",
		Shooter = "S _ _ _ _ _ _",
		Star = "S _ _ _",
		Dust = "D _ _ _"
	},

	Free = {
		Order = {"Fall", "Out", "Burst", "Fire", "Storm"},
		Fall = "F _ _ _",
		Out = "O _ _",
		Burst = "B _ _ _ _",
		Fire = "F _ _ _",
		Storm = "S _ _ _ _"
	},

	Open = {
		Order = {"House", "Broken", "Heart", "Land", "Mine"},
		House = "H _ _ _ _",
		Broken = "B _ _ _ _ _",
		Heart = "H _ _ _ _",
		Land = "L _ _ _",
		Mine = "M _ _ _"
	},

	Close = {
		Order = {"Call", "Center", "Stage", "Light", "Weight"},
		Call = "C _ _ _",
		Center = "C _ _ _ _ _",
		Stage = "S _ _ _ _",
		Light = "L _ _ _ _",
		Weight = "W _ _ _ _ _"
	},

	High = {
		Order = {"Land", "Lord", "Over", "Board", "Walk"},
		Land = "L _ _ _",
		Lord = "L _ _ _",
		Over = "O _ _ _",
		Board = "B _ _ _ _",
		Walk = "W _ _ _"
	},

	Low = {
		Order = {"Key", "Chain", "Link", "Up", "Town"},
		Key = "K _ _",
		Chain = "C _ _ _ _",
		Link = "L _ _ _",
		Up = "U _",
		Town = "T _ _ _"
	},

	Dark = {
		Order = {"Room", "Service", "Center", "Point", "Guard"},
		Room = "R _ _ _",
		Service = "S _ _ _ _ _ _",
		Center = "C _ _ _ _ _",
		Point = "P _ _ _ _",
		Guard = "G _ _ _ _"
	},

	Bright = {
		Order = {"Side", "Track", "Field", "Trip", "Wire"},
		Side = "S _ _ _",
		Track = "T _ _ _ _",
		Field = "F _ _ _ _",
		Trip = "T _ _ _",
		Wire = "W _ _ _"
	},
}

return HardLists