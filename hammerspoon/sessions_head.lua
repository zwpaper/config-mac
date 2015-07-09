--Sessions control function file--
--[[
Author: PapEr (zw.paper@gmail.com)
--]]

--[[
--example of sessions
sessions = {
	{'scraper', {}},
	{'hammerspoon', {}},
	{'github', {}},
	{'wear', {}},
	{'work', {}}
}
-- each window is saved as {win, isFullScreen}
--]]

--[[
const
--]]
--index for each sessions
index_session = 1
index_windows = 2

--index for each windows
index_win = 1
index_isFull = 2

--[[
Variable
--]]
current = 2
local path_session_save = hs.configdir .. '/sessions.sav'


--[[
Functions
--]]
-- session handling
function sessionsShow()
	if #sessions ~= 0 then
		local msg = ''
		for k, v in pairs(sessions) do
			if current == k then msg = msg .. '->' end
			msg = msg .. v[index_session] .. '\t'
		end
		hs.notify.new({title='Sessions List:', informativeText=msg}):send():release()
	else
		hs.notify.new({title='Sessions List:', informativeText='No session'}):send():release()
	end
end


function sessionSwitch(new)
	hs.alert(new .. ' ' .. current)
	for k, v in pairs(sessions[current][index_windows]) do
		if v[index_win]:isVisible() then
			sessions[current][index_windows][k] = v[index_win]:isFullScreen()
			if v[index_win]:isFullScreen() then
				v[index_win]:setFullScreen()
				hs.timer.doAfter(2, function() v[index_win]:minimize() end);
			else
				v[index_win]:minimize()
			end
		else
			table.remove(sessions[current], k)
		end
	end

	for k, v in pairs(sessions[new][index_windows]) do
		if v[index_win]:isMinimized() then v[index_win]:unminimize() end
		if v[index_isFull] then hs.timer.doAfter(2, function() v[index_win]:setFullScreen() end) end
	end
	current = new
	hs.notify.new({title='Change session', informativeText=sessions[new][index_session] .. ' actived' .. current}):send():release()
end


function sessionsRead()
	local sessions_file = assert(io.open(path_session_save, "r"))
	sessions = {}
	for line in sessions_file:lines() do
		if line:sub(1, 1) == '{' then
			if #line < 2 then
				hs.notify.new({title='Error', informativeText='No session name after "{"'}):send():release()
				error('No session name after "{"')
			else
				table.insert(sessions, {line:sub(2, -1), {}})
			end
		elseif line:sub(1, 1) == '}' then
			if #line ~= 1 then
				hs.notify.new({title='Error', informativeText='Session not end with "}"'}):send():release()
				error('Session not end with "}"')
			end
		else
			local id, isFull
			local err
			err, id, isFull = pcall(string.unpack, 'LB', line)
			if err then hs.alert('err ' .. id)
			else hs.alert(id .. isFull) end
		end
	end
	sessionsShow()
end


function sessionsSave(se)
-- use a '{session ' start a scope,
-- each line as a win
-- end a scope using '}'
	local session_to_save = ''
	for k, v in pairs(se) do
		one_session = '{' .. v[index_session] .. '\n'
		for key, val in pairs(v[index_windows]) do
			local id = val[index_win]:id()
			local isFull = (val[index_isFull] and '1' or '0')
			one_session = (one_session .. tostring(id) .. ':' tostring(isFull) .. '\n')
		end
		one_session = one_session .. '}' .. '\n'
		session_to_save = session_to_save .. one_session
	end
	local sessions_file = assert(io.open(path_session_save, "w"))
	sessions_file:write(session_to_save)
	sessions_file:flush()
	sessions_file:close()
end


-- utils
function findInList(list, item)
	if list then
		for k, v in pairs(list) do
			if item:id() == v[1]:id() then return k end
		end
	end
	return nil
end
