# Glowbugs

- goal would be to have glowbugs appear in certain distance from the player

## one way: loop over containers for enable disable and add the shrooms on onplayeradded

- OnPlayeradded might need to be replaced with something persistent over saving/loading.

- mushroom used just for simplicity and atm summoned to seyda neen near the bridge.

- doesn't implement yet castray to get bugs outside of objects / terrain.

- one possible way still is mwcsript bridge for enabling
 
```lua
local world = require('openmw.world')
local types = require('openmw.types')
local core = require('openmw.core')
local util = require('openmw.util')

local function onUpdate(dt)

    local pl = world.players
      local cel = world.cells
      for i, _ in pairs(cel) do
        if cel[i].region == "bitter coast region" then -- this can be changes to certain cell
          local cont = cel[i]:getAll(types.Container)
          for a, _ in pairs(cont) do
            if cont[a].recordId == "flora_bc_mushroom_01" then
               if (cont[a].position - pl[1].position):length() > 1000 then
                 cont[a].enabled = false
                 else 
                 cont[a].enabled = true
               end
            end
          end
        end
      end                   
end


local function onPlayerAdded(player)

           local rooms = world.createObject( "flora_bc_mushroom_01" ,400)
           local coor = {} 
            for i=1, 20 do
              for j=1 , 20 do
                local sta = rooms:split(1)
                coor = util.vector3(
                      -13422 - 1000 + math.random(50,200)*i, 
                      -68085 - 1000 + math.random(50,200)*j,
                      200 )
                        
                sta:teleport( "" , coor )
              end
           end          
end

return { 
      engineHandlers = { onUpdate = onUpdate, onPlayerAdded = onPlayerAdded }
      } 
```
