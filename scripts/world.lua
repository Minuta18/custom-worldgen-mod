require "customworldgen:main"

function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
end 


local chunks = {}
local ticks_before_regen = 60
local datafile = pack.data_file("customworldgen", "loaded_chunk.json")

function on_world_open()
    if not file.exists(datafile) then
        return {}
    end
    chunks = json.parse(file.read(datafile))
end

function on_world_tick()
    ticks_before_regen = ticks_before_regen - 1
    if ticks_before_regen ~= 0 then return end
    ticks_before_regen = 60
    -- if executed then return end
    for x = -10, 10, 1 do
        for z = -10, 10, 1 do
            -- Chunk respresents as rectangle
            local cx1, cz1, cx2, cz2 = customworldgen.get_cords_by_chunk(x, z)
            local px, py, pz = player.get_pos(0)
            -- Adding player's position
            cx1 = math.floor(cx1 + px)
            cz1 = math.floor(cz1 + pz)
            cx2 = math.floor(cx2 + px)
            cx2 = math.floor(cz2 + pz)
            local rcx, rcz = x + math.floor(px / 16), z + math.floor(pz / 16)
            -- Executing generation only if chunk is loaded
            -- print(string.format("%s %s", cx1, cz1))
            -- print(block.get(cx1, cz1))
            local ind = string.format("%s %s", rcx, rcz)
            if chunks[ind] == nil or chunks[ind] == false then
                if block.get(cx1, 0, cz1) ~= -1 then
                    chunks[ind] =  true
                    for i, gen in ipairs(customworldgen.generators) do
                        gen(rcx, rcz)                        
                    end
                end
            end
        end
    end
end

function on_world_save()
    print(dump(chunks))
    print(json.tostring(chunks))
    file.write(datafile, json.tostring(chunks))
end
