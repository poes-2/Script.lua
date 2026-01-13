-- ตรวจสอบว่า HttpService ถูกบล็อกหรือไม่
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ลิงก์ Ngrok ของคุณ (แก้ไขให้ถูกต้อง)
local API_URL = "https://maniform-plaguily-keven.ngrok-free.dev/update" 

local function sendDataToHost()
    -- ใช้ pcall เพื่อป้องกันเกมค้างถ้าส่งไม่ผ่าน
    local success, result = pcall(function()
        -- เช็คชื่อโฟลเดอร์เก็บข้อมูล (ลองเปลี่ยนจาก "Data" เป็น "leaderstats" ถ้าไม่ขึ้น)
        local dataFolder = LocalPlayer:FindFirstChild("Data") or LocalPlayer:FindFirstChild("leaderstats")
        
        if not dataFolder then
            return "Folder not found"
        end

        -- ดึงค่ามาเตรียมส่ง
        local payload = {
            ["player_name"] = LocalPlayer.Name,
            ["level"]       = tostring(dataFolder:FindFirstChild("Level") and dataFolder.Level.Value or "0"),
            ["beli"]        = tostring(dataFolder:FindFirstChild("Beli") and dataFolder.Beli.Value or "0"),
            ["fruit"]       = tostring(dataFolder:FindFirstChild("DevilFruit") and dataFolder.DevilFruit.Value or "None"),
            ["race"]        = tostring(dataFolder:FindFirstChild("Race") and dataFolder.Race.Value or "None")
        }

        -- ส่งข้อมูล (ใช้ฟังก์ชันมาตรฐานที่ Executor ทั่วไปรองรับ)
        if request then -- สำหรับ Executor บางตัวที่ใช้ฟังก์ชัน request()
            return request({
                Url = API_URL,
                Method = "POST",
                Headers = { ["Content-Type"] = "application/json" },
                Body = HttpService:JSONEncode(payload)
            })
        else -- สำหรับ Executor ปกติ
            return HttpService:PostAsync(API_URL, HttpService:JSONEncode(payload), Enum.HttpContentType.ApplicationJson)
        end
    end)

    if success then
        print("✅ ข้อมูลส่งไปถึงหน้าเว็บแล้ว!")
    else
        warn("❌ ส่งไม่สำเร็จ: " .. tostring(result))
    end
end

-- เริ่มทำงาน
print("🚀 ระบบกำลังเริ่มเชื่อมต่อกับคอมพิวเตอร์ของคุณ...")
while true do
    sendDataToHost()
    task.wait(5)
end
