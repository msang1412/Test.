getgenv().safig = {
    AutoChooseTeam = true,
    Team = "Pirates"
}

local function setTeam(teamName)
    local CommF = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_")
    pcall(function()
        CommF:InvokeServer("SetTeam", teamName)
    end)
end

task.spawn(function()
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    repeat task.wait() until game:IsLoaded()
    if getgenv().safig.AutoChooseTeam and not player.Character then
        repeat
            task.wait(0.5)
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            if ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CommF_") then
                setTeam(getgenv().safig.Team)
            end
        until player.Character or player.CharacterAdded:Wait()
    end
end)

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local FolderPath = "Smurf Cat Hub"
if not isfolder(FolderPath) then makefolder(FolderPath) end

local CurrentAcc = LocalPlayer.Name
local AccountFile = FolderPath.."/"..CurrentAcc..".json"

local function SaveAccount(data)
    writefile(AccountFile, HttpService:JSONEncode(data))
end

local function LoadAccount()
    if isfile(AccountFile) then
        return HttpService:JSONDecode(readfile(AccountFile))
    end
    return {}
end

local AccountData = LoadAccount()

local WazureV1 = loadstring(game:HttpGet("https://raw.githubusercontent.com/msang1412/Test./refs/heads/main/klsang.luau.txt"))()
WazureV1:Notify({
    Title = "Saki-Hub",
    Content = "Loading...",
    Logo = "rbxassetid://108593743519357",
    Time = 0.5,
    Delay = 3
})

task.wait(3)

local WazureGui = WazureV1:Start({
    Name = "Smurf Cat Hub",
    ["Logo Player"] = "rbxassetid://105621680321389",
    ["Name Player"] = "anonymous",
    ["Tab Width"] = 120,
    ["Color"] = Color3.fromRGB(6, 141, 234),
    ["Custom Toggle"] = false,
    ["CloseCallBack"] = function() end
})

local ShopTab = WazureGui:MakeTab("Shop")
local StatusAndServerTab = WazureGui:MakeTab("Status And Server")
local MainFarmTab = WazureGui:MakeTab("Main Farm")
local SubFarmingTab = WazureGui:MakeTab("Sub Farming")
local SettingTab = WazureGui:MakeTab("Setting")

local joinTime = tick()
local StatusLabel = StatusAndServerTab:MakeLabel("Time in server: 00:00:00")

task.spawn(function()
    while task.wait(1) do
        local elapsed = tick() - joinTime
        local h, m, s = math.floor(elapsed / 3600), math.floor((elapsed % 3600) / 60), math.floor(elapsed % 60)
        StatusLabel:Set(string.format("Time in server: %02d:%02d:%02d", h, m, s))
    end
end)

local function safeFind(path, name)
    local ok, result = pcall(function()
        return path:FindFirstChild(name)
    end)
    return ok and result ~= nil
end

local function setLabel(label, text)
    pcall(function()
        label:Set(text)
    end)
end

local MirageLabel = StatusAndServerTab:MakeLabel("Mirage Island: Checking...")
local KitsuneLabel = StatusAndServerTab:MakeLabel("Kitsune Island: Checking...")
local PrehistoricLabel = StatusAndServerTab:MakeLabel("Prehistoric Island: Checking...")
local FrozenLabel = StatusAndServerTab:MakeLabel("Frozen Dimension: Checking...")
local CakePrinceLabel = StatusAndServerTab:MakeLabel("Cake Prince: Checking...")
local RipIndraLabel = StatusAndServerTab:MakeLabel("Rip_Indra: Checking...")
local DoughKingLabel = StatusAndServerTab:MakeLabel("Dough King: Checking...")
local EliteLabel = StatusAndServerTab:MakeLabel("Elite Hunter: Checking...")
local MoonLabel = StatusAndServerTab:MakeLabel("Full Moon: Checking...")
local SwordLabel = StatusAndServerTab:MakeLabel("Legendary Sword: Checking...")
local BoneLabel = StatusAndServerTab:MakeLabel("Bone: Checking...")

task.spawn(function()
    local prev = ""
    while task.wait(1) do
        local found = safeFind(game.Workspace._WorldOrigin.Locations, "Mirage Island")
        local curr = found and "🟢" or "🔴"
        if curr ~= prev then
            setLabel(MirageLabel, "Mirage Island: " .. curr)
            prev = curr
        end
    end
end)

task.spawn(function()
    local prev = ""
    while task.wait(1) do
        local found = safeFind(game.Workspace.Map, "KitsuneIsland")
        local curr = found and "🟢" or "🔴"
        if curr ~= prev then
            setLabel(KitsuneLabel, "Kitsune Island: " .. curr)
            prev = curr
        end
    end
end)

task.spawn(function()
    local prev = ""
    while task.wait(1) do
        local found = safeFind(game.Workspace._WorldOrigin.Locations, "Prehistoric Island")
        local curr = found and "🟢" or "🔴"
        if curr ~= prev then
            setLabel(PrehistoricLabel, "Prehistoric Island: " .. curr)
            prev = curr
        end
    end
end)

task.spawn(function()
    local prev = ""
    while task.wait(1) do
        local found = safeFind(game.Workspace._WorldOrigin.Locations, "Frozen Dimension")
        local curr = found and "🟢" or "🔴"
        if curr ~= prev then
            setLabel(FrozenLabel, "Frozen Dimension: " .. curr)
            prev = curr
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        local result = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")
        if string.len(result) >= 86 then
            local count = string.sub(result, 39, 41)
            setLabel(CakePrinceLabel, "Cake Prince Kill: " .. count)
        else
            setLabel(CakePrinceLabel, "Cake Prince: 🟢")
        end
    end
end)

task.spawn(function()
    local prev = ""
    while task.wait(1) do
        local found = safeFind(game.ReplicatedStorage, "rip_indra True Form") or safeFind(game.Workspace.Enemies, "rip_indra")
        local curr = found and "🟢" or "🔴"
        if curr ~= prev then
            setLabel(RipIndraLabel, "Rip_Indra: " .. curr)
            prev = curr
        end
    end
end)

task.spawn(function()
    local prev = ""
    while task.wait(1) do
        local found = safeFind(game.ReplicatedStorage, "Dough King") or safeFind(game.Workspace.Enemies, "Dough King")
        local curr = found and "🟢" or "🔴"
        if curr ~= prev then
            setLabel(DoughKingLabel, "Dough King: " .. curr)
            prev = curr
        end
    end
end)

task.spawn(function()
    local prev = ""
    while task.wait(1) do
        local found = (
            safeFind(game.ReplicatedStorage, "Diablo") or safeFind(game.ReplicatedStorage, "Deandre") or safeFind(game.ReplicatedStorage, "Urban")
            or safeFind(game.Workspace.Enemies, "Diablo") or safeFind(game.Workspace.Enemies, "Deandre") or safeFind(game.Workspace.Enemies, "Urban")
        )
        local curr = found and "🟢" or "🔴"
        local progress = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter","Progress")
        if curr ~= prev then
            setLabel(EliteLabel, "Elite Hunter: " .. curr .. " | Killed: " .. progress)
            prev = curr
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        local id = game:GetService("Lighting").Sky.MoonTextureId
        local moon = "Moon: 0/5"
        if id == "http://www.roblox.com/asset/?id=9709149431" then moon = "Moon: 5/5"
        elseif id == "http://www.roblox.com/asset/?id=9709149052" then moon = "Moon: 4/5"
        elseif id == "http://www.roblox.com/asset/?id=9709143733" then moon = "Moon: 3/5"
        elseif id == "http://www.roblox.com/asset/?id=9709150401" then moon = "Moon: 2/5"
        elseif id == "http://www.roblox.com/asset/?id=9709149680" then moon = "Moon: 1/5" end
        setLabel(MoonLabel, moon)
    end
end)

task.spawn(function()
    while task.wait(3) do
        local sword = "Not Found Legend Swords"
        local remote = game:GetService("ReplicatedStorage").Remotes.CommF_
        if remote:InvokeServer("LegendarySwordDealer", "1") then sword = "Shisui"
        elseif remote:InvokeServer("LegendarySwordDealer", "2") then sword = "Wando"
        elseif remote:InvokeServer("LegendarySwordDealer", "3") then sword = "Saddi" end
        setLabel(SwordLabel, "Legendary Sword: " .. sword)
    end
end)

task.spawn(function()
    while task.wait(1) do
        local bone = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones", "Check")
        setLabel(BoneLabel, "Bone: " .. tostring(bone))
    end
end)

local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlaceId = game.PlaceId
local JobId = game.JobId

local InputJob = StatusAndServerTab:MakeTextInput("InputJobId", {
    ["Title"] = "Input Job Id",
    ["Content"] = "Paste Job Id Here",
    ["Callback"] = function(Value)
        getgenv().Job = Value
    end
})

local ToggleSpam = StatusAndServerTab:MakeToggle("SpamJoin", {
    ["Title"] = "Spam Join",
    ["Content"] = "",
    ["Default"] = false,
    ["Callback"] = function(Value)
        getgenv().Join = Value
    end
})

task.spawn(function()
    local lastTeleport = 0
    local cooldown = 1
    while task.wait() do
        if getgenv().Join and getgenv().Job and tick() - lastTeleport >= cooldown then
            lastTeleport = tick()
            pcall(function()
                TeleportService:TeleportToPlaceInstance(PlaceId, getgenv().Job, LocalPlayer)
            end)
        end
    end
end)

local lastJoin = 0
StatusAndServerTab:MakeButton("JoinServer", {
    ["Title"] = "Join Server",
    ["Content"] = "",
    ["Logo"] = "rbxassetid://18271082015",
    ["Callback"] = function()
        if getgenv().Job and tick() - lastJoin >= 3 then
            lastJoin = tick()
            pcall(function()
                TeleportService:TeleportToPlaceInstance(PlaceId, getgenv().Job, LocalPlayer)
            end)
        else
            WazureV1:Notify({
                Title = "Saki-Hub",
                Content = "Missing Job Id or on cooldown!",
                Logo = "rbxassetid://108593743519357",
                Time = 1
            })
        end
    end
})

local lastCopy = 0
StatusAndServerTab:MakeButton("CopyJobId", {
    ["Title"] = "Copy Job Id",
    ["Content"] = "",
    ["Logo"] = "rbxassetid://18271082015",
    ["Callback"] = function()
        if tick() - lastCopy >= 2 then
            lastCopy = tick()
            setclipboard(tostring(JobId))
            WazureV1:Notify({
                Title = "Saki-Hub",
                Content = "Copied Job Id!",
                Logo = "rbxassetid://108593743519357",
                Time = 1
            })
        else
            WazureV1:Notify({
                Title = "Cooldown",
                Content = "Please wait a moment!",
                Logo = "rbxassetid://108593743519357",
                Time = 1
            })
        end
    end
})

local lastRejoin = 0
StatusAndServerTab:MakeButton("RejoinServer", {
    ["Title"] = "Rejoin Server",
    ["Content"] = "",
    ["Logo"] = "rbxassetid://18271082015",
    ["Callback"] = function()
        if tick() - lastRejoin >= 3 then
            lastRejoin = tick()
            pcall(function()
                TeleportService:Teleport(PlaceId, LocalPlayer)
            end)
        end
    end
})

StatusAndServerTab:MakeButton("HopServer", {
    ["Title"] = "Hop Server",
    ["Content"] = "",
    ["Logo"] = "rbxassetid://18271082015",
    ["Callback"] = function()
        local PlaceID = game.PlaceId
        local foundAnything = ""
        local function TPReturner()
            local site
            if foundAnything == "" then
                site = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceID .. "/servers/Public?sortOrder=Asc&limit=100"))
            else
                site = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceID .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. foundAnything))
            end
            if site.nextPageCursor then
                foundAnything = site.nextPageCursor
            end
            for _, v in pairs(site.data) do
                if tonumber(v.playing) < tonumber(v.maxPlayers) then
                    WazureV1:Notify({
                        Title = "Saki-Hub",
                        Content = "Joining server: " .. v.id,
                        Logo = "rbxassetid://108593743519357",
                        Time = 2
                    })
                    pcall(function()
                        TeleportService:TeleportToPlaceInstance(PlaceID, v.id, LocalPlayer)
                    end)
                    task.wait(1)
                    break
                end
            end
        end
        task.spawn(function()
            while task.wait(2) do
                pcall(function()
                    TPReturner()
                    if foundAnything ~= "" then TPReturner() end
                end)
            end
        end)
    end
})

ShopTab:MakeSeperator("Shop")
local Codes = {
    "WildDares", "BossBuild", "GetPranked", "Sub2OfficialNoobie", "Sub2Daigrock",
    "Sub2NoobMaster123", "Bluxxy", "JCWK", "Enyu_is_Pro", "Sub2Fer999",
    "kittgaming", "TheGreatAce", "StrawHatMaine", "TantaiGaming", "Axiore",
    "SUB2GAMERROBOT_EXP1", "MagicBus", "StarcodeHEO", "Sub2CaptainMaui",
    "FIGHT4FRUIT", "EARN_FRUITS"
}

ShopTab:MakeLabel("Redeem Code")

ShopTab:MakeButton("Redeem All Code", {
    Title = "Redeem All Code",
    Logo = "rbxassetid://18271082015",
    Callback = function()
        for _, code in ipairs(Codes) do
            task.spawn(function()
                pcall(function()
                    game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(code)
                end)
                task.wait(0.4)
            end)
        end
    end
})

local CommF_Remote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_")

ShopTab:MakeLabel("Teleport Sea")

ShopTab:MakeButton("Teleport Sea 1", {
    Title = "Teleport Sea 1",
    Logo = "rbxassetid://18271082015",
    Callback = function()
        pcall(function() CommF_Remote:InvokeServer("TravelMain") end)
    end
})

ShopTab:MakeButton("Teleport Sea 2", {
    Title = "Teleport Sea 2",
    Logo = "rbxassetid://18271082015",
    Callback = function()
        pcall(function() CommF_Remote:InvokeServer("TravelDressrosa") end)
    end
})

ShopTab:MakeButton("Teleport Sea 3", {
    Title = "Teleport Sea 3",
    Logo = "rbxassetid://18271082015",
    Callback = function()
        pcall(function() CommF_Remote:InvokeServer("TravelZou") end)
    end
})

ShopTab:MakeLabel("Fighting Shop")

local fightingOrder = {
    {Name = "Black Leg", Remote = "BuyBlackLeg"},
    {Name = "Fishman Karate", Remote = "BuyFishmanKarate"},
    {Name = "Electro", Remote = "BuyElectro"},
    {Name = "Dragon Claw", Special = true},
    {Name = "Superhuman", Remote = "BuySuperhuman"},
    {Name = "Death Step", Remote = "BuyDeathStep"},
    {Name = "Sharkman Karate", Remote = "BuySharkmanKarate"},
    {Name = "Electric Claw", Remote = "BuyElectricClaw"},
    {Name = "Dragon Talon", Remote = "BuyDragonTalon"},
    {Name = "God Human", Remote = "BuyGodhuman"},
    {Name = "Sanguine Art", Remote = "BuySanguineArt"}
}

local function BuyNormal(remoteName)
    pcall(function() CommF_Remote:InvokeServer(remoteName) end)
end

local function BuyDragonClaw()
    pcall(function()
        CommF_Remote:InvokeServer("BlackbeardReward", "DragonClaw", "1")
        task.wait(0.3)
        CommF_Remote:InvokeServer("BlackbeardReward", "DragonClaw", "2")
    end)
end

local function BuyAllFightingStyles()
    for _, style in ipairs(fightingOrder) do
        task.spawn(function()
            if style.Special then
                BuyDragonClaw()
            else
                BuyNormal(style.Remote)
            end
            task.wait(0.5)
        end)
    end
end

for _, style in ipairs(fightingOrder) do
    ShopTab:MakeButton(style.Name, {
        Title = style.Name,
        Logo = "rbxassetid://18271082015",
        Callback = function()
            if style.Special then
                BuyDragonClaw()
            else
                BuyNormal(style.Remote)
            end
        end
    })
end

ShopTab:MakeLabel("Abilities Shop")

ShopTab:MakeButton("Skyjump [ $10,000 Beli ]", {
	Title = "Skyjump [ $10,000 Beli ]",
	Logo = "rbxassetid://18271082015",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Geppo")
	end
})

ShopTab:MakeButton("Buso Haki [ $25,000 Beli ]", {
	Title = "Buso Haki [ $25,000 Beli ]",
	Logo = "rbxassetid://18271082015",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Buso")
	end
})

ShopTab:MakeButton("Observation Haki [ $750,000 Beli ]", {
	Title = "Observation Haki [ $750,000 Beli ]",
	Logo = "rbxassetid://18271082015",
	Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk", "Buy")
	end
})

ShopTab:MakeButton("Soru [ $100,000 Beli ]", {
	Title = "Soru [ $100,000 Beli ]",
	Logo = "rbxassetid://18271082015",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Soru")
	end
})
ShopTab:MakeLabel("Misc Shop")

ShopTab:MakeButton("Buy Refund Stat (2500F)", {
    Title = "Buy Refund Stat (2500F)",
    Logo = "rbxassetid://18271082015",
    Callback = function()            
        local CommF = game:GetService("ReplicatedStorage").Remotes.CommF_
        pcall(function()
            CommF:InvokeServer("BlackbeardReward", "Refund", "1")
            task.wait(0.5)
            CommF:InvokeServer("BlackbeardReward", "Refund", "2")
        end)
    end
})

ShopTab:MakeButton("Buy Reroll Race (3000F)", {
    Title = "Buy Reroll Race (3000F)",
    Logo = "rbxassetid://18271082015",
    Callback = function()            
        local CommF = game:GetService("ReplicatedStorage").Remotes.CommF_
        pcall(function()
            CommF:InvokeServer("BlackbeardReward", "Reroll", "1")
            task.wait(0.5)
            CommF:InvokeServer("BlackbeardReward", "Reroll", "2")
        end)
    end
})

ShopTab:MakeButton("Buy Ghoul Race", {
    Title = "Buy Ghoul Race",
    Logo = "rbxassetid://18271082015",
    Callback = function()
        local CommF = game:GetService("ReplicatedStorage").Remotes.CommF_
        pcall(function()
            CommF:InvokeServer("Ectoplasm", "BuyCheck", 4)
            task.wait(0.5)
            CommF:InvokeServer("Ectoplasm", "Change", 4)
        end)
    end
})

ShopTab:MakeButton("Buy Cyborg Race (2500F)", {
    Title = "Buy Cyborg Race (2500F)",
    Logo = "rbxassetid://18271082015",
    Callback = function()
        if not _G.isBuying then
            _G.isBuying = true
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CyborgTrainer", "Buy")
            end)
            task.wait(0.5)
            _G.isBuying = false
        end
    end
})

MainFarmTab:MakeSeperator("MainFarm")

_G.AutoLevel = true
_G.BringEnemy = true

local ChooseWeapon = "Melee"
local SelectWeapon = ""

local Pos = CFrame.new(0, 20, 0)
local CurrentTargetPos = Vector3.new(0, 0, 0)

local HeightAboveOrder = 20
local UseHeightAbove = false

local Mon, NameQuest, LevelQuest, NameMon = "", "", 1, ""
local CFrameQuest, CFrameMon = CFrame.new(), CFrame.new()

local TWEEN_SPEED = 350
local player = game.Players.LocalPlayer

-- Biến toàn cục để quản lý tween
local isTeleporting = false
_G.CurrentTween = nil

local function SmoothStayAbove(targetHRP)
    if not targetHRP then return end
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    hrp.CFrame = CFrame.new(targetHRP.Position + Vector3.new(0, HeightAboveOrder, 0))
end

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- PHƯƠNG PHÁP TWEEN MƯỢT KHÔNG GIẬT
function topos(Pos)
    local Char = LocalPlayer.Character
    if not Char or not Char:FindFirstChild("HumanoidRootPart") then return end
    
    local HRP = Char.HumanoidRootPart
    local Distance = (HRP.Position - Pos.Position).Magnitude
    
    -- Kiểm tra teleport gần nhất
    local nearestTeleport = CheckNearestTeleporter(Pos)
    if nearestTeleport then
        requestEntrance(nearestTeleport)
        wait(0.5)
    end
    
    -- Tạo PartTele để tween mượt mà
    if not Char:FindFirstChild("PartTele") then
        local PartTele = Instance.new("Part", Char)
        PartTele.Size = Vector3.new(10, 1, 10)
        PartTele.Name = "PartTele"
        PartTele.Anchored = true
        PartTele.Transparency = 1
        PartTele.CanCollide = true
        PartTele.CFrame = HRP.CFrame
        
        -- Kết nối PartTele với nhân vật
        PartTele:GetPropertyChangedSignal("CFrame"):Connect(function()
            if not isTeleporting then return end
            task.wait()
            if Char and Char:FindFirstChild("HumanoidRootPart") then
                Char.HumanoidRootPart.CFrame = PartTele.CFrame
            end
        end)
    end
    
    isTeleporting = true
    
    -- Tween PartTele thay vì trực tiếp tween nhân vật
    local Tween = TweenService:Create(
        Char.PartTele, 
        TweenInfo.new(Distance / 360, Enum.EasingStyle.Linear), 
        {CFrame = Pos}
    )
    Tween:Play()
    
    Tween.Completed:Connect(function(status)
        if status == Enum.PlaybackState.Completed then
            if Char:FindFirstChild("PartTele") then
                Char.PartTele:Destroy()
            end
            isTeleporting = false
        end
    end)
    
    return Tween
end

-- Hàm dừng tween
function stopTeleport()
    isTeleporting = false
    local plr = game.Players.LocalPlayer
    if plr.Character:FindFirstChild("PartTele") then
        plr.Character.PartTele:Destroy()
    end
    if _G.CurrentTween then
        _G.CurrentTween:Cancel()
        _G.CurrentTween = nil
    end
end

-- Xử lý khi nhân vật chết
local function onCharacterAdded(character)
    local humanoid = character:WaitForChild("Humanoid")
    humanoid.Died:Connect(function()
        stopTeleport()
    end)
end

player.CharacterAdded:Connect(onCharacterAdded)
if player.Character then
    onCharacterAdded(player.Character)
end

function CheckNearestTeleporter(aI)
    local vcspos = aI.Position
    local minDist = math.huge
    local chosenTeleport = nil
    local y = game.PlaceId

    local TableLocations = {}

    if y == 2753915549 then
        TableLocations = {
            ["Sky3"] = Vector3.new(-7894, 5547, -380),
            ["Sky3Exit"] = Vector3.new(-4607, 874, -1667),
            ["UnderWater"] = Vector3.new(61163, 11, 1819),
            ["Underwater City"] = Vector3.new(61165.19140625, 0.18704631924629211, 1897.379150390625),
            ["Pirate Village"] = Vector3.new(-1242.4625244140625, 4.787059783935547, 3901.282958984375),
            ["UnderwaterExit"] = Vector3.new(4050, -1, -1814)
        }
    elseif y == 4442272183 then
        TableLocations = {
            ["Swan Mansion"] = Vector3.new(-390, 332, 673),
            ["Swan Room"] = Vector3.new(2285, 15, 905),
            ["Cursed Ship"] = Vector3.new(923, 126, 32852),
            ["Zombie Island"] = Vector3.new(-6509, 83, -133)
        }
    elseif y == 7449423635 then
        TableLocations = {
            ["Floating Turtle"] = Vector3.new(-12462, 375, -7552),
            ["Hydra Island"] = Vector3.new(5657.88623046875, 1013.0790405273438, -335.4996337890625),
            ["Mansion"] = Vector3.new(-12462, 375, -7552),
            ["Castle"] = Vector3.new(-5036, 315, -3179),
            ["Dimensional Shift"] = Vector3.new(-2097.3447265625, 4776.24462890625, -15013.4990234375),
            ["Beautiful Pirate"] = Vector3.new(5319, 23, -93),
            ["Beautiful Room"] = Vector3.new(5314.58203, 22.5364361, -125.942276, 1, 2.14762768e-08, -1.99111154e-13, -2.14762768e-08, 1, -3.0510602e-08, 1.98455903e-13, 3.0510602e-08, 1),
            ["Temple of Time"] = Vector3.new(28286, 14897, 103)
        }
    end

    for _, v in pairs(TableLocations) do
        local dist = (v - vcspos).Magnitude
        if dist < minDist then
            minDist = dist
            chosenTeleport = v
        end
    end

    local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
    if minDist <= (vcspos - playerPos).Magnitude then
        return chosenTeleport
    end
end

function requestEntrance(teleportPos)
    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", teleportPos)
    local char = game.Players.LocalPlayer.Character.HumanoidRootPart
    char.CFrame = char.CFrame + Vector3.new(0, 50, 0)
    task.wait(0.5)
end

local AccountData = {
    AutoFarmLevel = false,
    BringMobEnabled = true
}

local function SaveAccount(data)
    -- Lưu dữ liệu tài khoản (có thể thêm vào sau)
end

local function CreateAutoFarmToggles()
    if MainFarmTab then
        local ToggleAutoFarm = MainFarmTab:MakeToggle("AutoFarm", {
            Title = "Auto Farm Level",
            Content = "Enable Auto Farm",
            Default = AccountData.AutoFarmLevel or false,
            Callback = function(Value)
                AccountData.AutoFarmLevel = Value
                _G.AutoLevel = Value
                SaveAccount(AccountData)
                
                if not Value then
                    stopTeleport()
                    CurrentTargetPos = Vector3.new(0, 0, 0)
                    UseHeightAbove = false
                end
            end
        })
        
        local ToggleBringMob = MainFarmTab:MakeToggle("BringMob", {
            Title = "Bring Mob",
            Content = "Kéo quái lại gần nhau",
            Default = AccountData.BringMobEnabled or true,
            Callback = function(Value)
                AccountData.BringMobEnabled = Value
                _G.BringEnemy = Value
                SaveAccount(AccountData)
                
                if not Value then
                    for _, v in pairs(workspace.Enemies:GetChildren()) do
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            v.HumanoidRootPart.CanCollide = true
                            v.Humanoid.WalkSpeed = 16
                            v.Humanoid.JumpPower = 50
                        end
                    end
                end
            end
        })
        
        local StatusLabel = MainFarmTab:MakeLabel({
            Title = "Trạng thái",
            Content = "Auto Farm: " .. tostring(AccountData.AutoFarmLevel) .. " | Bring Mob: " .. tostring(AccountData.BringMobEnabled)
        })
        
        local function UpdateStatus()
            StatusLabel:SetContent("Auto Farm: " .. tostring(_G.AutoLevel) .. " | Bring Mob: " .. tostring(_G.BringEnemy))
        end
        
        ToggleAutoFarm.Callback = function(Value)
            AccountData.AutoFarmLevel = Value
            _G.AutoLevel = Value
            SaveAccount(AccountData)
            UpdateStatus()
            
            if not Value then
                stopTeleport()
                CurrentTargetPos = Vector3.new(0, 0, 0)
                UseHeightAbove = false
            end
        end
        
        ToggleBringMob.Callback = function(Value)
            AccountData.BringMobEnabled = Value
            _G.BringEnemy = Value
            SaveAccount(AccountData)
            UpdateStatus()
            
            if not Value then
                for _, v in pairs(workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                        v.HumanoidRootPart.CanCollide = true
                        v.Humanoid.WalkSpeed = 16
                        v.Humanoid.JumpPower = 50
                    end
                end
            end
        end
        
    else
        warn("MainFarmTab không tồn tại")
    end
end

CreateAutoFarmToggles()

-- Phần còn lại của code giữ nguyên...
local AttackController = {} 

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Player = Players.LocalPlayer
local Modules = ReplicatedStorage:WaitForChild("Modules")
local Net = Modules:WaitForChild("Net")
local RegisterAttack = Net:WaitForChild("RE/RegisterAttack")
local RegisterHit = Net:WaitForChild("RE/RegisterHit")
local ShootGunEvent = Net:WaitForChild("RE/ShootGunEvent")
local GunValidator = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Validator2")

local AttackConfig = {
    AttackDistance = 65,
    AttackMobs = true,
    AttackPlayers = true,
    AttackCooldown = 0.05,
    ComboResetTime = 0.05,
    MaxCombo = 2,
    HitboxLimbs = {"RightLowerArm", "RightUpperArm", "LeftLowerArm", "LeftUpperArm", "RightHand", "LeftHand"},
    AutoClickEnabled = true
}

local FastAttack = {}
FastAttack.__index = FastAttack

function FastAttack.new()
    local self = setmetatable({
        Debounce = 0,
        ComboDebounce = 0,
        ShootDebounce = 0,
        M1Combo = 0,
        EnemyRootPart = nil,
        Connections = {},
        Overheat = {Dragonstorm = {MaxOverheat = 3, Cooldown = 0, TotalOverheat = 0, Distance = 350, Shooting = false}},
        ShootsPerTarget = {["Dual Flintlock"] = 2},
        SpecialShoots = {["Skull Guitar"] = "TAP", ["Bazooka"] = "Position", ["Cannon"] = "Position", ["Dragonstorm"] = "Overheat"}
    }, FastAttack)    
    
    pcall(function()
        self.CombatFlags = require(Modules.Flags).COMBAT_REMOTE_THREAD
        self.ShootFunction = getupvalue(require(ReplicatedStorage.Controllers.CombatController).Attack, 9)
        local LocalScript = Player:WaitForChild("PlayerScripts"):FindFirstChildOfClass("LocalScript")
        if LocalScript and getsenv then
            self.HitFunction = getsenv(LocalScript)._G.SendHitsToServer
        end
    end)    
    
    return self
end

function FastAttack:IsEntityAlive(entity)
    local humanoid = entity and entity:FindFirstChild("Humanoid")
    return humanoid and humanoid.Health > 0
end

function FastAttack:CheckStun(Character, Humanoid, ToolTip)
    local Stun = Character:FindFirstChild("Stun")
    local Busy = Character:FindFirstChild("Busy")
    if Humanoid.Sit and (ToolTip == "Sword" or ToolTip == "Melee" or ToolTip == "Blox Fruit") then
        return false
    elseif Stun and Stun.Value > 0 or Busy and Busy.Value then
        return false
    end
    return true
end

function FastAttack:GetBladeHits(Character, Distance)
    local Position = Character:GetPivot().Position
    local BladeHits = {}
    Distance = Distance or AttackConfig.AttackDistance    
    
    local function ProcessTargets(Folder, CanAttack)
        for _, Enemy in ipairs(Folder:GetChildren()) do
            pcall(function()
                if Enemy ~= Character and self:IsEntityAlive(Enemy) then
                    local BasePart = Enemy:FindFirstChild(AttackConfig.HitboxLimbs[math.random(#AttackConfig.HitboxLimbs)]) or Enemy:FindFirstChild("HumanoidRootPart")
                    if BasePart and (Position - BasePart.Position).Magnitude <= Distance then
                        if not self.EnemyRootPart then
                            self.EnemyRootPart = BasePart
                        else
                            table.insert(BladeHits, {Enemy, BasePart})
                            table.insert(BladeHits, {})
                        end
                    end
                end
            end)
        end
    end    
    
    if AttackConfig.AttackMobs then pcall(ProcessTargets, Workspace.Enemies) end
    if AttackConfig.AttackPlayers then pcall(ProcessTargets, Workspace.Characters, true) end    
    
    return BladeHits
end

function FastAttack:GetClosestEnemy(Character, Distance)
    local BladeHits = self:GetBladeHits(Character, Distance)
    local Closest, MinDistance = nil, math.huge 
    
    for _, Hit in ipairs(BladeHits) do
        local Magnitude = (Character:GetPivot().Position - Hit[2].Position).Magnitude
        if Magnitude < MinDistance then
            MinDistance = Magnitude
            Closest = Hit[2]
        end
    end
    
    return Closest
end

function FastAttack:GetCombo()
    local Combo = (tick() - self.ComboDebounce) <= AttackConfig.ComboResetTime and self.M1Combo or 0
    Combo = Combo >= AttackConfig.MaxCombo and 1 or Combo + 1
    self.ComboDebounce = tick()
    self.M1Combo = Combo
    return Combo
end

function FastAttack:ShootInTarget(TargetPosition)
    local Character = Player.Character
    if not self:IsEntityAlive(Character) then return end
    
    local Equipped = Character:FindFirstChildOfClass("Tool")
    if not Equipped or Equipped.ToolTip ~= "Gun" then return end    
    
    local Cooldown = Equipped:FindFirstChild("Cooldown") and Equipped.Cooldown.Value or 0.3
    if (tick() - self.ShootDebounce) < Cooldown then return end    
    
    local ShootType = self.SpecialShoots[Equipped.Name] or "Normal"
    
    if ShootType == "Position" or (ShootType == "TAP" and Equipped:FindFirstChild("RemoteEvent")) then
        Equipped:SetAttribute("LocalTotalShots", (Equipped:GetAttribute("LocalTotalShots") or 0) + 1)
        GunValidator:FireServer(self:GetValidator2())        
        
        if ShootType == "TAP" then
            Equipped.RemoteEvent:FireServer("TAP", TargetPosition)
        else
            ShootGunEvent:FireServer(TargetPosition)
        end
        self.ShootDebounce = tick()
    else
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
        task.wait(0.05)
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
        self.ShootDebounce = tick()
    end
end

function FastAttack:GetValidator2()
    local v1 = getupvalue(self.ShootFunction, 15)
    local v2 = getupvalue(self.ShootFunction, 13)
    local v3 = getupvalue(self.ShootFunction, 16)
    local v4 = getupvalue(self.ShootFunction, 17)
    local v5 = getupvalue(self.ShootFunction, 14)
    local v6 = getupvalue(self.ShootFunction, 12)
    local v7 = getupvalue(self.ShootFunction, 18)
    
    local v8 = v6 * v2
    local v9 = (v5 * v2 + v6 * v1) % v3
    v9 = (v9 * v3 + v8) % v4
    v5 = math.floor(v9 / v3)
    v6 = v9 - v5 * v3
    v7 = v7 + 1    
    
    setupvalue(self.ShootFunction, 15, v1)
    setupvalue(self.ShootFunction, 13, v2)
    setupvalue(self.ShootFunction, 16, v3)
    setupvalue(self.ShootFunction, 17, v4)
    setupvalue(self.ShootFunction, 14, v5)
    setupvalue(self.ShootFunction, 12, v6)
    setupvalue(self.ShootFunction, 18, v7)
    
    return math.floor(v9 / v4 * 16777215), v7
end

function FastAttack:UseNormalClick(Character, Humanoid, Cooldown)
    self.EnemyRootPart = nil
    local BladeHits = self:GetBladeHits(Character)
    
    if self.EnemyRootPart then
        RegisterAttack:FireServer(Cooldown)
        if self.CombatFlags and self.HitFunction then
            self.HitFunction(self.EnemyRootPart, BladeHits)
        else
            RegisterHit:FireServer(self.EnemyRootPart, BladeHits)
        end
    end
end

function FastAttack:UseFruitM1(Character, Equipped, Combo)
    local Targets = self:GetBladeHits(Character)
    if not Targets[1] then return end
    
    local Direction = (Targets[1][2].Position - Character:GetPivot().Position).Unit
    Equipped.LeftClickRemote:FireServer(Direction, Combo)
end

function FastAttack:Attack()
    if not AttackConfig.AutoClickEnabled or (tick() - self.Debounce) < AttackConfig.AttackCooldown then return end
    
    local Character = Player.Character
    if not Character or not self:IsEntityAlive(Character) then return end
    
    local Humanoid = Character.Humanoid
    local Equipped = Character:FindFirstChildOfClass("Tool")
    if not Equipped then return end
    
    local ToolTip = Equipped.ToolTip
    if not table.find({"Melee", "Blox Fruit", "Sword", "Gun"}, ToolTip) then return end
    
    local Cooldown = Equipped:FindFirstChild("Cooldown") and Equipped.Cooldown.Value or AttackConfig.AttackCooldown
    if not self:CheckStun(Character, Humanoid, ToolTip) then return end
    
    local Combo = self:GetCombo()
    Cooldown = Cooldown + (Combo >= AttackConfig.MaxCombo and 0.05 or 0)
    self.Debounce = Combo >= AttackConfig.MaxCombo and ToolTip ~= "Gun" and (tick() + 0.05) or tick()
    
    if ToolTip == "Blox Fruit" and Equipped:FindFirstChild("LeftClickRemote") then
        self:UseFruitM1(Character, Equipped, Combo)
    elseif ToolTip == "Gun" then
        local Target = self:GetClosestEnemy(Character, 120)
        if Target then
            self:ShootInTarget(Target.Position)
        end
    else
        self:UseNormalClick(Character, Humanoid, Cooldown)
    end
end

local AttackInstance = FastAttack.new()
table.insert(AttackInstance.Connections, RunService.Stepped:Connect(function()
    AttackInstance:Attack()
end))

local TweenService = game:GetService("TweenService")

local function TweenObject(Object, Pos, Speed)
    Speed = Speed or 350
    if not Object or not Pos then return end
    local Distance = (Pos.Position - Object.Position).Magnitude
    local info = TweenInfo.new(Distance / Speed, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(Object, info, {CFrame = Pos})
    tween:Play()
end

local function GetMobPosition(EnemiesName)
    local pos = Vector3.zero
    local count = 0
    for _, v in pairs(workspace.Enemies:GetChildren()) do
        if v.Name == EnemiesName and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            pos += v.HumanoidRootPart.Position
            count += 1
        end
    end
    if count == 0 then
        return nil
    end
    return pos / count
end

local function BringMob(enable)
    if not enable then return end
    local enemies = workspace.Enemies:GetChildren()
    if #enemies == 0 then return end
    local totalpos = {}
    for _, v in pairs(enemies) do
        if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            if not totalpos[v.Name] then
                totalpos[v.Name] = GetMobPosition(v.Name)
            end
        end
    end
    for _, v in pairs(workspace.Enemies:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
            local hrp = v.HumanoidRootPart
            local humanoid = v.Humanoid
            if humanoid.Health > 0 and (hrp.Position - player.Character.HumanoidRootPart.Position).Magnitude <= 350 then
                local mobPos = totalpos[v.Name]
                if mobPos then
                    local TargetCFrame = CFrame.new(mobPos.X, mobPos.Y, mobPos.Z)
                    local Distance = (hrp.Position - TargetCFrame.Position).Magnitude
                    if Distance > 3 and Distance <= 280 then
                        TweenObject(hrp, TargetCFrame, 300)
                        hrp.CanCollide = false
                        humanoid.WalkSpeed = 0
                        humanoid.JumpPower = 0
                        if humanoid:FindFirstChild("Animator") then
                            humanoid.Animator:Destroy()
                        end
                        pcall(function()
                            player.SimulationRadius = math.huge
                        end)
                    end
                end
            end
        end
    end
end

function Tween(TargetCFrame)
    pcall(function()
        local HRP = player.Character:WaitForChild("HumanoidRootPart")
        local Distance = (TargetCFrame.Position - HRP.Position).Magnitude
        if Distance < 5 then 
            HRP.CFrame = TargetCFrame 
            return 
        end

        local FinalCFrame = TargetCFrame
        if UseHeightAbove then
            local SafeHeight = TargetCFrame.Position + Vector3.new(0, HeightAboveOrder, 0)
            FinalCFrame = CFrame.new(SafeHeight)
        end

        if _G.CurrentTween then 
            _G.CurrentTween:Cancel() 
            _G.CurrentTween = nil
        end

        -- Sử dụng phương pháp tween mượt mới
        _G.CurrentTween = topos(FinalCFrame)
    end)
end

function EquipTool(ToolSe)
    if player.Backpack:FindFirstChild(ToolSe) then
        player.Character.Humanoid:EquipTool(player.Backpack:FindFirstChild(ToolSe))
    end
end

function AutoHaki()
    if not player.Character:FindFirstChild("HasBuso") then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
    end
end

task.spawn(function()
    while task.wait(1) do
        pcall(function()
            local backpack = player.Backpack
            for _, v in pairs(backpack:GetChildren()) do
                if v.ToolTip == ChooseWeapon then
                    SelectWeapon = v.Name
                    break
                end
            end
        end)
    end
end)

-- QUEST SYSTEM FIXED VERSION
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Biến toàn cục cho quest - BỎ LOCAL MYLEVEL = 1
local Mon, NameQuest, LevelQuest, NameMon = "", "", 1, ""
local CFrameQuest, CFrameMon = CFrame.new(), CFrame.new()
local World1, World2, World3 = false, false, false

-- Xác định world
local placeId = game.PlaceId
if placeId == 2753915549 then
    World1 = true
elseif placeId == 4442272183 then
    World2 = true
elseif placeId == 7449423635 then
    World3 = true
end

function CheckLevel()
    pcall(function()
        if player and player:FindFirstChild("Data") and player.Data:FindFirstChild("Level") then
            MyLevel = player.Data.Level.Value
            CheckQuest()
        end
    end)
end

function CheckQuest()
    if World1 then
        if MyLevel >= 1 and MyLevel <= 9 then
            Mon = "Bandit"
            LevelQuest = 1
            NameQuest = "BanditQuest1"
            NameMon = "Bandit"
            CFrameQuest = CFrame.new(1059.37195, 15.4495068, 1550.4231, 0.939700544, -0, -0.341998369, 0, 1, -0, 0.341998369, 0, 0.939700544)
            CFrameMon = CFrame.new(1045.962646484375, 27.00250816345215, 1560.8203125)
        elseif MyLevel >= 10 and MyLevel <= 14 then
            Mon = "Monkey"
            LevelQuest = 1
            NameQuest = "JungleQuest"
            NameMon = "Monkey"
            CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838, 0, 0, 1, 0, 1, -0, -1, 0, 0)
            CFrameMon = CFrame.new(-1448.51806640625, 67.85301208496094, 11.46579647064209)
        elseif MyLevel >= 15 and MyLevel <= 29 then
            Mon = "Gorilla"
            LevelQuest = 2
            NameQuest = "JungleQuest"
            NameMon = "Gorilla"
            CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838, 0, 0, 1, 0, 1, -0, -1, 0, 0)
            CFrameMon = CFrame.new(-1129.8836669921875, 40.46354675292969, -525.4237060546875)
        elseif MyLevel >= 30 and MyLevel <= 39 then
            Mon = "Pirate"
            LevelQuest = 1
            NameQuest = "BuggyQuest1"
            NameMon = "Pirate"
            CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
            CFrameMon = CFrame.new(-1103.513427734375, 13.752052307128906, 3896.091064453125)
        elseif MyLevel >= 40 and MyLevel <= 59 then
            Mon = "Brute"
            LevelQuest = 2
            NameQuest = "BuggyQuest1"
            NameMon = "Brute"
            CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
            CFrameMon = CFrame.new(-1140.083740234375, 14.809885025024414, 4322.92138671875)
        elseif MyLevel >= 60 and MyLevel <= 74 then
            Mon = "Desert Bandit"
            LevelQuest = 1
            NameQuest = "DesertQuest"
            NameMon = "Desert Bandit"
            CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359, 0.819155693, -0, -0.573571265, 0, 1, -0, 0.573571265, 0, 0.819155693)
            CFrameMon = CFrame.new(924.7998046875, 6.44867467880249, 4481.5859375)
        elseif MyLevel >= 75 and MyLevel <= 89 then
            Mon = "Desert Officer"
            LevelQuest = 2
            NameQuest = "DesertQuest"
            NameMon = "Desert Officer"
            CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359, 0.819155693, -0, -0.573571265, 0, 1, -0, 0.573571265, 0, 0.819155693)
            CFrameMon = CFrame.new(1608.2822265625, 8.614224433898926, 4371.00732421875)
        elseif MyLevel >= 90 and MyLevel <= 99 then
            Mon = "Snow Bandit"
            LevelQuest = 1
            NameQuest = "SnowQuest"
            NameMon = "Snow Bandit"
            CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796, -0.342042685, 0, 0.939684391, 0, 1, 0, -0.939684391, 0, -0.342042685)
            CFrameMon = CFrame.new(1354.347900390625, 87.27277374267578, -1393.946533203125)
        elseif MyLevel >= 100 and MyLevel <= 119 then
            Mon = "Snowman"
            LevelQuest = 2
            NameQuest = "SnowQuest"
            NameMon = "Snowman"
            CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796, -0.342042685, 0, 0.939684391, 0, 1, 0, -0.939684391, 0, -0.342042685)
            CFrameMon = CFrame.new(1201.6412353515625, 144.57958984375, -1550.0670166015625)
        elseif MyLevel >= 120 and MyLevel <= 149 then
            Mon = "Chief Petty Officer"
            LevelQuest = 1
            NameQuest = "MarineQuest2"
            NameMon = "Chief Petty Officer"
            CFrameQuest = CFrame.new(-5039.58643, 27.3500385, 4324.68018, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            CFrameMon = CFrame.new(-4881.23095703125, 22.65204429626465, 4273.75244140625)
        elseif MyLevel >= 150 and MyLevel <= 174 then
            Mon = "Sky Bandit"
            LevelQuest = 1
            NameQuest = "SkyQuest"
            NameMon = "Sky Bandit"
            CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
            CFrameMon = CFrame.new(-4953.20703125, 295.74420166015625, -2899.22900390625)
        elseif MyLevel >= 175 and MyLevel <= 189 then
            Mon = "Dark Master"
            LevelQuest = 2
            NameQuest = "SkyQuest"
            NameMon = "Dark Master"
            CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
            CFrameMon = CFrame.new(-5259.8447265625, 391.3976745605469, -2229.035400390625)
        elseif MyLevel >= 190 and MyLevel <= 209 then
            Mon = "Prisoner"
            LevelQuest = 1
            NameQuest = "PrisonerQuest"
            NameMon = "Prisoner"
            CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -5.00292918e-09, -0.995993316, 1.60817859e-09, 1, -5.16744869e-09, 0.995993316, -2.06384709e-09, -0.0894274712)
            CFrameMon = CFrame.new(5098.9736328125, -0.3204058110713959, 474.2373352050781)
        elseif MyLevel >= 210 and MyLevel <= 249 then
            Mon = "Dangerous Prisoner"
            LevelQuest = 2
            NameQuest = "PrisonerQuest"
            NameMon = "Dangerous Prisoner"
            CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -5.00292918e-09, -0.995993316, 1.60817859e-09, 1, -5.16744869e-09, 0.995993316, -2.06384709e-09, -0.0894274712)
            CFrameMon = CFrame.new(5654.5634765625, 15.633401870727539, 866.2991943359375)
        elseif MyLevel >= 250 and MyLevel <= 274 then
            Mon = "Toga Warrior"
            LevelQuest = 1
            NameQuest = "ColosseumQuest"
            NameMon = "Toga Warrior"
            CFrameQuest = CFrame.new(-1580.04663, 6.35000277, -2986.47534, -0.515037298, 0, -0.857167721, 0, 1, 0, 0.857167721, 0, -0.515037298)
            CFrameMon = CFrame.new(-1820.21484375, 51.68385696411133, -2740.6650390625)
        elseif MyLevel >= 275 and MyLevel <= 299 then
            Mon = "Gladiator"
            LevelQuest = 2
            NameQuest = "ColosseumQuest"
            NameMon = "Gladiator"
            CFrameQuest = CFrame.new(-1580.04663, 6.35000277, -2986.47534, -0.515037298, 0, -0.857167721, 0, 1, 0, 0.857167721, 0, -0.515037298)
            CFrameMon = CFrame.new(-1292.838134765625, 56.380882263183594, -3339.031494140625)
        elseif MyLevel >= 300 and MyLevel <= 324 then
            Mon = "Military Soldier"
            LevelQuest = 1
            NameQuest = "MagmaQuest"
            NameMon = "Military Soldier"
            CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395, -0.499959469, 0, 0.866048813, 0, 1, 0, -0.866048813, 0, -0.499959469)
            CFrameMon = CFrame.new(-5411.16455078125, 11.081554412841797, 8454.29296875)
        elseif MyLevel >= 325 and MyLevel <= 374 then
            Mon = "Military Spy"
            LevelQuest = 2
            NameQuest = "MagmaQuest"
            NameMon = "Military Spy"
            CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395, -0.499959469, 0, 0.866048813, 0, 1, 0, -0.866048813, 0, -0.499959469)
            CFrameMon = CFrame.new(-5802.8681640625, 86.26241302490234, 8828.859375)
        elseif MyLevel >= 375 and MyLevel <= 399 then
            Mon = "Fishman Warrior"
            LevelQuest = 1
            NameQuest = "FishmanQuest"
            NameMon = "Fishman Warrior"
            CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
            CFrameMon = CFrame.new(60878.30078125, 18.482830047607422, 1543.7574462890625)
            if getgenv().AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
            end
        elseif MyLevel >= 400 and MyLevel <= 449 then
            Mon = "Fishman Commando"
            LevelQuest = 2
            NameQuest = "FishmanQuest"
            NameMon = "Fishman Commando"
            CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
            CFrameMon = CFrame.new(61922.6328125, 18.482830047607422, 1493.934326171875)
            if getgenv().AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
            end
        elseif MyLevel >= 450 and MyLevel <= 474 then
            Mon = "God's Guard"
            LevelQuest = 1
            NameQuest = "SkyExp1Quest"
            NameMon = "God's Guard"
            CFrameQuest = CFrame.new(-4721.88867, 843.874695, -1949.96643, 0.996191859, -0, -0.0871884301, 0, 1, -0, 0.0871884301, 0, 0.996191859)
            CFrameMon = CFrame.new(-4710.04296875, 845.2769775390625, -1927.3079833984375)
            if getgenv().AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-4607.82275, 872.54248, -1667.55688))
            end
        elseif MyLevel >= 475 and MyLevel <= 524 then
            Mon = "Shanda"
            LevelQuest = 2
            NameQuest = "SkyExp1Quest"
            NameMon = "Shanda"
            CFrameQuest = CFrame.new(-7859.09814, 5544.19043, -381.476196, -0.422592998, 0, 0.906319618, 0, 1, 0, -0.906319618, 0, -0.422592998)
            CFrameMon = CFrame.new(-7678.48974609375, 5566.40380859375, -497.2156066894531)
            if getgenv().AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
            end
        elseif MyLevel >= 525 and MyLevel <= 549 then
            Mon = "Royal Squad"
            LevelQuest = 1
            NameQuest = "SkyExp2Quest"
            NameMon = "Royal Squad"
            CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            CFrameMon = CFrame.new(-7624.25244140625, 5658.13330078125, -1467.354248046875)
        elseif MyLevel >= 550 and MyLevel <= 624 then
            Mon = "Royal Soldier"
            LevelQuest = 2
            NameQuest = "SkyExp2Quest"
            NameMon = "Royal Soldier"
            CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            CFrameMon = CFrame.new(-7836.75341796875, 5645.6640625, -1790.6236572265625)
        elseif MyLevel >= 625 and MyLevel <= 649 then
            Mon = "Galley Pirate"
            LevelQuest = 1
            NameQuest = "FountainQuest"
            NameMon = "Galley Pirate"
            CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293, 0.087131381, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, 0.087131381)
            CFrameMon = CFrame.new(5551.02197265625, 78.90135192871094, 3930.412841796875)
        elseif MyLevel >= 650 then
            Mon = "Galley Captain"
            LevelQuest = 2
            NameQuest = "FountainQuest"
            NameMon = "Galley Captain"
            CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293, 0.087131381, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, 0.087131381)
            CFrameMon = CFrame.new(5441.95166015625, 42.50205993652344, 4950.09375)
        end
    elseif World2 then
        if MyLevel >= 700 and MyLevel <= 724 then
            Mon = "Raider"
            LevelQuest = 1
            NameQuest = "Area1Quest"
            NameMon = "Raider"
            CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.22495985, 0, -0.974368095, 0, 1, 0, 0.974368095, 0, -0.22495985)
            CFrameMon = CFrame.new(-728.3267211914062, 52.779319763183594, 2345.7705078125)
        elseif MyLevel >= 725 and MyLevel <= 774 then
            Mon = "Mercenary"
            LevelQuest = 2
            NameQuest = "Area1Quest"
            NameMon = "Mercenary"
            CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.22495985, 0, -0.974368095, 0, 1, 0, 0.974368095, 0, -0.22495985)
            CFrameMon = CFrame.new(-1004.3244018554688, 80.15886688232422, 1424.619384765625)
        elseif MyLevel >= 775 and MyLevel <= 799 then
            Mon = "Swan Pirate"
            LevelQuest = 1
            NameQuest = "Area2Quest"
            NameMon = "Swan Pirate"
            CFrameQuest = CFrame.new(638.43811, 71.769989, 918.282898, 0.139203906, 0, 0.99026376, 0, 1, 0, -0.99026376, 0, 0.139203906)
            CFrameMon = CFrame.new(1068.664306640625, 137.61428833007812, 1322.1060791015625)
        elseif MyLevel >= 800 and MyLevel <= 874 then
            Mon = "Factory Staff"
            NameQuest = "Area2Quest"
            LevelQuest = 2
            NameMon = "Factory Staff"
            CFrameQuest = CFrame.new(632.698608, 73.1055908, 918.666321, -0.0319722369, 8.96074881e-10, -0.999488771, 1.36326533e-10, 1, 8.92172336e-10, 0.999488771, -1.07732087e-10, -0.0319722369)
            CFrameMon = CFrame.new(73.07867431640625, 81.86344146728516, -27.470672607421875)
        elseif MyLevel >= 875 and MyLevel <= 899 then
            Mon = "Marine Lieutenant"
            LevelQuest = 1
            NameQuest = "MarineQuest3"
            NameMon = "Marine Lieutenant"
            CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3216.06812, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
            CFrameMon = CFrame.new(-2821.372314453125, 75.89727783203125, -3070.089111328125)
        elseif MyLevel >= 900 and MyLevel <= 949 then
            Mon = "Marine Captain"
            LevelQuest = 2
            NameQuest = "MarineQuest3"
            NameMon = "Marine Captain"
            CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3216.06812, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
            CFrameMon = CFrame.new(-1861.2310791015625, 80.17658233642578, -3254.697509765625)
        elseif MyLevel >= 950 and MyLevel <= 974 then
            Mon = "Zombie"
            LevelQuest = 1
            NameQuest = "ZombieQuest"
            NameMon = "Zombie"
            CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, 0, -0.95628953, 0, 1, 0, 0.95628953, 0, -0.29242146)
            CFrameMon = CFrame.new(-5657.77685546875, 78.96973419189453, -928.68701171875)
        elseif MyLevel >= 975 and MyLevel <= 999 then
            Mon = "Vampire"
            LevelQuest = 2
            NameQuest = "ZombieQuest"
            NameMon = "Vampire"
            CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, 0, -0.95628953, 0, 1, 0, 0.95628953, 0, -0.29242146)
            CFrameMon = CFrame.new(-6037.66796875, 32.18463897705078, -1340.6597900390625)
        elseif MyLevel >= 1000 and MyLevel <= 1049 then
            Mon = "Snow Trooper"
            LevelQuest = 1
            NameQuest = "SnowMountainQuest"
            NameMon = "Snow Trooper"
            CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928, -0.374604106, 0, 0.92718488, 0, 1, 0, -0.92718488, 0, -0.374604106)
            CFrameMon = CFrame.new(549.1473388671875, 427.3870544433594, -5563.69873046875)
        elseif MyLevel >= 1050 and MyLevel <= 1099 then
            Mon = "Winter Warrior"
            LevelQuest = 2
            NameQuest = "SnowMountainQuest"
            NameMon = "Winter Warrior"
            CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928, -0.374604106, 0, 0.92718488, 0, 1, 0, -0.92718488, 0, -0.374604106)
            CFrameMon = CFrame.new(1142.7451171875, 475.6398010253906, -5199.41650390625)
        elseif MyLevel >= 1100 and MyLevel <= 1124 then
            Mon = "Lab Subordinate"
            LevelQuest = 1
            NameQuest = "IceSideQuest"
            NameMon = "Lab Subordinate"
            CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852, 0.453972578, -0, -0.891015649, 0, 1, -0, 0.891015649, 0, 0.453972578)
            CFrameMon = CFrame.new(-5707.4716796875, 15.951709747314453, -4513.39208984375)
        elseif MyLevel >= 1125 and MyLevel <= 1174 then
            Mon = "Horned Warrior"
            LevelQuest = 2
            NameQuest = "IceSideQuest"
            NameMon = "Horned Warrior"
            CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852, 0.453972578, -0, -0.891015649, 0, 1, -0, 0.891015649, 0, 0.453972578)
            CFrameMon = CFrame.new(-6341.36669921875, 15.951770782470703, -5723.162109375)
        elseif MyLevel >= 1175 and MyLevel <= 1199 then
            Mon = "Magma Ninja"
            LevelQuest = 1
            NameQuest = "FireSideQuest"
            NameMon = "Magma Ninja"
            CFrameQuest = CFrame.new(-5428.03174, 15.0622921, -5299.43457, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
            CFrameMon = CFrame.new(-5449.6728515625, 76.65874481201172, -5808.20068359375)
        elseif MyLevel >= 1200 and MyLevel <= 1249 then
            Mon = "Lava Pirate"
            LevelQuest = 2
            NameQuest = "FireSideQuest"
            NameMon = "Lava Pirate"
            CFrameQuest = CFrame.new(-5428.03174, 15.0622921, -5299.43457, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
            CFrameMon = CFrame.new(-5213.33154296875, 49.73788070678711, -4701.451171875)
        elseif MyLevel >= 1250 and MyLevel <= 1274 then
            Mon = "Ship Deckhand"
            LevelQuest = 1
            NameQuest = "ShipQuest1"
            NameMon = "Ship Deckhand"
            CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016)         
            CFrameMon = CFrame.new(1212.0111083984375, 150.79205322265625, 33059.24609375)    
            if getgenv().AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif MyLevel >= 1275 and MyLevel <= 1299 then
            Mon = "Ship Engineer"
            LevelQuest = 2
            NameQuest = "ShipQuest1"
            NameMon = "Ship Engineer"
            CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016)   
            CFrameMon = CFrame.new(919.4786376953125, 43.54401397705078, 32779.96875)   
            if getgenv().AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end             
        elseif MyLevel >= 1300 and MyLevel <= 1324 then
            Mon = "Ship Steward"
            LevelQuest = 1
            NameQuest = "ShipQuest2"
            NameMon = "Ship Steward"
            CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125)         
            CFrameMon = CFrame.new(919.4385375976562, 129.55599975585938, 33436.03515625)      
            if getgenv().AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif MyLevel >= 1325 and MyLevel <= 1349 then
            Mon = "Ship Officer"
            LevelQuest = 2
            NameQuest = "ShipQuest2"
            NameMon = "Ship Officer"
            CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125)
            CFrameMon = CFrame.new(1036.0179443359375, 181.4390411376953, 33315.7265625)
            if getgenv().AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif MyLevel >= 1350 and MyLevel <= 1374 then
            Mon = "Arctic Warrior"
            LevelQuest = 1
            NameQuest = "FrostQuest"
            NameMon = "Arctic Warrior"
            CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, 0, -0.358349502, 0, 1, 0, 0.358349502, 0, -0.933587909)
            CFrameMon = CFrame.new(5966.24609375, 62.97002029418945, -6179.3828125)
            if getgenv().AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6508.5581054688, 5000.034996032715, -132.83953857422))
            end
        elseif MyLevel >= 1375 and MyLevel <= 1424 then
            Mon = "Snow Lurker"
            LevelQuest = 2
            NameQuest = "FrostQuest"
            NameMon = "Snow Lurker"
            CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, 0, -0.358349502, 0, 1, 0, 0.358349502, 0, -0.933587909)
            CFrameMon = CFrame.new(5407.07373046875, 69.19437408447266, -6880.88037109375)
        elseif MyLevel >= 1425 and MyLevel <= 1449 then
            Mon = "Sea Soldier"
            LevelQuest = 1
            NameQuest = "ForgottenQuest"
            NameMon = "Sea Soldier"
            CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193, 0.990270376, -0, -0.13915664, 0, 1, -0, 0.13915664, 0, 0.990270376)
            CFrameMon = CFrame.new(-3028.2236328125, 64.67451477050781, -9775.4267578125)
        elseif MyLevel >= 1450 then
            Mon = "Water Fighter"
            LevelQuest = 2
            NameQuest = "ForgottenQuest"
            NameMon = "Water Fighter"
            CFrameQuest = CFrame.new(-3054, 240, -10146)
            CFrameMon = CFrame.new(-3291, 252, -10501)
        end
    elseif World3 then
        if MyLevel >= 1500 and MyLevel <= 1524 then
            Mon = "Pirate Millionaire"
            LevelQuest = 1
            NameQuest = "PiratePortQuest"
            NameMon = "Pirate Millionaire"
            CFrameQuest = CFrame.new(-290.074677, 42.9034653, 5581.58984, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
            CFrameMon = CFrame.new(-245.9963836669922, 47.30615234375, 5584.1005859375)
        elseif MyLevel >= 1525 and MyLevel <= 1574 then
            Mon = "Pistol Billionaire"
            LevelQuest = 2
            NameQuest = "PiratePortQuest"
            NameMon = "Pistol Billionaire"
            CFrameQuest = CFrame.new(-290.074677, 42.9034653, 5581.58984, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
            CFrameMon = CFrame.new(-187.3301544189453, 86.23987579345703, 6013.513671875)
        elseif MyLevel >= 1575 and MyLevel <= 1599 then
            Mon = "Dragon Crew Warrior"
            LevelQuest = 1
            NameQuest = "DragonCrewQuest"
            NameMon = "Dragon Crew Warrior"
            CFrameQuest = CFrame.new(6738.96142578125, 127.81645965576172, -713.511474609375)
            CFrameMon = CFrame.new(6920.71435546875, 56.15597152709961, -942.5044555664062)
        elseif MyLevel >= 1600 and MyLevel <= 1624 then 
            Mon = "Dragon Crew Archer"
            NameQuest = "DragonCrewQuest"
            LevelQuest = 2
            NameMon = "Dragon Crew Archer"
            CFrameQuest = CFrame.new(6738.96142578125, 127.81645965576172, -713.511474609375)
            CFrameMon = CFrame.new(6817.91259765625, 484.804443359375, 513.4141235351562)
        elseif MyLevel >= 1625 and MyLevel <= 1649 then
            Mon = "Hydra Enforcer"
            NameQuest = "VenomCrewQuest"
            LevelQuest = 1
            NameMon = "Hydra Enforcer"
            CFrameQuest = CFrame.new(5213.8740234375, 1004.5042724609375, 758.6944580078125)
            CFrameMon = CFrame.new(4584.69287109375, 1002.6435546875, 705.7958984375)
        elseif MyLevel >= 1650 and MyLevel <= 1699 then 
            Mon = "Venomous Assailant"
            NameQuest = "VenomCrewQuest"
            LevelQuest = 2
            NameMon = "Venomous Assailant"
            CFrameQuest = CFrame.new(5213.8740234375, 1004.5042724609375, 758.6944580078125)
            CFrameMon = CFrame.new(4638.78564453125, 1078.94091796875, 881.8002319335938)        
        elseif MyLevel >= 1700 and MyLevel <= 1724 then
            Mon = "Marine Commodore"
            LevelQuest = 1
            NameQuest = "MarineTreeIsland"
            NameMon = "Marine Commodore"
            CFrameQuest = CFrame.new(2180.54126, 27.8156815, -6741.5498, -0.965929747, 0, 0.258804798, 0, 1, 0, -0.258804798, 0, -0.965929747)
            CFrameMon = CFrame.new(2286.0078125, 73.13391876220703, -7159.80908203125)
        elseif MyLevel >= 1725 and MyLevel <= 1774 then
            Mon = "Marine Rear Admiral"
            NameMon = "Marine Rear Admiral"
            NameQuest = "MarineTreeIsland"
            LevelQuest = 2
            CFrameQuest = CFrame.new(2179.98828125, 28.731239318848, -6740.0551757813)
            CFrameMon = CFrame.new(3656.773681640625, 160.52406311035156, -7001.5986328125)
        elseif MyLevel >= 1775 and MyLevel <= 1799 then
            Mon = "Fishman Raider"
            LevelQuest = 1
            NameQuest = "DeepForestIsland3"
            NameMon = "Fishman Raider"
            CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)   
            CFrameMon = CFrame.new(-10407.5263671875, 331.76263427734375, -8368.5166015625)
        elseif MyLevel >= 1800 and MyLevel <= 1824 then
            Mon = "Fishman Captain"
            LevelQuest = 2
            NameQuest = "DeepForestIsland3"
            NameMon = "Fishman Captain"
            CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)   
            CFrameMon = CFrame.new(-10994.701171875, 352.38140869140625, -9002.1103515625) 
        elseif MyLevel >= 1825 and MyLevel <= 1849 then
            Mon = "Forest Pirate"
            LevelQuest = 1
            NameQuest = "DeepForestIsland"
            NameMon = "Forest Pirate"
            CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137, 0.707134247, -0, -0.707079291, 0, 1, -0, 0.707079291, 0, 0.707134247)
            CFrameMon = CFrame.new(-13274.478515625, 332.3781433105469, -7769.58056640625)
        elseif MyLevel >= 1850 and MyLevel <= 1899 then
            Mon = "Mythological Pirate"
            LevelQuest = 2
            NameQuest = "DeepForestIsland"
            NameMon = "Mythological Pirate"
            CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137, 0.707134247, -0, -0.707079291, 0, 1, -0, 0.707079291, 0, 0.707134247)   
            CFrameMon = CFrame.new(-13680.607421875, 501.08154296875, -6991.189453125)
        elseif MyLevel >= 1900 and MyLevel <= 1924 then
            Mon = "Jungle Pirate"
            LevelQuest = 1
            NameQuest = "DeepForestIsland2"
            NameMon = "Jungle Pirate"
            CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, -0.0871315002)
            CFrameMon = CFrame.new(-12256.16015625, 331.73828125, -10485.8369140625)
        elseif MyLevel >= 1925 and MyLevel <= 1974 then
            Mon = "Musketeer Pirate"
            LevelQuest = 2
            NameQuest = "DeepForestIsland2"
            NameMon = "Musketeer Pirate"
            CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, -0.0871315002)
            CFrameMon = CFrame.new(-13457.904296875, 391.545654296875, -9859.177734375)
        elseif MyLevel >= 1975 and MyLevel <= 1999 then
            Mon = "Reborn Skeleton"
            LevelQuest = 1
            NameQuest = "HauntedQuest1"
            NameMon = "Reborn Skeleton"
            CFrameQuest = CFrame.new(-9479.2168, 141.215088, 5566.09277, 0, 0, 1, 0, 1, -0, -1, 0, 0)
            CFrameMon = CFrame.new(-8763.7236328125, 165.72299194335938, 6159.86181640625)
        elseif MyLevel >= 2000 and MyLevel <= 2024 then
            Mon = "Living Zombie"
            LevelQuest = 2
            NameQuest = "HauntedQuest1"
            NameMon = "Living Zombie"
            CFrameQuest = CFrame.new(-9479.2168, 141.215088, 5566.09277, 0, 0, 1, 0, 1, -0, -1, 0, 0)
            CFrameMon = CFrame.new(-10144.1318359375, 138.62667846679688, 5838.0888671875)
        elseif MyLevel >= 2025 and MyLevel <= 2049 then
            Mon = "Demonic Soul"
            LevelQuest = 1
            NameQuest = "HauntedQuest2"
            NameMon = "Demonic Soul"
            CFrameQuest = CFrame.new(-9516.99316, 172.017181, 6078.46533, 0, 0, -1, 0, 1, 0, 1, 0, 0) 
            CFrameMon = CFrame.new(-9505.8720703125, 172.10482788085938, 6158.9931640625)
        elseif MyLevel >= 2050 and MyLevel <= 2074 then
            Mon = "Posessed Mummy"
            LevelQuest = 2
            NameQuest = "HauntedQuest2"
            NameMon = "Posessed Mummy"
            CFrameQuest = CFrame.new(-9516.99316, 172.017181, 6078.46533, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            CFrameMon = CFrame.new(-9582.0224609375, 6.251527309417725, 6205.478515625)
        elseif MyLevel >= 2075 and MyLevel <= 2099 then
            Mon = "Peanut Scout"
            LevelQuest = 1
            NameQuest = "NutsIslandQuest"
            NameMon = "Peanut Scout"
            CFrameQuest = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            CFrameMon = CFrame.new(-2143.241943359375, 47.72198486328125, -10029.9951171875)
        elseif MyLevel >= 2100 and MyLevel <= 2124 then
            Mon = "Peanut President"
            LevelQuest = 2
            NameQuest = "NutsIslandQuest"
            NameMon = "Peanut President"
            CFrameQuest = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            CFrameMon = CFrame.new(-1859.35400390625, 38.10316848754883, -10422.4296875)
        elseif MyLevel >= 2125 and MyLevel <= 2149 then
            Mon = "Ice Cream Chef"
            LevelQuest = 1
            NameQuest = "IceCreamIslandQuest"
            NameMon = "Ice Cream Chef"
            CFrameQuest = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            CFrameMon = CFrame.new(-872.24658203125, 65.81957244873047, -10919.95703125)
        elseif MyLevel >= 2150 and MyLevel <= 2199 then
            Mon = "Ice Cream Commander"
            LevelQuest = 2
            NameQuest = "IceCreamIslandQuest"
            NameMon = "Ice Cream Commander"
            CFrameQuest = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            CFrameMon = CFrame.new(-558.06103515625, 112.04895782470703, -11290.7744140625)
        elseif MyLevel >= 2200 and MyLevel <= 2224 then
            Mon = "Cookie Crafter"
            LevelQuest = 1
            NameQuest = "CakeQuest1"
            NameMon = "Cookie Crafter"
            CFrameQuest = CFrame.new(-2021.32007, 37.7982254, -12028.7295, 0.957576931, -8.80302053e-08, 0.288177818, 6.9301187e-08, 1, 7.51931211e-08, -0.288177818, -5.2032135e-08, 0.957576931)
            CFrameMon = CFrame.new(-2374.13671875, 37.79826354980469, -12125.30859375)
        elseif MyLevel >= 2225 and MyLevel <= 2249 then
            Mon = "Cake Guard"
            LevelQuest = 2
            NameQuest = "CakeQuest1"
            NameMon = "Cake Guard"
            CFrameQuest = CFrame.new(-2021.32007, 37.7982254, -12028.7295, 0.957576931, -8.80302053e-08, 0.288177818, 6.9301187e-08, 1, 7.51931211e-08, -0.288177818, -5.2032135e-08, 0.957576931)
            CFrameMon = CFrame.new(-1598.3070068359375, 43.773197174072266, -12244.5810546875)
        elseif MyLevel >= 2250 and MyLevel <= 2274 then
            Mon = "Baking Staff"
            LevelQuest = 1
            NameQuest = "CakeQuest2"
            NameMon = "Baking Staff"
            CFrameQuest = CFrame.new(-1927.91602, 37.7981339, -12842.5391, -0.96804446, 4.22142143e-08, 0.250778586, 4.74911062e-08, 1, 1.49904711e-08, -0.250778586, 2.64211941e-08, -0.96804446)
            CFrameMon = CFrame.new(-1887.8099365234375, 77.6185073852539, -12998.3505859375)
        elseif MyLevel >= 2275 and MyLevel <= 2299 then
            Mon = "Head Baker"
            LevelQuest = 2
            NameQuest = "CakeQuest2"
            NameMon = "Head Baker"
            CFrameQuest = CFrame.new(-1927.91602, 37.7981339, -12842.5391, -0.96804446, 4.22142143e-08, 0.250778586, 4.74911062e-08, 1, 1.49904711e-08, -0.250778586, 2.64211941e-08, -0.96804446)
            CFrameMon = CFrame.new(-2216.188232421875, 82.884521484375, -12869.2939453125)
        elseif MyLevel >= 2300 and MyLevel <= 2324 then
            Mon = "Cocoa Warrior"
            LevelQuest = 1
            NameQuest = "ChocQuest1"
            NameMon = "Cocoa Warrior"
            CFrameQuest = CFrame.new(233.22836303710938, 29.876001358032227, -12201.2333984375)
            CFrameMon = CFrame.new(-21.55328369140625, 80.57499694824219, -12352.3876953125)
        elseif MyLevel >= 2325 and MyLevel <= 2349 then
            Mon = "Chocolate Bar Battler"
            LevelQuest = 2
            NameQuest = "ChocQuest1"
            NameMon = "Chocolate Bar Battler"
            CFrameQuest = CFrame.new(233.22836303710938, 29.876001358032227, -12201.2333984375)
            CFrameMon = CFrame.new(582.590576171875, 77.18809509277344, -12463.162109375)
        elseif MyLevel >= 2350 and MyLevel <= 2374 then
            Mon = "Sweet Thief"
            LevelQuest = 1
            NameQuest = "ChocQuest2"
            NameMon = "Sweet Thief"
            CFrameQuest = CFrame.new(150.5066375732422, 30.693693161010742, -12774.5029296875)
            CFrameMon = CFrame.new(165.1884765625, 76.05885314941406, -12600.8369140625)
        elseif MyLevel >= 2375 and MyLevel <= 2399 then
            Mon = "Candy Rebel"
            LevelQuest = 2
            NameQuest = "ChocQuest2"
            NameMon = "Candy Rebel"
            CFrameQuest = CFrame.new(150.5066375732422, 30.693693161010742, -12774.5029296875)
            CFrameMon = CFrame.new(134.86563110351562, 77.2476806640625, -12876.5478515625)
        elseif MyLevel >= 2400 and MyLevel <= 2424 then
            Mon = "Candy Pirate"
            LevelQuest = 1
            NameQuest = "CandyQuest1"
            NameMon = "Candy Pirate"
            CFrameQuest = CFrame.new(-1150.0400390625, 20.378934860229492, -14446.3349609375)
            CFrameMon = CFrame.new(-1310.5003662109375, 26.016523361206055, -14562.404296875)
        elseif MyLevel >= 2425 and MyLevel <= 2449 then
            Mon = "Snow Demon"
            LevelQuest = 2
            NameQuest = "CandyQuest1"
            NameMon = "Snow Demon"
            CFrameQuest = CFrame.new(-1150.0400390625, 20.378934860229492, -14446.3349609375)
            CFrameMon = CFrame.new(-880.2006225585938, 71.24776458740234, -14538.609375)            
        elseif MyLevel >= 2450 and MyLevel <= 2474 then
            Mon = "Isle Outlaw"
            LevelQuest = 1
            NameQuest = "TikiQuest1"
            NameMon = "Isle Outlaw"
            CFrameQuest = CFrame.new(-16547.748046875, 61.13533401489258, -173.41360473632812)
            CFrameMon = CFrame.new(-16442.814453125, 116.13899993896484, -264.4637756347656)
        elseif MyLevel >= 2475 and MyLevel <= 2524 then
            Mon = "Island Boy"
            LevelQuest = 2
            NameQuest = "TikiQuest1"
            NameMon = "Island Boy"
            CFrameQuest = CFrame.new(-16547.748046875, 61.13533401489258, -173.41360473632812)
            CFrameMon = CFrame.new(-16901.26171875, 84.06756591796875, -192.88906860351562)
        elseif MyLevel >= 2525 and MyLevel <= 2550 then
            Mon = "Isle Champion"
            LevelQuest = 2
            NameQuest = "TikiQuest2"
            NameMon = "Isle Champion"
            CFrameQuest = CFrame.new(-16539.078125, 55.68632888793945, 1051.5738525390625)
            CFrameMon = CFrame.new(-16641.6796875, 235.7825469970703, 1031.282958984375)
        elseif MyLevel >= 2550 and MyLevel <= 2574 then
            Mon = "Serpent Hunter"
            LevelQuest = 1
            NameQuest = "TikiQuest3"
            NameMon = "Serpent Hunter"
            CFrameQuest = CFrame.new(-16665.1914, 104.596405, 1579.69434, 0.951068401, -0, -0.308980465, 0, 1, -0, 0.308980465, 0, 0.951068401)
            CFrameMon = CFrame.new(-16521.0625, 106.09285, 1488.78467, 0.469467044, 0, 0.882950008, 0, 1, 0, -0.882950008, 0, 0.469467044)
        elseif MyLevel >= 2575 then
            Mon = "Skull Slayer"
            LevelQuest = 2
            NameQuest = "TikiQuest3"
            NameMon = "Skull Slayer"
            CFrameQuest = CFrame.new(-16665.1914, 104.596405, 1579.69434, 0.951068401, -0, -0.308980465, 0, 1, -0, 0.308980465, 0, 0.951068401)
            CFrameMon = CFrame.new(-16855.043, 122.457253, 1478.15308, -0.999392271, 0, -0.0348687991, 0, 1, 0, 0.0348687991, 0, -0.999392271)
        end
    end
end
task.spawn(function()
    repeat task.wait(1) until player:FindFirstChild("Data") and player.Data:FindFirstChild("Level")
    CheckLevel() 
end)

function HasQuest()
    local QuestUI = player.PlayerGui.Main.Quest
    if QuestUI.Visible then
        local text = QuestUI.Container.QuestTitle.Title.Text
        return string.find(text, NameMon)
    end
    return false
end

spawn(function()
    while task.wait() do
        if _G.AutoLevel then
            pcall(function()
                CheckLevel()

                if not HasQuest() then
                    UseHeightAbove = false
                    
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("AbandonQuest")
                    wait(0.5)
                    Tween(CFrameQuest)
                    local dist = (CFrameQuest.Position - player.Character.HumanoidRootPart.Position).Magnitude
                    if dist <= 25 then
                        wait(0.5)
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", NameQuest, LevelQuest)
                        wait(1)
                    end
                else
                    local foundEnemy = false
                    for _, v in pairs(workspace.Enemies:GetChildren()) do
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and v.Name == Mon then
                            foundEnemy = true
                            CurrentTargetPos = v.HumanoidRootPart.Position

                            UseHeightAbove = true

                            repeat
                                task.wait()
                                AutoHaki()
                                EquipTool(SelectWeapon)
                                
                                SmoothStayAbove(v.HumanoidRootPart)
                                
                                CurrentTargetPos = v.HumanoidRootPart.Position
                                
                                if _G.BringEnemy then
                                    BringMob(true)
                                end

                                v.Humanoid.JumpPower = 0
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
                                v.HumanoidRootPart.Transparency = 1

                                if not _G.AutoLevel or not v.Parent or v.Humanoid.Health <= 0 or not HasQuest() then
                                    break
                                end
                            until not _G.AutoLevel or not v.Parent or v.Humanoid.Health <= 0 or not HasQuest()
                            break
                        end
                    end
                    
                    if not foundEnemy then
                        UseHeightAbove = false
                        Tween(CFrameMon)
                        CurrentTargetPos = Vector3.new(0, 0, 0)
                    end
                end
            end)
        end
    end
end)

local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.F then
        _G.AutoLevel = not _G.AutoLevel
    end
    
    if input.KeyCode == Enum.KeyCode.G then
        _G.BringEnemy = not _G.BringEnemy
        
        if not _G.BringEnemy then
            for _, v in pairs(workspace.Enemies:GetChildren()) do
                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                    v.HumanoidRootPart.CanCollide = true
                    v.Humanoid.WalkSpeed = 16
                    v.Humanoid.JumpPower = 50
                end
            end
        end
    end
end)

-- Biến để theo dõi trạng thái vòng lặp
local randomFruitRunning = false
local storeFruitRunning = false

-- Auto Random Fruit Toggle (phiên bản tối ưu)
SubFarmingTab:MakeToggle("RandomFF", {
    ["Title"] = "Auto Random Fruit",
    ["Content"] = "Automatic random devil fruit",
    ["Default"] = false,
    ["Callback"] = function(Value)
        _G.Random_Auto = Value
        if Value and not randomFruitRunning then
            randomFruitRunning = true
            spawn(function()
                while _G.Random_Auto and wait(Sec) do
                    pcall(function()
                        replicated.Remotes.CommF_:InvokeServer("Cousin", "Buy")
                    end)
                end
                randomFruitRunning = false
            end)
        end
    end
})

-- Auto Store Fruit Toggle (phiên bản tối ưu)
SubFarmingTab:MakeToggle("StoredF", {
    ["Title"] = "Auto Store Fruit",
    ["Content"] = "Automatic store devil fruit",
    ["Default"] = false,
    ["Callback"] = function(Value)
        _G.StoreF = Value
        if Value and not storeFruitRunning then
            storeFruitRunning = true
            spawn(function()
                while _G.StoreF and wait(Sec) do
                    pcall(function()
                        UpdStFruit()
                    end)
                end
                storeFruitRunning = false
            end)
        end
    end
})
            
