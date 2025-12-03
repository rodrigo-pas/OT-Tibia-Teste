local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local voices = {
	{ text = 'I wish I could eat some salmon right now... best prepared in Liberty Bay style... yummy.' },
	{ text = 'Wow, I\'m tired. I really should get some sleep... zzzz.' },
	{ text = 'What was that word again in Orcish language... hmm.' },
	{ text = 'Hey you! Are you an adventurer, too?' },
	{ text = '<sings> Stormy weathers, stormy weathers... stormy weathers on the sea!' }
}

local function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local player = Player(cid)
    local currentLevel = player:getStorageValue(55656)
    local cost = math.floor(100 * (2.3 ^ (currentLevel - 1)))

    if msgcontains(msg, 'experience') then
        npcHandler:say('Are you looking to increase your experience? It will cost you ' .. cost .. ' gold. Your current level is ' .. currentLevel .. '.', cid)
        npcHandler.topic[cid] = 1001 -- Assigning a new topic ID for the Experience Purchase dialogue
        return true
    end

    if npcHandler.topic[cid] == 1001 and msgcontains(msg, 'yes') then
        if player:getMoney() >= cost then
            player:removeMoney(cost)
            player:setStorageValue(55656, currentLevel + 1)
            npcHandler:say('Fine, now your idle experience level is ' .. player:getStorageValue(55656) .. '.', cid)
        else
            npcHandler:say('You don\'t have enough gold.', cid)
        end
        npcHandler.topic[cid] = 0
        return true
    end
end




npcHandler:addModule(VoiceModule:new(voices))

-- Basic keywords

-- Names
keywordHandler:addKeyword({'al', 'dee'}, StdModule.say, {npcHandler = npcHandler, text = 'I don\'t have much to say about him. I think he sells {tools}.'})
keywordHandler:addKeyword({'loui'}, StdModule.say, {npcHandler = npcHandler, text = 'Never seen him around.'})
keywordHandler:addKeyword({'zirella'}, StdModule.say, {npcHandler = npcHandler, text = 'She seriously asked me if she could have the remains of my {raft} as fire wood! Can you imagine that??'})
keywordHandler:addKeyword({'santiago'}, StdModule.say, {npcHandler = npcHandler, text = 'He promised to repair my {raft}.'})
keywordHandler:addKeyword({'amber'}, StdModule.say, {npcHandler = npcHandler, text = 'Did you know my name is also the name of a gem?'})
keywordHandler:addKeyword({'tom'}, StdModule.say, {npcHandler = npcHandler, text = 'To me he seems a bit rude, but maybe that\'s just my impression.'})
keywordHandler:addKeyword({'lee\'delle'}, StdModule.say, {npcHandler = npcHandler, text = 'I heard her offers are extraordinarily good.'})
keywordHandler:addKeyword({'oracle'}, StdModule.say, {npcHandler = npcHandler, text = 'The oracle is said to show you your {destiny} once you are level 8.'})
keywordHandler:addKeyword({'norma'}, StdModule.say, {npcHandler = npcHandler, text = 'She has changed a lot since I last saw her.'})
keywordHandler:addKeyword({'seymour'}, StdModule.say, {npcHandler = npcHandler, text = 'I think this poor guy was a bad choice as head of the {academy}.'})
keywordHandler:addKeyword({'lily'}, StdModule.say, {npcHandler = npcHandler, text = 'Hm, I think I haven\'t met her yet.'})
keywordHandler:addKeyword({'billy'}, StdModule.say, {npcHandler = npcHandler, text = 'He brought me some of his famous rat stew. I really didn\'t want to insult him, but I simply can\'t eat something like that. So I told him I\'m a vegetarian and I only eat fish. <gulps>'})
keywordHandler:addKeyword({'willie'}, StdModule.say, {npcHandler = npcHandler, text = 'He\'s funny in his own way.'})
keywordHandler:addKeyword({'paulie'}, StdModule.say, {npcHandler = npcHandler, text = 'No, I didn\'t go to the {bank} yet.'})
keywordHandler:addKeyword({'cipfried'}, StdModule.say, {npcHandler = npcHandler, text = 'A gentle person. You should visit him if you have questions or need healing.'})
keywordHandler:addKeyword({'hyacinth'}, StdModule.say, {npcHandler = npcHandler, text = 'Hyacinth is a great healer. He lives somewhere hidden on this isle.'})
keywordHandler:addKeyword({'obi'}, StdModule.say, {npcHandler = npcHandler, text = 'He\'s a funny little man.'})
keywordHandler:addKeyword({'dixi'}, StdModule.say, {npcHandler = npcHandler, text = 'I don\'t really know her, but she seems to be a nice girl.'})
keywordHandler:addKeyword({'zerbrus'}, StdModule.say, {npcHandler = npcHandler, text = 'An extraordinary warrior. He\'s the first and last line of defence of {Rookgaard}.'})
keywordHandler:addAliasKeyword({'dallheim'})

npcHandler:setMessage(MESSAGE_WALKAWAY, 'Yeah, see you later.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'See you later, |PLAYERNAME|.')
npcHandler:setMessage(MESSAGE_GREET, 'Oh hello, nice to see you |PLAYERNAME|. Are you here to upgrade your {experience}?')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
