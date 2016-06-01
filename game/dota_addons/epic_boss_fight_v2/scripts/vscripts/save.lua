--SAVING USING THE STORAGE LIB
--FINISHED , SLOT WORKS FINE , I WILL JUST ACTIVATE ANTI CHEAT WHEN LAUNCHING THE FINAL VERSION
function save(hero,slot,info,automatic)
		if info ~= true then info =false end
		if automatic ~= true then automatic = false end

		--if GameRules:IsCheatMode() == false then --Check if this lobby cheated
			print("Saving")
			local data_table = {}
			Storage:Get( PlayerResource:GetSteamAccountID(hero:GetPlayerID()), function( resultTable, successBool )
				if successBool then
					if resultTable	~= nil then
						data_table = resultTable
					end
					data_table[tostring(slot)] = { hero_name = hero:GetClassname(),
								inventory = hero.inventory,
								item_bar = hero.item_bar,
								active_list = hero.active_list,
								equipement = hero.equipement,
								level = hero.Level,
								xp = hero.XP,
								stats_points = hero.stats_points,
								gold = hero:GetGold(),
								skill_tree = hero.skill_tree
								}
					if info == true then
						DeepPrintTable(data_table)
					end
					--PASSING IT IN STORAGE
					Storage:Put( PlayerResource:GetSteamAccountID(hero:GetPlayerID()), data_table, function( resultTable, successBool )
						if successBool then
							--Notification
							print("Save completed")
							Notifications:Inventory(hero:GetPlayerID(), {text="Save Completed", duration=3})
							Notifications:Save(hero:GetPlayerID(), {text="Saved",duration=2,color="00FF22"})
						elseif successBool == false then
							--Notification
							if automatic == false then

								Notifications:Save(hero:GetPlayerID(), {text="Save Failed, try again later",duration=2,color="FF2222"})
							else
								Timers:CreateTimer(1, save(hero,slot,info,automatic))
							end
						end
					end)
				elseif successBool == false then
					print ("step 1 failed")
					--Notification
					if automatic == false then
						Notifications:Save(hero:GetPlayerID(), {text="Save Failed, try again later",duration=3,color="FF2222"})
					else
						Notifications:Save(hero:GetPlayerID(), {text="AutoSave Failed",duration=2,color="FF2222"})
					end
				end
			end)
		--[[elseif GameRules.cheats == true then
			--Notification
			if automatic == false then
				Notifications:Save(hero:GetPlayerOwner(), {text="Save are disactivated when cheat is detected",duration=2,color="#FF2222"})
			else
				Notifications:Save(hero:GetPlayerOwner(), {text="you can't save if you cheat :D",duration=2,color="#FF2222"})
			end
		end]]--
	end

function load(pID,slot)
local player = PlayerResource:GetPlayer(pID)
local data_table = {}

  Storage:Get( PlayerResource:GetSteamAccountID(pID), function( resultTable, successBool )
    if successBool then
    	print ("acces granted")
    	print ("load slot "..slot)
    	data_table = resultTable[tostring(slot)]
    	DeepPrintTable(data_table)
    elseif successBool == false then
      --Notification
      Notifications:Save(pID, {text="acess to server failed, try again later",duration=3,color="FF2222"})
    end

    HeroSelection:load_hero(data_table,pID)
  end)
end