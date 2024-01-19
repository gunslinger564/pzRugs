RugObjects = {}
RugTypes = {}
MainRugSprites = {}

--reverse searchable table 
RugObjects.AllRugs = {}
for i = 0,110 do
	if i ~= 86 and i ~= 94 and i ~= 95 and i ~= 102 and i ~= 103 then
		RugObjects.AllRugs["Moveables.floors_rugs_01_" .. i] = 0
	end
end
-- List of what dyes are used to make each rugtype
RugObjects.RugDyeCombo = {
	darkGreenRug ={"Base.HairDyeGreen"},
	darkPurpleRug ={"Base.HairDyeBlue","Base.HairDyeRed"},
	bordeauxRug ={"Base.HairDyeRed"},
	fancyOrangeRug ={"Base.HairDyeRed","Base.HairDyeGreen"},
	darkGreyRug ={"Base.HairDyeWhite","Base.HairDyeBlack"},
	blueCheckeredRug ={"Base.HairDyeBlue"},
	fancyBrownRug ={"Base.HairDyeLightBrown"},
	fancyGreenRug ={"Base.HairDyeGreen"},
	toddlerRug ={"Base.HairDyeYellow","Base.HairDyeBlue","Base.HairDyeRed","Base.HairDyeGreen"},
	redBathroomRug ={"Base.HairDyeRed"},
	purpleBathroomRug ={"Base.HairDyeBlue","Base.HairDyeRed"},
	doorMatRug ={"Base.HairDyeBlue","Base.HairDyeRed"},
}




-- List Of Rugs that are crafted/converted to. The first option is what's crafted
RugObjects.MainRugSprites = {
	darkGreenRug = {"Moveables.floors_rugs_01_60","Moveables.floors_rugs_01_0","Moveables.floors_rugs_01_2","Moveables.floors_rugs_01_88",},
	darkPurpleRug = {"Moveables.floors_rugs_01_8","Moveables.floors_rugs_01_10","Moveables.floors_rugs_01_80","Moveables.floors_rugs_01_61",},
	bordeauxRug = {"Moveables.floors_rugs_01_62","Moveables.floors_rugs_01_16","Moveables.floors_rugs_01_18","Moveables.floors_rugs_01_96",},
	fancyOrangeRug = {"Moveables.floors_rugs_01_24","Moveables.floors_rugs_01_32",},
	darkGreyRug = 	{"Moveables.floors_rugs_01_87","Moveables.floors_rugs_01_72","Moveables.floors_rugs_01_74","Moveables.floors_rugs_01_104",},
	blueCheckeredRug = {"Moveables.floors_rugs_01_26","Moveables.floors_rugs_01_34",},
	fancyBrownRug = {"Moveables.floors_rugs_01_28","Moveables.floors_rugs_01_36",},
	fancyGreenRug =  {"Moveables.floors_rugs_01_30","Moveables.floors_rugs_01_38",},
	toddlerRug =		{"Moveables.floors_rugs_01_63","Moveables.floors_rugs_01_65","Moveables.floors_rugs_01_68",},
	redBathroomRug = {"Moveables.floors_rugs_01_48",},
	purpleBathroomRug = {"Moveables.floors_rugs_01_52",},
	doorMatRug = {"Moveables.floors_rugs_01_56",}

}
RugObjects.RugTypes =
{
					darkGreenRug = {
										"Moveables.floors_rugs_01_0",
										"Moveables.floors_rugs_01_1",
										"Moveables.floors_rugs_01_2",
										"Moveables.floors_rugs_01_3",
										"Moveables.floors_rugs_01_4",
										"Moveables.floors_rugs_01_5",
										"Moveables.floors_rugs_01_6",
										"Moveables.floors_rugs_01_7",
										"Moveables.floors_rugs_01_60",
										"Moveables.floors_rugs_01_88",
										"Moveables.floors_rugs_01_89",
										"Moveables.floors_rugs_01_90",
										"Moveables.floors_rugs_01_91",
										"Moveables.floors_rugs_01_92",
										"Moveables.floors_rugs_01_93",
									},
					darkPurpleRug = {
										"Moveables.floors_rugs_01_8",
										"Moveables.floors_rugs_01_9",
										"Moveables.floors_rugs_01_10",
										"Moveables.floors_rugs_01_11",
										"Moveables.floors_rugs_01_12",
										"Moveables.floors_rugs_01_13",
										"Moveables.floors_rugs_01_14",
										"Moveables.floors_rugs_01_15",
										"Moveables.floors_rugs_01_61",
										"Moveables.floors_rugs_01_80",
										"Moveables.floors_rugs_01_81",
										"Moveables.floors_rugs_01_82",
										"Moveables.floors_rugs_01_83",
										"Moveables.floors_rugs_01_84",
										"Moveables.floors_rugs_01_85",
									},
				bordeauxRug = 		{
										"Moveables.floors_rugs_01_16",
										"Moveables.floors_rugs_01_17",
										"Moveables.floors_rugs_01_18",
										"Moveables.floors_rugs_01_19",
										"Moveables.floors_rugs_01_20",
										"Moveables.floors_rugs_01_21",
										"Moveables.floors_rugs_01_22",
										"Moveables.floors_rugs_01_23",
										"Moveables.floors_rugs_01_62",
										"Moveables.floors_rugs_01_96",
										"Moveables.floors_rugs_01_97",
										"Moveables.floors_rugs_01_98",
										"Moveables.floors_rugs_01_99",
										"Moveables.floors_rugs_01_100",
										"Moveables.floors_rugs_01_101",
									},
				fancyOrangeRug = 	{
										"Moveables.floors_rugs_01_24",
										"Moveables.floors_rugs_01_25",
										"Moveables.floors_rugs_01_32",
										"Moveables.floors_rugs_01_33",
										"Moveables.floors_rugs_01_40",
										"Moveables.floors_rugs_01_41",
									},
				toddlerRug =		{
										"Moveables.floors_rugs_01_63",
										"Moveables.floors_rugs_01_64",
										"Moveables.floors_rugs_01_65",
										"Moveables.floors_rugs_01_66",
										"Moveables.floors_rugs_01_67",
										"Moveables.floors_rugs_01_68",
										"Moveables.floors_rugs_01_69",
										"Moveables.floors_rugs_01_70",
										"Moveables.floors_rugs_01_71",
									},
				darkGreyRug = 		{	
										"Moveables.floors_rugs_01_72",
										"Moveables.floors_rugs_01_73",
										"Moveables.floors_rugs_01_74",
										"Moveables.floors_rugs_01_75",
										"Moveables.floors_rugs_01_76",
										"Moveables.floors_rugs_01_78",
										"Moveables.floors_rugs_01_79",
										"Moveables.floors_rugs_01_87",
										"Moveables.floors_rugs_01_104",
										"Moveables.floors_rugs_01_105",
										"Moveables.floors_rugs_01_106",
										"Moveables.floors_rugs_01_107",
										"Moveables.floors_rugs_01_108",
										"Moveables.floors_rugs_01_109",
									},

				blueCheckeredRug = 	{
										"Moveables.floors_rugs_01_26",
										"Moveables.floors_rugs_01_27",
										"Moveables.floors_rugs_01_34",
										"Moveables.floors_rugs_01_35",
										"Moveables.floors_rugs_01_42",
										"Moveables.floors_rugs_01_43",
									},
				fancyBrownRug =	 	{
										"Moveables.floors_rugs_01_28",
										"Moveables.floors_rugs_01_29",
										"Moveables.floors_rugs_01_36",
										"Moveables.floors_rugs_01_37",
										"Moveables.floors_rugs_01_44",
										"Moveables.floors_rugs_01_45",
									},
				fancyGreenRug = 	{
										"Moveables.floors_rugs_01_30",
										"Moveables.floors_rugs_01_31",
										"Moveables.floors_rugs_01_38",
										"Moveables.floors_rugs_01_39",
										"Moveables.floors_rugs_01_46",
										"Moveables.floors_rugs_01_47",
									},
				redBathroomRug =	{	"Moveables.floors_rugs_01_48",
										"Moveables.floors_rugs_01_49",
										"Moveables.floors_rugs_01_50",
										"Moveables.floors_rugs_01_51",
									},
				purpleBathroomRug = {	"Moveables.floors_rugs_01_52",
									 	"Moveables.floors_rugs_01_53",
									 	"Moveables.floors_rugs_01_54",
										"Moveables.floors_rugs_01_55",
									},
				doorMatRug 	= 		{	"Moveables.floors_rugs_01_56",
										"Moveables.floors_rugs_01_57",
										"Moveables.floors_rugs_01_58",
										"Moveables.floors_rugs_01_59",
									},
}
RugObjects.blackListConversion = {doorMatRug = true ,purpleBathroomRug = true,redBathroomRug = true}

for rugType, rugNames in pairs(RugObjects.RugTypes)do
	for _, rugName in pairs(rugNames)do
		for i,SRugName in pairs(RugObjects.AllRugs)do
			if i == rugName then
				RugObjects.AllRugs[i] = rugType
				
			end
		end
	end
end