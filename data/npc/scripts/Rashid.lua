local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local ACTION_ID_GIVE_BOOK = 7162

function onCreatureAppear(cid)
    npcHandler:onCreatureAppear(cid)
end

function onCreatureDisappear(cid)
    npcHandler:onCreatureDisappear(cid)
end

function onCreatureSay(cid, type, msg)
    npcHandler:onCreatureSay(cid, type, msg)
end

function onThink()
    npcHandler:onThink()
end

function greetCallback(cid)
    npcHandler:setMessage(MESSAGE_GREET, "Hello there! If you're looking for some work, I might have something for you. Interested?")
    npcHandler:addFocus(cid)
    return true
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    if Player(cid):getStorageValue(ACTION_ID_GIVE_BOOK) == 1 then
        npcHandler:say("I dont have any more work for you.", cid)
        return true
    end

    if npcHandler.topic[cid] == 1 then
        if msgcontains(msg, "yes") then
            npcHandler:say("Great! Now, once you've obtained the book, come back to me, and I'll pay you.", cid)
            npcHandler.topic[cid] = 2
        else
            npcHandler:say("Okay then.", cid)
            npcHandler.topic[cid] = 0
        end
    elseif npcHandler.topic[cid] == 2 then
        if msgcontains(msg, "book") then
            if Player(cid):getStorageValue(ACTION_ID_GIVE_BOOK) == -1 then
                if Player(cid):removeItem(1964, 1) then
                    Player(cid):addExperience(500, true)
                    Player(cid):addMoney(100)
                    npcHandler:say("Thank you! Here is your reward.", cid)
                    Player(cid):setStorageValue(ACTION_ID_GIVE_BOOK, 1) -- Set action ID to 1 to indicate book has been given
                else
                    npcHandler:say("You don't have the book with you.", cid)
                end
            else
                npcHandler:say("You have already completed this task.", cid)
            end
        else
            npcHandler:say("You need to obtain the book first.", cid)
        end
        npcHandler.topic[cid] = 0
    elseif msgcontains(msg, "job") or msgcontains(msg, "mission") or msgcontains(msg, "work") then
        npcHandler:say("Great! I need you to retrieve a big blue book from the library. Can you do that?", cid)
        npcHandler.topic[cid] = 1
    else
        npcHandler:say("Okay then.", cid)
    end
    return true
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
