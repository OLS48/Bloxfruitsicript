#include <stdio.h>

//Compiler version gcc  6.3.0

local authorizedUsers = {
    ["MOVEN_GRG"] = true,
}

if not authorizedUsers[game.Players.LocalPlayer.Name] then
    game.Players.LocalPlayer:Kick("You are not authorized to use this script!")
    return
end

local monsterList = {
    "Shark",
    "Sea King",
    "Kraken",
    "Dragon",
    "Megalodon",
    "Sea Beast",
    "Leviathan",
    "Water Dragon",
}

local selectedMonster = monsterList[1]

function loadSensitiveFunctions()
    local farming = false

    function farmMonster()
        while farming do
            wait(math.random(0.1, 0.5))
            for _, monster in pairs(game.Workspace:GetChildren()) do
                if monster:IsA("Model") and monster.Name == selectedMonster and monster:FindFirstChild("Humanoid") then
                    local humanoid = monster.Humanoid
                    if humanoid.Health > 0 then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = monster.PrimaryPart.CFrame * CFrame.new(0, 10, 0)
                        local virtualInput = game:GetService("VirtualUser")
                        virtualInput:CaptureController()
                        virtualInput:Button1Down(Vector2.new(0, 0))
                    end
                end
            end
        end
    end

    local StartButton = Instance.new("TextButton")
    StartButton.Size = UDim2.new(0, 300, 0, 100)
    StartButton.Position = UDim2.new(0.5, -150, 0.5, -50)
    StartButton.Text = "Start Farming"
    StartButton.Parent = game.Players.LocalPlayer.PlayerGui:WaitForChild("ScreenGui")

    StartButton.MouseButton1Click:Connect(function()
        farming = not farming
        if farming then
            StartButton.Text = "Stop Farming"
            spawn(farmMonster)
        else
            StartButton.Text = "Start Farming"
        end
    end)

    local monsterDropdown = Instance.new("TextButton")
    monsterDropdown.Size = UDim2.new(0, 300, 0, 50)
    monsterDropdown.Position = UDim2.new(0.5, -150, 0.6, -25)
    monsterDropdown.Text = "Select Monster"
    monsterDropdown.Parent = game.Players.LocalPlayer.PlayerGui:WaitForChild("ScreenGui")

    local monsterDropdownList = Instance.new("Frame")
    monsterDropdownList.Size = UDim2.new(0, 300, 0, #monsterList * 50)
    monsterDropdownList.Position = UDim2.new(0.5, -150, 0.6, 25)
    monsterDropdownList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    monsterDropdownList.Visible = false
    monsterDropdownList.Parent = game.Players.LocalPlayer.PlayerGui:WaitForChild("ScreenGui")

    for i, monsterName in ipairs(monsterList) do
        local monsterButton = Instance.new("TextButton")
        monsterButton.Size = UDim2.new(0, 300, 0, 50)
        monsterButton.Position = UDim2.new(0, 0, 0, (i - 1) * 50)
        monsterButton.Text = monsterName
        monsterButton.Parent = monsterDropdownList

        monsterButton.MouseButton1Click:Connect(function()
            selectedMonster = monsterName
            monsterDropdown.Text = "Selected: " .. selectedMonster
            monsterDropdownList.Visible = false
        end)
    end

    monsterDropdown.MouseButton1Click:Connect(function()
        monsterDropdownList.Visible = not monsterDropdownList.Visible
    end)
end

local executeFarming = loadSensitiveFunctions()
executeFarming()
