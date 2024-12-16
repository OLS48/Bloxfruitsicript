#include <stdio.h>

//Compiler version gcc  6.3.0

int main()
{
  printf("Hello, World!");
  return 0;
}-- قائمة المستخدمين المصرح لهم
local authorizedUsers = {
    ["OLS48l"] = true,  -- استبدل "YourUsername" باسم حسابك في Roblox
}

-- التحقق من إذا كان اللاعب مسموح له باستخدام السكربت
if not authorizedUsers[game.Players.LocalPlayer.Name] then
    game.Players.LocalPlayer:Kick("You are not authorized to use this script!")
    return
end

-- تحميل الوظائف الحساسة (التفريم)
function loadSensitiveFunctions()
    local farming = false
    local selectedMonster = "MonsterName"  -- استبدل "MonsterName" باسم الوحش الذي تود تفريمه

    -- وظيفة التفريم
    function farmMonster()
        while farming do
            wait(math.random(0.1, 0.5)) -- تأخير عشوائي
            for _, monster in pairs(game.Workspace:GetChildren()) do
                if monster:IsA("Model") and monster.Name == selectedMonster and monster:FindFirstChild("Humanoid") then
                    local humanoid = monster.Humanoid
                    if humanoid.Health > 0 then
                        -- نقل اللاعب إلى الوحش
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = monster.PrimaryPart.CFrame * CFrame.new(0, 10, 0)

                        -- الهجوم
                        local virtualInput = game:GetService("VirtualUser")
                        virtualInput:CaptureController()
                        virtualInput:Button1Down(Vector2.new(0, 0))
                    end
                end
            end
        end
    end

    -- بدء/إيقاف التفريم عبر زر
    local StartButton = Instance.new("TextButton")
    StartButton.Size = UDim2.new(0, 200, 0, 50)
    StartButton.Position = UDim2.new(0.5, -100, 0.5, -25)
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
end

-- تحميل الوظائف الحساسة
local executeFarming = loadSensitiveFunctions()
executeFarming()