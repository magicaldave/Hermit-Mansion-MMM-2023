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

## second pushing or pulling the player

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
