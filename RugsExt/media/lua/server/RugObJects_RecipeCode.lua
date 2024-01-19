
--recipes active based on sandbox option picked


function RugObjects.EasyRecipe(player,rugName,count)
	for x = 1,count do
		player:getInventory():RemoveOneOf("Base.Sheet")
		player:getInventory():AddItem(InventoryItemFactory.CreateItem(rugName))
	end
end



function RugObjects.MedRecipe(player,rugName,count)
	for x = 1,count do
		player:getInventory():RemoveOneOf("Base.Sheet")
		player:getInventory():RemoveOneOf("Base.Sheet")
		player:getInventory():RemoveOneOf("Base.Yarn")
		player:getInventory():RemoveOneOf("Base.Thread")
		player:getInventory():AddItem(InventoryItemFactory.CreateItem(rugName))
	end
end

function RugObjects.HardRecipe(player,rugName,count,choice)
	local dyeItems = {}
	local inventory = player:getInventory()
	local dyeList = RugObjects.RugDyeCombo[choice]

		

	
	for x = 1,count do
		if dyeList then
			for _, dyes in pairs(dyeList) do
				if inventory:containsType(dyes) then
					inventory:getItemFromType(dyes):Use()
				end
				
			end
		end
		inventory:RemoveOneOf("Base.Sheet")
		inventory:RemoveOneOf("Base.Sheet")
		inventory:RemoveOneOf("Base.Yarn")
		inventory:RemoveOneOf("Base.Thread")
		inventory:AddItem(InventoryItemFactory.CreateItem(rugName))
	end
end


function RugObjects.CustomRecipe(player,rugName,count)
	for x = 1,count do
		for _,i in pairs(RugObjects.setCustomCraftRecipe)do
			player:getInventory():RemoveOneOf(i)
		end
		player:getInventory():AddItem(InventoryItemFactory.CreateItem(rugName))
	end
end

function RugObjects.RipEasyRecipe(player,item)
	player:getInventory():RemoveOneOf(item)
	player:getInventory():AddItem(InventoryItemFactory.CreateItem("Base.Sheet"))
	
end


--Utility Functions


--gets the amount of rugs that can be made based on what recipe is active
function RugObjects.CraftItemsCount(player)
	local inventory = getSpecificPlayer(player):getInventory()
	local hasNeedle = inventory:containsType("Base.Needle")
	local sheetCount = inventory:getItemCount("Base.Sheet")
	local yarnCount = inventory:getItemCount("Base.Yarn")
	local hasThread = inventory:containsType("Base.Thread")
	local hasDye = false
	local itemCount = {}

		if RugObjects.RecipeName == "Custom" then
			local itemCount = {}
			local hasitems = false

			for _,item in pairs(RugObjects.setCustomCraftRecipe)do
				if inventory:containsType(item) then
					hasitems = true
					itemCount[item] = (itemCount[item] or 0)+1
				else hasitems = false end
			end
			hasCustom = hasitems
		end



		--Check Item Requirements based upon sandbox settings
	if RugObjects.RecipeName == "Easy" then
		if hasNeedle and (sheetCount > 0) and hasThread then
			return sheetCount
		else return nil end	
	elseif RugObjects.RecipeName == "Medium" then
		if hasNeedle and (sheetCount > 1) and (yarnCount > 0) and hasThread then
		 -- returning the item with least amount of uses
			return (math.min(math.floor(sheetCount / 2),yarnCount))
		else return nil end
	elseif RugObjects.RecipeName == "Hard" then
		local dyesCount = 0
		for i,x in pairs(RugObjects.RugDyeCombo) do
			for _,dye in pairs(x)do
				if inventory:containsType(dye)then
					dyesCount = dyesCount + 1
					hasDye = true
				else hasDye = false end
			end
		end
		if hasNeedle and (sheetCount > 1) and (yarnCount > 0) and hasDye and hasThread then
			dyesCount = dyesCount * 2
			-- returning the item with least amount of uses
			 return (math.min(math.floor(sheetCount / 2),yarnCount,dyesCount))
		else return nil end
	elseif RugObjects.RecipeName == "Custom" then
		local craftCount = nil
		for item,count in pairs(itemCount)do
			local minCraft = math.floor(inventory:getItemCountRecurse(item) / count)
			if (not craftCount) or minCraft < craftCount then
				craftCount = minCraft
			end

		end
		return craftCount
	else return nil end
end

--makes sure that items are selected in context
function RugObjects.CraftContextItemsCheck(item)
	if RugObjects.RecipeName == "Easy" then
		if(item:getFullType() == "Base.Sheet") or (item:getFullType() == "Base.Needle") or (item:getFullType() == "Base.Thread")then
			return true
		end
	elseif RugObjects.RecipeName == "Medium" then
		if(item:getFullType() == "Base.Sheet") or (item:getFullType() == "Base.Yarn") or (item:getFullType() == "Base.Needle") or (item:getFullType() == "Base.Thread")then
			return true
		end
	elseif RugObjects.RecipeName == "Hard" then
		if(item:getFullType() == "Base.Sheet") or (item:getFullType() == "Base.Yarn") or (item:getFullType() == "Base.Needle") or (item:getFullType() == "Base.Thread") or (string.find(item:getFullType(),"Base.HairDye"))then
			return true
		end
	elseif RugObjects.RecipeName == "Custom" then
		local hasItems = false
		for _,item in pairs(RugObjects.setCustomCraftRecipe)do
			if item:getFullType() == item then hasItems = true 
			else hasItems = false end
		end
		return hasItems
	else return nil end
end


function RugObjects.sortChoices(rugName)
	local rugType = RugObjects.AllRugs[rugName]
	if not RugObjects.blackListConversion[rugType] then
		return RugObjects.MainRugSprites[rugType]
	end
end

function RugObjects.sortChoicesByDye(player)
	if RugObjects.RecipeName == "Hard" then
		local inventory = getSpecificPlayer(player):getInventory()
		local choices = {}
		local hasDyes = false
		for type, dyes in pairs(RugObjects.RugDyeCombo)do

			for _,dye in pairs(dyes)do
				
				if inventory:containsType(dye)then
					hasDyes = true
				else hasDyes = false end
				
			end
			if n then
				choices[type] = {}
			end
		end
		for type, rugs in pairs(choices) do
			choices[type] = RugObjects.MainRugSprites[type]
		end
		return choices
	else return RugObjects.MainRugSprites end
end