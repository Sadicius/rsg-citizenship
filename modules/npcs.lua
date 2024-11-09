local DistanceSpawn = 20.0
local FadeIn = true
local PlayerLocations = { {npccoords = vector4(-564.81, -3776.67, 238.60, 267.50), npcmodel = 'a_m_m_bivfancytravellers_01',} }

lib.locale()
local spawnedPeds = {}

local function NearNPC(npcmodel, npccoords, heading)
    local spawnedPed = CreatePed(npcmodel, npccoords.x, npccoords.y, npccoords.z - 1.0, heading, false, false, 0, 0)
    SetEntityAlpha(spawnedPed, 0, false)
    SetRandomOutfitVariation(spawnedPed, true)
    SetEntityCanBeDamaged(spawnedPed, false)
    SetEntityInvincible(spawnedPed, true)
    FreezeEntityPosition(spawnedPed, true)
    SetBlockingOfNonTemporaryEvents(spawnedPed, true)
    -- set relationship group between npc and player
    SetPedRelationshipGroupHash(spawnedPed, GetPedRelationshipGroupHash(spawnedPed))
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(spawnedPed), `PLAYER`)
    if FadeIn then
        for i = 0, 255, 51 do
            Wait(50)
            SetEntityAlpha(spawnedPed, i, false)
        end
    end

    return spawnedPed
end

CreateThread(function()
    for k,v in pairs(PlayerLocations) do
        local coords = v.npccoords
        local newpoint = lib.points.new({
            coords = coords,
            heading = coords.w,
            distance = DistanceSpawn,
            model = v.npcmodel,
            ped = nil,
            targetOptions = {
                {
                    name = 'citizenship_main_menu',
                    icon = 'fa-solid fa-eye',
                    label = locale('cl_lang_10'),
                    targeticon = 'fas fa-passport',
                    onSelect = function()
                        beginExam()
                    end,
                    canInteract = function(_, distance)
                        return distance < 4.0
                    end
                }
            }
        })

        newpoint.onEnter = function(self)
            if not self.ped then
                lib.requestModel(self.model, 10000)
                self.ped = NearNPC(self.model, self.coords, self.heading)

                pcall(function ()
                    -- exports['rsg-core']:DrawText('Press [ALT] Comenzar')
                    exports.ox_target:addLocalEntity(self.ped, self.targetOptions)
                end)
            end
        end

        newpoint.onExit = function(self)
            exports['rsg-core']:HideText()
            exports.ox_target:removeLocalEntity(self.ped, locale('cl_lang_10'))
            if self.ped and DoesEntityExist(self.ped) then
                if FadeIn then
                    for i = 255, 0, -51 do
                        Wait(50)
                        SetEntityAlpha(self.ped, i, false)
                    end
                end
                DeleteEntity(self.ped)
                self.ped = nil
            end
        end

        spawnedPeds[k] = newpoint
    end
end)

-- cleanup
AddEventHandler("onResourceStop", function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    for k, v in pairs(spawnedPeds) do
        exports['rsg-core']:HideText()
        exports.ox_target:removeLocalEntity(v.ped, locale('cl_lang_10'))
        if v.ped and DoesEntityExist(v.ped) then
            DeleteEntity(v.ped)
        end

        spawnedPeds[k] = nil
    end
end)