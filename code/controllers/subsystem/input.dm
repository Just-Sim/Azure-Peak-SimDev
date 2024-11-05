SUBSYSTEM_DEF(input)
	name = "Input"
	wait = 1 //SS_TICKER means this runs every tick
	init_order = INIT_ORDER_INPUT
	flags = SS_TICKER
	priority = FIRE_PRIORITY_INPUT
	runlevels = RUNLEVELS_DEFAULT | RUNLEVEL_LOBBY

	/// KEEP THIS UP TO DATE!
	/// Roguetown does not use Classic Hotkeys, so we don't need to include them.
	var/static/list/all_macrosets = list(
		SKIN_MACROSET_HOTKEYS
		// SKIN_MACROSET_CLASSIC_HOTKEYS,
		// SKIN_MACROSET_CLASSIC_INPUT
	)
	/// New hotkey mode macro set. All input goes into map, game keeps incessently setting your focus to map, we can use ANY all we want here; we don't care about the input bar, the user has to force the input bar every time they want to type.
	var/static/list/macroset_hotkey

	/// Macro set for hotkeys
	var/list/hotkey_mode_macros

/datum/controller/subsystem/input/Initialize()
	setup_macrosets()

	initialized = TRUE

	refresh_client_macro_sets()

	return ..()

// This is for when macro sets are eventualy datumized
/datum/controller/subsystem/input/proc/setup_macrosets()
	//Classic Hotkeys would go here, but we don't have a "Enable Classic Hotkeys" button anywhere in the code so I just won't set them up.
	//Feel free to add one yourself, otherwise, here's the modern macroset.
	macroset_hotkey = list(
	"Any" = "\"KeyDown \[\[*\]\]\"",
	"Any+UP" = "\"KeyUp \[\[*\]\]\"",
	"Tab" = "\".winset \\\"input.focus=true?map.focus=true input.background-color=[COLOR_INPUT_DISABLED]:input.focus=true input.background-color=[COLOR_INPUT_ENABLED]\\\"\"",
	"Escape" = "\".winset \\\"input.text=\\\"\\\"\\\"\"",
	"Back" = "\".winset \\\"input.text=\\\"\\\"\\\"\"",
	)

// Badmins just wanna have fun ♪
/datum/controller/subsystem/input/proc/refresh_client_macro_sets()
	var/list/clients = GLOB.clients
	for(var/i in 1 to clients.len)
		var/client/user = clients[i]
		user.full_macro_assert()

/datum/controller/subsystem/input/fire()
	set waitfor = FALSE
	var/list/clients = GLOB.clients // Let's sing the list cache song
	for(var/i in 1 to clients.len)
		var/client/C = clients[i]
		C.keyLoop()

#define NONSENSICAL_VERB "NONSENSICAL_VERB_THAT_DOES_NOTHING"
/// A nonsensical Verb that does quite a lot actually.
/client/verb/NONSENSICAL_VERB_THAT_DOES_NOTHING()
	set name = "NONSENSICAL_VERB_THAT_DOES_NOTHING"
	set hidden = TRUE
