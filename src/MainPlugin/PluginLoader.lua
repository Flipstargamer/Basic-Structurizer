local pluginLoader = {}


function pluginLoader:Init(plugin: Plugin)
    pluginLoader.Toolbar = plugin:CreateToolbar("Basic Structurizer")
    pluginLoader.Struct = pluginLoader.Toolbar:CreateButton("Structurize", "Structiurize the game", "rbxassetid://0")
    pluginLoader.SettingsButton = pluginLoader.Toolbar:CreateButton("Open Settings", "Structiurize the game", "rbxassetid://0")
    pluginLoader.Structurizer = require(script.Parent:WaitForChild("Structurizer"))
    pluginLoader.GuiService = require(script.Parent:WaitForChild("Gui"):WaitForChild("GuiService"))
    pluginLoader.Settings = require(script.Parent:WaitForChild("Settings"))

    self.Settings:Init(self, plugin)

    if not self.Settings:Get("HasUsedBefore") then
        self.Settings:LoadDefaults()
    end

    --self.GuiService:Init(self)
    self.Structurizer:Init(self)

    self.Struct.Click:Connect(function()
        self.Structurizer:StructurizeGame()
    end)

    self.SettingsButton.Click:Connect(function()
        self.GuiService:OpenSettingsGui()
    end)
end

return pluginLoader