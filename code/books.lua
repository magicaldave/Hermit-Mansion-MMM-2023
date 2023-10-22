local world = require('openmw.world')
local types = require('openmw.types')
local core = require('openmw.core')
local util = require('openmw.util')
local time = require('openmw_aux.time')
--local async = require('openmw.async')

--journal MS_FargothRing 10

local function onObjectActive(object)
  
  local lp = world.players
  for i, _ in pairs(lp) do -- for every player
   
    if object.recordId ==  "radd hard-heart" or object.recordId == string.lower("DivineMarker") or object.recordId == string.lower("bk_BriefHistoryEmpire4") or object.recordId == string.lower("chest_small_02_anararen") then 
        -- the "books"
        -- divinemarker ouside moonmoth legion fort and "radd hard-heart" inside
        -- other ones are diffrent sides of ald-ruhn mages guild lower plaza 

        local timer = time.runRepeatedly(function()

          if types.Player.quests(lp[i])["MS_FargothRing"].stage ~= 10 then -- the quest stage
            
            if ( lp[i].position - object.position ):length() < 300 then
              if core.sound.isSoundPlaying("Ambient Factory Ruins", object) == false then
                core.sound.playSound3d("Daedric Chant",object, {
                volume = ( 300 / ( lp[i].position - object.position ):length() ) }  
                )         -- fades to distance of 300
              end
              print("sound")
            end
          else   -- quest stage 10 
          timer()  -- stops the timer
          print("stop")  
        end
       end, 10*time.second ) -- repeat every ten seconds
    end  
  end
end

return { engineHandlers = { onObjectActive = onObjectActive } }
