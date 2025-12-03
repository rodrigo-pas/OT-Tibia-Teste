local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local voices = { {text = "Runes, wands, rods, health and mana potions! Have a look!"} }
npcHandler:addModule(VoiceModule:new(voices))

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

keywordHandler:addKeyword({'stuff'}, StdModule.say, {npcHandler = npcHandler, text = 'Just ask me for a {trade} to see my offers.'})
keywordHandler:addAliasKeyword({'wares'})
keywordHandler:addAliasKeyword({'offer'})


shopModule:addSellableItem({'wand of dragonbreath', 'dragonbreath'}, 7100, 200, 'wand of dragonbreath')
shopModule:addSellableItem({'wand of decay', 'decay'}, 7097, 1000, 'wand of decay')
shopModule:addSellableItem({'wand of cosmic energy', 'cosmic energy'}, 7098, 2000, 'wand of cosmic energy')
shopModule:addSellableItem({'wand of inferno', 'inferno'}, 7096, 3000, 'wand of inferno')


shopModule:addSellableItem({'moonlight rod', 'moonlight'}, 7095, 200, 'moonlight rod')
shopModule:addSellableItem({'necrotic rod', 'necrotic'}, 7094, 1000, 'necrotic rod')
shopModule:addSellableItem({'terra rod', 'terra'}, 7090, 2000, 'terra rod')
shopModule:addSellableItem({'tempest rod', 'tempest'}, 7092, 3000, 'hailstorm rod')


shopModule:addBuyableItem({'blank rune'}, 2260, 10, 'blank')
shopModule:addBuyableItem({'identification'}, 7953, 100, 'scroll')
shopModule:addBuyableItem({'spellbook'}, 2175, 150, 'spellbook')
shopModule:addBuyableItem({'magic lightwand'}, 2163, 400, 'magic lightwand')

shopModule:addBuyableItem({'mana fluid', 'manafluid'}, 2006, 50, 7, 'mana fluid')
shopModule:addBuyableItem({'life fluid', 'lifefluid'}, 2006, 50, 10, 'life fluid')
shopModule:addBuyableItem({'loot wand'}, 6876, 1000)
shopModule:addBuyableItem({'brown mushroom'}, 2789, 12)
shopModule:addBuyableItem({'life ring'}, 2168, 1000)

shopModule:addBuyableItem({'dwarven ring'}, 2213, 2000)
shopModule:addBuyableItem({'energy ring'}, 2167, 2000)
shopModule:addBuyableItem({'ring of healing'}, 2216, 2000)
shopModule:addBuyableItem({'time ring'}, 2169, 2000)

shopModule:addSellableItem({'dragon necklace'}, 2201, 100)
shopModule:addSellableItem({'dwarven ring'}, 2213, 100)
shopModule:addSellableItem({'energy ring'}, 2167, 100)
shopModule:addSellableItem({'life ring'}, 2168, 50)
shopModule:addSellableItem({'might ring'}, 2164, 250)
shopModule:addSellableItem({'protection amulet'}, 2200, 100)
shopModule:addSellableItem({'ring of healing'}, 2216, 100)
shopModule:addSellableItem({'silver amulet'}, 2170, 50)
shopModule:addSellableItem({'strange talisman'}, 2161, 30)
shopModule:addSellableItem({'time ring'}, 2169, 100)
shopModule:addSellableItem({'ankh'}, 2327, 100)


shopModule:addSellableItem({'vial', 'flask'}, 2006, 5, 'empty vial', 0)


function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)
	local vocationId = player:getVocation():getId()
	local items = {
		[1] = 7100,
		[2] = 2182,
		[5] = 2190,
		[6] = 2182
	}

	if msgcontains(msg, 'first teataetarod') or msgcontains(msg, 'first waeteatand') then
		if table.contains({1, 2, 5, 6}, vocationId) then
			if player:getStorageValue(PlayerStorageKeys.firstRod) == -1 then
				selfSay('So you ask me for a {' .. ItemType(items[vocationId]):getName() .. '} to begin your adventure?', cid)
				npcHandler.topic[cid] = 1
			else
				selfSay('What? I have already gave you one {' .. ItemType(items[vocationId]):getName() .. '}!', cid)
			end
		else
			selfSay('Sorry, you aren\'t a druid either a sorcerer.', cid)
		end
	elseif msgcontains(msg, 'yes') then
		if npcHandler.topic[cid] == 1 then
			player:addItem(items[vocationId], 1)
			selfSay('Here you are young adept, take care yourself.', cid)
			player:setStorageValue(PlayerStorageKeys.firstRod, 1)
		end
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, 'no') and npcHandler.topic[cid] == 1 then
		selfSay('Ok then.', cid)
		npcHandler.topic[cid] = 0
	end

	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
