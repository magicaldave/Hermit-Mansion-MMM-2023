#### this should ad and remove things according to night eye effect
- using events

- the effect isn't going away currently (it's set to magnitude 0) before saving and loading so need to use spells ie. abilities, powers, diseases, etc, 

- The global adding/removing effects, under one cell to handle removing and adding without extra logic. bubbless currently. 
```lua
local world = require('openmw.world')
local types = require('openmw.types')
local core = require('openmw.core')

local function funcname(var)
    local cel = world.cells 
    for a, _ in pairs(cel) do
       if cel[a].name == "The Arcane Academy of Venarius, Training Room" then -- specifig cell
   
        local cont = cel[a]:getAll(types.Container)   -- object type to place at
        local bubblesone = world.createObject("active_bubbles00", #cont ) -- what to add, with type count

         for a, _ in pairs(cont) do
          local bubbles = bubblesone:split(1) -- one object for teleport
          bubbles:teleport( "The Arcane Academy of Venarius, Training Room", cont[a].position ) -- placement
         end
       end
    end
end

local function func2(var2)
    local cel = world.cells 
    for a, _ in pairs(cel) do
     if cel[a].name == "The Arcane Academy of Venarius, Training Room" then -- specifig cell
      local bubble = cel[a]:getAll(types.Activator)   --type to remove
       for i, _ in pairs(bubble) do
         if bubble[i].recordId == "active_bubbles00" then -- what specifically
            bubble[i]:remove() --remove in loop
         end
       end
     end
   end
end


return { eventHandlers = { addlight = funcname, removelight = func2 } } 
```
- Player checking spell and gating once onder onupdate
```lua
local core = require('openmw.core')
local self = require('openmw.self')
local types = require('openmw.types')

local function onUpdate(dt)

  if c == nil then --set the initial value for comparison ie. not nil
    c = 1   
  end

  if c >= 1 then  --  will fire initially and math drops c to 0
                  --  if having spell drops the c multiple times (from 2 or 3)
     if types.Actor.spells(self)["night-eye"] == nil then -- if haven't spell
       print("remove")
        core.sendGlobalEvent("removelight", { pself2 = self }) -- do stuff
        c = c - 1   
     end
  end
    
  if c <= 1 then  -- will fire initially and math raises c to 3
                  -- if don't have the spell initially the c raises to 2
                  -- fires only once in bot h cases 
     if types.Actor.spells(self)["night-eye"] then  -- if have the spell
        print("add")
        core.sendGlobalEvent("addlight", { pself = self }) -- do stuff
        c = c + 2
     end
  end
    
end

return { engineHandlers = { onUpdate = onUpdate } }
```

- The non working effect code
```lua
local core = require('openmw.core')
local self = require('openmw.self')
local types = require('openmw.types')

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
  
  if types.Actor.activeEffects(self):getEffect(core.magic.EFFECT_TYPE.NightEye) == nil or then
    c = 2
    core.sendGlobalEvent("removelight", { pself2 = self })
  end
end

return { engineHandlers = { onUpdate = onUpdate } }
```

