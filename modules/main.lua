customworldgen = {}

customworldgen.CHUNK_SIDE = 16
customworldgen.generators = {}

customworldgen.get_cords_by_chunk = function (chunk_x, chunk_z)
    return chunk_x * customworldgen.CHUNK_SIDE, 
        chunk_z * customworldgen.CHUNK_SIDE, 
        chunk_x * customworldgen.CHUNK_SIDE + customworldgen.CHUNK_SIDE - 1, 
        chunk_z * customworldgen.CHUNK_SIDE + customworldgen.CHUNK_SIDE - 1
end

customworldgen.get_chunk_by_cords = function (x, z)
    return math.floor(x / customworldgen.CHUNK_SIDE), 
        math.floor(z / customworldgen.CHUNK_SIDE)
end

customworldgen.register_generator = function (generator)
    table.insert(customworldgen.generators, generator)
end



customworldgen.register_generator(function (chunk_x, chunk_z)
    local cx1, cz1, cx2, cz2 = customworldgen.get_cords_by_chunk(
        chunk_x, chunk_z
    )

    for y = 60, 100, 1 do
        block.set(cx1 + 8, y, cz1 + 8, block.index("base:stone"), 0)
    end
end)
