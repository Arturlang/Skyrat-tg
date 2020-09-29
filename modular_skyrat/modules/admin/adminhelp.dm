//Let the initiator know their ahelp is being handled
/datum/admin_help/proc/HandleIssue(key_name = key_name_admin(usr))
	if(state != AHELP_ACTIVE)
		return

	if(handler && handler != usr.ckey)
		var/response = alert(usr, "This ticket is already being handled by [handler]. Do you want to replace yourself as the handler for the ticket?", "Ticket already assigned", "Yes", "No")

		if(response == "No")
			return

	var/msg = "<span class ='adminhelp'>Your ticket is now being handled by [usr?.client?.holder?.fakekey? usr.client.holder.fakekey : "an administrator"]! Please wait while they type their response and/or gather relevant information.</span>" // Skyrat Change

	if(initiator)
		to_chat(initiator, msg)

	SSblackbox.record_feedback("tally", "ahelp_stats", 1, "handling")
	msg = "Ticket [TicketHref("#[id]")] is being handled by [key_name]"
	message_admins(msg)
	log_admin_private(msg)
	AddInteraction("Being handled by [key_name]")

	handler = "[usr.ckey]"
