local P = {}
localconf = P

P.theme_path = os.getenv("HOME") .. '/.config/awesome/theme/theme.lua'
P.has_battery = true
P.battery = 'BAT0'
P.mwfact = 0.615

return localconf
