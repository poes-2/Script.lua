local HttpService = game:GetService("HttpService")
local player = game.Players.LocalPlayer

-- ตรวจสอบโฟลเดอร์ข้อมูล (พยายามหาทั้ง Data และ leaderstats)
local data = player:FindFirstChild("Data") or player:FindFirstChild("leaderstats")

-- ข้อมูลพื้นฐานของผู้เล่น
local userId = player.UserId
local username = player.Name
local displayName = player.DisplayName
local profileLink = "https://www.roblox.com/users/" .. userId .. "/profile"
local avatarThumbnail = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. userId .. "&width=420&height=420&format=png"

-- ⚠️ แก้ไข: ใส่ URL Webhook ของคุณตรงนี้
local WEBHOOK_URL = "https://discord.com/api/webhooks/1460479646519922790/1aVywpjKNzgAxe7CWZcekv5gwrN34x7oGarXaJ9XjRSYCEQrElarZx3dgN7FDCQv0JKr" 

function sendToWebhook()
    -- ดึงรายชื่อ UI ที่กำลังเปิดใช้งาน (Active)
    local uiList = {}
    for _, gui in pairs(player.PlayerGui:GetChildren()) do
        if gui:IsA("ScreenGui") and gui.Enabled then
            table.insert(uiList, "`" .. gui.Name .. "`")
        end
    end
    local uiString = #uiList > 0 and table.concat(uiList, ", ") or "ไม่พบ UI ที่เปิดอยู่"

    -- สร้างตาราง Payload สำหรับ Discord Embed
    local payload = {
        ["embeds"] = {{
            ["title"] = "👤 ข้อมูลผู้เล่นแบบละเอียด",
            ["description"] = "[คลิกเพื่อดูโปรไฟล์ของ " .. username .. "](" .. profileLink .. ")",
            ["color"] = 3447003, -- สีน้ำเงิน
            ["thumbnail"] = { ["url"] = avatarThumbnail },
            ["fields"] = {
                {["name"] = "📛 Display Name", ["value"] = displayName, ["inline"] = true},
                {["name"] = "🆔 Username", ["value"] = username, ["inline"] = true},
                {["name"] = "🔢 User ID", ["value"] = "`" .. tostring(userId) .. "`", ["inline"] = true},
                
                -- ตรวจสอบว่ามีข้อมูล Level/Beli หรือไม่ ถ้าไม่มีให้ใส่ N/A
                {["name"] = "🆙 Level", ["value"] = (data and data:FindFirstChild("Level")) and tostring(data.Level.Value) or "N/A", ["inline"] = true},
                {["name"] = "💰 Beli", ["value"] = (data and data:FindFirstChild("Beli")) and tostring(data.Beli.Value) or "N/A", ["inline"] = true},
                
                {["name"] = "📱 Client/Package", ["value"] = "`com.roblox.client`", ["inline"] = false},
                {["name"] = "🖥️ Active UIs", ["value"] = uiString, ["inline"] = false}
            },
            ["footer"] = {["text"] = "ดึงข้อมูลเมื่อ: " .. os.date("%X")}
        }}
    }

    -- ฟังก์ชันส่งข้อมูลที่รองรับ Executor ส่วนใหญ่ (request, http_request)
    local requestFunc = syn and syn.request or http_request or request or (http and http.request)

    if requestFunc then
        local success, err = pcall(function()
            requestFunc({
                Url = WEBHOOK_URL,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = HttpService:JSONEncode(payload)
            })
        end)
        
        if success then
            print("✅ ส่งข้อมูล " .. username .. " ไปยัง Discord เรียบร้อยแล้ว!")
        else
            warn("❌ เกิดข้อผิดพลาดขณะส่ง: " .. tostring(err))
        end
    else
        warn("❌ Executor ของคุณไม่รองรับฟังก์ชันส่ง HTTP Request")
    end
end

-- สั่งรันฟังก์ชัน
sendToWebhook()
