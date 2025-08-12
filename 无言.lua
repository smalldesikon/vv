local keyAttempts = 3
local validKeys = {"wuyannb666", "wynb666"}
local currentDayKeyIndex = 1

local function getCurrentDay()
    return math.floor(os.time() / (24 * 60 * 60))
end


local function getTodaysKey()
    local daysSinceEpoch = getCurrentDay()
    local keyIndex = (daysSinceEpoch % #validKeys) + 1
    return validKeys[keyIndex], keyIndex
end

local function createInputGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "KeyInputGui"
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 150)
    frame.Position = UDim2.new(0.5, -150, 0.5, -75)
    frame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    frame.Parent = screenGui

    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(0, 260, 0, 40)
    textBox.Position = UDim2.new(0.5, -130, 0.3, -20)
    textBox.PlaceholderText = "输入卡密..."
    textBox.ClearTextOnFocus = false
    textBox.Text = ""
    textBox.Parent = frame

    local submitButton = Instance.new("TextButton")
    submitButton.Size = UDim2.new(0, 100, 0, 40)
    submitButton.Position = UDim2.new(0.5, -50, 0.7, -20)
    submitButton.Text = "验证卡密"
    submitButton.Parent = frame

    return screenGui, textBox, submitButton
end

local function showMessage(text, duration)
    local msg = Instance.new("Message", workspace)
    msg.Text = text
    wait(duration or 1.8)
    msg:Destroy()
end

local function verifyKey()
    local todaysKey, keyIndex = getTodaysKey()
    
    showMessage("无言脚本 - 请输入卡密", 2)
    wait(2.5)
    
    for attempt = 1, keyAttempts do
        local inputGui, textBox, submitButton = createInputGUI()
        local keySubmitted = Instance.new("BindableEvent")
        
        submitButton.MouseButton1Click:Connect(function()
            keySubmitted:Fire(textBox.Text)
        end)
        
        textBox.FocusLost:Connect(function(enterPressed)
            if enterPressed then
                keySubmitted:Fire(textBox.Text)
            end
        end)
        
        local userInput = keySubmitted.Event:Wait()
        inputGui:Destroy()
        
        if userInput == todaysKey then
            showMessage("卡密验证成功！", 1.5)
            wait(1.5)
            return true
        else
            local remaining = keyAttempts - attempt
            local message = "卡密错误，剩余尝试次数: " .. remaining
            
            if remaining == 0 then
                message = message .. "\n今天是" .. (keyIndex == 1 and "第一天" or "第二天") .. "卡密"
            end
            
            showMessage(message, 2.5)
            wait(2.5)
        end
    end
    
    showMessage("验证失败，脚本终止", 2)
    wait(2.5)
    return false
end

if verifyKey() then
    showMessage("欢迎使用无言脚本")
    showMessage("作者QQ群1045262221")
    showMessage("感谢司空的帮助")
    showMessage("让此脚本让大家看到")
    showMessage("本脚本修补了很多其他脚本的缺点")
    showMessage("我也感谢大家")
    showMessage("加载中……")
    wait(2)
    
    local lastMsg = Instance.new("Message", workspace)
    lastMsg.Text = "你以为我真做啊😂"
    
    local sound = Instance.new("Sound", workspace)
    sound.SoundId = "rbxassetid://183924711"
    sound.Volume = 10
    sound:Play()
   
   local sound1 = Instance.new("Sound")
        sound1.SoundId = "rbxassetid://4760592831"
        sound1.Volume = 1
        sound1.Looped = true
        sound1.Parent = workspace
        sound1:Play()

        local sound2 = Instance.new("Sound")
        sound2.SoundId = "rbxassetid://140242130183594"
        sound2.Volume = 1
        sound2.Looped = true
        sound2.Parent = workspace
        sound2:Play()

        local sound3 = Instance.new("Sound")
        sound3.SoundId = "rbxassetid://97846194346269"
        sound3.Volume = 1
        sound3.Looped = true
        sound3.Parent = workspace
        sound3:Play()

        local sound4 = Instance.new("Sound")
        sound4.SoundId = "rbxassetid://106786416076383"
        sound4.Volume = 1
        sound4.Looped = true
        sound4.Parent = workspace
        sound4:Play()
        
    wait(1)
    
    while true do
    
    end)
    
    showMessage("请联系群主获取有效卡密", 3)
end