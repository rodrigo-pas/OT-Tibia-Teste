local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end



local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)


	  if msgcontains(msg, 'small axe') or msgcontains(msg, 'axe') then
        npcHandler:say('Do you bring me my small axe?', cid)
        npcHandler.topic[cid] = 1001 -- Assigning a new topic ID for the Logbook Quest dialogue
        return true
		end
		
	 if npcHandler.topic[cid] == 1001 and msgcontains(msg, 'yes') then
        if Player(cid):getStorageValue(2559) ~= 1 then
            if Player(cid):removeItem(2559, 1) then
                Player(cid):addItem(2553, 1)
                Player(cid):setStorageValue(2559, 1)
                Player(cid):addExperience(100, true)
                npcHandler:say("Excellent. Here, take this pickaxe as a reward.", cid)
            else
                npcHandler:say("You don't have the axe with you.", cid)
            end
        else
            npcHandler:say("You have already completed this quest.", cid)
        end
        npcHandler.topic[cid] = 0
        return true
    end



	
end


npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())
