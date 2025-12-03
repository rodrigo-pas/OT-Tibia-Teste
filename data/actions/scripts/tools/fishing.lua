local waterIds = {493, 4608, 4609, 4610, 4611, 4612, 4613, 4614, 4615, 4616, 4617, 4618, 4619, 4620, 4621, 4622, 4623, 4624, 4625, 7236, 10499, 15401, 15402}
local useWorms = false

local SUCCESSFUL_USES_STORAGE = 2580 -- Change to any unused value
local TOTAL_FISHING_USES_STORAGE = 2581 -- New storage for total fishing uses
local FISHING_EXHAUST = 60000 -- 60 seconds in milliseconds
local FISHING_ATTEMPTS = 60

function onUse(player, item, fromPosition, target, toPosition, isHotkey)

    local targetId = target.itemid
    if not table.contains(waterIds, target.itemid) then
        return false
    end

    if player:getStorageValue(SUCCESSFUL_USES_STORAGE) > os.time() then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "You are exhausted from fishing. Please wait.")
        return false
    end

    player:setStorageValue(SUCCESSFUL_USES_STORAGE, os.time() + FISHING_EXHAUST / 1000)
    toPosition:sendMagicEffect(CONST_ME_WATERSPLASH)
    toPosition:sendMagicEffect(2)

    local totalExp = 0

	-- Increment total fishing uses
    local totalFishingUses = player:getStorageValue(TOTAL_FISHING_USES_STORAGE)
    if totalFishingUses < 0 then
        totalFishingUses = 0
    end
    totalFishingUses = totalFishingUses + 1
    player:setStorageValue(TOTAL_FISHING_USES_STORAGE, totalFishingUses)
    for i = 1, FISHING_ATTEMPTS do
        --local exp = math.random(1, 1)
        --totalExp = totalExp + exp
        player:addExperience(exp, true)

        if targetId == 493 then
            return true
        end

        player:addSkillTries(SKILL_FISHING, 1)
        if math.random(1, 100) <= math.min(math.max(10 + (player:getEffectiveSkillLevel(SKILL_FISHING) - 10) * 0.597, 10), 50) then
            if useWorms and not player:removeItem(3976, 1) then
                return true
            end

            local rareChance = math.random(1, 1000)
            local fishItemId
            local fishExp
            if rareChance == 1 then
                fishItemId = 2669 -- Northern Pike
                fishExp = 3
                totalExp = totalExp + fishExp
            elseif rareChance <= 100 then
                fishItemId = 2667 -- Shiny Fish
                fishExp = 2
                totalExp = totalExp + fishExp
            else
                fishItemId = 2670 -- Common Fish
                fishExp = 1
                totalExp = totalExp + fishExp
            end

            -- Add fish to player's inventory if capacity allows
            if player:getFreeCapacity() > 4000 then
                player:addItem(fishItemId, 1)
            else
                player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "Not adding fish because there's no capacity.")
            end

            

            if totalFishingUses % 1000 == 0 then
                -- Award random experience between 100 and 200
                local bonusExp = math.random(100, 200)
                player:addExperience(bonusExp, true)
                player:setStorageValue(55650, player:getStorageValue(55650) + 1)
                player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "[Actions] You gained " .. bonusExp .. " experience from fishing!")
                player:getPosition():sendMagicEffect(28)
            end
        end
    end

    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "You gained a total of " .. totalExp .. " experience from fishing.")
    return true
end
