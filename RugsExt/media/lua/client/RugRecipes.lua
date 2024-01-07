rugObjects = rugObjects  or {}
rugTypes = rugTypes or {}
local function ripCarpet(player,rug)
		player:getInventory():Remove(rug)
		player:getInventory():AddItem("Base.Sheet")
end
local function convertPiece(player,option,item)
	player:getInventory():Remove(item)
	player:getInventory():AddItem(option)
	
end

local function sortChoices(rugName)
	local choices = {}
	local r = nil
		for _, list in pairs(rugTypes) do
			for i, names in pairs(list) do
				if string.find(names,rugName) then
					choices = list
					r = i
				end
			end
		end
	choices[r] = nil
	return choices
end
		
			
local function rugItemsContextMenuEntry(player, context, items,test)
	if test and ISInventoryObjectContextMenu.Test then return true end
  local items = ISInventoryPane.getActualItems(items)
  for _, item in pairs(items) do
	for i, name in pairs(rugObjects) do
    		if string.find(item:getFullType(),name) then
					-- local ripRug = context:addOption(getText("rip rug square"),getSpecificPlayer(player),ripCarpet,item)
					 local choices = {}
					choices = sortChoices(item:getFullType())
				for _, option in pairs(choices) do
      				local convertRug = context:addOption(getText("Change rug piece to" .. Translator.getMoveableDisplayName(options)), getSpecificPlayer(player), convertPiece,option,item)
    			end
			end
	end
end
end

Events.OnFillInventoryObjectContextMenu.Add(rugItemsContextMenuEntry)