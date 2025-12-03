local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local voices = {
	{ text = 'Ah yes this book is great.' },
	{ text = 'For the fire to persist the mage casting it must be wise.' },
	{ text = 'The Ice element some say its forbidden others that its deadly.' },
	{ text = 'Hmm another one to my collection?' }
}

local spells = {
    ["Light"] = {
        vocations = {1,2,3,4,5,6,7,8},
		price = 100,
        requiredMagicLevel = 0
    },
    ["Find Person"] = {
        vocations = {1,2,3,4,5,6,7,8},
		price = 100,
        requiredMagicLevel = 0
    },
    ["Magic Rope"] = {
        vocations = {1,2,3,4,5,6,7,8},
		price = 100,
        requiredMagicLevel = 0
    },
    ["Light Healing"] = {
        vocations = {1,2,3,4,5,6,7,8},
		price = 100,
        requiredMagicLevel = 0
    },
    ["Antidote"] = {
        vocations = {1,2,3,4,5,6,7,8},
		price = 100,
        requiredMagicLevel = 0
    },
    ["Intense Healing"] = {
        vocations = {1, 2, 3, 5, 6, 7},
		price = 250,
        requiredMagicLevel = 2
    },
    ["Levitate"] = {
        vocations = {1,2,3,4,5,6,7,8},
		price = 1000,
        requiredMagicLevel = 3
    },
    ["Energy Strike"] = {
        vocations = {1, 2, 5, 6},
		price = 1000,
        requiredMagicLevel = 0
    },
    ["Summon Creature"] = {
        vocations = {1, 2, 5, 6},
		price = 5000,
        requiredMagicLevel = 16
    },
    ["Great Light"] = {
        vocations = {1,2,3,4,5,6,7,8},
		price = 300,
        requiredMagicLevel = 3
    },
    ["Magic Shield"] = {
        vocations = {1, 2, 5, 6},
		price = 1000,
        requiredMagicLevel = 3
    },
    ["Haste"] = {
        vocations = {1, 2, 3, 4, 5, 6, 7, 8},
		price = 800,
        requiredMagicLevel = 3
    },
    ["Flame Strike"] = {
        vocations = {1, 2, 5, 6},
		price = 1000,
        requiredMagicLevel = 3
    },
    ["Force Strike"] = {
        vocations = {1, 2, 5, 6},
		price = 1000,
        requiredMagicLevel = 3
    },
    ["Fire Wave"] = {
        vocations = {1, 5},
		price = 2000,
        requiredMagicLevel = 3
    },
    ["Heal Friend"] = {
        vocations = {2, 6},
		price = 1000,
        requiredMagicLevel = 7
    },
    ["Ultimate Healing"] = {
        vocations = {1, 2, 5,6},
		price = 10000,
        requiredMagicLevel = 8
    },
    ["Strong Haste"] = {
        vocations = {1, 2, 5, 6},
		price = 10000,
        requiredMagicLevel = 8
    },
    ["Challenge"] = {
        vocations = {8},
		price = 10000,
        requiredMagicLevel = 3
    },
    ["Energy Beam"] = {
        vocations = {1, 5},
		price = 5000,
        requiredMagicLevel = 14
    },
    ["Creature Illusion"] = {
        vocations = {1, 2, 3, 4, 5, 6, 7, 8},
		price = 1000,
        requiredMagicLevel = 10
    },
    ["Cancel Invisibility"] = {
        vocations = {1, 5},
		price = 5000,
        requiredMagicLevel = 12
    },
    ["Ultimate Light"] = {
        vocations = {1, 2, 3, 5, 6, 7},
		price = 1000,
        requiredMagicLevel = 12
    },
    ["Great Energy Beam"] = {
        vocations = {1, 5},
		price = 2500,
        requiredMagicLevel = 14
    },
    ["Berserk"] = {
        vocations = {4, 8},
		price = 10000,
        requiredMagicLevel = 5
    },
    ["Invisibility"] = {
        vocations = {1, 2, 3, 5, 6, 7},
		price = 10000,
        requiredMagicLevel = 21
    },
    ["Mass Healing"] = {
        vocations = {2,6},
		price = 10000,
        requiredMagicLevel = 19
    },
    ["Undead Legion"] = {
        vocations = {2, 6},
		price = 1000,
        requiredMagicLevel = 10 -- Adjust as needed since the magic level is not specified
    },
    ["Ultimate Explosion"] = {
        vocations = {1, 5},
		price = 60000,
        requiredMagicLevel = 40
    },
    ["Poison Storm"] = {
        vocations = {2, 6},
		price = 40000,
        requiredMagicLevel = 40
    },
    ["Energy Wave"] = {
        vocations = {1,5},
		price = 6000,
        requiredMagicLevel = 20
    },
    ["Wild Growth"] = {
        vocations = {2,6},
		price = 3000,
        requiredMagicLevel = 13
    },
    ["Food"] = {
        vocations = {1, 2, 3, 4, 5, 6, 7, 8},
		price = 2500,
        requiredMagicLevel = 1
    },
    ["Animate Dead Rune"] = {
        vocations = {3,6},
		price = 850,
        requiredMagicLevel = 7
    },
    ["Blank Rune"] = {
        vocations = {1,2,3,4,5,6,7,8},
		price = 5000,
        requiredMagicLevel = 0 -- Adjust as needed since the magic level is not specified
    },
    ["Chameleon Rune"] = {
        vocations = {2,6},
		price = 2000,
        requiredMagicLevel = 11
    },
    ["Conjure Arrow"] = {
        vocations = {3, 7},
		price = 1000,
        requiredMagicLevel = 2
    },
    ["Conjure Bolt"] = {
        vocations = {3,7},
		price = 3000,
        requiredMagicLevel = 6
    },
    ["Conjure Explosive Arrow"] = {
        vocations = {3,7},
		price = 5000,
        requiredMagicLevel = 10
    },
    ["Conjure Poisoned Arrow"] = {
        vocations = {3,7},
		price = 1500,
        requiredMagicLevel = 5
    },
    ["Conjure Power Bolt"] = {
        vocations = {3,7},
		price = 10000,
        requiredMagicLevel = 14
    },
    ["Convince Creature Rune"] = {
        vocations = {2,5},
		price = 3000,
        requiredMagicLevel = 10
    },
    ["Cure Poison Rune"] = {
        vocations = {2,5},
		price = 200,
        requiredMagicLevel = 1
    },
    ["Destroy Field Rune"] = {
        vocations = {1,2,5,6},
		price = 1000,
        requiredMagicLevel = 6
    },
    ["Disintegrate Rune"] = {
        vocations = {1,2,5,6},
		price = 5000,
        requiredMagicLevel = 8
    },
    ["Enchant Staff"] = {
        vocations = {9},
        requiredMagicLevel = 2002
    },
    ["Energy Bomb Rune"] = {
        vocations = {1,2,5,6},
		price = 10000,
        requiredMagicLevel = 18
    },
    ["Energy Field Rune"] = {
        vocations = {1, 2,5,6},
		price = 2500,
        requiredMagicLevel = 5
    },
    ["Energy Wall Rune"] = {
        vocations = {1, 5},
		price = 7500,
        requiredMagicLevel = 18
    },
    ["Explosion Rune"] = {
        vocations = {5,6,7,8},
		price = 13000,
        requiredMagicLevel = 12
    },
    ["Fire Field Rune"] = {
        vocations = {1, 2, 5, 6},
		price = 1500,
        requiredMagicLevel = 3
    },
    ["Fire Bomb Rune"] = {
        vocations = {1, 2, 5, 6},
		price = 5000,
        requiredMagicLevel = 9
    },
    ["Fire Wall Rune"] = {
        vocations = {1, 2, 5, 6},
		price = 3500,
        requiredMagicLevel = 13
    },
    ["Fireball Rune"] = {
        vocations = {1, 2, 5, 6,3,7},
		price = 3000,
        requiredMagicLevel = 5
    },
    ["Great Fireball Rune"] = {
        vocations = {1, 2, 5, 6},
		price = 5500,
        requiredMagicLevel = 9
    },
    ["Heavy Magic Missile Rune"] = {
        vocations = {1,2,3,5,6,7},
		price = 2500,
        requiredMagicLevel = 6
    },
    ["Intense Healing Rune"] = {
        vocations = {3,5},
		price = 900,
        requiredMagicLevel = 4
    },
    ["Haste Rune"] = {
        vocations = {1, 2, 5, 6},
		price = 5000,
        requiredMagicLevel = 10
    },
    ["Great Haste Rune"] = {
        vocations = {1, 2, 5, 6},
		price = 12000,
        requiredMagicLevel = 15
    },
    ["Light Magic Missile Rune"] = {
        vocations = {1,2,3,5,6,7},
		price = 350,
        requiredMagicLevel = 1
    },
    ["Magic Wall Rune"] = {
        vocations = {1,5},
		price = 10000,
        requiredMagicLevel = 14
    },
    ["Paralyze Rune"] = {
        vocations = {3, 5},
		price = 50000,
        requiredMagicLevel = 0 -- Adjust as needed since the magic level is not specified
    },
    ["Poison Bomb Rune"] = {
        vocations = {1,2,5,6},
		price = 4000,
        requiredMagicLevel = 8
    },
    ["Poison Field Rune"] = {
        vocations = {1,2,5,6},
		price = 600,
        requiredMagicLevel = 2
    },
    ["Poison Wall Rune"] = {
        vocations = {2,5},
		price = 2000,
        requiredMagicLevel = 11
    },
    ["Soulfire Rune"] = {
        vocations = {1,5},
		price = 1500,
        requiredMagicLevel = 13
    },
    ["Stalagmite Rune"] = {
        vocations = {2,6}, --D
		price = 2000,
        requiredMagicLevel = 7
    },
    ["Sudden Death Rune"] = {
        vocations = {1, 5}, -- Sorcerer
		price = 25000,
        requiredMagicLevel = 25
    },
    ["Ultimate Healing Rune"] = {
        vocations = {2, 6}, -- Druid
		price = 1000,
        requiredMagicLevel = 11
    }
	
	
}

local function learnSpell(cid, spellName)
    local player = Player(cid)
    local spell = spells[spellName]

    if not spell then
        npcHandler:say("I don't know that spell.", cid)
        return false
    end

    if not npcHandler:isFocused(cid) then
        return false
    end

    if not player then
        return false
    end

    if not npcHandler:isFocused(cid) then
        return false
    end

    if not npcHandler:isFocused(cid) then
        return false
    end

    if not npcHandler:isFocused(cid) then
        return false
    end

    if not npcHandler:isFocused(cid) then
        return false
    end

    --if not player:isPremium() then
     --   npcHandler:say("You need a premium account in order to buy " .. spellName .. ".", cid)
      --  return true
    --end

    local playerVocation = player:getVocation():getId()
    local playerMagicLevel = player:getMagicLevel()

    if not table.contains(spell.vocations, playerVocation) then
        npcHandler:say("You cannot learn this spell with your vocation.", cid)
        return true
    end

    if player:hasLearnedSpell(spellName) then
        npcHandler:say("You already know this spell.", cid)
        return true
    end

    if playerMagicLevel < spell.requiredMagicLevel then
        npcHandler:say("You do not have the required magic level to learn this spell.", cid)
        return true
    end

    if not player:removeTotalMoney(spell.price) then
        npcHandler:say("You do not have enough money, this spell costs " .. spell.price .. " gold.", cid)
        return false -- Returning false here indicates that the transaction failed due to lack of money
    end

    npcHandler:say("You have learned " .. spellName .. ".", cid)
    player:learnSpell(spellName)
    return true
end



local function listLearnableSpells(cid)
    local player = Player(cid)
    if not player then
        return
    end

    local playerVocation = player:getVocation():getId()
    local playerMagicLevel = player:getMagicLevel()
    local learnableSpells = {}

    for spellName, spell in pairs(spells) do
        if not player:hasLearnedSpell(spellName) and playerMagicLevel >= spell.requiredMagicLevel and table.contains(spell.vocations, playerVocation) then
            table.insert(learnableSpells, spellName)
        end
    end

    table.sort(learnableSpells)

    if #learnableSpells > 0 then
        local spellList = "You can learn the following spells: " .. table.concat(learnableSpells, ", ") .. "."
        npcHandler:say(spellList, cid)
    else
        npcHandler:say("You know everything so far.", cid)
    end
end

-- Update the creatureSayCallback function to handle the confirmation
local function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local player = Player(cid)

    -- Check if the message contains "learn spells"
    if msgcontains(msg, 'learn spells') then
        listLearnableSpells(cid)
        return true
    end

    -- Iterate over the spell names in the spells table and compare them directly
    for spellName, _ in pairs(spells) do
        if msgcontains(msg, spellName:lower()) then
            -- Ask the player if they want to learn the spell
            npcHandler:say("Do you want to learn " .. spellName .. " for " .. spells[spellName].price .. " gold?", cid)
            npcHandler.topic[cid] = spellName -- Set the topic to the spell name
            return true
        end
    end

    -- Check if the player's response matches the confirmation
    if npcHandler.topic[cid] then
        local spellName = npcHandler.topic[cid]
        if msgcontains(msg, 'yes') then
            -- Confirm learning the spell
            learnSpell(cid, spellName)
        else
            -- Player declined learning the spell
            npcHandler:say("Alright, maybe next time.", cid)
        end
        npcHandler.topic[cid] = nil -- Reset the topic
        return true
    end

    -- If the player's message doesn't match any known spell, respond accordingly
    npcHandler:say("I don't know that spell.", cid)
    return true
end 




npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())



npcHandler:addModule(VoiceModule:new(voices))


npcHandler:setMessage(MESSAGE_WALKAWAY, 'Yeah, see you later.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'See you later, |PLAYERNAME|.')
npcHandler:setMessage(MESSAGE_GREET, 'Abracadabra |PLAYERNAME|. Are you here to {learn spells}?')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
