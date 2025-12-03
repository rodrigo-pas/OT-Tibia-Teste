-- Monster list with names
local monsters = {
    "Amazon", "Ancient Scarab", "Assassin", "Badger", "Bandit", "Banshee", "Bat", "Bear", "Behemoth", "Beholder",
    "Black Knight", "Black Sheep", "Blue Djinn", "Bonebeast", "Bug", "Butterfly", "Butterfly Purple", "Butterfly Yellow",
    "Butterfly Red", "Butterfly Blue", "Carniphila", "Cave Rat", "Centipede", "Chicken", "Cobra", "Crab", "Crocodile",
    "Crypt Shambler", "Cyclops", "Dark Monk", "Deer", "Demon Skeleton", "Demon", "Dog", "Dragon Lord", "Dragon",
    "Dwarf Geomancer", "Dwarf Guard", "Dwarf Soldier", "Dwarf", "Dworc Fleshhunter", "Dworc Venomsniper", "Dworc Voodoomaster",
    "Efreet", "Elder Beholder", "Elephant", "Elf Arcanist", "Elf Scout", "Elf", "Fire Devil", "Fire Elemental",
    "Flamingo", "Frost Troll", "Gargoyle", "Gazer", "Ghost", "Ghoul", "Giant Spider", "Goblin", "Green Djinn",
    "Hero", "Hunter", "Hyaena", "Hydra", "Kongra", "Larva", "Lich", "Lion", "Lizard Sentinel", "Lizard Snakecharmer",
    "Lizard Templar", "Marid", "Merlkin", "Minotaur Archer", "Minotaur Guard", "Minotaur Mage", "Minotaur", "Monk",
    "Mummy", "Necromancer", "Orc Berserker", "Orc Leader", "Orc Rider", "Orc Shaman", "Orc Spearman", "Orc Warlord",
    "Orc Warrior", "Orc", "Panda", "Parrot", "Pig", "Poison Spider", "Polar Bear", "Priestess", "Rabbit", "Rat",
    "Rotworm", "Scarab", "Scorpion", "Serpent Spawn", "Sheep", "Sibang", "Skeleton", "Skunk", "Slime2", "Slime",
    "Smuggler", "Snake", "Spider", "Spit Nettle", "Stalker", "Stone Golem", "Swamp Troll", "Tarantula", "Terror Bird",
    "Tiger", "Troll", "Valkyrie", "Vampire", "War Wolf", "Warlock", "Wasp", "Wild Warrior", "Winter Wolf", "Witch",
    "Wolf", "Yeti"
}

-- Define the onKill function
function onKill(cid, target)
    local player = Player(cid)
    local targetName = getCreatureName(target)
    
    -- Check if the target is a monster
    if isMonster(target) then
        -- Find the index of the monster in the list
        local monsterIndex = -1
        for i, name in ipairs(monsters) do
            if name == targetName then
                monsterIndex = i
                break
            end
        end
        
        if monsterIndex ~= -1 then
            -- Use the monster index to set storage
            local key = 1010000 + monsterIndex
            local killCount = player:getStorageValue(key) or 0
            
            -- If the kill count is -1 or 0, set it to 1 instead of incrementing by 1
            if killCount <= 0 then
                killCount = 1
            else
                killCount = killCount + 1
            end
            
            player:setStorageValue(key, killCount)

            -- Send task information to the player
            local taskMessage = "[Bestiary] You have killed a " .. targetName .. "! Total " .. targetName .. "s killed: " .. killCount .. "."
            player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, taskMessage)

            -- Check if the killCount meets the requirement for the rewards
            if killCount % 100 == 0 then
                local maxHealth = target:getMaxHealth()
                local expReward = math.random(maxHealth*25, maxHealth * 55.25) -- Random experience reward based on monster's max health
                local goldReward = math.random(maxHealth*15, maxHealth * 18.25) -- Random gold reward based on monster's max health
                player:addExperience(expReward)
                player:addMoney(goldReward)
                player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You have received a reward for killing " .. killCount .. " " .. targetName .. "s! Experience: " .. expReward .. ", Gold: " .. goldReward)
                
                -- Check if the kill count is also a multiple of 500 and give gem bag also!
                if killCount % 500 == 0 then
                    player:addItem(6512, 1) -- Add a gem bag
					local expReward = math.random(maxHealth*66, maxHealth * 82.25) -- Random experience reward based on monster's max health
					local goldReward = math.random(maxHealth*20, maxHealth * 32.25) -- Random gold reward based on monster's max health
					player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You have received a Double reward for killing " .. killCount .. " " .. targetName .. "s! Experience: " .. expReward .. ", Gold: " .. goldReward)
                    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You have received a gem bag as a reward for killing " .. killCount .. " " .. targetName .. "s!")
                end
            end
        else
            print("Monster not found in the list:", targetName)
        end
    end

    return true
end
