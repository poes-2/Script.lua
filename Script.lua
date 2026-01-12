local HttpService = game:GetService("HttpService")
local player = game.Players.LocalPlayer
local data = player.Data
local backpack = player.Backpack --

local URL = "https://b8c57f00-6777-466d-af24-5995a7db0f38-00-2clf2cbn9f528.pike.replit.dev/"

function updateToWeb()
    local myItems = {}
    -- ดึงรายชื่อดาบจาก Backpack (อ้างอิงจาก DEX Explorer ของคุณ)
    for _, item in pairs(backpack:GetChildren()) do
        if item:IsA("Tool") then
            table.insert(myItems, item.Name)
        end
    end

    local payload = {
        username = player.Name,
        level = data.Level.Value, --
        money = data.Beli.Value, --
        fruit = data.DevilFruit.Value, --
        items = myItems -- รายชื่อดาบทั้งหมดที่ถืออยู่
    }

    pcall(function()
        request({
            Url = URL,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode(payload)
        })
    end)
end

-- อัปเดตทุก 10 วินาที
spawn(function()
    while true do
        updateToWeb()
        task.wait(10)
    end
end)
