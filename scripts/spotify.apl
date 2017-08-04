if appIsRunning("spotify") then
	tell application "Spotify"
		if player state is stopped then
			return "⏹"
		else if player state is paused then
			set emoji to "⏸"
		else
			set emoji to "🎶"
		end if

		set state to my formatTime(player position) & "/" & my formatTime((duration of current track) / 1000)

		return emoji & "  " & name of current track & " - " & artist of current track & " (" & state & ")"
	end tell
else
	return "⏹"
end if

on formatTime(secs)
	set secs to round secs
	set h to secs div hours
	set m to secs mod hours div minutes
	set s to secs mod minutes
	if h is 0 then
		return (m as string) & ":" & my pad(s)
	else
		return (h as string) & ":" & my pad(m) & ":" & my pad(s)
	end if
end formatTime

on pad(v)
	return text -2 thru -1 of (v + 100 as text)
end pad

on appIsRunning(appName)
	tell application "System Events" to (name of processes) contains appName
end appIsRunning
