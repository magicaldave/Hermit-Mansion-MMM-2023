### the goal is to make totem which summons eiter friendly or hostile cretures to combat
- might need refactor
#### friendly
##### "going near the totem"    (creture, player, actor ?)
```lua
local core = require('openmw.core')
local self = require('openmw.self')
local nearby = require('openmw.nearby')
local types = require('openmw.types')

local function onUpdate(dt)
  local nearact = nearby.activators
  for a, _ in pairs(nearact) do
    if nearact[a].recordId == string.lower("AB_In_TelCrystal01") and (self.position - nearact[a].position):length() < 600 then
      core.sendGlobalEvent("addskel", { playerself = self } )
    end 
  end
    
  local nearskel = nearby.actors
  for i, _ in pairs(nearskel) do
    if nearskel[i].recordId == string.lower("T_Glb_Und_SkelOrc_01") and types.Actor.stats.dynamic.health(nearskel[i]).current <= 0 then
     
       core.sendGlobalEvent("removeskel", { skel = nearskel[i] } )
      
    end
  end
end

return { engineHandlers = { onUpdate = onUpdate } }
```

##### Global handling adding / removel

```lua
local world = require('openmw.world')
local types = require('openmw.types')
local core = require('openmw.core')

local skels

local function func1(var1)
   if skels == nil then
       skels = 0
   end

   if skels <= 5 then         
     local skeleton = world.createObject("T_Glb_Und_SkelOrc_01", 1)
     skeleton:teleport("The Arcane Academy of Venarius, Training Room", var1.playerself.position )
     skeleton:addScript("glows/glow_custom.lua")--sendEvent('StartAIPackage', {type='Combat', target=var1.playerself} )
     print("add")
     skels = skels + 1                      
   end

end

local function func2(var2)
   
      var2.skel:remove()
      print("remove")
      skels = skels - 1
      --world.createObject("AB_Fx_LavaBubbles",1):teleport("The Arcane Academy of Venarius, Training Room",var2.skel.position)
      
end

return { eventHandlers = { addskel = func1, removeskel = func2 } } 
```


##### local on summoned cretures

```lua
local ais = require('openmw.interfaces').AI
local nearby = require('openmw.nearby')

--local function onActive()
--local function onUpdate(dt)

local function onTeleported()
  local near = nearby.players
  local targ = ais.getActivePackage()
  for i,_ in pairs(near) do
      ais.removePackages("Combat")
      ais.startPackage({type='Follow', target=near[i], sideWithTarget = true })
  end
end

return { engineHandlers = { onTeleported = onTeleported }} 
--onUpdate = onUpdate }}--onActive = onActive } }
```
