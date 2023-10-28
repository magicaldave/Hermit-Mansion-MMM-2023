local core = require("openmw.core")
local world = require("openmw.world")

local function checkTR(player)
  local globals = world.mwscript.getGlobalVariables(player)
  if core.contentFiles.has("TR_Mainland.esm") then
    globals.AAV_hasTR = 1
  else
    globals.AAV_hasTR = 0
  end
end

return {
    engineHandlers = {
      onPlayerAdded = checkTR
    }
}
