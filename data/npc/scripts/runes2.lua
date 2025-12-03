local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)            npcHandler:onCreatureAppear(cid)             end
function onCreatureDisappear(cid)         npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)     npcHandler:onCreatureSay(cid, type, msg)     end
function onThink()                         npcHandler:onThink()                         end

function getQuestId(cid, quest_name)
    return getPlayerStorageValue(cid, quest_name)
end

function itemCap(item_id)
    return ItemType(item_id):getCapacity()
end

local shopWindow = {}
local t = {
          [2121] = {price = 20, price2 = 0}, -- [ITEMID TO SELL] = {Buy cost (0 = not buyable), sell cost (0 = not sellable)}
          [2120] = {price = 56, price2 = 0}
          }

local onBuy = function(cid, item, subType, amount, ignoreCap, inBackpacks)
    local player = Player(cid)
    local test = (t[item].price*amount)
	
	if player:removeMoney(test) then
	    doPlayerAddItem(cid, item, amount)
	end
	
	return true
end

local onSell = function(cid, item, subType, amount)
    local player = Player(cid)
    local test = (t[item].price2*amount)

	doPlayerRemoveItem(cid, item, amount)
	player:addMoney(test)
	
	return true
end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)
shopModule:addBuyableItem({'worm'}, 3976, 1, 'worm')

local function onGreet_Callback(cid)
    local player = Player(cid)

		    npcHandler:setMessage(MESSAGE_GREET, "Hello there, i see you found my gardens. My name is a Kim and im a Alchemist. I been living on this island for decads now trying to grow new herbs and flower for my potions. If you intressent in {Buying} a potion or two, just ask.")

	
    
    return true
end

function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	

        if msgcontains(msg, 'buying') then
             ShopModule.requestTrade(cid, msg, items, {module = shopModule}, nil)
        end

	
    return true
end



npcHandler:setCallback(CALLBACK_GREET, onGreet_Callback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())