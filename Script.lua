-- [[ LAZEN V32 - MAIN SCRIPT (PASTEBIN) ]]
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local FIREBASE_URL = "https://lazen-rejoin-default-rtdb.asia-southeast1.firebasedatabase.app/keys"

-- 1. [ AUTHENTICATION SYSTEM ]
local function getHWID()
    return game:GetService("RbxAnalyticsService"):GetClientId()
end

local function checkLicense(key)
    if not key or key == "" or key == "ใส่คีย์ที่นี่" then
        player:Kick("\n❌ กรุณาใส่คีย์ในช่อง _G.AUTH_KEY\n(Please provide a key)")
        return false
    end

    local hwid = getHWID()
    local url = FIREBASE_URL .. "/" .. key .. ".json"
    
    -- ตรวจสอบคีย์
    local response
    local s, e = pcall(function()
        response = game:HttpGet(url)
    end)

    if not s or not response or response == "null" then
        player:Kick("\n❌ ไม่พบคีย์นี้ในฐานข้อมูล\n(Invalid Key)")
        return false
    end

    local data = HttpService:JSONDecode(response)
    local hwid_list = data.hwid_list or {}
    
    -- เช็ค HWID
    local isRegistered = false
    for _, v in pairs(hwid_list) do
        if v == hwid then isRegistered = true break end
    end

    if not isRegistered then
        if #hwid_list < 3 then
            table.insert(hwid_list, hwid)
            local updateUrl = FIREBASE_URL .. "/" .. key .. "/hwid_list.json"
            -- ใช้ request() ของ Executor เพื่อเขียนข้อมูล
            local req = (syn and syn.request) or (http and http.request) or http_request or request
            if req then
                req({
                    Url = updateUrl,
                    Method = "PUT",
                    Headers = {["Content-Type"] = "application/json"},
                    Body = HttpService:JSONEncode(hwid_list)
                })
                print("✅ Registered new device (" .. #hwid_list .. "/3)")
            else
                player:Kick("\n❌ ตัวรันไม่รองรับระบบลงทะเบียน (Missing request function)")
                return false
            end
        else
            player:Kick("\n❌ คีย์นี้ใช้ครบ 3 เครื่องแล้ว\n(Device limit reached 3/3)")
            return false
        end
    end
    return true
end

-- ตรวจสอบสิทธิ์ก่อนเริ่มรัน Autoplay
if not checkLicense(_G.AUTH_KEY) then return end
    









local entities = workspace:WaitForChild("Entities")
local player = game:GetService("Players").LocalPlayer
local pGui = player:WaitForChild("PlayerGui")
local code = game:GetService("ReplicatedStorage").Remotes.ClaimReward

local function getRemotes()
    local char = player.Character or player.CharacterAdded:Wait()
    local unitAction = char:WaitForChild("CharacterHandler"):WaitForChild("Remotes"):WaitForChild("UnitAction")
    local stageEndRemote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("StageEnd")
    local equip = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Units")
    return unitAction, stageEndRemote, equip
end
local Btn = game:GetService("Players").LocalPlayer.PlayerGui.GameHUD.VoteSkipFrame.BTNs.Yes
local Lighting = game:GetService("Lighting")
game:GetService("ReplicatedStorage").Remotes.TutorialUnitSelected:FireServer("Goku")
local function setBlackAndWhite()
    local colorCorrection = Lighting:FindFirstChild("BlackWhiteEffect") or Instance.new("ColorCorrectionEffect")
    colorCorrection.Name = "BlackWhiteEffect"
    colorCorrection.Saturation = -1 
    colorCorrection.Contrast = 0 
    colorCorrection.Parent = Lighting
end

local function disableShadows()
    Lighting.GlobalShadows = false 
    Lighting.Brightness = 2 
    Lighting.FogEnd = 9e9 
    for _, effect in pairs(Lighting:GetChildren()) do
        if effect:IsA("BlurEffect") or effect:IsA("SunRaysEffect") or effect:IsA("BloomEffect") then
            effect.Enabled = false
        end
    end
    Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    Lighting.Ambient = Color3.fromRGB(128, 128, 128)
end

setBlackAndWhite()
disableShadows()
local lvllb = game:GetService("Players").LocalPlayer.PlayerGui.Profile.Profile.RightList.Highest_DPS.Amnt.Text
 
local unitActionRemote, stageEndRemote, equipRemote = getRemotes()
_G.autocode = true
_G.autoplay = true
local giftCodes = _G.giftCodes or {} 


local positionunit = {
    Vector3.new(8.897756, 11.168432, 6.065472),
    Vector3.new(-7.414098, 11.202391, 6.985901),
    Vector3.new(-6.065681, 11.000000, -4.460190),
    Vector3.new(-5.807373, 11.001482, 5.486828),
	Vector3.new(-3.208645, 11.173594, 15.127435),
	Vector3.new(-14.439435, 10.999999, -0.342543),
	Vector3.new(-7.563638, 11.013908, -10.798132),
}



local sum = {"Special", true}
 
-- ตรวจสอบ Lobby
if workspace:FindFirstChild("Lobby") then
       
    local rewards = {"Weekly", "Monthly"}
    for _, rewardName in pairs(rewards) do
        local args = {rewardName, true}
        pcall(function()
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Daily"):FireServer(unpack(args))
            
            
        end)
        task.wait(0.5)
    end
   if lvllb <= "55000" then
	game:GetService("ReplicatedStorage").Remotes.RequestBannerSummon:InvokeServer(unpack(sum)) 
	
	print(8)
	task.wait(1)
    end
    
    local stage = pGui.Pods.MapSelection.Content.StageSelection.ScrollingFrame["Leaf Village"].ActsCleared
    local textValue = stage.Text
    local currentActs = tonumber(textValue:match("%d+"))  
    if currentActs and currentActs <= 1 then
	task.wait(3)
        local args = {"Create", "Leaf_Village", "Story", "1", false, "Normal"}
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Pod"):FireServer(unpack(args))
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Pod"):FireServer("Start")
    elseif currentActs and currentActs <= 2 then
        local args = {"Create", "Leaf_Village", "Story", "2", false, "Normal"}
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Pod"):FireServer(unpack(args))
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Pod"):FireServer("Start")
    elseif currentActs and currentActs <= 3 then
        local args = {"Create", "Leaf_Village", "Story", "3", false, "Normal"}
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Pod"):FireServer(unpack(args))
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Pod"):FireServer("Start")
    elseif currentActs and currentActs <= 4 then
        local args = {"Create", "Leaf_Village", "Story", "4", false, "Normal"}
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Pod"):FireServer(unpack(args))
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Pod"):FireServer("Start")
    elseif currentActs and currentActs <= 5 then
        local args = {"Create", "Leaf_Village", "Story", "5", false, "Normal"}
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Pod"):FireServer(unpack(args))
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Pod"):FireServer("Start")
    elseif currentActs and currentActs <= 6 then
        local args = {
            "Create",
            "Leaf_Village",
            "Story",
            "Infinite",
            false,
            "Normal"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Pod"):FireServer(unpack(args))
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Pod"):FireServer("Start")
    end
end

local function getInventoryDataSorted()
    local fullInventory = {}
    local listPath = pGui.UnitInventory.Inventory.Content.Units.UnitsListFrame.List
    local rarityScore = {
        ["Secret"] = 6, ["Mythic"] = 5, ["Legendary"] = 4,
        ["Epic"] = 3, ["Rare"] = 2, ["Uncommon"] = 1, ["Common"] = 0
    }
    for _, obj in pairs(listPath:GetChildren()) do
        if obj:IsA("Frame") or obj:IsA("ImageButton") then
            local guid = obj.Name 
            local uName = obj:GetAttribute("UnitName") or "Unknown"
            local uRarity = obj:GetAttribute("Rarity") or "Common"
            if guid ~= "ExtraInventory" and uName ~= "Sprintcart" and uName ~= "Bulla" then
                table.insert(fullInventory, {
                    Name = uName, GUID = guid, Rarity = uRarity, Score = rarityScore[uRarity] or 0
                })
            end
        end
    end
    table.sort(fullInventory, function(a, b) return a.Score > b.Score end)
    return fullInventory
end

-- ดึงข้อมูลตัวละครและใส่ทีม
local sortedUnits = getInventoryDataSorted()
local myTeamGUIDs = {}
local usedGUIDs = {}
local slotCount = 1

for _, unit in pairs(sortedUnits) do
    if slotCount > 6 then break end 
    if not usedGUIDs[unit.GUID] then
        table.insert(myTeamGUIDs, unit.GUID) -- เก็บไว้ใช้วางตัวละคร
        pcall(function()
            equipRemote:FireServer("Equip", tostring(slotCount), unit.GUID)
        end)
        usedGUIDs[unit.GUID] = true
        print(string.format("Slot %d: %s [%s]", slotCount, unit.Name, unit.Rarity))
        slotCount = slotCount + 1
        task.wait(0.5)
    end
end

local AutoSkipWaves= {
    "AutoSkipWaves",
    true
}

local DisableCameraShake = {
    "DisableCameraShake",
    true
}

local DisableVisualEffects= {
    "DisableVisualEffects",
    true
}

local LowDetailMode= {
    "LowDetailMode",
    true
}

local DisableEnemyTags= {
    "DisableEnemyTags",
    true
}


local DisableDamageIndicators= {
    "DisableDamageIndicators",
    true
}

local DisableUnitTags= {
    "DisableUnitTags",
    true
}


 






-- [[ 3. ระบบ Loop หลัก (ฉบับรวมสมบูรณ์) ]]
math.randomseed(tick())

task.spawn(function()
    while true do
	local inf = game:GetService("Players").LocalPlayer.PlayerGui.StageEnd.StageEnd.LHS.PlanetHolder.ActName.NameTitle.Text
local dfd = game:GetService("Players").LocalPlayer.PlayerGui.GameHUD.Story.Stage
    local story = tonumber(dfd.Text:match("%d+"))
	 local basehel = game:GetService("Players").LocalPlayer.PlayerGui.GameHUD.WaveFrame.NexusHealth.HealthLabel
     local Heltbase = tonumber(basehel.Text:match("%d+")) or 0
	 local wave = game:GetService("Players").LocalPlayer.PlayerGui.GameHUD.WaveFrame.WaveInfo.Waves.CurrentWave
        -- [ ส่วนที่ 1: ตรวจสอบสถานะ Lobby ]
        if workspace:FindFirstChild("Lobby") then
            if _G.autocode then
                pcall(function()
                    for _, giftCode in pairs(giftCodes) do
                        code:FireServer(giftCode)
                        task.wait(0.1)
                    end
                end)
            end

        -- [ ส่วนที่ 2: ตรวจสอบสถานะภายในแมพ ]
        elseif workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("TowerPlacement") then
            local Btn = game:GetService("Players").LocalPlayer.PlayerGui.GameHUD.VoteSkipFrame.BTNs.Yes
            firesignal(Btn.Activated)
            -- ระบบ Autoplay พื้นฐาน
            if _G.autoplay then
                local alertNames = {"NotificationsFrame", "Notifications", "WaveStartFrame", "AlertGui"}
                
                pcall(function()
                    -- 1. วางตัวละคร (สุ่มตำแหน่ง)
                    if #myTeamGUIDs > 0 then
                        local randomUnit = myTeamGUIDs[math.random(1, #myTeamGUIDs)]
                        local randomPos = positionunit[math.random(1, #positionunit)]
                        unitActionRemote:FireServer("Place", randomUnit, randomPos, 0)
                    end

                    -- 2. ลบมอนสเตอร์ (Clear Lag)
                    for _, monster in pairs(entities:GetChildren()) do
                        local isPlayerUnit = false
                        for _, u in pairs(sortedUnits) do
                            if string.find(monster.Name, u.Name) then 
                                isPlayerUnit = true 
                                break 
                            end
                        end
                        if not isPlayerUnit then 
                            monster:Destroy() 
                        end
                    end

                    -- 3. ปิดแจ้งเตือน UI
                    for _, uiName in pairs(alertNames) do
                        local targetUI = pGui:FindFirstChild(uiName, true)
                        if targetUI then
                            if targetUI:IsA("ScreenGui") then targetUI.Enabled = false 
                            else targetUI.Visible = false end
                        end
                    end

                    -- 4. อัปเกรดตัวละคร
                    for _, v in pairs(entities:GetChildren()) do
                        for _, u in pairs(sortedUnits) do
                            if string.find(v.Name, u.Name) then
                                unitActionRemote:FireServer("Upgrade", v, false)
                            end
                        end
                    end 
                end)
            end
            if story <= 5 then
				
                    stageEndRemote:FireServer("Next")
                
				
			elseif story == 6 then
			    stageEndRemote:FireServer("Lobby")
			end
            
            if inf and string.find(inf, "Act Infinite") then
                
                -- ขายตัวละครที่ Wave 16 (Story/Infinite Logic)
                if wave.Text == "16" then
                    pcall(function()
                        local currentSorted = getInventoryDataSorted()
                        local actionRemote = getRemotes() -- ดึง remote แรก (unitAction)
                        for _, v in pairs(entities:GetChildren()) do
                            for _, u in pairs(currentSorted) do
                                if string.find(v.Name, u.Name) then
                                    actionRemote:FireServer("Sell", v)
                                end
                            end
                        end
                    end)
                end
               
                                -- ตรวจสอบเลือดฐานเพื่อ Replay (พร้อม Delay 3 วินาที)
                if Heltbase  <= 1 then      
                    if not _G.Replaying then
                        _G.Replaying = true -- ล็อคป้องกันการทำงานซ้ำ
                        
                        print("Base  low. Waiting 3 seconds before Replay...")
                        task.wait(5) -- รอ 3 วินาทีก่อนกด Replay
                        
                        pcall(function()
                            stageEndRemote:FireServer("Replay")
                        end)
                        
                        print("Replay Sent.")
                        task.wait(5) -- Cooldown ป้องกันลูปทำงานซ้ำก่อนเปลี่ยนด่าน
                        _G.Replaying = false
                    end
                end
                
            end
            
        end

        task.wait(2) -- หน่วงเวลา Loop เพื่อลดภาระ CPU
    end
end)

if workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("TowerPlacement") then
	pcall(function ()
	    
		game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ChangeSetting"):FireServer(unpack(DisableCameraShake))
		game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ChangeSetting"):FireServer(unpack(AutoSkipWaves))
		game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ChangeSetting"):FireServer(unpack(DisableVisualEffects))
		game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ChangeSetting"):FireServer(unpack(LowDetailMode))
		game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ChangeSetting"):FireServer(unpack(DisableEnemyTags))
		game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ChangeSetting"):FireServer(unpack(DisableDamageIndicators))
		game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ChangeSetting"):FireServer(unpack(DisableUnitTags))
		print(8000)
	end)
end





