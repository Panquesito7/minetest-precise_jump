--[[
    Removes player speed depending on the jump time for a more realistic feeling. Built for Minetest.
    Copyright (C) 2023 David Leal (halfpacho@gmail.com)

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
--]]

local jump_time, is_holding = { }, { }
local privilege_required = minetest.settings:get_bool("precise_jump.privilege_required") or false

local S = minetest.get_translator(minetest.get_current_modname())

if privilege_required then
    minetest.register_privilege({"precise_jump"}, {
        description = S("Allows the player to perform precise jumps."),
        give_to_admin = true
    })
end

-- Table containing a list of velocities depending on the jump time.
-- Modifying these values might cause unwanted side effects.
local velocity_table = {
    {max_time = 0.25, min_time = 0.01, new_velocity_y = -2.75},
    {max_time = 0.6, min_time = 0.25, new_velocity_y = -2.5},
    {max_time = 0.8, min_time = 0.45, new_velocity_y = -2.2},
    {max_time = 1, min_time = 0.75, new_velocity_y = -1.34},
    {max_time = 1.4, min_time = 0.8, new_velocity_y = -1},
    {max_time = math.huge, min_time = 1.5, new_velocity_y = 0},
}

--- @brief Calculates the time the player is holding the jump button.
--- @param player userdata The player that will be checked
--- @return nil
local function calculate_time(player)
    local control = player:get_player_control()

    -- Initialize jump time in case it's not initialized.
    if jump_time[player] == nil then
        jump_time[player] = 0
    end

    if control.jump then
        if is_holding[player] then
            return
        end

        if jump_time[player] <= 1.5 then
            jump_time[player] = jump_time[player] + 0.09
        else
            is_holding[player] = true
            jump_time[player] = 1.5
        end
    else
        for _, v in ipairs(velocity_table) do
            if jump_time[player] <= v.max_time and jump_time[player] >= v.min_time then
                player:add_velocity(vector.new(0, v.new_velocity_y, 0))
                break
            end
        end

        is_holding[player] = false
        jump_time[player] = 0
    end
end

minetest.register_globalstep(function(dtime)
    for _, player in ipairs(minetest.get_connected_players()) do
        if privilege_required then
            if minetest.check_player_privs(player, {precise_jump = true}) then
                calculate_time(player)
            end
        else
            calculate_time(player)
        end
    end
end)
