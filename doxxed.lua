-- thx ride and frosted for the docs and also i reccomend looking into the source cuz im lazy + i probably did everything maybe idk also ignore my tp they're just for testing 
local startTick = tick()
local UserInputService=game:GetService("UserInputService")
local BodyVelocity=Instance.new("BodyVelocity")
local aimhook=Instance.new("Folder",game.CoreGui)
local aFolder=Instance.new("Folder",workspace)
aFolder.Name="HiCastlers"..math.random(1,10000000)
aimhook.Name="aimhook"
local arsonfuncs={}
local SelfAccessories={}
local ChrModels = game:GetObjects("rbxassetid://12194933496")[1]
local clientScript=getsenv(game.Players.LocalPlayer.PlayerGui.Client)--shit ik, yet effective.
ChrModels.Parent = game.CoreGui

BodyVelocity.MaxForce = Vector3.new(math.huge, 0, math.huge)
local mt = getrawmetatable(game)

make_writeable(mt)
local oldmt=mt.__namecall

mt.__namecall = newcclosure(function(self,...)
  local method = getnamecallmethod()

  if method == 'Kick' then
     wait(9e9)
     return nil
  end

   return oldmt(self,...)
end)
local library =
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Storm99999/whitelistkeys/main/0ctolib2.lua"))(
    {cheatname = "aimhook", gamename = "CounterBlox"} --
)
function arsonfuncs:RotationY(cframe)
    local x, y, z = cframe:ToOrientation()
    return CFrame.new(cframe.Position) * CFrame.Angles(0,y,0)
end

function arsonfuncs:GetWorkspaceFolder()
    return aFolder;    
end

function arsonfuncs:IsNotBehindWall(target)
    local dwLocalPlayer = game.Players.LocalPlayer
    local dwCamera = workspace.CurrentCamera
    if not dwLocalPlayer.Character then return end
    local raycast = Ray.new(dwLocalPlayer.Character.Head.Position, (target.Position - dwLocalPlayer.Character.Head.Position).Unit*3000)
    local close_part, position = game:GetService("Workspace"):FindPartOnRayWithIgnoreList(raycast, {
        dwLocalPlayer.Character
    },
    false,
    true
    )

    if close_part and close_part.Parent then
        local hum = close_part.Parent:FindFirstChildOfClass("Humanoid")
        --if not hum.Parent and not hum.Parent.Parent then return end
        if not hum then
            --hum = part.Parent.Parent:FindFirstChildOfClass("Humanoid")    
        end
        
        if hum and target and hum.Parent == target.Parent then
            local pos, is_visible = dwCamera:WorldToScreenPoint(target.Position)
            if is_visible then
                return true    
            end
        end
    end
end

function arsonfuncs:Plant()
    if not game.Players.LocalPlayer.Character then return end
	if not game.Workspace.Map.Gamemode.Value == "defusal" then return end
	local pos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
	game.Workspace.CurrentCamera.CameraType = "Fixed"
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Map.SpawnPoints.C4Plant.CFrame
	task.wait(.2)
	game.ReplicatedStorage.Events.PlantC4:FireServer((pos+Vector3.new(0, -2.75, 0))*CFrame.Angles(math.rad(90), 0, math.rad(180)), "A")
	task.wait(.2)
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
	game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
	game.Workspace.CurrentCamera.CameraType = "Custom"
	game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
end

function arsonfuncs:IsAlive(p) if p.Character and p.Character:FindFirstChild("Humanoid") and p.Character:FindFirstChild("UpperTorso") and p.Character.Humanoid.Health > 0 then return true end return false end

local CurrentCamera = workspace.CurrentCamera
local Players = game.GetService(game, "Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

function arsonfuncs:ClosestPlayer()
    local MaxDist, Closest = math.huge
    for I,V in pairs(Players.GetPlayers(Players)) do
        if V == LocalPlayer then continue end
        if V.Team == LocalPlayer then continue end
        if not V.Character then continue end
        local Head = V.Character.FindFirstChild(V.Character, "Head")
        if not Head then continue end
        local Pos, Vis = CurrentCamera.WorldToScreenPoint(CurrentCamera, Head.Position)
        if not Vis then continue end
        local MousePos, TheirPos = Vector2.new(Mouse.X, Mouse.Y), Vector2.new(Pos.X, Pos.Y)
        local Dist = (TheirPos - MousePos).Magnitude
        if Dist < MaxDist then
            MaxDist = Dist
            Closest = V
        end
    end
    return Closest
end

function arsonfuncs:SwapCharacter(with)
    local LocalPlayer=game.Players.LocalPlayer
    for _,Part in pairs (LocalPlayer.Character:GetChildren()) do
        if Part:IsA("Accessory") then
            Part:Destroy()
        end
        if Part:IsA("BasePart") then
            if with:FindFirstChild(Part.Name) then
                Part.Color = with:FindFirstChild(Part.Name).Color
                Part.Transparency = with:FindFirstChild(Part.Name).Transparency
            end
            if Part.Name == "FakeHead" then
				Part.Color = with:FindFirstChild("Head").Color
                Part.Transparency = with:FindFirstChild("Head").Transparency
            end
        end

        if (Part.Name == "Head" or Part.Name == "FakeHead") and Part:FindFirstChildOfClass("Decal") and with.Head:FindFirstChildOfClass("Decal") then
            Part:FindFirstChildOfClass("Decal").Texture = with.Head:FindFirstChildOfClass("Decal").Texture
        end
    end

    if with:FindFirstChildOfClass("Shirt") then
        if LocalPlayer.Character:FindFirstChildOfClass("Shirt") then
            LocalPlayer.Character:FindFirstChildOfClass("Shirt"):Destroy()
        end
        local Clone = with:FindFirstChildOfClass("Shirt"):Clone()
        Clone.Parent = LocalPlayer.Character
    end

    if with:FindFirstChildOfClass("Pants") then
        if LocalPlayer.Character:FindFirstChildOfClass("Pants") then
            LocalPlayer.Character:FindFirstChildOfClass("Pants"):Destroy()
        end
        local Clone = with:FindFirstChildOfClass("Pants"):Clone()
        Clone.Parent = LocalPlayer.Character
    end

    for _,Part in pairs (with:GetChildren()) do
        if Part:IsA("Accessory") then
            local Clone = Part:Clone()
            for _,Weld in pairs (Clone.Handle:GetChildren()) do
                if Weld:IsA("Weld") and Weld.Part1 ~= nil then
                    Weld.Part1 = LocalPlayer.Character[Weld.Part1.Name]
                end
            end
            Clone.Parent = LocalPlayer.Character
        end
    end

	if LocalPlayer.Character:FindFirstChildOfClass("Shirt") then
		local String = Instance.new("StringValue")
		String.Name = "OriginalTexture"
		String.Value = LocalPlayer.Character:FindFirstChildOfClass("Shirt").ShirtTemplate
		String.Parent = LocalPlayer.Character:FindFirstChildOfClass("Shirt")

	end
	if LocalPlayer.Character:FindFirstChildOfClass("Pants") then
		local String = Instance.new("StringValue")
		String.Name = "OriginalTexture"
		String.Value = LocalPlayer.Character:FindFirstChildOfClass("Pants").PantsTemplate
		String.Parent = LocalPlayer.Character:FindFirstChildOfClass("Pants")

		
	end
	for i,v in pairs(LocalPlayer.Character:GetChildren()) do
		if v:IsA("BasePart") and v.Transparency ~= 1 then
			table.insert(SelfAccessories, v)
			local Color = Instance.new("Color3Value")
			Color.Name = "OriginalColor"
			Color.Value = v.Color
			Color.Parent = v

			local String = Instance.new("StringValue")
			String.Name = "OriginalMaterial"
			String.Value = v.Material.Name
			String.Parent = v
		elseif v:IsA("Accessory") and v.Handle.Transparency ~= 1 then
			table.insert(SelfAccessories, v.Handle)
			local Color = Instance.new("Color3Value")
			Color.Name = "OriginalColor"
			Color.Value = v.Handle.Color
			Color.Parent = v.Handle

			local String = Instance.new("StringValue")
			String.Name = "OriginalMaterial"
			String.Value = v.Handle.Material.Name
			String.Parent = v.Handle
		end
	end

	
end
local VMOffsets={X=.5,Y=.5,Z=.5};
local configTable = {
    Aimlock={
        Enabled=false,
        Smoothness=0.08,
        AimPart="Head",
        PredictMovement=true,
        TPAura=false,
        SilentAim=false,
        Penetration=false,
        GunMods={ NoRecoil=false },
        Auto=false,
        AutoMethod='firebullet',
        Backtrack=false,
        BacktrackDelay=200,
        BacktrackType='Parts',
    },

    AntiAim={
        Enabled=false,
        Type='aimhook',
        OhioYawStrenght=50,
        SpinYawStrenght=50,
        UseRotation=false,
        Rotation=180,
    },
    
    Player={
        BunnyHop=false,
        BunnyHopType="Humanoid",
        BunnySpeed=20,
        Hitsounds=false,
        Volume=1,
        ThirdPerson=true,
        NoFall=false,
        RemKillers=false,
        KillSay=false,
        ChatContext='1, sit no name dog!',
        Head=false,
        Acc=false,
    },
    
    Visuals={
        ESP=false,
        ESPColor=Color3.fromRGB(255,0,255),
        ESPOutline=Color3.fromRGB(26, 35, 57),
        VMChange=false,
        BulletTracers=false,
        BMaterial="ForceField",
        BColor=Color3.fromRGB(255,0,255),
        GunChams=false,
        Chams=false,
        ChamsColor=Color3.fromRGB(255,0,255),
        ForceCrosshair=false,
    },

    Exploits={
        InfiniteCash=false,
        Multi=false,
        Multiplier=0,
        DoubleTap=0,
        Invisibility=false,
    },
    
    Hitsound="skeet.cc",
    Characters={},
    SelectedChar="Delinquent",
    GC_THEME="aimhook",
    GC_TRANSPARENCY=.5,
    CustomColor=Color3.fromRGB(255,0,255),
    CustomMaterial="ForceField",
    Effects={}
}

for _,v in pairs(ChrModels:GetChildren())do
    table.insert(configTable.Characters, v.Name or nil)
end
library:init()
local utility = library.utility
local signal = library.signal

local menu =
    library.NewWindow({title = library.cheatname .. " - dev | " ..   library.gamename, size = UDim2.new(0, 500, 0.5, 20)}) 

--> Tabs <-- 
local CombatTab = menu:AddTab("Combat")
local Visualstab5 = menu:AddTab("Visuals")
local Misctab = menu:AddTab("Misc")
local Plrtab = menu:AddTab("Player")
local aatab = menu:AddTab("AntiAim")

local SettingsTab = library:CreateSettingsTab(menu)
--> sections <-- 
local Aimbotsec = CombatTab:AddSection("Aim Assist", 1)
local aaSec = aatab:AddSection("Anti Aim", 1)
local mods = CombatTab:AddSection("Gun Mods", 2)

local Visualstab = Visualstab5:AddSection("Visuality",1)
local VM = Visualstab5:AddSection("Viewmodel",2)
local gc = Visualstab5:AddSection("Gun Chams",1)

--local saimsec = CombatTab:AddSection("Bullet-Prioritize", 2)
local playerSec=Plrtab:AddSection("Utility", 1)
local exploitssec = Misctab:AddSection("Exploits", 1)



gc:AddToggle(
    {
      
        state = false;
        tooltip = 'very nice effect!';
        risky = false,
        text = "Enabled",
        flag = "testflag",
        callback = function(bool)
            configTable.Visuals.GunChams=bool;
        end 
    }
)

local fatass = gc:AddToggle(
    {
      
        state = false;
        tooltip = 'very nice effect!';
        risky = false,
        text = "Custom Color",
        flag = "testflag",
        callback = function(bool)
            --configTable.CustomColor=bool;
        end 
    }
)
fatass:AddColor(
    {
        text = "Color",
          color = Color3.new(255,0,255);
          tooltip = 'Give yourself a custom color!';
        flag = "",
        callback = function(f)
            configTable.CustomColor=f;
        end
    }
)

gc:AddSlider(
    {
        text = "Custom Transparency",
        flag = '"',
        suffix = "°",
        min = .1,
        max = 1,
        increment = .1,
        callback = function(v)
            configTable.GC_TRANSPARENCY = v;
        end
    }
)
gc:AddList(
    {
        text = "Custom Gun Material",
        flag = "",
        selected = {"ForceField"};
        multi = false,
        values = { 
            "ForceField",
            "Neon",
            "Glass",
        },
    --   
        callback = function(bool)
            configTable.CustomMaterial=bool;
        end
    }
)
gc:AddList(
    {
        text = "Gun Theme",
        flag = "",
        selected = {"aimhook"};
        multi = false,
        values = { 
            "aimhook",
            "stormware.cc",
            "onetap.lua",
            "lgbtq",
            "custom",
        },
    --   
        callback = function(bool)
            configTable.GC_THEME=bool;
        end
    }
)


aaSec:AddToggle(
    {
      
        state = false;
        tooltip = 'probably should be enabled for hvh';
        risky = false,
        text = "Enabled",
        flag = "testflag",
        callback = function(bool)
            configTable.AntiAim.Enabled=bool;
        end 
    }
)
aaSec:AddToggle(
    {
      
        state = false;
        tooltip = 'probably should be enabled for hvh';
        risky = false,
        text = "Use Rotation",
        flag = "testflag",
        callback = function(bool)
            configTable.AntiAim.UseRotation=bool;
        end 
    }
)
aaSec:AddSlider(
    {
        text = "Rotation",
        flag = '"',
        suffix = "°",
        min = 1,
        max = 400,
        increment = 1,
        callback = function(v)
            configTable.AntiAim.Rotation=v;
        end
    }
)
aaSec:AddSlider(
    {
        text = "Spin Yaw Strenght",
        flag = '"',
        suffix = "°",
        min = 1,
        max = 400,
        increment = 1,
        callback = function(v)
            configTable.AntiAim.SpinYawStrenght=v;
        end
    }
)
aaSec:AddSlider(
    {
        text = "Ohio Yaw Strenght",
        flag = '"',
        suffix = "°",
        min = 1,
        max = 400,
        increment = 1,
        callback = function(v)
            configTable.AntiAim.SpinYawStrenght=v;
        end
    }
)
aaSec:AddList(
    {
        text = "Anti Aim Type",
        flag = "",
        selected = {"aimhook"};
        multi = false,
        values = { 
            "aimhook",
            "silly ahh",
            "Down",
            "Up",
            "Random",
            "jjsploit",
            "jizz",
            "classic",
            "next gen",
            "spin",
            "ohio",
        },
    --   
        callback = function(bool)
            configTable.AntiAim.Type=bool;
        end
    }
)

mods:AddButton(
    {
        text = "Infinite Ammo",
        risky = true,
        confirm = false, 
        callback = function()
            local mt = getrawmetatable(game)
            make_writeable(mt);
            local old_index = mt.__index
            
            mt.__index = function(i, vls)
                if tostring(i) == "StoredAmmo" then
                    if tostring(vls) == "Value" then
                        return 99999 
                    end
                end
                
                return old_index(i,vls)
            end
            
            local mt = getrawmetatable(game)
            make_writeable(mt);
            local old_index = mt.__index
            
            mt.__index = function(i, vls)
                if tostring(i) == "Ammo" then
                    if tostring(vls) == "Value" then
                        return 99999 
                    end
                end
                
                return old_index(i,vls)
            end	
        end
    }
)


mods:AddButton(
    {
        text = "Fire Rate",
        risky = true,
        confirm = false, 
        callback = function()
            
            local mt = getrawmetatable(game)
            make_writeable(mt);
            local old_index = mt.__index
            
            mt.__index = function(i, vls)
                if tostring(i) == "FireRate" then
                    if tostring(vls) == "Value" then
                        return 0.02 
                    end
                end
                
                return old_index(i,vls)
            end	
        end
    }
)

mods:AddButton(
    {
        text = "Instant Reload",
        risky = true,
        confirm = false, 
        callback = function()
            
            local mt = getrawmetatable(game)
            make_writeable(mt);
            local old_index = mt.__index
            
            mt.__index = function(i, vls)
                if tostring(i) == "ReloadTime" then
                    if tostring(vls) == "Value" then
                        return 0.01
                    end
                end
                
                return old_index(i,vls)
            end	
        end
    }
)

mods:AddButton(
    {
        text = "Instant Equip",
        risky = true,
        confirm = false, 
        callback = function()
            
            local mt = getrawmetatable(game)
            make_writeable(mt);
            local old_index = mt.__index
            
            mt.__index = function(i, vls)
                if tostring(i) == "EquipTime" then
                    if tostring(vls) == "Value" then
                        return 0
                    end
                end
                
                return old_index(i,vls)
            end	
        end
    }
)
mods:AddToggle(
    {
      
        state = false;
        tooltip = 'No Recoil';
        risky = false,
        text = "No Recoil",
        flag = "testflag",
        callback = function(bool)
            configTable.Aimlock.GunMods.NoRecoil=bool;
        end 
    }
)


playerSec:AddToggle(
    {
      
        state = false;
        tooltip = 'Bunny Hop!';
        risky = false,
        text = "Bunny Hop",
        flag = "testflag",
        callback = function(bool)
            configTable.Player.BunnyHop=bool;
        end 
    }
)
playerSec:AddList(
    {
        text = "BunnyHop Type",
        flag = "",
        selected = {"Humanoid"};
        multi = false,
        values = { 
            "Humanoid",
            "Velocity",
        },
    --   
        callback = function(bool)
            configTable.Player.BunnyHopType=bool;
        end
    }
)
playerSec:AddSlider(
    {
        text = "BunnyHop Speed",
        flag = '"',
        suffix = "°",
        min = 10,
        max = 100,
        increment = 1,
        callback = function(v)
            configTable.Player.BunnySpeed=v;
        end
    }
)

playerSec:AddToggle(
    {
      
        state = false;
        tooltip = 'Says a message when you get a kill.';
        risky = false,
        text = "Kill Say",
        flag = "testflag",
        callback = function(bool)
            configTable.Player.KillSay=bool;
        end 
    }
)

playerSec:AddToggle(
    {
      
        state = false;
        tooltip = 'removes your head hitboxes!';
        risky = false,
        text = "Remove Head",
        flag = "testflag",
        callback = function(bool)
            configTable.Player.Head=bool;
        end 
    }
)

playerSec:AddToggle(
    {
      
        state = false;
        tooltip = 'removes your accessories';
        risky = false,
        text = "Remove Accessories",
        flag = "testflag",
        callback = function(bool)
            configTable.Player.Acc=bool;
        end 
    }
)

playerSec:AddBox(
    {
        text = "Message",
        flag = "box",
        input = '';
         focused = true;
        callback = function(text)
            configTable.Player.ChatContext=text;
        end
    }
)

local th = playerSec:AddToggle(
    {
      
        state = true;
        tooltip = 'ThirdPerson';
        risky = false,
        text = "Third person",
        flag = "testflag",
        callback = function(bool)
            configTable.Player.ThirdPerson=bool;
            if bool then
                game.Players.LocalPlayer.CameraMaxZoomDistance = 15
				game.Players.LocalPlayer.CameraMinZoomDistance =15
            else
                game.Players.LocalPlayer.CameraMaxZoomDistance = 0
				game.Players.LocalPlayer.CameraMinZoomDistance = 0
            end
        end 
    }
)

playerSec:AddToggle(
    {
      
        state = false;
        tooltip = 'Removes Fall damage!';
        risky = false,
        text = "No Fall",
        flag = "testflag",
        callback = function(bool)
            configTable.Player.NoFall=bool;
        end 
    }
)

playerSec:AddToggle(
    {
      
        state = false;
        tooltip = 'Removes The kill spots!';
        risky = false,
        text = "Remove Killers",
        flag = "testflag",
        callback = function(bool)
            configTable.Player.RemKillers=bool;
            if bool then
                if workspace:FindFirstChild("Map") and workspace:FindFirstChild("Map"):FindFirstChild("Killers") then
    				local clone = workspace:FindFirstChild("Map"):FindFirstChild("Killers"):Clone()
    				clone.Name = "Cloned"
    				clone.Parent = workspace:FindFirstChild("Map")
    	
    				workspace:FindFirstChild("Map"):FindFirstChild("Killers"):Destroy()
			    end        
            else
                if workspace:FindFirstChild("Map") and workspace:FindFirstChild("Map"):FindFirstChild("Cloned") then
			        workspace:FindFirstChild("Map"):FindFirstChild("Cloned").Name = "Killers"
		        end
            end
        end 
    }
)

th:AddBind(
    {
        tooltip = 'Bind';
        text = "Bind",
         mode = "hold",
          risky = true,
        flag = "Aimbotkeybind",
        nomouse = false,
        noindicator = false,
        bind = Enum.KeyCode.E,
        callback = function(bool)
            configTable.Player.ThirdPerson = not configTable.Player.ThirdPerson
        end
    }
)

playerSec:AddToggle(
    {
      
        state = false;
        tooltip = 'A sound shall play when EnemyHit';
        risky = false,
        text = "Hitsounds",
        flag = "testflag",
        callback = function(bool)
            configTable.Player.Hitsounds=bool;
        end 
    }
)

playerSec:AddList(
    {
        text = "sound",
        flag = "",
        selected = {"nl"};
        multi = false,
        values = {"skeet.cc", "rust", "bag", "sit","reminder","uwu","zing","crowbar","ara ara","burp","mario","laugh","huh","nl"},
    --   
        callback = function(bool)
            configTable.Hitsound=bool;
        end
    }
)
playerSec:AddSlider(
    {
        text = "Volume",
        flag = '"',
        suffix = "°",
        min = 1,
        max = 10,
        increment = 1,
        callback = function(v)
            configTable.Player.Volume=v;
        end
    }
)
exploitssec:AddToggle(
    {
      
        state = false;
        tooltip = 'Gives You Infinite Cash';
        risky = false,
        text = "Infinite Cash",
        flag = "testflag",
        callback = function(bool)
            configTable.Exploits.InfiniteCash=bool;
        end 
    }
)

exploitssec:AddButton(
    {
        text = "Invisibility",
        risky = true,
        confirm = false, 
        callback = function()
                if not game.Players.LocalPlayer.Character then return end
    local cframe = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    local troll_cframe = CFrame.new(-45591, 46595, -4822) -- void, have fun wallbanging LOL.
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = troll_cframe
    

    local esc = game.Players.LocalPlayer.Character.LowerTorso:GetChildren()
       for i, v in pairs(esc) do
         v:Destroy()
         wait()
       end
       
           game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cframe

        end
    }
)

exploitssec:AddToggle(
    {
      
        state = false;
        tooltip = 'Triple Tap';
        risky = false,
        text = "Triple Tap",
        flag = "testflag",
        callback = function(bool)
            configTable.Exploits.DoubleTap=bool;
        end 
    }
)
local fl = exploitssec:AddToggle(
    {
      
        state = false;
        tooltip = 'Fake lags you!';
        risky = false,
        text = "Fake Lag",
        flag = "testflag",
        callback = function(bool)
            if bool then
                game:GetService("NetworkClient"):SetOutgoingKBPSLimit(1)
            else
                game:GetService("NetworkClient"):SetOutgoingKBPSLimit(9e9)    
            end
        end 
    }
)
local pl = exploitssec:AddToggle(
    {
      
        state = false;
        tooltip = 'Plant C4';
        risky = false,
        text = "Plant C4",
        flag = "testflag",
        callback = function(bool)
            if bool then
                arsonfuncs:Plant()
            end
        end 
    }
)

pl:AddBind(
    {
        tooltip = 'Bind';
        text = "Bind",
         mode = "hold",
          risky = true,
        flag = "Aimbotkeybind",
        nomouse = false,
        noindicator = false,
        bind = Enum.KeyCode.Equals,
        callback = function(bool)
            if bool then
                arsonfuncs:Plant()
            end
        end
    }
)

fl:AddBind(
    {
        tooltip = 'Bind';
        text = "Bind",
         mode = "hold",
          risky = true,
        flag = "Aimbotkeybind",
        nomouse = false,
        noindicator = false,
        bind = Enum.KeyCode.Equals,
        callback = function(bool)
            
        end
    }
)

exploitssec:AddToggle(
    {
      
        state = false;
        tooltip = 'Damage Multiplier';
        risky = false,
        text = "Damage Multiplier",
        flag = "testflag",
        callback = function(bool)
            configTable.Exploits.Multi=bool;
        end 
    }
)
exploitssec:AddSlider(
    {
        text = "Multiplier",
        flag = '"',
        suffix = "°",
        min = 1,
        max = 10,
        increment = 1,
        callback = function(v)
            configTable.Exploits.Multiplier=v;
        end
    }
)
exploitssec:AddToggle(
    {
      
        state = false;
        tooltip = 'Changes your Character!';
        risky = false,
        text = "Character Changer",
        flag = "testflag",
        callback = function(bool)
            if bool then
                arsonfuncs:SwapCharacter(ChrModels:FindFirstChild(configTable.SelectedChar))    
            end
        end 
    }
)
exploitssec:AddList(
    {
        text = "Character",
        flag = "",
        selected = {"Delinquent"};
        multi = false,
        values = configTable.Characters,
    --   
        callback = function(bool)
            configTable.SelectedChar=bool;
        end
    }
)
local aimbottoggle = Aimbotsec:AddToggle(
    {
      
        state = false;
        tooltip = 'Aimlock';
        risky = false,
        text = "Smooth Bot",
        flag = "testflag",
        callback = function(bool)
            configTable.Aimlock.Enabled=bool;
        end 
    }
)
local aimbottoggle = Aimbotsec:AddToggle(
    {
      
        state = false;
        tooltip = 'Backtracks';
        risky = false,
        text = "Backtrack",
        flag = "testflag",
        callback = function(bool)
            configTable.Aimlock.Backtrack=bool;
        end 
    }
)

Aimbotsec:AddToggle(
    {
      
        state = false;
        tooltip = 'Silently Aims for you!';
        risky = false,
        text = "Silent Aim",
        flag = "testflag",
        callback = function(bool)
            configTable.Aimlock.SilentAim=bool;
        end 
    }
)

Aimbotsec:AddToggle(
    {
      
        state = false;
        tooltip = 'Auto Shoot';
        risky = false,
        text = "Auto Tap",
        flag = "testflag",
        callback = function(bool)
            configTable.Aimlock.Auto=bool;
        end 
    }
)
Aimbotsec:AddList(
    {
        text = "Auto Shoot Method",
        flag = "",
        selected = {"firebullet"};
        multi = false,
        values = { 
            "firebullet",
            "VirtualUser",
        },
    --   
        callback = function(bool)
            configTable.Aimlock.AutoMethod=bool;
        end
    }
)
Aimbotsec:AddList(
    {
        text = "Backtrack Method",
        flag = "",
        selected = {"Parts"};
        multi = false,
        values = { 
            "Parts",
            "Character",
        },
    --   
        callback = function(bool)
            configTable.Aimlock.BacktrackType=bool;
        end
    }
)
Aimbotsec:AddToggle(
    {
      
        state = false;
        tooltip = 'Wallbang';
        risky = false,
        text = "Wallbang",
        flag = "testflag",
        callback = function(bool)
            configTable.Aimlock.Penetration=bool;
        end 
    }
)

local espTOg = Visualstab:AddToggle(
    {
      
        state = false;
        tooltip = 'ESP';
        risky = false,
        text = "ESP",
        flag = "testflag",
        callback = function(bool)
            configTable.Visuals.ESP=bool;
        end 
    }
)
local espTOg2 = Visualstab:AddToggle(
    {
      
        state = false;
        tooltip = 'ESP Outline';
        risky = false,
        text = "ESP Outline",
        flag = "testflag",
        callback = function(bool)
        end 
    }
)
local espTOg2 = Visualstab:AddToggle(
    {
      
        state = false;
        tooltip = 'Brings back your crosshair!';
        risky = false,
        text = "Force Crosshair",
        flag = "testflag",
        callback = function(bool)
            configTable.Visuals.ForceCrosshair=bool;
        end 
    }
)
Visualstab:AddList(
    {
        text = "Remove Effects",
        flag = "",
        selected = {};
        multi = true,
        values = { 
            "Scope",
            "Flash",
            "Smoke",
            "Bullet Holes",
            "Blood",
        },
    --   
        callback = function(val)
            configTable.Effects=val;
        	if table.find(val, "Scope") then
        		LocalPlayer.PlayerGui.GUI.Crosshairs.Scope.ImageTransparency = 1
        		LocalPlayer.PlayerGui.GUI.Crosshairs.Scope.Scope.ImageTransparency = 1
        		LocalPlayer.PlayerGui.GUI.Crosshairs.Scope.Scope.Size = UDim2.new(2,0,2,0)
        		LocalPlayer.PlayerGui.GUI.Crosshairs.Scope.Scope.Position = UDim2.new(-0.5,0,-0.5,0)
        		LocalPlayer.PlayerGui.GUI.Crosshairs.Scope.Scope.Blur.ImageTransparency = 1
        		LocalPlayer.PlayerGui.GUI.Crosshairs.Scope.Scope.Blur.Blur.ImageTransparency = 1
        		LocalPlayer.PlayerGui.GUI.Crosshairs.Frame1.Transparency = 1
        		LocalPlayer.PlayerGui.GUI.Crosshairs.Frame2.Transparency = 1
        		LocalPlayer.PlayerGui.GUI.Crosshairs.Frame3.Transparency = 1
        		LocalPlayer.PlayerGui.GUI.Crosshairs.Frame4.Transparency = 1
        	else
        		LocalPlayer.PlayerGui.GUI.Crosshairs.Scope.ImageTransparency = 0
        		LocalPlayer.PlayerGui.GUI.Crosshairs.Scope.Scope.ImageTransparency = 0
        		LocalPlayer.PlayerGui.GUI.Crosshairs.Scope.Scope.Size = UDim2.new(1,0,1,0)
        		LocalPlayer.PlayerGui.GUI.Crosshairs.Scope.Scope.Position = UDim2.new(0,0,0,0)
        		LocalPlayer.PlayerGui.GUI.Crosshairs.Scope.Scope.Blur.ImageTransparency = 0
        		LocalPlayer.PlayerGui.GUI.Crosshairs.Scope.Scope.Blur.Blur.ImageTransparency = 0
        		LocalPlayer.PlayerGui.GUI.Crosshairs.Frame1.Transparency = 0
        		LocalPlayer.PlayerGui.GUI.Crosshairs.Frame2.Transparency = 0
        		LocalPlayer.PlayerGui.GUI.Crosshairs.Frame3.Transparency = 0
        		LocalPlayer.PlayerGui.GUI.Crosshairs.Frame4.Transparency = 0
        	end
        	
        	if table.find(val, "Flash") then
        		LocalPlayer.PlayerGui.Blnd.Enabled = false
        	else
        		LocalPlayer.PlayerGui.Blnd.Enabled = true
        	end
        	
        	if table.find(val, "Smoke") then
        		for i,v in pairs(workspace.Ray_Ignore.Smokes:GetChildren()) do
        			if v.Name == "Smoke" then
        				v:Remove()
        			end
        		end
        	end
        	
        	if table.find(val, "Bullet Holes") then
        		for i,v in pairs(workspace.Debris:GetChildren()) do
        			if v.Name == "Bullet" then
        				v:Remove()
        			end
        		end
        	end
        	
        	if table.find(val, "Blood") then
        		for i,v in pairs(workspace.Debris:GetChildren()) do
        			if v.Name == "SurfaceGui" then
        				v:Remove()
        			end
        		end
        	end
        end
    }
)

local chamsTog = Visualstab:AddToggle(
    {
      
        state = false;
        tooltip = 'Chams';
        risky = false,
        text = "Chams",
        flag = "testflag",
        callback = function(bool)
            configTable.Visuals.Chams=bool;
        end 
    }
)


chamsTog:AddColor(
    {
        text = "Color",
          color = Color3.new(255,0,255);
          tooltip = '';
        flag = "",
        callback = function(f)
            configTable.Visuals.ChamsColor=f;
        end
    }
)
local btrac=Visualstab:AddToggle(
    {
      
        state = false;
        tooltip = 'Trace Your Bullets!';
        risky = false,
        text = "Bullet Tracers",
        flag = "testflag",
        callback = function(bool)
            configTable.Visuals.BulletTracers=bool;
        end 
    }
)
VM:AddToggle(
    {
      
        state = false;
        tooltip = 'Enable';
        risky = false,
        text = "Viewmodel Changer",
        flag = "testflag",
        callback = function(bool)
            configTable.Visuals.VMChange=bool;
        end 
    }
)
btrac:AddColor(
    {
        text = "Color",
          color = Color3.new(255,0,255);
          tooltip = '';
        flag = "",
        callback = function(f)
            configTable.Visuals.BColor=f;
        end
    }
)
Visualstab:AddList(
    {
        text = "Bullet Tracers Material",
        flag = "",
        selected = {"ForceField"};
        multi = false,
        values = { 
            "ForceField",
            "Neon",
            "Glass",
        },
    --   
        callback = function(bool)
            configTable.Visuals.BMaterial=bool;
        end
    }
)
espTOg:AddColor(
    {
        text = "Color",
          color = Color3.new(255,0,255);
          tooltip = '';
        flag = "",
        callback = function(f)
            configTable.Visuals.ESPColor=f;
        end
    }
)
espTOg2:AddColor(
    {
        text = "Color",
          color = Color3.new(255,0,255);
          tooltip = '';
        flag = "",
        callback = function(f)
            configTable.Visuals.ESPOutline=f;

        end
    }
)

VM:AddSlider(
    {
        text = "Viewmodel X",
        flag = '"',
        suffix = "°",
        min = -10,
        max = 10,
        increment = .1,
        callback = function(v)
            VMOffsets.X=v;
        end
    }
)
VM:AddSlider(
    {
        text = "Viewmodel Y",
        flag = '"',
        suffix = "°",
        min = -10,
        max = 10,
        increment = .1,
        callback = function(v)
            VMOffsets.Y=v;
        end
    }
)
VM:AddSlider(
    {
        text = "Viewmodel Z",
        flag = '"',
        suffix = "°",
        min = -10,
        max = 10,
        increment = .1,
        callback = function(v)
            VMOffsets.Z=v;
        end
    }
)

local aimbottoggle5 = Aimbotsec:AddToggle(
    {
      
        state = false;
        tooltip = 'Use Smoothness';
        risky = false,
        text = "Use Smoothness",
        flag = "testflag",
        callback = function(bool)
            getgenv().Smoothness=bool;
        end 
    }
)

local aimbottoggle5 = Aimbotsec:AddToggle(
    {
      
        state = false;
        tooltip = 'Use Prediction';
        risky = false,
        text = "Use Prediction",
        flag = "testflag",
        callback = function(bool)
            getgenv().PredictMovement=bool;
        end 
    }
)
if not workspace:FindFirstChild("aimhookYo") then
                                    local i=Instance.new("Folder", workspace)
                                    i.Name='aimhookYo'
                                    i.Parent=workspace
                                end

Aimbotsec:AddList(
    {
        text = "Aim Part",
        flag = "",
        selected = {"Head"};
        multi = false,
        values = { 
            "Head",
            "UpperTorso",
            "HumanoidRootPart",
             "LowerTorso", 
             "LeftHand",
             "RightHand",
             "LeftLowerArm",
             "RightLowerArm",
             "LeftUpperArm",
             "RightUpperArm",
             "LeftFoot",
             "LeftLowerLeg",
             "LeftUpperLeg",
             "RightLowerLeg",
              "RightFoot",
             "RightUpperLeg"
        },
    --   
        callback = function(bool)
            getgenv().OldAimPart=bool;

          getgenv().AimPart=bool;
        end
    }
)
Aimbotsec:AddSlider(
    {
        text = "Smoothness",
        flag = '"',
        suffix = "°",
        min = 0,
        max = 10,
        increment = .01,
        callback = function(v)
            getgenv().SmoothnessAmount=v;
        end
    }
)
Aimbotsec:AddSlider(
    {
        text = "Prediction",
        flag = '"',
        suffix = "°",
        min = 0,
        max = 10,
        increment = .1,
        callback = function(v)
            getgenv().PredictionVelocity=v;
        end
    }
)

Aimbotsec:AddSlider(
    {
        text = "Backtrack Delay (ms)",
        flag = '"',
        suffix = "°",
        min = 100,
        max = 1000,
        increment = 1,
        callback = function(v)
            configTable.Aimlock.BacktrackDelay = v;
        end
    }
)


task.spawn(function()
    while task.wait()do
        
        if configTable.AntiAim.Type == 'spin' and configTable.AntiAim.Enabled then
            if arsonfuncs:IsAlive(game.Players.LocalPlayer) and game.Players.LocalPlayer.Character:FindFirstChild("Gun") then
                game.Players.LocalPlayer.Character.Humanoid.AutoRotate = false
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(configTable.AntiAim.SpinYawStrenght), 0)
            end
        end
        
        if configTable.AntiAim.UseRotation and configTable.AntiAim.Enabled then
            if arsonfuncs:IsAlive(game.Players.LocalPlayer) and game.Players.LocalPlayer.Character:FindFirstChild("Gun") then
               game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=
                CFrame.new(
                    game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                )*
                CFrame.Angles(
                    0,
                    math.rad(game.Players.LocalPlayer.Character.HumanoidRootPart.Orientation.Y),
                    math.rad(configTable.AntiAim.Rotation)
                )
            end
        end
        
        if configTable.AntiAim.Type == 'ohio' and configTable.AntiAim.Enabled then
            if arsonfuncs:IsAlive(game.Players.LocalPlayer) and game.Players.LocalPlayer.Character:FindFirstChild("Gun") then
                game.Players.LocalPlayer.Character.Humanoid.AutoRotate = false
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(configTable.AntiAim.OhioYawStrenght), 0)
            end
        end
        
        if configTable.Player.Acc then
            if game.Players.LocalPlayer.Character then
                for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren())do
                    if string.find(v.Name:lower(),"hat")and v:FindFirstChild("Handle") then v.Handle:Destroy() end
                    if string.find(v.Name:lower(),"dkit")and v:FindFirstChild("Handle") then v.Handle:Destroy() end    
                end
            end
        end
        
        if configTable.Player.Head then
            if game.Players.LocalPlayer.Character then
                for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren())do
                    if string.find(v.Name:lower(),"headhb") then v:Destroy() end
                    if string.find(v.Name:lower(),"fakehead") then v:Destroy() end    
                end
            end
        end
        if configTable.Aimlock.Auto and arsonfuncs:IsAlive(game.Players.LocalPlayer) then
            local nearest = arsonfuncs:ClosestPlayer()
            
            if nearest and nearest.TeamColor ~= game.Players.LocalPlayer.TeamColor and nearest.Name ~= game.Players.LocalPlayer.Name and nearest.Character and nearest.Character:FindFirstChild("Humanoid") and arsonfuncs:IsAlive(nearest) then
                if nearest.Character:FindFirstChild("Head") and arsonfuncs:IsNotBehindWall(nearest.Character.Head) and game.Players.LocalPlayer.Character:FindFirstChild("Gun") then
                    if configTable.Aimlock.AutoMethod=="firebullet" then
                        clientScript.firebullet()
                        local LocalPlayer = game.Players.LocalPlayer
    				    local args = {
    					    [1] = nearest.Character.Head,
    						[2] = nearest.Character.Head.Position,
    						[3] = LocalPlayer.Character.EquippedTool.Value,
    						[4] = 100,
    						[5] = LocalPlayer.Character.Gun,
    						[8] = 1,
    						[9] = false,
    						[10] = false,
    						[11] = Vector3.new(),
    						[12] = 100,
    						[13] = Vector3.new()
    					}
    					game.ReplicatedStorage.Events.HitPart:FireServer(unpack(args))
                        
                        if configTable.Exploits.DoubleTap then
                            clientScript.firebullet()
                            task.wait(.01)
                            clientScript.firebullet()
                        end
                    else
                        game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                        task.wait(.01)
                        game:GetService("VirtualUser"):Button1Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                        
                        if configTable.Exploits.DoubleTap then
                            game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                            task.wait(.01)
                            game:GetService("VirtualUser"):Button1Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                        end
                    end
                end
            end
        end
        
        if configTable.Visuals.GunChams then
            if workspace.CurrentCamera:FindFirstChild("Arms") then
                    if workspace.CurrentCamera.Arms:FindFirstChild("new") then
                        for _global_index, v in pairs(workspace.CurrentCamera.Arms.new:GetChildren()) do
                            for __newindexF,v2 in pairs(v:GetDescendants()) do
                                if v2:IsA("SpecialMesh") then
                                    v2.TextureId = ""    
                                end
                                
                                if v2:IsA("Decal") then
                                    v2:Destroy()    
                                end
                            end
                            
                            if configTable.GC_THEME == "aimhook" then
                                v.BrickColor = BrickColor.new("Deep blue")
                                v.Material = Enum.Material.ForceField
    
                            end
                            if configTable.GC_THEME == "stormware.cc" then
                                v.BrickColor = BrickColor.new("Royal purple")
                                v.Material = Enum.Material.ForceField
                            end
                            if configTable.GC_THEME == "lgbtq" then
                                v.Material = Enum.Material.Neon
                                v.Color = Color3.fromHSV(tick()%5/5,1,1)
                            end
                            
                            if configTable.GC_THEME == "custom" then
                                v.Material = configTable.CustomMaterial;
                                v.Color = configTable.CustomColor;
                            end
                            if configTable.GC_THEME == "onetap.lua" then
                                v.BrickColor = BrickColor.new("Bright yellow")
                                v.Material = Enum.Material.ForceField
                            end
                            
                            v.Transparency = configTable.GC_TRANSPARENCY
                        end
                    else
                        for __protectedIndex, vs in pairs(workspace.CurrentCamera.Arms:GetChildren()) do
                            --if not vs:IsA("MeshPart") then end
                            if vs:IsA("MeshPart") and vs.Transparency ~= 1 then
                                vs.Material = Enum.Material.ForceField
                                if configTable.GC_THEME == "aimhook" then
                                    vs.BrickColor = BrickColor.new("Deep blue")    
                                end
                                if configTable.GC_THEME == "stormware.cc" then
                                    vs.BrickColor = BrickColor.new("Royal purple")    
                                end
                                if configTable.GC_THEME == "onetap.lua" then
                                    vs.BrickColor = BrickColor.new("Bright yellow")    
                                end
                                if configTable.GC_THEME == "lgbtq" then
                                    vs.Material = Enum.Material.Neon
                                    vs.Color = Color3.fromHSV(tick()%5/5,1,1)
                                end
                            
                                if configTable.GC_THEME == "custom" then
                                    vs.Material = configTable.CustomMaterial;
                                    vs.Color = configTable.CustomColor;
                                end
                                vs.Transparency = configTable.GC_TRANSPARENCY or .5
                            end
                        end
                    end
            end
        end
        
        if configTable.Player.ThirdPerson then
            game.Players.LocalPlayer.CameraMaxZoomDistance = 15
			game.Players.LocalPlayer.CameraMinZoomDistance =15    
        else
            game.Players.LocalPlayer.CameraMaxZoomDistance = 0
			game.Players.LocalPlayer.CameraMinZoomDistance = 0   
        end
        if configTable.Exploits.InfiniteCash and game.Players.LocalPlayer.Cash.Value ~= 10000 then
            game.Players.LocalPlayer.Cash.Value=10000;    
        end
        
        if configTable.Player.BunnyHop then
            if configTable.Player.BunnyHopType == "Velocity" and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("UpperTorso") then
                    BodyVelocity:Destroy()
            		BodyVelocity = Instance.new("BodyVelocity")
            		BodyVelocity.MaxForce = Vector3.new(math.huge,0,math.huge)
            		if UserInputService:IsKeyDown("Space") and game.Players.LocalPlayer.Character then 
            			local add = 0
            			if UserInputService:IsKeyDown("A") then add = 90 end
            			if UserInputService:IsKeyDown("S") then add = 180 end
            			if UserInputService:IsKeyDown("D") then add = 270 end
            			if UserInputService:IsKeyDown("A") and UserInputService:IsKeyDown("W") then add = 45 end
            			if UserInputService:IsKeyDown("D") and UserInputService:IsKeyDown("W") then add = 315 end
            			if UserInputService:IsKeyDown("D") and UserInputService:IsKeyDown("S") then add = 225 end
            			if UserInputService:IsKeyDown("A") and UserInputService:IsKeyDown("S") then add = 145 end
            			local rot = arsonfuncs:RotationY(workspace.CurrentCamera.CFrame) * CFrame.Angles(0,math.rad(add),0)
            			if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("UpperTorso") then
            			    BodyVelocity.Parent = game.Players.LocalPlayer.Character.UpperTorso
            			
            			end
            			if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            
            		    	game.Players.LocalPlayer.Character.Humanoid.Jump = true
            			end
            			BodyVelocity.Velocity = Vector3.new(rot.LookVector.X,0,rot.LookVector.Z) * (configTable.Player.BunnySpeed * 2)
            			if add == 0 and not UserInputService:IsKeyDown("W") then
            				BodyVelocity:Destroy()
            			end
            		end
                end
            end
    end
    end
end)

getgenv().OldAimPart = "Head"
getgenv().AimPart =  "Head"
    getgenv().AimlockKey = "c"
    getgenv().AimRadius = 90 -- How far away from someones character you want to lock on at
    getgenv().ThirdPerson = true 
    getgenv().FirstPerson = true
    getgenv().TeamCheck = true -- Check if Target is on your Team (True means it wont lock onto your teamates, false is vice versa) (Set it to false if there are no teams)
    getgenv().PredictMovement = true -- Predicts if they are moving in fast velocity (like jumping) so the aimbot will go a bit faster to match their speed 
    getgenv().PredictionVelocity = 6.612
    getgenv().CheckIfJumped = true
    getgenv().Smoothness = true
    getgenv().SmoothnessAmount = 0.08

    local Players, Uis, RService, SGui = game:GetService"Players", game:GetService"UserInputService", game:GetService"RunService", game:GetService"StarterGui";
    local Client, Mouse, Camera, CF, RNew, Vec3, Vec2 = Players.LocalPlayer, Players.LocalPlayer:GetMouse(), workspace.CurrentCamera, CFrame.new, Ray.new, Vector3.new, Vector2.new;
    local Aimlock, MousePressed, CanNotify = true, false, false;
    local AimlockTarget;
    local OldPre;
    

    
    getgenv().WorldToViewportPoint = function(P)
        return Camera:WorldToViewportPoint(P)
    end
    
    getgenv().WorldToScreenPoint = function(P)
        return Camera.WorldToScreenPoint(Camera, P)
    end
    
    getgenv().GetObscuringObjects = function(T)
        if T and T:FindFirstChild(getgenv().AimPart) and Client and Client.Character:FindFirstChild("Head") then 
            local RayPos = workspace:FindPartOnRay(RNew(
                T[getgenv().AimPart].Position, Client.Character.Head.Position)
            )
            if RayPos then return RayPos:IsDescendantOf(T) end
        end
    end
    
    getgenv().GetNearestTarget = function()
        -- Credits to whoever made this, i didnt make it, and my own mouse2plr function kinda sucks
        local players = {}
        local PLAYER_HOLD  = {}
        local DISTANCES = {}
        for i, v in pairs(Players:GetPlayers()) do
            if v ~= Client then
                table.insert(players, v)
            end
        end
        for i, v in pairs(players) do
            if v.Character ~= nil then
                local AIM = v.Character:FindFirstChild("Head")
                if getgenv().TeamCheck == true and v.Team ~= Client.Team then
                    local DISTANCE = (v.Character:FindFirstChild("Head").Position - game.Workspace.CurrentCamera.CFrame.p).magnitude
                    local RAY = Ray.new(game.Workspace.CurrentCamera.CFrame.p, (Mouse.Hit.p - game.Workspace.CurrentCamera.CFrame.p).unit * DISTANCE)
                    local HIT,POS = game.Workspace:FindPartOnRay(RAY, game.Workspace)
                    local DIFF = math.floor((POS - AIM.Position).magnitude)
                    PLAYER_HOLD[v.Name .. i] = {}
                    PLAYER_HOLD[v.Name .. i].dist= DISTANCE
                    PLAYER_HOLD[v.Name .. i].plr = v
                    PLAYER_HOLD[v.Name .. i].diff = DIFF
                    table.insert(DISTANCES, DIFF)
                elseif getgenv().TeamCheck == false and v.Team == Client.Team then 
                    local DISTANCE = (v.Character:FindFirstChild("Head").Position - game.Workspace.CurrentCamera.CFrame.p).magnitude
                    local RAY = Ray.new(game.Workspace.CurrentCamera.CFrame.p, (Mouse.Hit.p - game.Workspace.CurrentCamera.CFrame.p).unit * DISTANCE)
                    local HIT,POS = game.Workspace:FindPartOnRay(RAY, game.Workspace)
                    local DIFF = math.floor((POS - AIM.Position).magnitude)
                    PLAYER_HOLD[v.Name .. i] = {}
                    PLAYER_HOLD[v.Name .. i].dist= DISTANCE
                    PLAYER_HOLD[v.Name .. i].plr = v
                    PLAYER_HOLD[v.Name .. i].diff = DIFF
                    table.insert(DISTANCES, DIFF)
                end
            end
        end
        
        if unpack(DISTANCES) == nil then
            return nil
        end
        
        local L_DISTANCE = math.floor(math.min(unpack(DISTANCES)))
        if L_DISTANCE > getgenv().AimRadius then
            return nil
        end
        
        for i, v in pairs(PLAYER_HOLD) do
            if v.diff == L_DISTANCE then
                return v.plr
            end
        end
        return nil
    end
    Uis.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton2 and configTable.Aimlock.Enabled then
            if AimlockTarget == nil then
                pcall(function()
                    if MousePressed ~= true then MousePressed = true end 
                    local Target;Target = GetNearestTarget()
                    if Target ~= nil then 
                        AimlockTarget = Target
                    end
                end)
            elseif a == AimlockKey and AimlockTarget ~= nil then
                if AimlockTarget ~= nil then AimlockTarget = nil end
                if MousePressed ~= false then 
                    MousePressed = false 
                end
            end
        end
    end)
    
    Uis.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton2 and configTable.Aimlock.Enabled then
            if AimlockTarget ~= nil then AimlockTarget = nil end
                if MousePressed ~= false then 
                    MousePressed = false 
                end
        end
    end)
    
   
    RService.RenderStepped:Connect(function()
        if configTable.Aimlock.Backtrack and configTable.Aimlock.BacktrackType == 'Parts' then
            if arsonfuncs:IsAlive(game.Players.LocalPlayer) and game.Players.LocalPlayer.Character:FindFirstChild("Gun") then
                        for _, v in pairs(game.Players:GetPlayers())do
                            if arsonfuncs:IsAlive(v) and v.TeamColor ~= game.Players.LocalPlayer.TeamColor and v ~= game.Players.LocalPlayer then
                                local track = Instance.new("Part")
        						track.Name = v.Name
        						track.Anchored = true
        						track.Material = "Neon"
        						track.CanCollide = false
        						track.Transparency = 0
        						track.Color = Color3.fromRGB(255,0,255)
        						track.Size = v.Character.Head.Size 
        						track.CFrame = v.Character.Head.CFrame
        						track.Parent = arsonfuncs:GetWorkspaceFolder();
        						
        						local BacktrackTag = Instance.new("ObjectValue")
        						BacktrackTag.Parent = track
        						BacktrackTag.Name = "PlayerName"
        						BacktrackTag.Value = v
        						
        						spawn(function()
        							task.wait(configTable.Aimlock.BacktrackDelay/1000)
        							track:Destroy()
        						end)
                            end
                        end
            end
        end
        
        if configTable.Aimlock.Backtrack and configTable.Aimlock.BacktrackType == 'Character' then
            if arsonfuncs:IsAlive(game.Players.LocalPlayer) and game.Players.LocalPlayer.Character:FindFirstChild("Gun") then
                        for _, v in pairs(game.Players:GetPlayers())do
                            if arsonfuncs:IsAlive(v) and v.TeamColor ~= game.Players.LocalPlayer.TeamColor and v ~= game.Players.LocalPlayer and not workspace.aimhookYo:FindFirstChild(v.Name) then
                                local a -- took me very long smh

                                if v.Character then
                                    local nChar = Instance.new("Model", workspace.aimhookYo)
                                    nChar.Name=v.Name;
                                    if not nChar:FindFirstChild("PlayerName") then
                                        local BacktrackTag = Instance.new("ObjectValue")
                						BacktrackTag.Parent = nChar;
                						BacktrackTag.Name = "PlayerName"
                						BacktrackTag.Value = v
        						    end
                                    for i,va in pairs(v.Character:GetChildren()) do
                                        if va:IsA("BasePart") then
                                             if va.Transparency~=1 then
                                                    a=va:Clone()
                                                    task.wait()
                                                    a.Name=v.Name;
                                                    a.CanCollide=false
                                                    a.Parent=nChar
                                                    a.Anchored=true
                                                    a.Color=Color3.fromRGB(255,0,255)
                                                    a.Material="ForceField"
                                                    a.Transparency=.5
                                                    a.Reflectance=0
                                                    if a:IsA("MeshPart")then
                                                        a.TextureID=""
                                                        a.CanCollide = false
                                                    end
                                                    for _,c in pairs(a:GetChildren())do
                                                        if not c:IsA("SpecialMesh")then
                                                            c:Destroy()
                                                        else
                                                            c.TextureId=""
                                                        end
                                                    end
                                            end    
                                        end
                                    end
                                end
                                
                                
                                task.wait(configTable.Aimlock.BacktrackDelay/1000)
                                workspace.aimhookYo:ClearAllChildren()
                            end
                    end
            end
        end
        if configTable.Aimlock.GunMods.NoRecoil then
            clientScript.resetaccuracy()
			clientScript.RecoilX = 0
			clientScript.RecoilY = 0    
        end
        if getgenv().ThirdPerson == true and getgenv().FirstPerson == true then 
            if (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude > 1 or (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude <= 1 then 
                CanNotify = true 
            else 
                CanNotify = false 
            end
        elseif getgenv().ThirdPerson == true and getgenv().FirstPerson == false then 
            if (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude > 1 then 
                CanNotify = true 
            else 
                CanNotify = false 
            end
        elseif getgenv().ThirdPerson == false and getgenv().FirstPerson == true then 
            if (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude <= 1 then 
                CanNotify = true 
            else 
                CanNotify = false 
            end
        end
        if Aimlock == true and MousePressed == true then 
            if AimlockTarget and AimlockTarget.Character and AimlockTarget.Character:FindFirstChild(getgenv().AimPart) and AimlockTarget.Character.Humanoid.Health > 0 then 
                if getgenv().FirstPerson == true then
                    if CanNotify == true then
                        if getgenv().PredictMovement == true then
                            if getgenv().Smoothness == true and AimlockTarget.Character.Humanoid.Health > 0  then
                                --// The part we're going to lerp/smoothen \\--
                                local Main = CF(Camera.CFrame.p, AimlockTarget.Character[getgenv().AimPart].Position + AimlockTarget.Character[getgenv().AimPart].Velocity/PredictionVelocity)
                                
                                --// Making it work \\--
                                Camera.CFrame = Camera.CFrame:Lerp(Main, getgenv().SmoothnessAmount, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut)
                            else
                                Camera.CFrame = CF(Camera.CFrame.p, AimlockTarget.Character[getgenv().AimPart].Position + AimlockTarget.Character[getgenv().AimPart].Velocity/PredictionVelocity)
                            end
                        elseif getgenv().PredictMovement == false then 
                            if getgenv().Smoothness == true then
                                --// The part we're going to lerp/smoothen \\--
                                local Main = CF(Camera.CFrame.p, AimlockTarget.Character[getgenv().AimPart].Position)

                                --// Making it work \\--
                                Camera.CFrame = Camera.CFrame:Lerp(Main, getgenv().SmoothnessAmount, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut)
                            else
                                Camera.CFrame = CF(Camera.CFrame.p, AimlockTarget.Character[getgenv().AimPart].Position)
                            end
                        end
                    end
                end
            end
        end
     
end)


local lplr = game.Players.LocalPlayer
local camera = game:GetService("Workspace").CurrentCamera
local CurrentCamera = workspace.CurrentCamera
local worldToViewportPoint = CurrentCamera.worldToViewportPoint

local HeadOff = Vector3.new(0, 0.5, 0)
local LegOff = Vector3.new(0,3,0)

for i,v in pairs(game.Players:GetChildren()) do
    local BoxOutline = Drawing.new("Square")
    BoxOutline.Visible = false
    BoxOutline.Color = configTable.Visuals.ESPOutline
    BoxOutline.Thickness = 3
    BoxOutline.Transparency = 1
    BoxOutline.Filled = false

    local Box = Drawing.new("Square")
    Box.Visible = false
    Box.Color = configTable.Visuals.ESPColor
    Box.Thickness = 1
    Box.Transparency = 1
    Box.Filled = false

    function boxesp()
        game:GetService("RunService").RenderStepped:Connect(function()
                
				if not configTable.Visuals.ESP == true then Box.Visible = false BoxOutline.Visible = false else Box.Visible = true BoxOutline.Visible = true end
            if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= lplr and v.Character.Humanoid.Health > 0 then
                local Vector, onScreen = camera:worldToViewportPoint(v.Character.HumanoidRootPart.Position)

                local RootPart = v.Character.HumanoidRootPart
                local Head = v.Character.Head
                local RootPosition, RootVis = worldToViewportPoint(CurrentCamera, RootPart.Position)
                local HeadPosition = worldToViewportPoint(CurrentCamera, Head.Position + HeadOff)
                local LegPosition = worldToViewportPoint(CurrentCamera, RootPart.Position - LegOff)

                if onScreen then
                    BoxOutline.Size = Vector2.new(1000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
                    BoxOutline.Position = Vector2.new(RootPosition.X - BoxOutline.Size.X / 2, RootPosition.Y - BoxOutline.Size.Y / 2)
                    BoxOutline.Visible = true
                    
                    Box.Size = Vector2.new(1000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
                    Box.Position = Vector2.new(RootPosition.X - Box.Size.X / 2, RootPosition.Y - Box.Size.Y / 2)
                    Box.Visible = true
                    Box.Color=configTable.Visuals.ESPColor
                    BoxOutline.Color=configTable.Visuals.ESPOutline
                    if v.TeamColor == lplr.TeamColor then
                        BoxOutline.Visible = false
                        Box.Visible = false
                    else
						if configTable.Visuals.ESP == true then
                        	BoxOutline.Visible = true
                            Box.Visible = true
						else
                            BoxOutline.Visible = false
                            Box.Visible = false
                        end
                    end

                else
                    BoxOutline.Visible = false
                    Box.Visible = false
                end
            else
                BoxOutline.Visible = false
                Box.Visible = false
            end
        end)
    end
    coroutine.wrap(boxesp)()
end

game.Players.PlayerAdded:Connect(function(v)
    local BoxOutline = Drawing.new("Square")
    BoxOutline.Visible = false
    BoxOutline.Color =configTable.Visuals.ESPOutline
    BoxOutline.Thickness = 3
    BoxOutline.Transparency = 1
    BoxOutline.Filled = false

    local Box = Drawing.new("Square")
    Box.Visible = false
    Box.Color = configTable.Visuals.ESPColor
    Box.Thickness = 1
    Box.Transparency = 1
    Box.Filled = false

    function boxesp()
        game:GetService("RunService").RenderStepped:Connect(function()
				

            if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= lplr and v.Character.Humanoid.Health > 0 then
                local Vector, onScreen = camera:worldToViewportPoint(v.Character.HumanoidRootPart.Position)

                local RootPart = v.Character.HumanoidRootPart
                local Head = v.Character.Head
                local RootPosition, RootVis = worldToViewportPoint(CurrentCamera, RootPart.Position)
                local HeadPosition = worldToViewportPoint(CurrentCamera, Head.Position + HeadOff)
                local LegPosition = worldToViewportPoint(CurrentCamera, RootPart.Position - LegOff)

                if onScreen then
                    BoxOutline.Size = Vector2.new(1000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
                    BoxOutline.Position = Vector2.new(RootPosition.X - BoxOutline.Size.X / 2, RootPosition.Y - BoxOutline.Size.Y / 2)
                    BoxOutline.Visible = true
                    BoxOutline.Color=configTable.Visuals.ESPOutline

                    Box.Size = Vector2.new(1000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
                    Box.Position = Vector2.new(RootPosition.X - Box.Size.X / 2, RootPosition.Y - Box.Size.Y / 2)
                    Box.Visible = true
                    Box.Color=configTable.Visuals.ESPColor

                    if v.TeamColor == lplr.TeamColor then
                        BoxOutline.Visible = false
                        Box.Visible = false
                    else
                        if configTable.Visuals.ESP == true then
                        	BoxOutline.Visible = true
                            Box.Visible = true
						else
                            BoxOutline.Visible = false
                            Box.Visible = false
                        end
                    end

                else
                    BoxOutline.Visible = false
                    Box.Visible = false
                end
            else
                BoxOutline.Visible = false
                Box.Visible = false
            end
        end)
    end
    coroutine.wrap(boxesp)()
end)

local MT = getrawmetatable(game)
local OldNC = MT.__namecall
local OldIDX = MT.__index
setreadonly(MT, false)
MT.__namecall = newcclosure(function(self, ...)
    local Args, Method = {...}, getnamecallmethod()
    if Method == "FindPartOnRayWithIgnoreList" and not checkcaller() then
        local CP = arsonfuncs:ClosestPlayer()
        if CP and CP.Character and CP.Character.FindFirstChild(CP.Character, "Head") and configTable.Aimlock.SilentAim then
            Args[1] = Ray.new(CurrentCamera.CFrame.Position, (CP.Character[getgenv().AimPart or "Head"].Position - CurrentCamera.CFrame.Position).Unit * 1000)
            return OldNC(self, unpack(Args))
        end
    end
    
    if Method == "FindPartOnRayWithIgnoreList" and Args[2][1] == workspace.Debris and not checkcaller() then
        if configTable.Aimlock.Penetration then
            table.insert(Args[2],workspace.Map)    
        end
    end
    return OldNC(self, ...)
end)


local ArsoniaFunctionLib={}
function ArsoniaFunctionLib:Tween(...) game:GetService("TweenService"):Create(...):Play() end
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
local oldIndex = mt.__index
setreadonly(mt,false)
mt.__namecall = function(self, ...)
	local method = tostring(getnamecallmethod())
    local args = {...}
    
	if method == "SetPrimaryPartCFrame" and self.Name == "Arms" then
	    if configTable.Player.ThirdPerson then
	        args[1] = args[1] * CFrame.new(9e9,9e9,9e9);--invisible lol
	    else
    	    if configTable.Visuals.VMChange then
    		    args[1] = args[1] * CFrame.new(VMOffsets.X,VMOffsets.Y,VMOffsets.Z);
    	    end
	    end

	end
	
	if self.Name == "ControlTurn" and configTable.AntiAim.Enabled then
	    if configTable.AntiAim.Type == 'aimhook' then
	        args[1]=-6.1
	    end
	    
	    if configTable.AntiAim.Type == 'ohio' then
	        local n = math.random(1,3)
	        if n == 1 then
	            args[1]=math.random(-10,21)
	        end
	        
	        if n == 2 then
	            args[1]=-5
	        end
	        
	        if n == 3 then
	            args[1]=-math.huge
	        end
	    end
	    
	    if configTable.AntiAim.Type == 'Up' then
	        args[1]=1.5962564026167
	    end
	    
	    if configTable.AntiAim.Type == 'jjsploit' then
	        args[1]=-20.5
	    end
	    
	    if configTable.AntiAim.Type == 'jizz' then
	        args[1]=math.random(-100,100)
	    end
	    
	    if configTable.AntiAim.Type == 'classic' then
	        args[1]=math.random(-2000,-1000)
	    end
	    
	    if configTable.AntiAim.Type == 'next gen' then
	        local m = math.random(1,2)
	        if m == 1 then
	            args[1]=-56.7
	        else
	            args[1]=56.7
	        end
	    end
	    
	    if configTable.AntiAim.Type == 'silly ahh' then
	        args[1]=-8.1
	    end
	    
	    if configTable.AntiAim.Type == 'Random' then
	        args[1]=math.random(-10,10)
	    end
	    
	    if configTable.AntiAim.Type == 'Down'then
	        args[1]=-1.5962564026167
	    end
	end
	
	if self.Name == "HitPart" then
	    
	    if configTable.Exploits.Multi then
	        args[8] = args[8] * configTable.Exploits.Multiplier;    
	    end
	    
	    if configTable.Visuals.BulletTracers then
    	    spawn(function()
                local Camera = workspace.CurrentCamera
        		local beam = Instance.new("Part")
        		
        		 beam.Parent = workspace.Debris;
        
                        beam.Anchored = true
                        beam.CanCollide = false
                        beam.Material = configTable.Visuals.BMaterial
                        beam.Color = configTable.Visuals.BColor
                        beam.Size = Vector3.new(0.1, 0.1, (Camera.CFrame.Position - args[1].CFrame.Position).Magnitude)
                        --print(args[1])
                        beam.CFrame = CFrame.new(Camera.CFrame.Position, args[1].CFrame.Position) * CFrame.new(0, 0, -beam.Size.Z / 2)
                        ArsoniaFunctionLib:Tween(beam, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = 1})
                        task.wait(1.5)
                        beam:Destroy()
    	    end)
	    end
	    
	    if configTable.Aimlock.TPAura then
	        spawn(function()
	            if string.find(args[1].Name,'HeadHB') or string.find(args[1].Name,'UpperTorso') or string.find(args[1].Name,'LowerTorso') or string.find(args[1].Name,'Leg') then
	                local position = args[1].CFrame
	                if true then
    	                if game.Players.LocalPlayer.Character then
    	                   game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = position - Vector3.new(0,0,5)     
    	                end
                    end
	            end
	        end)     
	    end
    
        return oldNamecall(self, unpack(args))

	end
	
	if self.Name =="FallDamage" and configTable.Player.NoFall then
	    return;
	end
	
	return oldNamecall(self, unpack(args))
end

function getSound()
    local res = nil;
    
    if configTable.Hitsound=="skeet.cc" then
        res="rbxassetid://5447626464"
    end
    
    if configTable.Hitsound=="rust" then
        res="rbxassetid://5043539486"    
    end
    
    if configTable.Hitsound=="bag" then
        res="rbxassetid://364942410"    
    end
    
    if configTable.Hitsound=="sit" then
        writefile("sit.mp3",game:HttpGet("https://raw.githubusercontent.com/Storm99999/whitelistkeys/main/aimhook/sounds/sit.mp3?raw=true"))
        res=getsynasset("sit.mp3")   
    end
    
    if configTable.Hitsound=="reminder" then
        writefile("reminder.mp3",game:HttpGet("https://raw.githubusercontent.com/Storm99999/whitelistkeys/main/aimhook/sounds/reminder.mp3?raw=true"))
        res=getsynasset("reminder.mp3")   
    end
    
    if configTable.Hitsound=="uwu" then
        writefile("uwu.mp3",game:HttpGet("https://raw.githubusercontent.com/Storm99999/whitelistkeys/main/aimhook/sounds/uwu.mp3?raw=true"))
        res=getsynasset("uwu.mp3")   
    end
    
    if configTable.Hitsound=="zing" then
        writefile("zing.mp3",game:HttpGet("https://raw.githubusercontent.com/Storm99999/whitelistkeys/main/aimhook/sounds/animezing.mp3?raw=true"))
        res=getsynasset("zing.mp3")   
    end
    
    if configTable.Hitsound=="crowbar" then
        writefile("crowbar.mp3",game:HttpGet("https://raw.githubusercontent.com/Storm99999/whitelistkeys/main/aimhook/sounds/crowbar.mp3?raw=true"))
        res=getsynasset("crowbar.mp3")   
    end
    
    if configTable.Hitsound=="laugh" then
        writefile("laugh.mp3",game:HttpGet("https://raw.githubusercontent.com/Storm99999/whitelistkeys/main/aimhook/sounds/laugh.mp3?raw=true"))
        res=getsynasset("laugh.mp3")   
    end
    
    if configTable.Hitsound=="burp" then
        writefile("burp.mp3",game:HttpGet("https://raw.githubusercontent.com/Storm99999/whitelistkeys/main/aimhook/sounds/burp.mp3?raw=true"))
        res=getsynasset("burp.mp3")   
    end
    
    if configTable.Hitsound=="mario" then
        writefile("mario.mp3",game:HttpGet("https://raw.githubusercontent.com/Storm99999/whitelistkeys/main/aimhook/sounds/mariowoahh.mp3?raw=true"))
        res=getsynasset("mario.mp3")   
    end
    
    if configTable.Hitsound=="huh" then
        writefile("huh.mp3",game:HttpGet("https://raw.githubusercontent.com/Storm99999/whitelistkeys/main/aimhook/sounds/huhh.mp3?raw=true"))
        res=getsynasset("huh.mp3")   
    end
    if configTable.Hitsound=="ara ara" then
        writefile("ara.mp3",game:HttpGet("https://raw.githubusercontent.com/Storm99999/whitelistkeys/main/aimhook/sounds/ara.mp3?raw=true"))
        res=getsynasset("ara.mp3")   
    end
    if configTable.Hitsound=="nl" then
        writefile("neverlose.mp3",game:HttpGet("https://raw.githubusercontent.com/Storm99999/whitelistkeys/main/aimhook/sounds/neverlose.mp3?raw=true"))
        res=getsynasset("neverlose.mp3")
        print("gotten")
    end
    return res;
end


game.Players.LocalPlayer.Additionals.TotalDamage:GetPropertyChangedSignal("Value"):Connect(function(v)

    if not configTable.Player.Hitsounds then return end
    
    local sound = Instance.new("Sound")
    sound.Parent = game:GetService("SoundService")
    sound.SoundId = getSound()
    sound.Volume = configTable.Player.Volume
    sound.PlayOnRemove = true
    sound:Destroy()
end)

game.Players.LocalPlayer.Status.Kills:GetPropertyChangedSignal("Value"):Connect(function(v)
    if v == 0 then return end
    if not configTable.Player.KillSay then return end
    
    game:GetService("ReplicatedStorage").Events.PlayerChatted:FireServer(configTable.Player.ChatContext, false, "Innocent", false, true)
end)


workspace.Ray_Ignore.Smokes.ChildAdded:Connect(function(child)
    if child.Name == "Smoke" and table.find(configTable.Effects, "Smoke") then
		task.wait()
		child:Remove()
	end
end)
workspace.Debris.ChildAdded:Connect(function(child)
	
	if child.Name == "Bullet" and table.find(configTable.Effects, "Bullet Holes") then
		task.wait()
		child:Remove()
	elseif child.Name == "SurfaceGui" and table.find(configTable.Effects, "Blood") then
		task.wait()
		child:Remove()
	end
end)
local Crosshair=game.Players.LocalPlayer.PlayerGui.GUI.Crosshairs.Crosshair
Crosshair:GetPropertyChangedSignal("Visible"):Connect(function(current)
	if not game.Players.LocalPlayer.Character then return end
	if not configTable.Visuals.ForceCrosshair then return end
	if game.Players.LocalPlayer.Character:FindFirstChild("AIMING") then return end
	
	Crosshair.Visible = true
end)

workspace.ChildAdded:Connect(function(x)
    task.wait(5)-- wait until loaded
    if x =="Map"then 
        if configTable.Player.RemKillers then
            if workspace:FindFirstChild("Map") and workspace:FindFirstChild("Map"):FindFirstChild("Killers") then
				local clone = workspace:FindFirstChild("Map"):FindFirstChild("Killers"):Clone()
				clone.Name = "Cloned"
				clone.Parent = workspace:FindFirstChild("Map")
	
				workspace:FindFirstChild("Map"):FindFirstChild("Killers"):Destroy()
			end    
        end
    end
end)
