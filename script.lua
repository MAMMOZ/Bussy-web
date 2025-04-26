repeat wait() until game:IsLoaded()
repeat task.wait() until game:GetService("Players").LocalPlayer
repeat task.wait() until game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")
repeat task.wait() until game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main")

task.wait(160)

local __script__host = "http://110.164.203.137:3000"
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local saveModule = require(game:GetService("ReplicatedStorage").Library.Client.Save)
local result = saveModule.Get()
-- สถานะไอดี
-- ไอดี
-- Rank
-- Rebirth
-- จำนวนเพชร
-- จำนวนตัวยักษ์
-- จำนวนไอเท็มอื่นๆรอนึกได้ Inventory

-- Rank
local Rank = result.Rank
local Rebirths = result.Rebirths

-- PET
-- local pet = result.Inventory.Pet
-- for i, v in pairs(pet) do
--     if string.find(v.id, "^Huge") then
--         print(v.id)
--         print(v._am)
--         hugeCount = hugeCount + 1
--     end
-- end

function getpet()
    local petTable = {}
    local hugeCount = 0
    local pet = result.Inventory.Pet

    for _, v in pairs(pet) do
        local found = "None"
        local found_sh = false

        for j, k in pairs(v) do
            if string.find(v.id, "^Huge") then
                if j == "pt" and k == 1 then
                    found = "Gold"
                elseif j == "pt" and k == 2 then
                    found = "Rainbow"
                elseif j == "sh" then
                    found_sh = true
                end
            end
        end

        if string.find(v.id, "^Huge") then
            table.insert(petTable, { type = found, sh = found_sh, id = v.id })
            hugeCount = hugeCount + 1
        end
    end
    return petTable, hugeCount
end


-- for _, petData in ipairs(petTable) do
--     print(petData.type, petData.id)
-- end


-- Diamonds
function getDia()
    local GetSave = function()
            return require(game.ReplicatedStorage.Library.Client.Save).Get()
    end

    for i, v in pairs(GetSave().Inventory.Currency) do
        if v.id == "Diamonds" then
            -- print(i,v._am)
            return v._am
        end
    end
end

-- Inventory
function getInventory()
    local inventoryItems = {
        ["Rainbow Mini Chest"] = 0,
        ["Charm Stone"] = 0,
        ["Mini Chest"] = 0,
        ["Diamond Gift Bag"] = 0,
        ["Secret Key"] = 0,
        ["Secret Key Upper Half"] = 0,
        ["Void Key"] = 0,
        ["Void Key Upper Half"] = 0,
        ["Tech Key"] = 0,
        ["Tech Key Upper Half"] = 0,
        ["Crystal Key"] = 0,
        ["Crystal Key Upper Half"] = 0,
        ["Arcade Token"] = 0,
        ["Insta Plant Capsule"] = 0,
        ["Large Gift Bag"] = 0,
        ["Gift Bag"] = 0,
        ["Void Spinny Wheel Ticket"] = 0,
        ["Tech Spinny Wheel Ticket"] = 0,
        ["Spinny Wheel Ticket"] = 0,
        ["Seed Bag"] = 0,
        ["Diamond Seed"] = 0
    }

    for _, v in pairs(result.Inventory.Misc) do
        for key in pairs(inventoryItems) do
            if v.id == key then  -- แก้จาก string.match เป็นการเช็คค่าตรง ๆ
                inventoryItems[key] = v._am
            end
        end
    end

    return inventoryItems
end


-- Egg
function getEgg()
    local eggCount = 0
    if not (result and result.Inventory and type(result.Inventory.Egg) == "table") then
        print("Error: result.Inventory.Egg is nil or not a table")
        return 0  -- Return 0 since there are no eggs
    end

    for i, v in pairs(result.Inventory.Egg) do
        -- if string.find(v.id, "^Huge") or string.find(v.id, "^Gargantuan") then
            eggCount = eggCount + 1
        -- end
    end
    return eggCount
end





function sendRequest()
    local huge, huge_type = getpet()
    local inventory = getInventory()

    local res = request({
        Url = __script__host .. "/addbot", -- ปรับ URL ให้ถูกต้อง
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = HttpService:JSONEncode({
            ["account"] = LocalPlayer.Name,
            ["rank"] = Rank,
            ["Rebirth"] = Rebirths,
            ["gem"] = getDia(),
            ["huge"] = huge,
            ["huge_type"] = huge_type,
            ["egg"] = getEgg(),
            ["Rainbow_Mini_Chest"] = inventory["Rainbow Mini Chest"] or 0,
            ["Charm_Stone"] = inventory["Charm Stone"] or 0,
            ["Mini_Chest"] = inventory["Mini Chest"] or 0,
            ["Diamond_Gift_Bag"] = inventory["Diamond Gift Bag"] or 0,
            ["Secret_Key"] = inventory["Secret Key"] or 0,
            ["Secret_Key_Upper_Half"] = inventory["Secret Key Upper Half"] or 0,
            ["Void_Key"] = inventory["Void Key"] or 0,
            ["Void_Key_Upper_Half"] = inventory["Void Key Upper Half"] or 0,
            ["Tech_Key"] = inventory["Tech Key"] or 0,
            ["Tech_Key_Upper_Half"] = inventory["Tech Key Upper Half"] or 0,
            ["Crystal_Key"] = inventory["Crystal Key"] or 0,
            ["Crystal_Key_Upper_Half"] = inventory["Crystal Key Upper Half"] or 0,
            ["Arcade_Token"] = inventory["Arcade Token"] or 0,
            ["Insta_Plant_Capsule"] = inventory["Insta Plant Capsule"] or 0,
            ["Large_Gift_Bag"] = inventory["Large Gift Bag"] or 0,
            ["Gift_Bag"] = inventory["Gift Bag"] or 0,
            ["Void_Spinny_Wheel_Ticket"] = inventory["Void Spinny Wheel Ticket"] or 0,
            ["Tech_Spinny_Wheel_Ticket"] = inventory["Tech Spinny Wheel Ticket"] or 0,
            ["Spinny_Wheel_Ticket"] = inventory["Spinny Wheel Ticket"] or 0,
            ["Seed_Bag"] = inventory["Seed Bag"] or 0,
            ["Diamond_Plant_Seed"] = inventory["Diamond Seed"] or 0
        })
    })
   warn(res.Body)
end

task.spawn(function()
    while true do
        print("mammozzz")
        print(LocalPlayer.DisplayName)
        sendRequest()
        -- if not x then warn(p) end
        task.wait(getgenv().time_m)
    end
end)
