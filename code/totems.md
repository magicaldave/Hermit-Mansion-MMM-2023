# totems which can alter the reality

## making the player push the button

```lua
local core = require('openmw.core')
local self = require('openmw.self')

local function onKeyPress(key)
    if key.symbol == 'c' then
      core.sendGlobalEvent("totem", { data1 = self })
    end
end

return { engineHandlers = { onKeyPress = onKeyPress } }

```

## first by gaining platformer ability

```lua
local world = require('openmw.world')
local types = require('openmw.types')
local core = require('openmw.core')
local util = require('openmw.util')

local function functionname(func)

    local ce = world.cells
    for i, _ in pairs(ce) do
      local sta = ce[i]:getAll(types.Activator)
      for a, _ in pairs(sta) do
        if sta[a].recordId == "firebit_01" then
          local dist = (sta[a].position - func.data1.position):length()
            print(tostring(dist))
            if dist < 1000 then
              func.data1:teleport( func.data1.cell, util.transform.move(func.data1.position) * util.vector3(0,0,100) )
            end
        end
      end
    end
end

return {
    eventHandlers = { totem = functionname }
}
```

## second pushing or pulling the player (button)

```lua
    local ce = world.cells
    for i, _ in pairs(ce) do
      local sta = ce[i]:getAll(types.Activator)
      for a, _ in pairs(sta) do
        if sta[a].recordId == "firebit_01" then
          local dist = (sta[a].position - func.data1.position):length()
            print(tostring(dist))
            if dist < 1000 then
            
            --[[
              local direction = util.vector3(
                  (sta[a].position.x - func.data1.position.x),
                  (sta[a].position.y - func.data1.position.y),
                  (sta[a].position.z - func.data1.position.z)
                  ):normalize()*10 ]]  -- pull inward
              local direction = util.vector3(
                  ( func.data1.position.x - sta[a].position.x),
                  ( func.data1.position.y - sta[a].position.y),
                  ( func.data1.position.z - sta[a].position.z)
                  ):normalize()*10  -- push outward
              func.data1:teleport( func.data1.cell, util.transform.move(func.data1.position)*direction )
            end
        end
      end
    end
```
## making the push on onupdate in only global
- this has drawback that player can't move while being pushed so maybe with delay
```lua
local world = require('openmw.world')
local types = require('openmw.types')
local core = require('openmw.core')
local util = require('openmw.util')

local function onUpdate(dt)
    local ce = world.cells
    for i, _ in pairs(ce) do
      local sta = ce[i]:getAll(types.Creature)
      for a, _ in pairs(sta) do
        if sta[a].recordId == "scrib" then
         local pla = world.players
          local dist = (sta[a].position - pla[1].position):length()
            --print(tostring(dist))
            if dist < 1000 then
            
              local direction = util.vector3(
                  ( pla[1].position.x - sta[a].position.x),
                  ( pla[1].position.y - sta[a].position.y),
                  ( pla[1].position.z - sta[a].position.z)
                  ):normalize()*1  -- push outward
             
              pla[1]:teleport( pla[1].cell, util.transform.move(pla[1].position)*direction )
            end
        end
      end
    end

end

return {
    engineHandlers = { onUpdate = onUpdate }
}
```
