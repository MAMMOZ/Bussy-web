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
-- function getEgg()
--     local eggCount = 0
--     for i, v in pairs(result.Inventory.Misc) do
--         print(v.id)
--         if string.find(v.id, "^Huge") then
--             -- print(i,v.id)
--             -- return v.id
--             eggCount = eggCount + 1
--         end
--     end
--     return eggCount
-- end

-- Egg
function getEgg()
    local eggCount = 0
    if not (result and result.Inventory and type(result.Inventory.Egg) == "table") then
        print("Error: result.Inventory.Egg is nil or not a table")
        return 0  -- Return 0 since there are no eggs
    end

    for i, v in pairs(result.Inventory.Egg) do
        if string.find(v.id, "^Huge") then
            eggCount = eggCount + 1
        end
    end
    return eggCount
end





function sendRequest()
    local huge, huge_type = getpet()
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
            ["egg"] = getEgg()
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
