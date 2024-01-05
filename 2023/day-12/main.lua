-- Read data and split them into lines. Lua doesn't have native methods for that.
local contents = io.lines("input.txt", "a")()
local data = {}
for line in contents:gmatch("[^\n]+") do
    table.insert(data, line)
end

local memo = {}

-- Function to stringify an array. This is used as a key.
local function stringify(array)
    local str = ""
    for _, v in ipairs(array) do
        str = str .. v .. ","
    end
    return str:sub(1, -2)
end

-- Copy an array with its first element popped.
local function popfirst(array)
    local result = {}
    if #array <= 1 then
        return result
    end

    for i = 2, #array do
        table.insert(result, array[i])
    end
    return result
end

-- Arguments in order:
-- prompt: The full prompt that was passed in.
-- matchgroup: The group that we should match against.
-- lastgroup: The number of broken springs at this point.
local function fillqmarks(prompt, matchgroup, lastgroup)
    -- Base case, if prompt is empty.
    if #prompt == 0 then
        if #matchgroup == 0 or matchgroup[1] == lastgroup then -- Return 1 if we've matched all groups.
            return 1
        else
            return 0 -- If there is more to match, oh no.
        end
    end

    -- Base case 2, if match group is empty.
    if #matchgroup == 0 then
        if prompt:find("#") == nil then -- There are no more surely broken behind.
            return 1
        else
            return 0 -- Only dots behind! We're done!
        end
    end

    -- If lastgroup is already > matchgroup[1], then it's meaningless to go further.
    if lastgroup > matchgroup[1] then
        return 0
    end

    -- If memoized, return the memoized value.
    local key = prompt .. "," .. stringify(matchgroup) .. "," .. lastgroup
    if memo[key] ~= nil then
        return memo[key]
    end

    -- Start handling the new case.
    local char = prompt:sub(1, 1)
    local val = 0

    if char == "#" then
        val = fillqmarks(prompt:sub(2), matchgroup, lastgroup + 1)
    elseif char == "." then
        if lastgroup > 0 then
            if matchgroup[1] ~= lastgroup then
                val = 0
            else
                val = fillqmarks(prompt:sub(2), popfirst(matchgroup), 0)
            end
        else
            val = fillqmarks(prompt:sub(2), matchgroup, lastgroup) -- Noop. Val is equal to next call.
        end
    elseif char == "?" then                                        -- It's an unknown! Split!
        local prompthash = "#" .. prompt:sub(2)
        local promptdot = "." .. prompt:sub(2)
        val = fillqmarks(prompthash, matchgroup, lastgroup) + fillqmarks(promptdot, matchgroup, lastgroup)
    else
        print("Uh oh at " .. prompt .. "," .. stringify(matchgroup) .. "," .. lastgroup .. "!")
        return -1
    end

    -- We should have retrieved val by now.
    memo[key] = val
    return val
end

-- Just splitting 1,1,3 into an actual array to work on.
local function makematchgroup(matchdata)
    local matchgroup = {}
    for num in matchdata:gmatch("%d+") do
        table.insert(matchgroup, tonumber(num))
    end
    return matchgroup
end

-- Expand the data 5 fold like the AoC problem.
local function expanddata(prompt, matchdata)
    local expprompt = prompt:rep(5, "?")
    local expmatchdata = matchdata:rep(5, ",")
    return expprompt, makematchgroup(expmatchdata)
end

-- Part one operates on folded data.
local function solvepartone(data)
    local sum = 0
    for _, line in ipairs(data) do
        local prompt, matchdata = line:match("^(.+) (.+)$")
        local matchgroup = makematchgroup(matchdata)
        local v = fillqmarks(prompt .. ".", matchgroup, 0)
        sum = sum + v
    end
    print(sum)
end

-- Part two operates on expanded data.
local function solveparttwo(data)
    local sum = 0
    for _, line in ipairs(data) do
        local prompt, matchdata = line:match("^(.+) (.+)$")
        local expprompt, expdata = expanddata(prompt, matchdata)
        local v = fillqmarks(expprompt .. ".", expdata, 0)
        sum = sum + v
    end
    print(sum)
end

-- Please please please please pleaes please
solvepartone(data)
solveparttwo(data)
