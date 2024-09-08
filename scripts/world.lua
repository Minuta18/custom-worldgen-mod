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
local ticks_before_regen = customworldgen.params["generation_rate"]
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
    ticks_before_regen = customworldgen.params["generation_rate"]
    local radius = customworldgen.params["generation_radius"]
    for x = -radius, radius, 1 do
        for z = -radius, radius, 1 do
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
    file.write(datafile, json.tostring(chunks))
end
