-- Change these values to your own messages
local msg_values = {
	"frame by frame: . ,", 
	"create video: SHIFT+w", 
	"modify playback speed: \n 10%: [ ] \n 50%: { } \n reset: BACKSPACE",
	"cycle through available audio tracks: #",
	"audio offset +/- 0.1s: CTRL++ CTRL+-",
	"cycle through available sub: j SHIFT+j",
	"sub offset +/- 0.1s: x z",
	"move sub pos (up/down): r t",
	"seek to prev/next sub: CTRL+LEFT CTRL+RIGHT",
	"sub style overrite: u",
	"screenshot: s SHIFT+s CTRL+s",
	"show/toggle OSD: o SHIFT+O"
	}
local current_index = 0;

local function cycle_messages()
	local last_index = #msg_values

	if current_index == last_index then
		current_index = 1 
	else
		current_index = current_index + 1
	end
	mp.osd_message(msg_values[current_index])
end

local function show_current_message()
	if current_index > 0 then
		mp.osd_message(msg_values[current_index])
	end
end

mp.add_key_binding("c", "cycle_messages", cycle_messages)
mp.add_key_binding("C", "show_current_message", show_current_message)