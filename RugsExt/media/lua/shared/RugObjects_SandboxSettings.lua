local Sandbox = SandboxVars.RugObjects
function RugObjects.OnInitGlobalModData()
    if Sandbox.setMediumRecipe then
        RugObjects.RecipeName = "Medium"
        RugObjects.UsedRecipe = RugObjects.MedRecipe
        RugObjects.RipRecipe = RugObjects.RipMedRecipe
    elseif Sandbox.setHardRecipe then
        RugObjects.RecipeName = "Hard"
        RugObjects.UsedRecipe = RugObjects.HardRecipe
        RugObjects.RipRecipe = RugObjects.RipHardRecipe
    elseif Sandbox.setCustomRecipe then
        RugObjects.RecipeName = "Custom"
        RugObjects.UsedRecipe = RugObjects.CustomRecipe
        RugObjects.setCustomCraftRecipe = {}
        RugObjects.setCustomRipRecipe = {}
        for word in string.gmatch(Sandbox.setCustomCraftRecipe,'[^,%s]+') do
        table.insert(RugObjects.setCustomCraftRecipe,word)
        end
        for word in string.gmatch(Sandbox.setCustomRipRecipe,'[^,%s]+') do
            table.insert(RugObjects.setCustomRipRecipe,word)
        end
    else
        RugObjects.RecipeName = "Easy"
        RugObjects.UsedRecipe = RugObjects.EasyRecipe
        RugObjects.RipRecipe = RugObjects.RipEasyRecipe

    end
end
Events.OnInitGlobalModData.Add(RugObjects.OnInitGlobalModData)


    
    
    

