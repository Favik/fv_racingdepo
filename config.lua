Config = {}

Config.TriggerEventKick = true
Config.KickReason = "You've triggered the event more times than possible!"


Config.ESXnotify = true                   -- If set to false mythic_notify is used for notifications and if set to true ESX notifications are used.

Config.Item = 'depotkit'                  -- Usable item
Config.KeyBind = 38                       -- Build/Dismantling depot and repair vehicle bind (38 => E) - https://docs.fivem.net/docs/game-references/controls/

Config.BuildTime = 5                      -- Build depot in sec
Config.DismantTime = 5                    -- Dismant depot in sec

Config.Refuel = 60.0                      -- Refuelling value (0.0 - 100.0)
Config.RepairTime = 3                     -- Vehicle repair time in sec

Config.Locale = 'en'                      -- Language settings / Translation

Locales['cs'] = {
    ['repair_veh'] = 'Opravit vozidlo',
    ['dismant_depot'] = 'Demontáz depa',
    ['start_fix'] = 'Opravujete vozidlo',
    ['fixed'] = 'Vozidlo opraveno',
    ['out_veh'] = 'Musíš vystoupit z vozidla',
    ['cooldown'] = 'Chvíli počkejte jedno depo právě stavíte'
}

Locales['pl'] = {
    ['repair_veh'] = 'Naprawić pojazd',
    ['dismant_depot'] = 'Demontaż zajezdnia',
    ['start_fix'] = 'Naprawa pojazdu',
    ['fixed'] = 'Pojazd jest naprawiony',
    ['out_veh'] = 'Musisz wysiąść z pojazdu',
    ['cooldown'] = 'Chwileczkę, właśnie budujesz zajezdnię'
}

Locales['en'] = {
    ['repair_veh'] = 'Repair the vehicle',
    ['dismant_depot'] = 'Dismantling the depot',
    ['start_fix'] = 'Repairing your vehicle',
    ['fixed'] = 'The vehicle is repaired',
    ['out_veh'] = 'You must get out of the vehicle',
    ['cooldown'] = 'Wait a minute, you are currently building a depot'
}