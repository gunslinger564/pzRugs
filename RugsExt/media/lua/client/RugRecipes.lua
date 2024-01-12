-- converts rug by deleting the old one and creating a new one
function RugObjects.convertPiece(player,option,item)
	player:getInventory():Remove(item)
	player:getInventory():AddItem(InventoryItemFactory.CreateItem(option))
end
function RugObjects.convertPieceX(player,option,item,group)
	for _,i in pairs(group) do
		player:getInventory():Remove(i)
		player:getInventory():AddItem(InventoryItemFactory.CreateItem(option))
	end
end
function RugObjects.rugItemGroup(item)
	for _,i in pairs(RugTypes)do
		for _,x in pairs(i)do
			if x == item then
				do return i end
			end
		end
	end
end
-- narrows down rug change choices by type of rug and returns all rug items in that type as a table
function RugObjects.sortChoices(rugName)
	local choices = {}
		for type,tbl in pairs(RugTypes) do
			for i,square in pairs(tbl) do
					for x,t in pairs(MainRugSprites)do
						if x == type and rugName == square then 	
							choices = t
							return choices
						end

					end
					if square == rugName then choices = tbl return choices end
					
			end
			
		end

		
end
--crafts one rug at a time
function RugObjects.makeRugPiece(player,rugName)
	player:getInventory():RemoveOneOf("Base.Sheet")
	player:getInventory():AddItem(InventoryItemFactory.CreateItem(rugName))
end
--allows crafting all rugs possible
function RugObjects.makeRugPieceX(player,rugName,sheetCount)
	for x = 1,sheetCount do
	player:getInventory():RemoveOneOf("Base.Sheet")
	player:getInventory():AddItem(InventoryItemFactory.CreateItem(rugName))
	end
end
		
-- add context menu options	
function RugObjects.rugItemsContextMenuEntry(player, context, items)
	local ChangeRugSubmenu = nil
	local CraftRugSubmenu = nil
	local hasNeedle = nil
	local hasSheet = nil
	local sheetCount = 0
	local rugGroup = {}
	local items = ISInventoryPane.getActualItems(items)
	local inventory = getSpecificPlayer(player):getInventory():getItems()
	--checks inventory if it has craft items
	for i= 0, inventory:size()-1 do 
		local item = inventory:get(i)
		if(item:getFullType() == "Base.Needle" or "Base.SutureNeedle") then
			hasNeedle = true
		end
		if(item:getFullType() == "Base.Sheet") then
			hasSheet = true
		   sheetCount = sheetCount+1
	   	end
	end
	for _, item in pairs(items) do
		if string.find(item:getFullType(),"Moveables.floors_rugs")then
			for _, name in pairs(RugObjects.rugItemGroup(item:getFullType())) do
				if (item:getFullType() == name)then
					table.insert(rugGroup,item)
				end
			end
		end
	end
	--iterate through context items
	for _, item in pairs(items) do
		--checks if item is a rug
		for i, name in pairs(RugObjects) do


			if (item:getFullType() == name) and not ChangeRugSubmenu then
				ChangeRugSubmenu = context:getNew(context)
				context:addSubMenu(context:addOption(getText("Change " .. item:getName() .. "  to")), ChangeRugSubmenu)
					local choices = {}
					-- narrows rugs down by type and returns it as a table
					choices = RugObjects.sortChoices(item:getFullType())
					if choices then
						for _,option in pairs(choices) do
							--removes current item from the list to change to
							if (option ~= item:getFullType()) then
							-- add menu option for changing rug type
								ChangeRugSubmenu:addOption(getText(InventoryItemFactory.CreateItem(option):getCustomNameFull()), getSpecificPlayer(player), RugObjects.convertPiece,option,item)
							end
						end
						for _,option in pairs(choices) do
							if(#rugGroup > 1) and (option ~= item:getFullType()) then
									ChangeRugSubmenu:addOption(getText(InventoryItemFactory.CreateItem(option):getCustomNameFull() .. " X " .. #rugGroup), getSpecificPlayer(player), RugObjects.convertPieceX,option,item,rugGroup)
							end
						end
				end
			end
		end
	end
	-- checks if there is a needle and sheet item in the inventory before giving the option to craft a rug
	if hasNeedle and hasSheet and not CraftRugSubmenu then
		--creating submenu for craft options
		CraftRugSubmenu = context:getNew(context)
		context:addSubMenu(context:addOption(getText("Craft Rug")),CraftRugSubmenu)
		--listing craft options in context menu
		for i,t in pairs(MainRugSprites) do
				CraftRugSubmenu:addOption(getText(i),getSpecificPlayer(player),makeRugPiece,t[1],sheet)		
		end
		for i,t in pairs(MainRugSprites) do
			--extra crafting option for using all sheets in inventory
			if sheetCount > 1 then
				CraftRugSubmenu:addOption(getText(i) .. " X " .. sheetCount,getSpecificPlayer(player),makeRugPieceX,t[1],sheetCount)
			end
	end
	end
end

Events.OnFillInventoryObjectContextMenu.Add(RugObjects.rugItemsContextMenuEntry)