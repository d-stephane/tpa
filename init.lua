
tpa = {};
minetest.log("action", "[tpa] loaded")

-- ---------------------------------------------------------------------------------------------------------------------
-- Localisation : Chargement du mod intllib si celui-ci est present
-- ---------------------------------------------------------------------------------------------------------------------
local S
if minetest.get_modpath("intllib") then
    S = intllib.Getter()
else
    S = function(s) return s end
end

tpa.intllib = S

-- ---------------------------------------------------------------------------------------------------------------------

dofile(minetest.get_modpath("tpa") .. "/command.lua");


