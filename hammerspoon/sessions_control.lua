--Sessions control--

--[[
ToDo:
* Save windows state when changing session
* Add a new session
* delete a session
* jump to a session easily
* save session safely
	save the sessions to a file
* show windows in current session
--]]

--Functions--
function findInList(list, item)
	if list then
		for k, v in pairs(list) do
			if item:id() == v[1]:id() then return k end
		end
	end
	return nil
end

sessions = {
	'scraper',
	'hammerspoon', 
	'github',
	'wear',
	'work'
}
--a list for each session
windows_in_session = {
	--a list for each window
	--hs.window, isFullScreen
	{},
	{}, 
	{},
	{},
	{}
}

current = 2


--Show sessions list
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "I", function()
	if #sessions ~= 0 then
		local msg = ''
		for k, v in pairs(sessions) do
			if current == k then msg = msg .. '->' .. ' ' end
			msg = msg .. v .. '\t'
		end
		hs.notify.new({title="Session List:", informativeText=msg}):send():release()
	else
		hs.notify.new({title="Session List:", informativeText='No session'}):send():release()
	end
end)

--Add current window into session
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "O", function()
	local win = hs.window.focusedWindow()
	if win:id() then 
		if findInList(windows_in_session[current], win) then 
			hs.notify.new({title="Add window to session", informativeText="Already added"}):send():release() 
			return
		end
		local status = {}
		table.insert(status, win)
		table.insert(status, win:isFullScreen())
		table.insert(windows_in_session[current], status)
		hs.notify.new({title="Add window to session", 
					informativeText=win:title() .. " added" .. ' (All: '.. #windows_in_session[current] .. ')'}):send():release()
	else hs.notify.new({title="Add window to session", informativeText="No focused window"}):send():release() end

end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "P", function()
	local win = hs.window.focusedWindow()
	if win:id() then
		local key = findInList(windows_in_session[current], win)
		if key then 
			table.remove(windows_in_session[current], key)
			hs.notify.new({title="Del window from session", 
						informativeText=win:title() .. " Deleted" .. ' (All: '.. #windows_in_session[current] .. ')'}):send():release()
		else hs.notify.new({title="Del window from session", informativeText="Not in this session"}):send():release() end
	else hs.notify.new({title="Add window to session", informativeText="No focused window"}):send():release() end

end)

--session switch
function session_switch(id)
	if windows_in_session[current] then
		for k, v in pairs(windows_in_session[current]) do
			if v[1]:isFullScreen() then v[1]:setFullScreen(); hs.timer.doAfter(2, function() v[1]:minimize() end); 
			else v[1]:minimize() end
		end
	end
	if windows_in_session[id] then
		for k, v in pairs(windows_in_session[id]) do
			if v[1]:isMinimized() then v[1]:unminimize() end
			if v[2] then v[1]:setFullScreen() end
		end
		current = id
		hs.notify.new({title="Change session", informativeText=sessions[current] .. ' actived'}):send():release()
	end
end

function session_switch_prv()
	local i = current - 1
	if current == 0 then i = #sessions end
	session_switch(i)
end
hs.hotkey.bind({"cmd","alt","ctrl"}, "[", session_switch_prv)

function session_switch_next()
	local i = current + 1
	if current == #sessions then i = 1 end
	session_switch(i)
end
hs.hotkey.bind({"cmd","alt","ctrl"}, "]", session_switch_next)