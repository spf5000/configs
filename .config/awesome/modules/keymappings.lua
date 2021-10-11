modkey = "Mod1"

local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local menubar = require("menubar")

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey }, "s",
        hotkeys_popup.show_help,
        {description="show help", group="awesome"}
    ),

    awful.key({ modkey }, "j",
        function () awful.client.focus.bydirection("down") end,
        {description = "focus down", group = "windows"}
    ),

    awful.key({ modkey }, "k",
        function () awful.client.focus.bydirection("up") end,
        {description = "focus up", group = "windows"}
    ),

    awful.key({ modkey }, "h",
        function () awful.client.focus.bydirection("left") end,
        {description = "focus left", group = "windows"}
    ),

    awful.key({ modkey }, "l",
        function () awful.client.focus.bydirection("right") end,
        {description = "focus right", group = "windows"}
    ),

    awful.key({ modkey }, "j",
        function () awful.client.focus.bydirection("down") end,
        {description = "focus down", group = "windows"}
    ),

    awful.key({ modkey, "Shift" }, "k",
        function () awful.client.swap.bydirection("up") end,
        {description = "swap up", group = "windows"}
    ),

    awful.key({ modkey, "Shift" }, "h",
        function () awful.client.swap.bydirection("left") end,
        {description = "swap left", group = "windows"}
    ),

    awful.key({ modkey, "Shift" }, "l",
        function () awful.client.swap.bydirection("right") end,
        {description = "swap right", group = "windows"}
    ),

    awful.key({ modkey, "Shift" }, "j", 
        function () awful.client.swap.bydirection("down") end,
        {description = "swap down", group = "windows"}
    ),

    awful.key({ modkey, "Control" }, "k", 
        function () awful.client.swap.byidx( -1)    end, 
        {description = "swap with previous client by index", group = "client"}
    ),

    awful.key({ modkey, "Control" }, "j", 
        function () awful.screen.focus_relative( 1) end,
        {description = "focus the next screen", group = "screen"}
    ),

    awful.key({ modkey, "Control" }, "h", 
        function () awful.screen.focus_relative(-1) end,
        {description = "focus the previous screen", group = "screen"}
    ),

    awful.key({ modkey, "Control" }, "l", 
        function () awful.screen.focus_relative(1) end,
        {description = "focus the next screen", group = "screen"}
    ),

    awful.key({ modkey}, "u", 
        awful.client.urgent.jumpto,
        {description = "jump to urgent client", group = "client"}
    ),

    awful.key({ modkey, }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "windows"}
    ),

    -- Standard program
    awful.key({ modkey }, "Return", 
        function () awful.spawn(terminal) end,
        {description = "open a terminal", group = "launcher"}
    ),

    awful.key({ modkey, "Shift" }, "w", 
        function () awful.spawn(browser) end,
        {description = "opens a browser", group = "launcher"}
    ),

    awful.key({ modkey, "Shift" }, "r", 
        awesome.restart,
        {description = "reload awesome", group = "awesome"}
    ),

    awful.key({ modkey, "Shift"   }, "e", 
        awesome.quit,
        {description = "quit awesome", group = "awesome"}
    ),

    -- Brightness 
    awful.key({ }, "XF86MonBrightnessUp", function () awful.util.spawn("brightnessctl s +10%") end),
    awful.key({ }, "XF86MonBrightnessDown", function () awful.util.spawn("brightnessctl s 10%-") end),

    -- Sound/Volume
    awful.key({ }, "XF86AudioRaiseVolume", function () awful.util.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%") end),
    awful.key({ }, "XF86AudioLowerVolume", function () awful.util.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%") end),
    awful.key({ }, "XF86AudioMute", function () awful.util.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle") end),

    --[[
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    --]]
    awful.key({ modkey, }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
        function ()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
              c:emit_signal(
                "request::activate", "key.unminimize", {raise = true}
              )
            end
        end,
        {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey }, "r",
        function () awful.screen.focused().mypromptbox:run() end,
        {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "d", 
        function() menubar.show() end,
        {description = "show the menubar", group = "launcher"}
    ),

    awful.key({ modkey }, "x",
        function ()
            awful.prompt.run {
              prompt       = "Run Lua code: ",
              textbox      = awful.screen.focused().mypromptbox.widget,
              exe_callback = awful.util.eval,
              history_path = awful.util.get_cache_dir() .. "/history_eval"
            }
        end,
        {description = "lua execute prompt", group = "awesome"}),

    -- Was clientkeys
    awful.key({ modkey }, "f",
        function ()
            local c = client.focus
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "windows"}),

    awful.key({ modkey, "Shift"   }, "q",      
        function () 
            local c = client.focus
            c:kill() 
        end,
        {description = "close", group = "client"}
    ),

    awful.key({ modkey, "Shift" }, "Return", 
        function () 
            local c = client.focus
            c:swap(awful.client.getmaster()) 
        end,
        {description = "move to master", group = "client"}
    ),

    awful.key({ modkey }, "o",
        function (c) c:move_to_screen() end,
        {description = "move to screen", group = "client"}
    )
)

--[[
clientkeys = gears.table.join(
    awful.key({ modkey }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "windows"}),

    awful.key({ modkey, "Shift"   }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Shift" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"})
)
--]]

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 10 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

root.keys(globalkeys)

