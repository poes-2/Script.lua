local HttpService = game:GetService("HttpService")
local player = game.Players.LocalPlayer

-- ตรวจสอบโฟลเดอร์ข้อมูลในเกม (รองรับทั้งแมพทั่วไปและแมพยอดนิยม)
local data = player:FindFirstChild("Data") or player:FindFirstChild("leaderstats")

-- 1. ข้อมูลพื้นฐานของผู้เล่น
local userId = player.UserId
local username = player.Name
local displayName = player.DisplayName
local profileLink = "https://www.roblox.com/users/" .. userId .. "/profile"
local avatarThumbnail = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. userId .. "&width=420&height=420&format=png"

-- 2. ข้อมูล Package/Client (สำหรับแสดงผล)
local clientPackage = "com.roblox.client"

-- ⚠️ ตรวจสอบ URL Webhook ให้ถูกต้อง (ถ้ามีช่องว่างหน้า-หลังให้ลบออกด้วย)
local WEBHOOK_URL = "https://discord.com/api/webhooks/1460479646519922790/1aVywpjKNzgAxe7CWZcekv5gwrN34x7oGarXaJ9XjRSYCEQrElarZx3dgN7FDCQv0JKr" 

function sendToWebhook()
    -- 3. ดึงรายชื่อ UI (ScreenGui) ที่รันอยู่
    local uiList = {}
    for _, gui in pairs(player.PlayerGui:GetChildren()) do
        if gui:IsA("ScreenGui") and gui.Enabled then
            table.insert(uiList, "`" .. gui.Name .. "`")
        end
    end
    local uiString = #uiList > 0 and table.concat(uiList, ", ") or "ไม่พบ UI"

    -- 4. สร้างข้อมูลสำหรับส่งไป Discord
    local payload = {
        ["embeds"] = {{
            ["title"] = "👤 ข้อมูล Client ผู้เล่น",
            ["description"] = "ลิงก์โปรไฟล์: [" .. username .. "](" .. profileLink .. ")",
            ["color"] = 0x3498db, -- สีน้ำเงิน Sky Blue
            ["thumbnail"] = { ["url"] = avatarThumbnail },
            ["fields"] = {
                {["name"] = "📛 Display Name", ["value"] = displayName, ["inline"] = true},
                {["name"] = "🆔 Username", ["value"] = username, ["inline"] = true},
                {["name"] = "🔢 User ID", ["value"] = "`" .. tostring(userId) .. "`", ["inline"] = true},
                
                {["name"] = "🆙 Level", ["value"] = (data and data:FindFirstChild("Level")) and tostring(data.Level.Value) or "N/A", ["inline"] = true},
                {["name"] = "💰 Beli/Money", ["value"] = (data and data:FindFirstChild("Beli")) and tostring(data.Beli.Value) or "N/A", ["inline"] = true},
                
                {["name"] = "📱 Package", ["value"] = "`" .. clientPackage .. "`", ["inline"] = false},
                {["name"] = "🖥️ Active UIs", ["value"] = uiString, ["inline"] = false}
            },
            ["footer"] = {["text"] = "ส่งข้อมูลเมื่อ: " .. os.date("%X")}
        }}
    }

    -- 5. ส่งข้อมูลผ่านฟังก์ชันพิเศษของ Executor (ข้ามข้อจำกัด Server)
    local requestFunc = syn and syn.request or http_request or request or (http and http.request)

    if requestFunc then
        local success, response = pcall(function()
            return requestFunc({
                Url = WEBHOOK_URL,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = HttpService:JSONEncode(payload)
            })
        end)

        if success then
            print("✅ ส่งข้อมูล " .. username .. " สำเร็จ!")
        else
            warn("❌ ส่งข้อมูลไม่สำเร็จ: " .. tostring(response))
        end
    else
        warn("❌ Executor นี้ไม่รองรับการส่ง HTTP Request")
    end
end

-- สั่งทำงาน
sendToWebhook()
