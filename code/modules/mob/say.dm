//Speech verbs.
/mob/verb/say_typing_indicator()
	set name = "say_indicator"
	set hidden = TRUE
	set category = "IC"
	client?.last_activity = world.time
	display_typing_indicator()
	var/message = input(usr, "", "say") as text|null
	// If they don't type anything just drop the message.
	clear_typing_indicator()		// clear it immediately!
	if(!length(message))
		return
	return say_verb(message)

/mob/verb/say_verb(message as text)
	set name = "Say"
	set category = "IC"
	set hidden = 1

	// If they don't type anything just drop the message.
	clear_typing_indicator()
	if(!length(message))
		return
	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, span_danger("Speech is currently admin-disabled."))
		return
	if(message)
		clear_typing_indicator()
		say(message)

/mob/proc/whisper_keybind()
	client?.last_activity = world.time
	var/message = input(src, "", "whisper") as text|null
	if(!length(message))
		return
	return whisper_verb(message)

/mob/verb/whisper_verb(message as text)
	set name = "Whisper"
	set category = "IC"
	set hidden = TRUE
	if(!length(message))
		return
	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, "<span class='danger'>Speech is currently admin-disabled.</span>")
		return
	whisper(message)

/mob/proc/whisper(message, datum/language/language=null)
	client?.last_activity = world.time
	say(message, language) //only living mobs actually whisper, everything else just talks

/mob/verb/me_typing_indicator()
	set name = "me_indicator"
	set hidden = TRUE
	set category = "IC"
	client?.last_activity = world.time
	display_typing_indicator()
	var/message = input(usr, "", "me") as message|null
	// If they don't type anything just drop the message.
	clear_typing_indicator()		// clear it immediately!
	if(!length(message))
		return
	return me_verb(message)

/mob/verb/me_verb(message as message)
	set name = "me"
	set category = "IC"
	set hidden = TRUE // I will never understand why Roguetown doesn't have an IC tab yet it's in the code.
	if(!length(message))
		return
	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, "<span class='danger'>Speech is currently admin-disabled.</span>")
		return

	if(length(message) > MAX_MESSAGE_LEN)
		to_chat(usr, message)
		to_chat(usr, "<span class='danger'>^^^----- The preceeding message has been DISCARDED for being over the maximum length of [MAX_MESSAGE_LEN]. It has NOT been sent! -----^^^</span>")
		return

	message = trim(html_encode(message), MAX_MESSAGE_LEN)
	clear_typing_indicator()		// clear it immediately!

	client?.last_activity = world.time

	usr.emote("me",1,message,TRUE)

///Speak as a dead person (ghost etc)
/mob/proc/say_dead(message)

	return // RTCHANGE

///Check if this message is an emote
/mob/proc/check_emote(message, forced)
	if(copytext_char(message, 1, 2) == "*")
		emote(copytext_char(message, 2), intentional = !forced, custom_me = TRUE)
		return 1

/mob/proc/check_whisper(message, forced)
	if(copytext_char(message, 1, 2) == "+")
		whisper(copytext_char(message, 2))//already sani'd
		return 1

///Check if the mob has a hivemind channel
/mob/proc/hivecheck()
	return 0

///Check if the mob has a ling hivemind
/mob/proc/lingcheck()
	return LINGHIVE_NONE

/**
  * Get the mode of a message
  *
  * Result can be
  * * MODE_WHISPER (Quiet speech)
  * * MODE_HEADSET (Common radio channel)
  * * A department radio (lots of values here)
  */
/mob/proc/get_message_mode(message)
	var/key = copytext_char(message, 1, 2)
	if(key == "#")
		return MODE_WHISPER
	else if(key == ";")
		return MODE_HEADSET
	else if(length(message) > 2 && (key in GLOB.department_radio_prefixes))
		var/key_symbol = lowertext(copytext_char(message, 2, 3))
		return GLOB.department_radio_keys[key_symbol]
