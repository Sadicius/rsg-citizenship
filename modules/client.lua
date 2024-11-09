
local RSGCore = exports['rsg-core']:GetCoreObject()
lib.locale()

function hasPlyLoaded()
    return LocalPlayer.state.isLoggedIn
end

local examCompleted = false

-- Utility function to notify the user
local function notifyUser(message, messageType)
    lib.notify({ title = message, type = messageType })
end

-- Utility function to handle screen fading
local function fadeScreenIn(duration)
    DoScreenFadeIn(duration or 1000)
end

local function fadeScreenOut(duration)
    DoScreenFadeOut(duration or 500)
end

-- Utility function to set player coordinates and heading
local function setPedCoords(ped, coords, heading)
    SetEntityCoords(ped, coords.x, coords.y, coords.z, 1, 0, 0, 1)
    SetEntityHeading(ped, heading)
end

-- Function to begin the exam
function beginExam()
    local ped = PlayerPedId()
    if not ped then return end

    local alert = lib.alertDialog({
        header = locale('cl_lang_4'),
        content = locale('cl_lang_5'),
        centered = true,
        cancel = true,
        labels = {
            confirm = locale('cl_lang_5_a'),
            cancel = locale('cl_lang_5_b')
        }
    })

    if alert == 'cancel' then return end

    local score = 0
    for _, question in ipairs(Config.Questions) do
        local options = {}
        for _, option in ipairs(question.options) do
            table.insert(options, {type = 'checkbox', label = option.label})
        end
        local input = lib.inputDialog(question.title, options)
        if not input then
            notifyUser(locale('cl_lang_5_c'), 'error')
            return
        end
        for i, answer in ipairs(input) do
            if answer and question.options[i].correct then
                score = score + 1
            end
        end
    end

    if score >= Config.PassingScore then
        lib.alertDialog({
            header = locale('cl_lang_6'),
            content = locale('cl_lang_7'),
            centered = true,
            cancel = false,
            labels = {
                confirm = locale('cl_lang_7_a'),
                cancel = locale('cl_lang_5_b')
            }
        })
        lib.callback.await('stevo_citizenship:addCitizenship', false)
        examCompleted = true
        fadeScreenOut(800)
        Wait(800)
        setPedCoords(ped, Config.completionCoords, Config.completionCoords.h)
        Wait(500)
        fadeScreenIn(1000)
    else
        lib.alertDialog({
            header = locale('cl_lang_8'),
            content = locale('cl_lang_9'),
            centered = true,
            cancel = false,
            labels = {
                confirm = locale('cl_lang_5_b'),
                cancel = locale('cl_lang_5_b')
            }
        })
    end
end

-- Function to handle citizenship escape
local function escapeCitizenship()
    if examCompleted then exports['rsg-core']:HideText() return end -- lib.hideTextUI()

    fadeScreenOut(500)
    FreezeEntityPosition(cache.ped, true)
    Wait(800)
    setPedCoords(cache.ped, Config.spawnCoords, Config.spawnCoords.h)
    FreezeEntityPosition(cache.ped, false)
    fadeScreenIn(1000)
    notifyUser(locale('cl_lang_2'), 'info')

end

-- Function to load citizenship interactions
local function loadCitizenship()
    fadeScreenOut(500)
    FreezeEntityPosition(cache.ped, true)
    Wait(800)
    setPedCoords(cache.ped, Config.spawnCoords, Config.spawnCoords.h)

    -- loadInteractions()
    lib.alertDialog({
        header = locale('cl_lang_9_a'),
        content = locale('cl_lang_9_b'),
        centered = true,
        cancel = false,
        labels = {
            confirm = locale('cl_lang_5_a'),
            cancel = locale('cl_lang_5_b')
        }
    })

    local citizenZone = lib.zones.box({
        name = "citizenZone",
        coords = Config.citizenZone.coords,
        size = Config.citizenZone.size,
        rotation = Config.citizenZone.rotation,
    })

    function citizenZone:onExit(self)
        if examCompleted then
            citizenZone:remove()
            exports['rsg-core']:HideText()
            return
        end
        escapeCitizenship()
    end

    FreezeEntityPosition(cache.ped, false)
    fadeScreenIn(1000)
    notifyUser(locale('cl_lang_1'), 'info')
end

-- Function to check if the player is a citizen on load
local function OnPlayerLoaded()
    local isCitizen = lib.callback.await('stevo_citizenship:checkCitizenship', false)
    if not isCitizen then
        loadCitizenship()
    end
end

RegisterNetEvent('RSGCore:Client:OnPlayerLoaded', function()
    OnPlayerLoaded()
end)

-- Event handler for resource start
AddEventHandler('onResourceStart', function(resourceName)
    local r = GetCurrentResourceName()
    if r ~= resourceName then return end
    OnPlayerLoaded()
end)