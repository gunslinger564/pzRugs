
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
					inventory:getItemFromTypeRecurse(dyes):Use()
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


------------Utility Functions------------


--gets the amount of rugs that can be made based on what recipe is active
function RugObjects.CraftItemsCount(player,choice)
	local inventory = getSpecificPlayer(player):getInventory()
	local hasNeedle = inventory:containsType("Base.Needle")
	local sheetCount = inventory:getItemCountRecurse("Base.Sheet")
	local yarnCount = inventory:getItemCountRecurse("Base.Yarn")
	local hasThread = inventory:getItemCountRecurse("Base.Thread")
	local hasDye = false
	local itemCount = {}
	local hasCustom = false

		if RugObjects.RecipeName == "Custom" then
			local itemCount = {}
			local hasitems = false

			for _,item in pairs(RugObjects.setCustomCraftRecipe)do
				if inventory:containsType(item) then
					hasitems = true
					itemCount[item] = (itemCount[item] or 0)+1
				else hasitems = false break end
			end
			hasCustom = hasitems
		end



		--Check Item Requirements based upon sandbox settings
	if RugObjects.RecipeName == "Easy" then
		if hasNeedle and (sheetCount > 0) then
			return sheetCount
		else return nil end	
	elseif RugObjects.RecipeName == "Medium" then
		if hasNeedle and (sheetCount > 1) and (yarnCount > 0) and (hasThread>0)then
		 -- returning the item with least amount of uses
			return (math.min(math.floor(sheetCount / 2),yarnCount,hasThread))
		else return nil end
	elseif RugObjects.RecipeName == "Hard" then
		local totalDyeUses = nil
		local sortDye = {}
		if choice then
			for _,dye in pairs(RugObjects.RugDyeCombo[choice]) do
					if inventory:containsTypeRecurse(dye)then
						local drainablecount = 0
						local invDyes = inventory:getAllTypeRecurse(dye)
						for i=1,invDyes:size()do
							local dyes = invDyes:get(i-1)
							drainablecount = drainablecount + dyes:getDrainableUsesInt()

						end
						table.insert(sortDye,drainablecount)

						hasDye = true
					else hasDye = false break end
			end
			
		totalDyeUses = math.min(unpack(sortDye))
		else 
			local c = 0
			local inv = inventory:getItems()
			for i=1,inv:size() do
				local item = inv:get(i-1)
				if string.find(item:getFullType(),"Base.HairDye")then
					c = c + item:getDrainableUsesInt()
					hasDye = true
				end
			end
			totalDyeUses = c
		end	
		if hasNeedle and (sheetCount > 1) and (yarnCount > 0) and hasDye and (hasThread>0) then
			-- returning the item with least amount of uses
			 return (math.min(math.floor(sheetCount / 2),yarnCount,totalDyeUses,hasThread))
		else return nil end
	elseif (RugObjects.RecipeName == "Custom") and  hasCustom then
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



--makes sure that craft items are selected in context
function RugObjects.CraftContextItemsCheck(item,player)
	local inventory = getSpecificPlayer(player):getInventory()
	if RugObjects.RecipeName == "Easy" then
		if((item:getFullType() == "Base.Sheet") or (item:getFullType() == "Base.Needle")) and (inventory:containsType("Base.Sheet") and inventory:containsType("Base.Needle"))then
			return true
		end
	elseif RugObjects.RecipeName == "Medium" then
		if(item:getFullType() == "Base.Sheet") or (item:getFullType() == "Base.Yarn") or (item:getFullType() == "Base.Needle") or (item:getFullType() == "Base.Thread") and ((inventory:getItemCountRecurse("Base.Sheet")>1) and inventory:containsType("Base.Needle") and inventory:containsType("Base.Thread") and inventory:containsType("Base.Yarn"))then
			return true
		end
	elseif RugObjects.RecipeName == "Hard" then
		if(item:getFullType() == "Base.Sheet") or (item:getFullType() == "Base.Yarn") or (item:getFullType() == "Base.Needle") or (item:getFullType() == "Base.Thread") or (string.find(item:getFullType(),"Base.HairDye")) and ((inventory:getItemCountRecurse("Base.Sheet")>1) and inventory:containsType("Base.Needle") and inventory:containsType("Base.Thread") and inventory:containsType("Base.Yarn"))then
			return true
		end
	elseif RugObjects.RecipeName == "Custom" then
		local hasItems = false
		for _,item in pairs(RugObjects.setCustomCraftRecipe)do
			if item:getFullType() == item then hasItems = true 
			else hasItems = false break end
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
			if hasDyes then
				choices[type] = RugObjects.MainRugSprites[type]
			end
		end
		return choices
	else return RugObjects.MainRugSprites end
end