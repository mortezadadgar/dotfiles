-- Show OSD clock
-- GitHub: https://github.com/blue-sky-r/mpv/tree/master/scripts

-- defaults
local cfg = {
	interval = '45m',
	format   = "%H:%M",
	duration = 2.5,
	key      = 'h',
	name     = 'show-clock'
}

-- human readable time format to seconds: 15m 3s -> 903
local function htime2sec(hstr)
	local s = tonumber(hstr)
	-- only number withoout units
	if s then return s end
	-- human units h,m,s to seconds
	local hu = {h=60*60, m=60, s=1}
	s = 0
	for unit,mult in pairs(hu) do
		local _,_,num = string.find(hstr, "(%d+)"..unit)
		if num then
			s = s + tonumber(num)*mult
		end
	end
	return s
end

-- calc aligned timeout in sec
local function aligned_timeout(align)
	local time = os.time()
	local atout = align * math.ceil(time / align) - time
	return atout
end

-- OSD show clock
local function osd_clock()
	local s = os.date(cfg.format)
	mp.osd_message(s, cfg.duration)
end

-- non empty interval enables osd clock
if cfg.interval then
	-- osd timer
	local osd_timer = mp.add_periodic_timer(htime2sec(cfg.interval), osd_clock)
	osd_timer:stop()

	-- start osd timer exactly at interval boundary
	local delay = aligned_timeout(htime2sec(cfg.interval))

	-- delayed start
	mp.add_timeout(delay,
		function()
			osd_timer:resume()
			osd_clock()
		end
	)

	-- optional bind to the key
	if cfg.key then
		mp.add_key_binding(cfg.key, cfg.name, osd_clock)
	end
end
