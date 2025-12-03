local holes = {468, 481, 483}
local sandIds = {231, 9059} -- desert sand

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local tile = Tile(toPosition)
    if not tile then
        return false
    end

    local ground = tile:getGround()
    if not ground then
        return false
    end

    local groundId = ground:getId()

    if table.contains(holes, groundId) then
        ground:transform(groundId + 1)
        ground:decay()

        toPosition.z = toPosition.z + 1
        tile:relocateTo(toPosition)
    elseif groundId == 231 then
        if target.itemid == 231 and target.actionid == 100 then
            ground:transform(489)
            ground:decay()
        else
            local randomValue = math.random(1, 1000)
            if randomValue <= 10 then
                Game.createItem(2159, 1, toPosition) -- 0.1% chance for Scarab Coin
            elseif randomValue <= 30 then
                Game.createMonster("Scarab", toPosition) -- 0.3% chance for Scarab
            elseif randomValue <= 50 then
                Game.createMonster("Larva", toPosition) -- 0.6% chance for Larva (remaining probability)
			else
			toPosition:sendMagicEffect(CONST_ME_POFF)
			player:addExperience(math.random(1,4),true)
            end
            
        end
    else
        return false
    end

    return true
end
