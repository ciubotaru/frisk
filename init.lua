minetest.log('action', '[MOD] Frisk loading ...')
local frisk_version = "0.0.1"

local i18n --internationalization
if minetest.get_modpath("intllib") then
	i18n = intllib.Getter()
else
	i18n = function(s,a,...)
		a={a,...}
		local v = s:gsub("@(%d+)", function(n)
			return a[tonumber(n)]
		end)
		return v
	end
end

local function frisk(stack, player, pointedThing)
	if not minetest.check_player_privs(player:get_player_name(), {frisk=true}) then
		minetest.chat_send_player(player:get_player_name(), i18n("You do not have the 'frisk' privilege"))
		return
	end
	local obj = pointedThing.ref
	if obj and pointedThing.type == "object" then
		local pName = obj:get_player_name()
		if pName ~= "" then
			local detached_inv = minetest.create_detached_inventory(pName) --InvRef
			local player_inv = minetest.get_inventory({type='player', name = pName}) --InvRef
			detached_inv:set_list('main', player_inv:get_list('main'))
			local formspec =
				'size[8,5]' ..
				'label[0,0;' .. i18n("@1\'s inventory", pName) ..']'..
				'list[detached:'.. pName..';main;0,1;8,4;]'
			minetest.show_formspec(player:get_player_name(), 'frisk:frisk', formspec)
		end
	end
end

minetest.register_privilege("frisk", "Player can check other players\' inventory.")

minetest.register_tool('frisk:screen', {
	description = i18n('Screening Device'),
	inventory_image = 'frisk_screen.png',
	on_use = frisk,
})

minetest.register_craft({
	output = 'frisk:screen',
	recipe = {
		{'', 'default:steel_ingot', ''},
		{'default:steel_ingot', 'default:glass', 'default:steel_ingot'},
		{'', 'default:steel_ingot',''},
	}
})

minetest.register_craft({
	output = 'frisk:screen',
	recipe = {
		{'', 'default:copper_ingot', ''},
		{'default:copper_ingot', 'default:glass', 'default:copper_ingot'},
		{'', 'default:copper_ingot',''},
	}
})

minetest.register_craft({
	output = 'frisk:screen',
	recipe = {
		{'', 'default:bronze_ingot', ''},
		{'default:bronze_ingot', 'default:glass', 'default:bronze_ingot'},
		{'', 'default:bronze_ingot',''},
	}
})

minetest.register_craft({
	output = 'frisk:screen',
	recipe = {
		{'', 'default:gold_ingot', ''},
		{'default:gold_ingot', 'default:glass', 'default:gold_ingot'},
		{'', 'default:gold_ingot',''},
	}
})

minetest.log('action', 'MOD: Frisk version ' .. frisk_version .. ' loaded.')
