customworldgen = {}

customworldgen.CHUNK_SIDE = 16
customworldgen.generators = {}
customworldgen.params = {}
customworldgen.params["generation_rate"] = 60
customworldgen.params["generation_radius"] = 10

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
