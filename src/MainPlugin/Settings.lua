local settings = {}

local cache = {}

function settings:Init(loader, plugin: Plugin)
    self.Loader = loader
    self.plugin = plugin
end

function settings:Set(key: string, value: any)
    cache[key] = value
    self.plugin:SetSetting(key, value)
end

function settings:Get(key: string): any
    if cache[key] then
        return cache[key]
    end
    return self.plugin:GetSetting(key)
end

function settings:LoadDefaults()
    self:Set("ScriptsFolderName", "Scripts")
    self:Set("HasUsedBefore", true)
end

return settings