local Translations = {
   ["Auto Farm"] = "自动农场",
    ["Automatically"] = "自动地",
    ["Auto Claim Gifts"] = "自动领取礼物",
    ["Set Size"] = "设置尺寸",
    ["Auto Set Size"] = "自动设置尺寸",
    ["Buy Pet"] = "购买宠物",
    ["Select Pet- None"] = "选择宠物 - 无",
    ["Auto Rebirth"] = "自动重生",
    ["Target Rebirths"] = "目标重生次数 ",
    ["Auto Rebirth Target"] = "自动重目标",
    ["Select Crystal-Mythical Crystal"] = "选择水晶-神话水晶",
    ["Auto Open Crystal"] = "自动开启水晶",
    ["Auto Farm Weight"] = "自动农场举重",
    ["Auto Farm Handstands"] = "自动农场倒立",
    ["Auto Farm Punch"] = "自动农场拳击",
    ["Auto Farm Pushups"] = "自动农场俯卧撑",
    ["Auto Farm Situps"] = "自动农场仰卧起坐",
    ["Faster Farm"] = "快速农场",
    ["Faster Auto Farm Weight"] = "快速自动农场举重",
    ["Faster Auto Farm Handstands"] = "快速自动农场倒立",
    ["Faster Auto Farm Pushups"] = "快速自动农场俯卧撑",
    ["Faster Auto Farm Situps"] = "快速自动农场仰卧起坐",
    ["Teleport"] = "传送",
    ["Miscellaneous"] = "杂项",
    ["Auto Join Brawl"] = "自动加入乱斗",
    ["Auto Spin Wheel"] = "自动旋转转盘",
    ["Lock Position"] = "锁定位置",
    ["Blue Crystal"] = "蓝色水晶",
    ["Frost Crystal"] = "冰霜水晶",
    ["Galaxy Oracle Crystal"] = "星系预言水晶",
    ["Green Crystal"] = "绿色水晶",
    ["Inferno Crystal"] = "地狱水晶",
    ["Jungle Crystal"] = "丛林水晶",
    ["Legends Crystal"] = "传奇水晶",
    ["Muscle Elite Crystal"] = "肌肉精英水晶",
    ["Mythical Crystal"] = "神话水晶",
    ["Walkspeed"] = "移动速度",
    ["Enable Walkspeed"] = "启用移动速度",
    ["Anti-AFK"] = "防挂机",
    ["White Screen"] = "白屏",
    ["FPS Booster"] = "加速器",
}

local function translateText(text)
    if not text or type(text) ~= "string" then return text end
    
    if Translations[text] then
        return Translations[text]
    end
    
    for en, cn in pairs(Translations) do
        if text:find(en) then
            return text:gsub(en, cn)
        end
    end
    
    return text
end

local function setupTranslationEngine()
    local success, err = pcall(function()
        local oldIndex = getrawmetatable(game).__newindex
        setreadonly(getrawmetatable(game), false)
        
        getrawmetatable(game).__newindex = newcclosure(function(t, k, v)
            if (t:IsA("TextLabel") or t:IsA("TextButton") or t:IsA("TextBox")) and k == "Text" then
                v = translateText(tostring(v))
            end
            return oldIndex(t, k, v)
        end)
        
        setreadonly(getrawmetatable(game), true)
    end)
    
    if not success then
        warn("元表劫持失败:", err)
       
        local translated = {}
        local function scanAndTranslate()
            for _, gui in ipairs(game:GetService("CoreGui"):GetDescendants()) do
                if (gui:IsA("TextLabel") or gui:IsA("TextButton") or gui:IsA("TextBox")) and not translated[gui] then
                    pcall(function()
                        local text = gui.Text
                        if text and text ~= "" then
                            local translatedText = translateText(text)
                            if translatedText ~= text then
                                gui.Text = translatedText
                                translated[gui] = true
                            end
                        end
                    end)
                end
            end
            
            local player = game:GetService("Players").LocalPlayer
            if player and player:FindFirstChild("PlayerGui") then
                for _, gui in ipairs(player.PlayerGui:GetDescendants()) do
                    if (gui:IsA("TextLabel") or gui:IsA("TextButton") or gui:IsA("TextBox")) and not translated[gui] then
                        pcall(function()
                            local text = gui.Text
                            if text and text ~= "" then
                                local translatedText = translateText(text)
                                if translatedText ~= text then
                                    gui.Text = translatedText
                                    translated[gui] = true
                                end
                            end
                        end)
                    end
                end
            end
        end
        
        local function setupDescendantListener(parent)
            parent.DescendantAdded:Connect(function(descendant)
                if descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox") then
                    task.wait(0.1)
                    pcall(function()
                        local text = descendant.Text
                        if text and text ~= "" then
                            local translatedText = translateText(text)
                            if translatedText ~= text then
                                descendant.Text = translatedText
                            end
                        end
                    end)
                end
            end)
        end
        
        pcall(setupDescendantListener, game:GetService("CoreGui"))
        local player = game:GetService("Players").Loca
