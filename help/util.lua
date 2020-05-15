--/////////////////////////////
--	util 一些杂类函数
--/////////////////////////////
local function debug(log)
	lib.Debug(log)
end

LogTimeUsed = {}
LogTimeUsed.new		= function() return {} end
LogTimeUsed.start	= function(t)
	if t then
		local now = lib.GetTime()
		t[1] = now
	end
end
LogTimeUsed.log		= function(t, tolog)
	local is_debug = false
	if t then
		local now = lib.GetTime()
		if t[1] ~= nil then
			if is_debug then
				debug(tolog.." [time_used="..(now-t[1]).."ms]")
			end
		else
			if is_debug then
				debug(tolog.." [timer_start]")
			end
		end
		t[1] = now
	end
end
LogTimeUsed.stop		= function(t)
	if t then
		t[1] = nil
	end
end

local time_used_log = LogTimeUsed.new()
local function log_time_used(tolog)
	LogTimeUsed.log(time_used_log, tolog)
end

local function memory_monitor()
	--debug("[memory_used] [before step		] "..collectgarbage("count"))
	--collectgarbage("step", 0)
	----debug("[memory_used] [before collect] "..collectgarbage("count"))
	collectgarbage("collect")
	----debug("[memory_used] [after  collect] "..collectgarbage("count"))
end

local function getTimeNow()
	return os.clock()
end

help.util = {
	debug						= debug,
	log_time_used		= log_time_used,
	memory_monitor	= memory_monitor,
	getTimeNow			= getTimeNow
}

return help.util