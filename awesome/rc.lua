-- Standard awesome library
local awful = require("awful")
awful.autofocus = require("awful.autofocus")
awful.rules = require("awful.rules")
-- Theme handling library
local wibox = require("wibox")
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local revelation  = require("revelation") 
local vicious = require("vicious")
local localconf = require("localconf")
require("obvious.popup_run_prompt")
obvious.popup_run_prompt.set_opacity(0.7)
obvious.popup_run_prompt.set_slide(true)
obvious.popup_run_prompt.set_height(20)
require("obvious.wlan")
local scratch  = require("scratch")



--- Spawns cmd if no client can be found matching properties
-- If such a client can be found, pop to first tag where it is visible, and give it focus
-- @param cmd the command to execute
-- @param properties a table of properties to match against clients. Possible entries: any properties of the client object
function run_or_raise(cmd, properties)
   local clients = client.get()
   local focused = awful.client.next(0)
   local findex = 0
   local matched_clients = {}
   local n = 0
   for i, c in pairs(clients) do
      --make an array of matched clients
      if match(properties, c) then
         n = n + 1
         matched_clients[n] = c
         if c == focused then
            findex = n
         end
      end
   end
   if n > 0 then
      local c = matched_clients[1]
      -- if the focused window matched switch focus to next in list
      if 0 < findex and findex < n then
         c = matched_clients[findex+1]
      end
      local ctags = c:tags()
      if #ctags == 0 then
         -- ctags is empty, show client on current tag
         local curtag = awful.tag.selected()
         awful.client.movetotag(curtag, c)
      else
         -- Otherwise, pop to first tag client is visible on
         awful.tag.viewonly(ctags[1])
      end
      -- And then focus the client
      client.focus = c
      c:raise()
      return
   end
   awful.util.spawn(cmd)
end

-- Returns true if all pairs in table1 are present in table2
function match (table1, table2)
   for k, v in pairs(table1) do
      if table2[k] ~= v and not table2[k]:find(v) then
         return false
      end
   end
   return true
end

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
--beautiful.init("/usr/share/awesome/themes/default/theme.lua")
beautiful.init("/home/yuhei/.config/awesome/themes/awesome-solarized/light/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "mlterm -ac 2"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
 if screen.count() == 1 then
   layouts =
      {
      awful.layout.suit.tile.bottom,
      awful.layout.suit.tile.top,
      awful.layout.suit.tile,
      awful.layout.suit.tile.left,
      awful.layout.suit.fair,
      awful.layout.suit.fair.horizontal,
      awful.layout.suit.spiral,
      awful.layout.suit.spiral.dwindle,
      awful.layout.suit.floating,
      awful.layout.suit.max,
      awful.layout.suit.max.fullscreen,
      awful.layout.suit.magnifier
   }

else
   layouts =
      {
      awful.layout.suit.tile,
      awful.layout.suit.tile.left,
      awful.layout.suit.tile.bottom,
      awful.layout.suit.tile.top,
      awful.layout.suit.fair,
      awful.layout.suit.fair.horizontal,
      awful.layout.suit.spiral,
      awful.layout.suit.spiral.dwindle,
      awful.layout.suit.floating,
      awful.layout.suit.max,
      awful.layout.suit.max.fullscreen,
      awful.layout.suit.magnifier
   }
end


-- }}}

 -- {{{ Tags
 tags = {
   settings = {
     { names  = { "emacs", "img", "media", "dl", "misc", "chrome"},
       layout = { layouts[1], layouts[1], layouts[1], layouts[1], layouts[1] }
     },
     { names  = { "www",  "filer", "mpc", "misc"},
       layout = { layouts[3], layouts[1], layouts[1], layouts[1] }
 }}}
 
 for s = 1, screen.count() do
     tags[s] = awful.tag(tags.settings[s].names, s, tags.settings[s].layout)
 end
 -- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = 
                          {
                          { "awesome", myawesomemenu, beautiful.awesome_icon },
                          { "open terminal", terminal }, 
                          { "Reboot", function () awful.util.spawn_with_shell("sudo reboot") end},
                          { "poweroff", function () awful.util.spawn_with_shell("poweroff") end}, 
                          { "VirtualBox", function () awful.util.spawn_with_shell("VirtualBox") end}
                       }
                    })


-- Directory containing icons for the wibox
icon_path = os.getenv('HOME') .. '/.config/awesome/icons/'

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- nautiluslauncher = awful.widget.launcher({ image = "/usr/share/icons/hicolor/24x24/apps/nautilus.png",
--                                            command = "nautilus --no-desktop"})
-- firefoxlauncher = awful.widget.launcher({ image = icon_path .. 'firefox.png',
--                                      command = "firefox"})
-- emacslauncher = awful.widget.launcher({ image = "/usr/share/icons/hicolor/24x24/apps/emacs-xwidget-bzr.png",
--                                      command = "emacs"})



-- }}}

-- {{{ Wibox
-- Create a textclock widget

os.setlocale("ja_JP.UTF-8") -- 日本語表示
mytextclock = awful.widget.textclock( --{ align = "right"},
                                      "  %Y.%m.%d (%a) %H:%M  ",
                                      --"  %Y.%m.%d (%a) %H:%M:%S  ",
                                      60)

-- BEGIN OF AWESOMPD WIDGET DECLARATION

local awesompd = require('awesompd/awesompd')

musicwidget = awesompd:create() -- Create awesompd widget
  musicwidget.font = "Liberation Mono" -- Set widget font 
  musicwidget.scrolling = true -- If true, the text in the widget will be scrolled
  musicwidget.output_size = 30 -- Set the size of widget in symbols
  musicwidget.update_interval = 10 -- Set the update interval in seconds

  -- Set the folder where icons are located (change username to your login name)
  musicwidget.path_to_icons = "/home/yuhei/.config/awesome/icons" 

  -- Set the default music format for Jamendo streams. You can change
  -- this option on the fly in awesompd itself.
  -- possible formats: awesompd.FORMAT_MP3, awesompd.FORMAT_OGG
  musicwidget.jamendo_format = awesompd.FORMAT_MP3
  
  -- Specify the browser you use so awesompd can open links from
  -- Jamendo in it.
  musicwidget.browser = "firefox"

  -- If true, song notifications for Jamendo tracks and local tracks
  -- will also contain album cover image.
  musicwidget.show_album_cover = true

  -- Specify how big in pixels should an album cover be. Maximum value
  -- is 100.
  musicwidget.album_cover_size = 50
  
  -- This option is necessary if you want the album covers to be shown
  -- for your local tracks.
  musicwidget.mpd_config = "/etc/mpd.conf"
  
  -- Specify decorators on the left and the right side of the
  -- widget. Or just leave empty strings if you decorate the widget
  -- from outside.
  musicwidget.ldecorator = " "
  musicwidget.rdecorator = " "

  -- Set all the servers to work with (here can be any servers you use)
  musicwidget.servers = {
     { server = "localhost",
          port = 6600 }
  }

  -- Set the buttons of the widget. Keyboard keys are working in the
  -- entire Awesome environment. Also look at the line 352.
  musicwidget:register_buttons({ { "", awesompd.MOUSE_LEFT, musicwidget:command_playpause() },
     			       { "Control", awesompd.MOUSE_SCROLL_UP, musicwidget:command_prev_track() },
  			       { "Control", awesompd.MOUSE_SCROLL_DOWN, musicwidget:command_next_track() },
  			       { "", awesompd.MOUSE_SCROLL_UP, musicwidget:command_volume_up() },
  			       { "", awesompd.MOUSE_SCROLL_DOWN, musicwidget:command_volume_down() },
  			       { "", awesompd.MOUSE_RIGHT, musicwidget:command_show_menu() },
                               { "", "XF86AudioLowerVolume", musicwidget:command_volume_down() },
                               { "", "XF86AudioRaiseVolume", musicwidget:command_volume_up() },
                               { modkey, "Pause", musicwidget:command_playpause() } })

  musicwidget:run() -- After all configuration is done, run the widget

-- END OF AWESOMPD WIDGET DECLARATION
-- Don't forget to add the widget to the wibox. It is done on the line 244.



-- Create a systray
mysystray = wibox.widget.systray()

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })




    -- -- CPU usage
    cpuicon = wibox.widget.imagebox()
    cpuicon:set_image(icon_path .. 'cpu.png')
    cpugraph = awful.widget.graph()
    cpugraph:set_width(30)
    cpugraph:set_height(16)
    cpugraph:set_border_color(beautiful.border_widget)
    cpugraph:set_background_color(beautiful.bg_widget)
    cpugraph:set_color(beautiful.fg_widget)
    vicious.register(cpugraph, vicious.widgets.cpu, '$1')

    -- Create a volume widget
    volumeicon = wibox.widget.imagebox()
    volumeicon:set_image(icon_path .. 'volume-control.png')
    volume = awful.widget.progressbar()
    volume:set_width(8)
    volume:set_height(16)
    volume:set_vertical(true)
    volume:set_border_color(beautiful.border_widget)
    volume:set_background_color(beautiful.bg_widget)
    volume:set_color(beautiful.fg_widget)
    vicious.register(volume, vicious.widgets.volume, '$1', 1, 'Master')


    -- Memory usage
    local memoryicon = wibox.widget.imagebox()
    memoryicon:set_image(icon_path .. 'mem.png')
    local memory = awful.widget.progressbar()
    memory:set_width(8)
    memory:set_height(16)
    memory:set_vertical(true)
    memory:set_border_color(beautiful.border_widget)
    memory:set_background_color(beautiful.bg_widget)
    memory:set_color(beautiful.fg_widget)
    vicious.register(memory, vicious.widgets.mem, '$1', 9)

    --Create a weather widget

    weathertext  = "weather"

    mytimer = timer({ timeout = 3600 })
    mytimer:connect_signal("timeout", function() awful.util.spawn_with_shell("python2 /home/yuhei/Documents/Python/weather.py") end)
    mytimer:start()

    -- debugtimer = timer({ timeout = 30 })
    -- debugtimer:connect_signal("timeout", function() naughty.notify({ preset = naughty.config.presets.critical,
    --                                                              title = "debug",
    --                                                              text = awful.util.pread("cat /tmp/weather.txt") }) end)
    -- debugtimer:start()

-- {{{ WEATHER
    weatherwidget = wibox.widget.textbox()
    weatherwidget:set_text(weathertext)
    weatherwidget_t = awful.tooltip({ objects = {weatherwidget},})
    weathertext = awful.util.pread("cat /tmp/weather.txt")
    weathertimer = timer(
       { timeout = 60 } -- Update every 15 minutes. 
                        ) 
    weathertimer:connect_signal(
       "timeout", function() 
          weathertext = awful.util.pread("cat /tmp/weather.txt")
          weatherwidget:set_text(weathertext)
                  end)
    weathertimer:start() -- Start the timer

vicious.register(weatherwidget, vicious.widgets.pkg,
                function(widget,args)
                   local str = awful.util.pread("cat /tmp/weather_detail.txt")
                   weatherwidget_t:set_text(str)
                   return  args[1]
                end, 1800, "Arch")
    -- -- I added some spacing because on my computer it is right next to my clock.
    -- awful.widget.layout.margins[weatherwidget] = { right = 5 } 


-- {{{ PACMAN
-- Icon
pacicon = wibox.widget.imagebox()
pacicon:set_image(icon_path .. 'pac.png')
pacicon_t = awful.tooltip({ objects = { pacicon},})

-- Upgrades
pacwidget = wibox.widget.textbox()
pacwidget_t = awful.tooltip({ objects = { pacwidget},})

vicious.register(pacwidget, vicious.widgets.pkg,
                function(widget,args)
                    local io = { popen = io.popen }
                    local s = io.popen("pacman -Qu")
                    local str = ''

                    for line in s:lines() do
                        str = str .. line .. "\n"
                    end
                    pacwidget_t:set_text(str)
                    pacicon_t:set_text(str)
                    s:close()

                    if args[1]   ==  0 then
                       pacicon:set_image(icon_path .. 'pac.png')
                    elseif args[1]  <  20 then  
                       pacicon:set_image(icon_path .. 'pacnew.png')
                    else
                       pacicon:set_image(icon_path .. 'paccaution.png')
                    end

                    return  args[1]
                end, 1800, "Arch")

-- vicious.register(pacwidget, vicious.widgets.pkg, function(widget, args)
--   if args[1] > 0 then
--     pacicon:set_image(icon_path .. 'pacnew.png')
--   else
--     pacicon:set_image(icon_path .. 'pac.png')
--   end

--   return args[1]
-- end, 1801, "Arch S") -- Arch S for ignorepkg

-- Buttons
function popup_pac()
  local pac_updates = ""
  local f = io.popen("pacman -Sup --dbpath /var/lib/pacman")
  if f then
    pac_updates = f:read("*a"):match(".*/(.*)-.*\n$")
  end
  f:close()

  if not pac_updates then
    pac_updates = "System is up to date"
  end

  naughty.notify { text = pac_updates }
end
-- pacwidget:buttons(awful.util.table.join(awful.button({ }, 1, popup_pac)))
-- pacicon:buttons(pacwidget:buttons())
-- }}}


    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    -- left_layout:add(emacslauncher)
    -- left_layout:add(firefoxlauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end

    right_layout:add(musicwidget.widget)  -- Widget is added here.
    right_layout:add(weatherwidget)
    right_layout:add(pacicon)
    right_layout:add(pacwidget)
    right_layout:add(volumeicon)
    right_layout:add(volume)
    right_layout:add(memoryicon)
    right_layout:add(memory)
    right_layout:add(cpuicon)
    right_layout:add(cpugraph)
    right_layout:add(mytextclock)
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
-- }}}



-- for s = 1, screen.count() do
--     -- Create a promptbox for each screen
--     mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
--     -- Create an imagebox widget which will contains an icon indicating which layout we're using.
--     -- We need one layoutbox per screen.
--     mylayoutbox[s] = awful.widget.layoutbox(s)
--     mylayoutbox[s]:buttons(awful.util.table.join(
--                            awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
--                            awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
--                            awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
--                            awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
--     -- Create a taglist widget
--     mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

--     -- Create a tasklist widget
--     mytasklist[s] = awful.widget.tasklist(function(c)
--                                               return awful.widget.tasklist.label.currenttags(c, s)
--                                           end, mytasklist.buttons)

-- -- Create a separator
-- separator = widget({ type = "textbox" })
-- separator.text = separator_text
-- spacer = widget({ type = "textbox" })
-- spacer.text = spacer_text

-- -- -- CPU usage
-- cpuicon = widget({ type = "imagebox" })
-- cpuicon.image = image(icon_path .. 'cpu.png')
-- cpugraph = awful.widget.graph()
-- cpugraph:set_width(30)
-- cpugraph:set_height(16)
-- cpugraph:set_border_color(beautiful.border_widget)
-- cpugraph:set_background_color(beautiful.bg_widget)
-- cpugraph:set_color(beautiful.fg_widget)
-- vicious.register(cpugraph, vicious.widgets.cpu, '$1')


-- -- Create a battery monitor
-- if localconf.has_battery then
--     batteryicon = widget({ type = "imagebox" })
--     batteryicon.image = image(icon_path .. 'battery.png')
--     battery = awful.widget.progressbar()
--     battery:set_width(8)
--     battery:set_height(16)
--     battery:set_vertical(true)
--     battery:set_border_color(beautiful.border_widget)
--     battery:set_background_color(beautiful.bg_widget)
--     battery:set_color(beautiful.fg_widget)
--     vicious.register(battery, vicious.widgets.bat, '$2', 61, localconf.battery)
-- end

-- -- Create a volume widget
-- volumeicon = widget({ type = "imagebox" })
-- volumeicon.image = image(icon_path .. 'volume-control.png')
-- volume = awful.widget.progressbar()
-- volume:set_width(8)
-- volume:set_height(16)
-- volume:set_vertical(true)
-- volume:set_border_color(beautiful.border_widget)
-- volume:set_background_color(beautiful.bg_widget)
-- volume:set_color(beautiful.fg_widget)
-- vicious.register(volume, vicious.widgets.volume, '$1', 1, 'Master')

-- -- Directory containing icons for the wibox
-- icon_path = os.getenv('HOME') .. '/.config/awesome/icons/'

-- -- CPU usage
-- cpuicon = widget({ type = "imagebox" })
-- cpuicon.image = image(icon_path .. 'cpu.png')
-- cpugraph = awful.widget.graph()
-- cpugraph:set_width(30)
-- cpugraph:set_height(16)
-- cpugraph:set_border_color(beautiful.border_widget)
-- cpugraph:set_background_color(beautiful.bg_widget)
-- cpugraph:set_color(beautiful.fg_widget)
-- vicious.register(cpugraph, vicious.widgets.cpu, '$1')

-- -- Memory usage
-- memoryicon = widget({ type = 'imagebox' })
-- memoryicon.image = image(icon_path .. 'mem.png')
-- memory = awful.widget.progressbar()
-- memory:set_width(8)
-- memory:set_height(16)
-- memory:set_vertical(true)
-- memory:set_border_color(beautiful.border_widget)
-- memory:set_background_color(beautiful.bg_widget)
-- memory:set_color(beautiful.fg_widget)
-- vicious.register(memory, vicious.widgets.mem, '$1', 9)

-- -- -- -- Wifi
-- -- -- wifiicon = widget({ type = "imagebox" })
-- -- -- wifiicon.image = image(icon_path .. 'wifi.png')
-- -- -- wifiwidget = widget({ type = "textbox" })
-- -- -- vicious.register(wifiwidget, vicious.widgets.wifi,
-- -- --                  function (widget, args)
-- -- --                     if args["{link}"] == 0 then
-- -- --                        wifiicon.visible = false
-- -- --                        return ""
-- -- --                     else
-- -- --                        wifiicon.visible = true
-- -- --                        return string.format("[%i%%]", args["{link}"]/70*100)
-- -- --                        --return string.format("%s [%i%%]", args["{ssid}"], args["{link}"]/70*100)
-- -- --                     end
-- -- --                  end, refresh_delay, "wlan0")

-- --Create a weather widget

-- weathertext  = "weather"

-- mytimer = timer({ timeout = 3600 })
-- mytimer:connect_signal("timeout", function() weathertext = awful.util.pread("python2 /home/yuhei/Documents/Python/weather.py") end)
-- mytimer:start()

-- -- debugtimer = timer({ timeout = 30 })
-- -- debugtimer:connect_signal("timeout", function() naughty.notify({ preset = naughty.config.presets.critical,
-- --                                                              title = "debug",
-- --                                                              text = awful.util.pread("cat /tmp/weather.txt") }) end)
-- -- debugtimer:start()

-- weatherwidget = widget({ type = "textbox" })
-- weatherwidget.text = awful.util.pread("cat /tmp/weather.txt")
-- weathertimer = timer(
--   { timeout = 60 } -- Update every 15 minutes. 
-- ) 
-- weathertimer:connect_signal(
--   "timeout", function() 
--      weatherwidget.text = awful.util.pread("cat /tmp/weather.txt")
--  end)
-- weathertimer:start() -- Start the timer

-- weatherwidget:connect_signal(
-- "mouse::enter", function() 
--   weather = naughty.notify(
--     {title="Weather",text=awful.util.pread("cat /tmp/weather_detail.txt")})
--   end) -- this creates the hover feature. replace METARID and remove -m if you want Fahrenheit
-- weatherwidget:connect_signal(
--   "mouse::leave", function() 
--     naughty.destroy(weather) 
--   end)

-- -- I added some spacing because on my computer it is right next to my clock.
-- awful.widget.layout.margins[weatherwidget] = { right = 5 } 

--     -- Create the wibox
--     mywibox[s] = awful.wibox({ position = "top", height = "18", screen = s })
--     --mywibox[s] = awful.wibox({ position = "top", height = "18", screen = s })
--     -- Add widgets to the wibox - order matters
--     mywibox[s].widgets = {
--         {
--            mylauncher,
--            emacslauncher,
--            firefoxlauncher,
--            nautiluslauncher,
--            mytaglist[s],
--            mypromptbox[s],
--            layout = awful.widget.layout.horizontal.leftright
--         },
--         mylayoutbox[s],
--         mytextclock,
--         weatherwidget,
--         cpugraph.widget, 
--         cpuicon, 
--         separator,
--         memory.widget, 
--         memoryicon,
--         separator,
--         volume.widget,
--         volumeicon, 
--         separator,
--         localconf.has_battery and battery.widget or nil,
--         localconf.has_battery and batteryicon or nil,
--         -- -- wifiwidget,
--         -- -- wifiicon,

--         s == 1 and mysystray or nil,
--         mytasklist[s],
--         layout = awful.widget.layout.horizontal.rightleft


--     }
-- end
-- -- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
   awful.key({                   }, "XF86Back",    awful.tag.viewprev),
   awful.key({ modkey            }, "XF86Back", awful.tag.viewnext),
   awful.key({ modkey, "Shift"   }, "z", function () scratch.pad.toggle() end),
   awful.key({ modkey            }, "z", function () scratch.drop(terminal, "top", "center", 1, 0.4, false, 1) end),
   awful.key({ modkey            }, "e", function () run_or_raise("emacs",{ class = "Emacs" }) end),
   awful.key({ modkey            }, "a", function () run_or_raise("nautilus --no-desktop",{ class = "Nautilus" }) end),
   awful.key({ modkey,  "Control" }, "a", function () run_or_raise("nemo --no-desktop",{ class = "Nemo" }) end),
   awful.key({ modkey, "Shift"   }, "w", function () run_or_raise("google-chrome-unstable",{ class = "Google-chrome-unstable" }) end),
   awful.key({ modkey            }, "w", function () run_or_raise("firefox",{ class = "Firefox" }) end),
   awful.key({ modkey,  "Shift"  }, "t", function () run_or_raise("thg",{ class = "Thg" }) end),
   awful.key({ modkey,  "Shift"  }, "m", function () run_or_raise("marlin",{ class = "Marlin" }) end),
   awful.key({ modkey            }, "s", function () run_or_raise("opera" ,{ class = "Opera" }) end),
   awful.key({ modkey, "Control" }, "b",   awful.tag.viewprev       ),
   awful.key({ modkey, "Control" }, "f",  awful.tag.viewnext       ),
   awful.key({ modkey,           }, "Escape", awful.tag.history.restore),
   awful.key({ }, "Print", function () awful.util.spawn_with_shell("ruby /home/yuhei/Documents/Ruby/gyazo") end),
   --awful.key({ }, "Print", function () awful.util.spawn("gnome-screenshot") end),

   awful.key({ modkey,           }, "n",
             function ()
                awful.client.focus.byidx( 1)
                if client.focus then client.focus:raise() end
             end),
   awful.key({ modkey,           }, "p",
             function ()
                awful.client.focus.byidx(-1)
                if client.focus then client.focus:raise() end
             end),
   --awful.key({ modkey,           }, "w", function () mymainmenu:show(true)        end),
   
    -- Layout manipulation
   awful.key({ modkey, "Shift"   }, "n", function () awful.client.swap.byidx(  1)    end),
   awful.key({ modkey, "Shift"   }, "p", function () awful.client.swap.byidx( -1)    end),
   awful.key({ modkey,           }, ".", function () awful.screen.focus(1)           end),
   awful.key({ modkey,           }, ",", function () awful.screen.focus(2)           end),
   awful.key({ modkey, "Control" }, "n", function () awful.screen.focus_relative( 1) end),
   awful.key({ modkey, "Control" }, "p", function () awful.screen.focus_relative(-1) end),
    --awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
   awful.key({ modkey,           }, "u", 
             function ()           
                --awful.screen.focus(mouse.screen + 1)
                if  mouse.screen  == 1
                then 
                   awful.screen.focus(2)
                else 
                   --naughty.notify({ text = "hoge" })
                   awful.tag.viewnext ()
                end
             end),
   awful.key({ modkey,           }, "i", 
             function ()           
                --awful.screen.focus(mouse.screen + 1)
                if  mouse.screen  == 2
                then 
                   awful.screen.focus(1)
                else 
                   --naughty.notify({ text = "hoge" })
                   awful.tag.viewnext ()
                end
             end),
   awful.key({ modkey,           }, "Tab",
             function ()
                awful.client.focus.history.previous()
                if client.focus then
                   client.focus:raise()
                end
             end),

    -- Standard program
   awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
   awful.key({ modkey, "Control" }, "r", awesome.restart),
   awful.key({ modkey, "Shift"   }, "q", awesome.quit),
   awful.key({ modkey, "Control" }, "q",     function () awful.util.spawn_with_shell("poweroff") end),
   awful.key({ modkey,           }, "n",     function () awful.tag.incmwfact( 0.05)    end),
   awful.key({ modkey,           }, "p",     function () awful.tag.incmwfact(-0.05)    end),
   awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
   awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
   awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
   awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
   awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
   awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),
   --awful.key({ modkey }, "s",  revelation.revelation),
   awful.key({ modkey },            "d",
             function ()
                -- awful.util.spawn("dmenu_run -i -p 'Run command:' -nb '" .. 
                awful.util.spawn("dmenu_run -hist /home/yuhei/dmenu-hist -i -p 'Run command:' -nb '" .. 
                                 beautiful.bg_normal .. "' -nf '" .. beautiful.fg_normal .. 
                                 "' -sb '" .. beautiful.bg_focus .. 
                                 "' -sf '" .. beautiful.fg_focus .. "'") end), 

   awful.key({ modkey , "Control"}, "d",
             function ()
                awful.util.spawn("clipmenu") end), 



   -- Prompt
   --awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),
   --awful.key({ modkey }, "r", obvious.popup_run_prompt.run_prompt), 
   --awful.key({ modkey            }, "r",           myshifty.rename),
   awful.key({ modkey }, "x",
             function ()
                awful.prompt.run({ prompt = "Run Lua code: " },
                                 mypromptbox[mouse.screen].widget,
                                 awful.util.eval, nil,
                                 awful.util.getdir("cache") .. "/history_eval")
             end))




clientkeys = awful.util.table.join(
   awful.key({ modkey, "Control" }, "z",      function (c) scratch.pad.set(c, 0.60, 0.60, true)  end),
   awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
   awful.key({ modkey, "Shift" }, "c",      function (c) c:kill()                         end),
   awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
   awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
   awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
   awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
   --awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),

   awful.key({ modkey,           }, "m",
             function (c)
                c.maximized_horizontal = not c.maximized_horizontal
                c.maximized_vertical   = not c.maximized_vertical
             end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber))
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 43,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 43,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 43,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 43,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end


clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
if screen.count() == 1 then
   -- {{{ Rules
   awful.rules.rules = {
      -- All clients will match this rule.
      { rule = { },
        properties = { border_width = beautiful.border_width,
                       border_color = beautiful.border_normal,
                       focus = true,
                       keys = clientkeys,
                       buttons = clientbuttons, 
                       size_hints_honors = false } },
      { rule = { class = "MPlayer" },
        properties = { floating = true } },
      { rule = { class = "Gloobus-preview" },
        properties = { floating = true, 
                       focus = true} },
      { rule = { class = "pinentry" },
        properties = { floating = true } },
      { rule = { class = "gimp" },
        properties = { floating = true } },
      -- Set Firefox to always map on tags number 2 of screen 1.
      -- { rule = { class = "Firefox" },
      --   properties = { tag = tags[1][2] } },
      -- { rule = { class = "Nautilus" },
      --   properties = { tag = tags[1][3] } },
      { rule = { class = "Emacs" },
        --properties = { tag = tags[1][1], size_hints_honor = false } },
        properties = {size_hints_honor = false } }
   }
   -- }}}
else
   awful.rules.rules = {
      -- All clients will match this rule.
      { rule = { },
        properties = { border_width = beautiful.border_width,
                       border_color = beautiful.border_normal,
                       focus = true,
                       keys = clientkeys,
                       buttons = clientbuttons } },
      -- { rule = { class = "Gloobus-preview" },
      --   properties = { floating = true, 
      --                  focus = true, 
      --                   --tag = tags[mouse.screen]["www"]
      --            } },

    -- { rule = { class = "Gloobus-preview-configuration" },
    --   properties = { floating = true } },
    -- { rule = { class = "Gloobus-preview" },
    --   properties = { floating = true, 
    --   			 border_width = 0 } },
      { rule = { instance = "plugin-container" },
        properties = { floating = true } },
      { rule = { class = "MPlayer" },
        properties = { floating = true } },
      { rule = { class = "pinentry" },
        properties = { floating = true } },
      { rule = { class = "gimp" },
        properties = { floating = true } },
      -- { rule = { class = "Totem" },
      --   properties = { tag = tags[1][5], switchtotag = true } },
      -- Firefoxをサブディスプレイのタグ1に表示する
      -- switchtotagをtrueにするとフォーカスも移る
      { rule = { class = "Firefox" },
        properties = { tag = tags[2][1]} },
      { rule = { class = "MComix" },
        properties = { tag = tags[1][2]}},
      { rule = { class = "Shotwell" },
        properties = { tag = tags[1][2]}},
      { rule = { class = "Geeqie" },
        properties = { tag = tags[1][2]}},
      { rule = { class = "Qcomicbook" },
        properties = { tag = tags[1][2]} },
      { rule = { class = "Gmpc" },
        properties = { tag = tags[2][3]} },
      { rule = { class = "Nautilus" },
        properties = { tag = tags[2][2]} },
      { rule = { class = "Rawtherapee" },
        properties = { tag = tags[2][4]} , switchtotag = true},
      { rule = { class = "cantata" },
        properties = { tag = tags[1][3]} , switchtotag = true},
      { rule = { class = "Marlin" },
        properties = { tag = tags[1][4]} },
      { rule = { class = "VirtualBox" },
        properties = { tag = tags[1][5]} },
      { rule = { class = "Google-chrome-unstable" },
        properties = { tag = tags[1][6]} },
      { rule = { class = "Vlc" },
        properties = { tag = tags[1][3], switchtotag = true, maximized_vertical = true, maximized_horizontal = true} },
      { rule = { class = "mpv" },
        properties = { tag = tags[1][3], switchtotag = true, maximized_vertical = true, maximized_horizontal = true} },
      { rule = { class = "sushi-start" },
        properties = {switchtotag = false} },
      { rule = { class = "jd-Main" },  properties = { tag = tags[1][4]} },
      { rule = { class = "qBittorrent" }, properties = { tag = tags[1][4]} },
      -- { rule = { class = "Rhythmbox" },
      --   properties = { tag = tags[2][3], switchtotag = true } },
      { rule = { class = "Thg" },
        properties = { tag = tags[1][5], switchtotag = true } }, 
        --Emacsは開く場所を特定しないでどこでも開けるようにしておく。
        --size_hints_honorをfalseにしておくと変な隙間ができないようになる。
      { rule = { class = "Emacs" }, 
        properties = { tag = tags[1][1], size_hints_honor = false, maximized_vertical = true, maximized_horizontal = true} }
        --properties = { tag = tags[1][1], size_hints_honor = false } },

   }
end

-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

-- Set keys
root.keys(globalkeys)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

awful.util.spawn_with_shell("pa-applet")
awful.util.spawn_with_shell("conky")
-- awful.util.spawn_with_shell("dropbox")
-- awful.util.spawn_with_shell("owncloud")
awful.util.spawn_with_shell("blueman-applet")
awful.util.spawn_with_shell("bskk -f ~/.emacs.d/.ddskk/bayesian -s")
awful.util.spawn_with_shell("python2 /home/yuhei/Documents/Python/weather.py")
-- awful.util.spawn_with_shell("gnome-power-manager")
-- awful.util.spawn_with_shell("wicd-client --tray")
awful.util.spawn_with_shell("emacs --daemon")
-- awful.util.spawn_with_shell("SpiderOak --headless")
-- awful.util.spawn_with_shell("clipmenud")
awful.util.spawn_with_shell("mpdscribble")
awful.util.spawn_with_shell("xset r rate 300 60")
-- awful.util.spawn_with_shell("keepass")
-- awful.util.spawn_with_shell("lsyncd /home/yuhei/Documents/dotfiles_myuhe/lua/sync.lua")
awful.util.spawn_with_shell("nitrogen --restore")
awful.util.spawn_with_shell("offlineimap")


