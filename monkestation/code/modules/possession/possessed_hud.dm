/datum/hud/possessed
	has_interaction_ui = TRUE

/datum/hud/possessed/New(mob/living/carbon/owner)
	..()

	var/atom/movable/screen/using
	var/atom/movable/screen/inventory/inv_box

	using = new/atom/movable/screen/language_menu
	using.icon = ui_style
	using.hud = src
	static_inventory += using

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "id"
	inv_box.icon = ui_style
	inv_box.icon_state = "id"
	inv_box.icon_full = "template_small"
	inv_box.screen_loc = ui_id
	inv_box.slot_id = ITEM_SLOT_ID
	inv_box.hud = src
	static_inventory += inv_box

	using = new/atom/movable/screen/navigate
	using.icon = ui_style
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/area_creator
	using.icon = ui_style
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/mov_intent
	using.icon = ui_style
	using.icon_state = (mymob.m_intent == MOVE_INTENT_WALK ? "walking" : "running")
	using.screen_loc = ui_movi
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/drop()
	using.icon = ui_style
	using.screen_loc = ui_drop_throw
	using.hud = src
	static_inventory += using

	build_hand_slots()

	using = new /atom/movable/screen/swap_hand()
	using.icon = ui_style
	using.icon_state = "swap_1"
	using.screen_loc = ui_swaphand_position(owner,1)
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/swap_hand()
	using.icon = ui_style
	using.icon_state = "swap_2"
	using.screen_loc = ui_swaphand_position(owner,2)
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/resist()
	using.icon = ui_style
	using.screen_loc = ui_above_intent
	using.hud = src
	hotkeybuttons += using

	using = new /atom/movable/screen/human/toggle()
	using.icon = ui_style
	using.screen_loc = ui_inventory
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/human/equip()
	using.icon = ui_style
	using.screen_loc = ui_equip_position(mymob)
	using.hud = src
	static_inventory += using

	throw_icon = new /atom/movable/screen/throw_catch()
	throw_icon.icon = ui_style
	throw_icon.screen_loc = ui_drop_throw
	throw_icon.hud = src
	hotkeybuttons += throw_icon

	rest_icon = new /atom/movable/screen/rest()
	rest_icon.icon = ui_style
	rest_icon.screen_loc = ui_above_movement
	rest_icon.hud = src
	rest_icon.update_appearance()
	static_inventory += rest_icon

	healths = new /atom/movable/screen/healths()
	healths.hud = src
	infodisplay += healths

	healthdoll = new /atom/movable/screen/healthdoll()
	healthdoll.hud = src
	infodisplay += healthdoll

	stamina = new /atom/movable/screen/stamina()
	stamina.hud = src
	infodisplay += stamina

	pull_icon = new /atom/movable/screen/pull()
	pull_icon.icon = ui_style
	pull_icon.screen_loc = ui_above_intent
	pull_icon.hud = src
	pull_icon.update_appearance()
	static_inventory += pull_icon

	zone_select = new /atom/movable/screen/zone_sel()
	zone_select.icon = ui_style
	zone_select.hud = src
	zone_select.update_appearance()
	static_inventory += zone_select

	combo_display = new /atom/movable/screen/combo()
	infodisplay += combo_display

/datum/hud/possessed/persistent_inventory_update()
	if(!mymob)
		return
	var/mob/living/H = mymob
	if(hud_version != HUD_STYLE_NOHUD)
		for(var/obj/item/I in H.held_items)
			I.screen_loc = ui_hand_position(H.get_held_index_of_item(I))
			H.client.screen += I
	else
		for(var/obj/item/I in H.held_items)
			I.screen_loc = null
			H.client.screen -= I
