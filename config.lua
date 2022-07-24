Config = {}

Config.ESXnotify = true                   -- If set to false mythic_notify is used for notifications and if set to true ESX notifications are used.

Config.Item = 'depokit'                   -- Usable item
Config.KeyBind = 38                       -- Build/fold depot and repair vehicle bind - https://docs.fivem.net/docs/game-references/controls/

Config.BuildTime = 5                      -- Build depot in sec
Config.FoldTime = 5                       -- Fold depot in sec

Config.Refuel = 60.0                      -- Refuelling value (0.0 - 100.0)
Config.FixTime = 3

Config.Locale = 'en'                      -- Language settings / Translation

Locales['cs'] = {
    ['start_fix'] = 'Opravujete vozidlo',
    ['fixed'] = 'Vozidlo opraveno',
}

Locales['pl'] = {
    ['start_fix'] = 'Naprawa pojazdu',
    ['fixed'] = 'Pojazd jest naprawiony',
}

Locales['en'] = {
    ['start_fix'] = 'Repairing your vehicle',
    ['fixed'] = 'The vehicle is repaired',
}