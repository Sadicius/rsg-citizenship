Config = {}
Config.Debug = false

Config.PassingScore = 4 -- Amount of correct questions required to get citizenship.

-- DO NOT MODIFY UNLESS YOU ARE GOING TO MODIFY citizenZone
Config.spawnCoords = vec4(-558.84, -3778.55, 238.60, 0.09)--  -368.58, 732.12, 116.18, 355.90
Config.examCoords = vec3(-564.81, -3776.67, 238.60) -- vec3(-368.58, 732.12, 116.18)
Config.completionCoords = vec4(-169.47, 629.38, 114.03, 236.72)

Config.citizenZone = { -- Can be created through /zone box
    coords = vec3(-559.77, -3775.15, 238.60),
    size = vec3(30.0, 20.0, 6.5),
    rotation = 5.0
}

lib.locale()
Config.Questions = {
    {
        title = locale('cl_lang_12'),
        allowCancel = false,
        options = {
            {label = locale('cl_lang_13'), correct = false},
            {label = locale('cl_lang_14'), correct = true},
            {label = locale('cl_lang_15'), correct = false},
        }
    },
    {
        title = locale('cl_lang_16'),
        allowCancel = false,
        options = {
            {label = locale('cl_lang_17'), correct = false},
            {label = locale('cl_lang_18'), correct = false},
            {label = locale('cl_lang_19'), correct = true},
        }
    },
    {
        title = locale('cl_lang_20'),
        options = {
            {label = locale('cl_lang_21'), correct = false},
            {label = locale('cl_lang_22'), correct = true},
            {label = locale('cl_lang_23'), correct = false},
        }
    },
    {
        title = locale('cl_lang_24'),
        allowCancel = false,
        options = {
            {label = locale('cl_lang_25'), correct = true},
            {label = locale('cl_lang_26'), correct = false},
            {label = locale('cl_lang_27'), correct = false},
        }
    },
    {
        title = locale('cl_lang_28'),
        options = {
            {label = locale('cl_lang_29'), correct = false},
            {label = locale('cl_lang_30'), correct = true},
            {label = locale('cl_lang_31'), correct = false},
        }
    },
    {
        title = locale('cl_lang_32'),
        allowCancel = false,
        options = {
            {label = locale('cl_lang_33'), correct = true},
            {label = locale('cl_lang_34'), correct = false},
            {label = locale('cl_lang_35'), correct = false},
        }
    },
    {
        title = locale('cl_lang_36'),
        allowCancel = false,
        options = {
            {label = locale('cl_lang_37'), correct = true},
            {label = locale('cl_lang_38'), correct = false},
            {label = locale('cl_lang_39'), correct = false},
        }
    },
    {
        title = locale('cl_lang_40'),
        allowCancel = false,
        options = {
            {label = locale('cl_lang_41'), correct = false},
            {label = locale('cl_lang_42'), correct = true},
            {label = locale('cl_lang_43'), correct = false},
        }
    },
    {
        title = locale('cl_lang_44'),
        allowCancel = false,
        options = {
            {label = locale('cl_lang_45'), correct = false},
            {label = locale('cl_lang_46'), correct = false},
            {label = locale('cl_lang_47'), correct = true},
        }
    },
    {
        title = locale('cl_lang_48'),
        allowCancel = false,
        options = {
            {label = locale('cl_lang_49'), correct = false},
            {label = locale('cl_lang_50'), correct = true},
            {label = locale('cl_lang_51'), correct = false},
        }
    }
}