
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
	for _,i in pairs(RugObjects.RugTypes)do
		for _,x in pairs(i)do
			if x == item then
				do return i end
			end
		end
	end
end

		
-- add context menu options	
function RugObjects.rugItemsContextMenuEntry(player, context, items)
	local ChangeRugSubmenu = nil
	local CraftRugSubmenu = nil
	local rugGroup = {}
	local dye = nil
	local items = ISInventoryPane.getActualItems(items)
	--checks inventory if it has craft items
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


		--Converting rugs


		--checks if item is a rug by index in ruglist
			if (RugObjects.AllRugs[item:getFullType()]) and not ChangeRugSubmenu then
				ChangeRugSubmenu = context:getNew(context)
					local choices = nil
					-- narrows rugs down by type and returns it as a table
					choices = RugObjects.sortChoices(item:getFullType())
					if choices then
					context:addSubMenu(context:addOption(getText("Change " .. item:getName() .. "  to")), ChangeRugSubmenu)
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

		--Crafting rugs

		local isContext	= RugObjects.CraftContextItemsCheck(item)
		local count = RugObjects.CraftItemsCount(player)
		local choices = RugObjects.sortChoicesByDye(player)
		
		
		if count and isContext and not CraftRugSubmenu  then
			--creating submenu for craft options
			CraftRugSubmenu = context:getNew(context)
			context:addSubMenu(context:addOption(getText("Craft Rug")),CraftRugSubmenu)
			--listing craft options in context menu
			for i,t in pairs(choices) do
					CraftRugSubmenu:addOption(getText(i),getSpecificPlayer(player),RugObjects.UsedRecipe,t[1],1,i)		
			end
			if count > 1 then
				for i,t in pairs(choices) do
					--extra crafting option for using all sheets in inventory
						CraftRugSubmenu:addOption(getText(i) .. " X " .. count,getSpecificPlayer(player),RugObjects.UsedRecipe,t[1],count,i)
				end
			end
		end
	end
end

Events.OnFillInventoryObjectContextMenu.Add(RugObjects.rugItemsContextMenuEntry)