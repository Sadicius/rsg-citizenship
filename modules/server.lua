local RSGCore = exports['rsg-core']:GetCoreObject()
lib.locale()

local function GetIdentifier(id)
    local Player = RSGCore.Functions.GetPlayer(id)
    return Player.PlayerData.citizenid
end

local success, result = pcall(MySQL.scalar.await, 'SELECT 1 FROM stevo_citizenship')

if not success then
    MySQL.query([[CREATE TABLE IF NOT EXISTS `stevo_citizenship` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `citizen` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `citizen` (`citizen`)
    )]])
    if Config.Debug then print('[Stevo Scripts] Deployed database table for stevo_citizenship') end
end

lib.callback.register('stevo_citizenship:checkCitizenship', function(source)
    local identifier = GetIdentifier(source)
    local isCitizen = false
    local row = MySQL.single.await('SELECT * FROM `stevo_citizenship` WHERE `citizen` = ? LIMIT 1', { identifier })
    if row then isCitizen = true end
    return isCitizen
end)

lib.callback.register('stevo_citizenship:addCitizenship', function(source)
    local identifier = GetIdentifier(source)
    local id = MySQL.insert.await('INSERT INTO `stevo_citizenship` (citizen) VALUES (?)', { identifier })
    return id
end)