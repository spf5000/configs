local awful = require("awful")

-- Autostart applications
autorun = true
autorunApps =
{
  "nm-applet",
  "pasystray",
  "cbatticon",
}
if autorun then
  for app = 1, #autorunApps do
    awful.util.spawn(autorunApps[app])
  end
end


