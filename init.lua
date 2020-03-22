-- Core implemation requirements (imports).
local internet = require("lib_internet")
local logger = require("lib_logger")
local time = require("lib_time")

-- Unit requirements (imports).

-- The function called when everything is setup and ready to go within the nodeMCU.
-- This includes the internet connection, clock syncronization and logger logger
-- setup.
local function on_start()
  logger.info("Application starting - basic application")
end

local function on_failed()
  logger.info("Application failed to start")
end

local function on_internet_connected()
  time.clock_syncronization(time.UK_TIME_SERVER, on_start, on_failed);
end

-- 1 second before we start so we have a safe cutoff point.
local start_timer = tmr.create()

start_timer:register(1000, tmr.ALARM_SINGLE,  function ()
  internet.configure_station("The Promise Lan", "DangerZone2018", nil)
  internet.connect_station(nil, on_internet_connected, on_failed)
end)

start_timer:start()
