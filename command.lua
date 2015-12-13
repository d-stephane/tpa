
local S = tpa.intllib
local P = ""

minetest.register_chatcommand("tpa", {
    privs = {
        interact = true
    },
    func = function(name, param)
        if param == "" then
            -- Nom du joueur non saisie
            minetest.show_formspec(name, "tpa:error_empty_player_name",
                "size[7,2]" ..
                "label[0,0;" .. S("Attention, please enter the name of the player you wish you teleporter") .. "]" ..
                "button_exit[0,1;2,1;exit;" .. S("Close") .. "]")
            return false, ""
        else
            -- Verification de la présence du joueur auquel on veut se téléporter
            local player = minetest.get_player_by_name(param)

            if not player then
                -- Joeuur non présent
                minetest.show_formspec(name, "tpa:error_player_not_connected",
                    "size[7,2]" ..
                    "label[0,0;" .. S("Note that the player you are trying to teleport you is not connected") .. "]" ..
                    "button_exit[0,1;2,1;exit;" .. S("Close") .. "]")
                return false, ""
            end

            -- Le joueur est présent, on affiche une demande de TP
            minetest.show_formspec(param, "tpa:ok_ask_player",
                "size[7,2]" ..
                "label[0,0;" .. name .. " " .. S("wants to teleport to you") .. "]" ..
                "button_exit[0,1;2,1;button_yes;" .. S("Yes") .. "]" ..
                "button_exit[2,1;2,1;button_no;" .. S("No") .. "]")

            P = name;
        end

        return true, ""
    end
})


minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= "tpa:ok_ask_player" then
        -- Le nom du formulaire n'est pas tpa:ok_ask_player, exit
        return false
    end

    if fields.button_yes then
        -- Acceptation du TP
        --local pos = player:getpos()
        local player_demandeur = minetest.get_player_by_name(P)
        player_demandeur:setpos(player:getpos())
    else
        -- Refus du TP
        minetest.show_formspec(P, "tpa:no_tp_cancelled",
            "size[7,2]" ..
            "label[0,0;" .. player:get_player_name() .. " " .. S("do not want you to teleport to him") .. "]" ..
            "button_exit[0,1;2,1;exit;" .. S("Close") .. "]")
    end

    return true
end)
