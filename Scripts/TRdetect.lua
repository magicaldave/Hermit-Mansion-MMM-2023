local core = require("openmw.core")
local world = require("openmw.world")

local function checkTR(player)
  if core.contentFiles.has("TR_Mainland.esm") then
    local globals = world.mwscript.getGlobalVariables(player)
    globals.hasTR = 1
  end
end



return {
    interfaceName = 'AAV_global',
    interface = {
      hasTR = hasTR,
      version = 001,
    },
    engineHandlers = {
      onPlayerAdded = checkTR
    }
}
