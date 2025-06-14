local HttpService = game:GetService("HttpService")
local HttpUtils = {}

function HttpUtils:Get(url)
    local success, result = pcall(function()
        return game:HttpGet(url)
    end)
    if not success then
        warn("HTTP GET failed for URL: " .. url)
        return nil
    end
    return result
end

function HttpUtils:GetWithRetry(url, retries)
    retries = retries or 3
    for i = 1, retries do
        local result = HttpUtils:Get(url)
        if result then return result end
        task.wait(1)
    end
    return nil
end

return HttpUtils
