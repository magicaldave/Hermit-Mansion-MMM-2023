#### this should ad and remove things according to night eye effect
- using events

- Global
```lua
local world = require('openmw.world')
local types = require('openmw.types')
local core = require('openmw.core')
local util = require('openmw.util')
--local time = require('openmw_aux.time')
--local async = require('openmw.async')

local function funcname(var)
    
   local cont = var.pself.cell:getAll(types.Container)
    local bubblesone = world.createObject("active_bubbles00", #cont ) 
      
      for a, _ in pairs(cont) do
        local bubbles = bubblesone:split(1)
        bubbles:teleport( var.pself.cell.name, cont[a].position )
      end
end

local function func2(var1)
    local activs = var1.pself2.cell:getAll(types.Activator)
      for i, _ in pairs(activs) do
        if activs[i].recordId == "active_bubbles00" then
          activs[i]:remove()
          print("remove")
        end  
      end
end

return { eventHandlers = { addlight = funcname, removelight = func2 } } 
```
- Player
```lua
local core = require('openmw.core')
local self = require('openmw.self')
--local nearby = require('openmw.nearby')
--local camera = require("openmw.camera")
--local util = require("openmw.util")
--local ui = require('openmw.ui')
local types = require('openmw.types')
--local input = require('openmw.input')


local function onUpdate(dt)

  if c == nil then
    c = 1
  end
  
  if types.Actor.activeEffects(self):getEffect(core.magic.EFFECT_TYPE.NightEye) then
   if c == 2 or c == 1 then
        core.sendGlobalEvent("addlight", { pself = self }) --, near1 = near[i]
      c = 4
    end
  end
  
  if types.Actor.activeEffects(self):getEffect(core.magic.EFFECT_TYPE.NightEye) == nil then
    c = 2
    core.sendGlobalEvent("removelight", { pself2 = self })
  end
end

return { engineHandlers = { onUpdate = onUpdate } }

```
- code from apparatuses
```lua
local function func2(var2)
    local cel = world.cells --[var2.appaself2.cell.name]
    for a, _ in pairs(cel) do
     if cel[a].name == var2.pself2.cell.name then 
      local bubble = cel[a]:getAll(types.Activator)
       for i, _ in pairs(bubble) do
         if bubble[i].recordId == "active_bubbles00" then
            bubble[i]:remove()
            print("remove")
         end
       end
     end
    end
end
```

