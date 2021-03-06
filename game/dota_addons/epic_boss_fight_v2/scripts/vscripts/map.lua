require( "libraries/Timers" )
if map == nil then
    map = class({})
end

function OnEnterShop(trigger)
    local ent = trigger.activator
    if not ent then return end
    ent.Isinshop = true
    if ent:IsHero() then
        local PID = ent:GetPlayerID() 
        print ("test enter shop")
        table = {}
        table.shop = LoadKeyValues("scripts/kv/shop.kv")
        table.info = LoadKeyValues("scripts/kv/items.kv")
        for k,v in pairs(table.info) do
            v.item_name = k
            if v.cat == "weapon" then v.level = 0 end
        end
        CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(PID), "Open_Shop", table)
    end
    --play sound telling player he entered it
    --open shop hud
    return
end

function OnExitShop(trigger)
    local ent = trigger.activator
    if not ent then return end
    ent.Isinshop = false
    if ent:IsHero() then
        local PID = ent:GetPlayerID() 
        CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(PID), "Close_Shop", {} )
    end
    --play exit music ?
    --close shop hud if player didn't yet
    return
end


function OnEnterForge(trigger)
    local ent = trigger.activator
    if not ent then return end
    ent.Isinforge= true
    if ent:IsHero() then
        local PID = ent:GetPlayerID() 
        CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(PID), "Open_Forge", {} )
    end
    return
end

function OnExitForge(trigger)
    local ent = trigger.activator
    if not ent then return end
    ent.Isinforge = false
    if ent:IsHero() then
        local PID = ent:GetPlayerID() 
        CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(PID), "Close_Forge", {} )
    end
    return
end