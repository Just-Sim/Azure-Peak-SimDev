/datum/keybinding/client/communication
	category = CATEGORY_COMMUNICATION

// No indicators
/datum/keybinding/client/communication/say
	hotkey_keys = list("CtrlT")
	name = "Say"
	full_name = "IC Say"
	clientside = "say"

/datum/keybinding/client/communication/me
	hotkey_keys = list("CtrlM")
	name = "Me"
	full_name = "Me (emote)"
	clientside = "me"

// Indicators
/datum/keybinding/client/communication/say_with_indicator
	hotkey_keys = list("T")
	name = "say_with_indicator"
	full_name = "Say with Typing Indicator"

/datum/keybinding/client/communication/say_with_indicator/down(client/user)
	var/mob/M = user.mob
	M.say_typing_indicator()
	return TRUE

/datum/keybinding/client/communication/me_with_indicator
	hotkey_keys = list("M")
	name = "me_with_indicator"
	full_name = "Me (emote) with Typing Indicator"

/datum/keybinding/client/communication/me_with_indicator/down(client/user)
	var/mob/M = user.mob
	M.me_typing_indicator()
	return TRUE

/datum/keybinding/client/communication/subtle
	hotkey_keys = list(",")
	name = "Subtle"
	full_name = "Subtle Emote"
	clientside = "subtle"

/datum/keybinding/client/communication/whisper
	hotkey_keys = list() // Left unbound because Y is used for LOOC, but I'd prefer a whisper key over using #.
	name = "Whisper"
	full_name = "Whisper"
	clientside = "whisper"

/datum/keybinding/client/communication/looc
	hotkey_keys = list("Y")
	name = "LOOC"
	full_name = "Local Out of Character chat"
	clientside = "looc"
