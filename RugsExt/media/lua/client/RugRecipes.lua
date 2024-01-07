
local function ripCarpet(player,rug)
		player:getInventory():Remove(rug)
		player:getInventory():AddItem("Base.Sheet")
end
local function convertPiece(player,option,item)
	player:getInventory():Remove(item)
	getPlayer():getInventory():AddItem(InventoryItemFactory.CreateItem(option))
end

local function sortChoices(rugName)
	local choices = nil
		for type,tbl in pairs(RugTypes) do
			for i,square in pairs(tbl) do
					for x,t in pairs(MainRugSprites)do
						if x == type and rugName == square then 	
							print("found match")	
							choices = t
							return choices
						end

					end
					if square == rugName then choices = tbl return choices end
					
			end
			
		end

		
end
		
			
local function rugItemsContextMenuEntry(player, context, items,test)
	if test and ISInventoryObjectContextMenu.Test then return true end
	local items = ISInventoryPane.getActualItems(items)
	
	for _, item in pairs(items) do
		for i, name in pairs(rugObjects) do
    		if string.find(item:getFullType(),name) then
					local ripRug = context:addOption(getText("rip rug square"),getSpecificPlayer(player),ripCarpet,item)
					local choices = {}
					choices = sortChoices(item:getFullType())
					if choices then
				for _,option in pairs(choices) do
      				local convertRug = context:addOption(getText("Change rug piece to" .. option ), getSpecificPlayer(player), convertPiece,option,item)
				end
				end
			end
		end
	end
end

Events.OnFillInventoryObjectContextMenu.Add(rugItemsContextMenuEntry)