local ServerScriptService = game:GetService("ServerScriptService")

local structurizer = {}

structurizer.GlobalsSource = [[
    local globals = {}

    return globals
]]

function structurizer:Init(loader)
    self.Loader = loader
end

function structurizer:StructurizeGame()
    if ServerScriptService:FindFirstChild("Loader") then
        print("Game already Structiurized")
        return
    end

    local loader = Instance.new("Script")
    loader.Name = "Loader"
    loader.Source = self:GetLoaderSource()
    loader.Parent = ServerScriptService

    local scriptsFolder = Instance.new("Folder")
    scriptsFolder.Name = self.Loader.Settings:Get("ScriptsFolderName") or "Scripts"
    scriptsFolder.Parent = ServerScriptService
end

function structurizer:GetLoaderSource(): string
    local source = [[
        local ServerScriptService = game:GetService("ServerScriptService")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")

        local globals = require(ReplicatedStorage:WaitForChild("Globals"))
        local scripts = ServerScriptService:WaitForChild({{scriptsfoldername}})

        for _, script in ipairs(scripts:GetChildren()) do
            globals.ServerScripts[script.Name] = require(script)
        end

        for _, value in pairs(globals.ServerScripts) do
            if value.Init then return end
            value:Init()
        end
    ]]

    source = string.gsub(source, "{{scriptsfoldername}}", self.Loader.Settings:Get("ScriptsFolderName") or "Scripts")

    return source
end

return structurizer

