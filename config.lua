Config = {}

Config.ESXnotify = true                  -- If set to false mythic_notify is used for notifications and if set to true ESX notifications are used.

Config.Item = 'depokit'                   -- Usable item
Config.KeyBind = 38                       -- Build/Dismantling depot and repair vehicle bind - https://docs.fivem.net/docs/game-references/controls/

Config.BuildTime = 5                      -- Build depot in sec
Config.FoldTime = 5                       -- Fold depot in sec

Config.Refuel = 60.0                      -- Refuelling value (0.0 - 100.0)
Config.RepairTime = 3                     -- Vehicle repair time in sec

Config.Locale = 'en'                      -- Language settings / Translation

Locales['cs'] = {
    ['repair_veh'] = 'Opravit vozidlo',
    ['fold_depo'] = 'Demontáz depa',
    ['start_fix'] = 'Opravujete vozidlo',
    ['fixed'] = 'Vozidlo opraveno',
}

Locales['pl'] = {
    ['repair_veh'] = 'Naprawić pojazd',
    ['fold_depo'] = 'Demontaż zajezdnia',
    ['start_fix'] = 'Naprawa pojazdu',
    ['fixed'] = 'Pojazd jest naprawiony',
}

Locales['en'] = {
    ['repair_veh'] = 'Repair the vehicle',
    ['fold_depo'] = 'Dismantling the depot',
    ['start_fix'] = 'Repairing your vehicle',
    ['fixed'] = 'The vehicle is repaired',
}