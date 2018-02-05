export compute

"""
`compute(path::String)`

Call the `compute` function on the configuration file.

Inputs:
======

* path::String - Path to configuration file

"""
function compute(path::String)
    cfg = parse_config(path)
    is_raster = cfg["data_type"] == "raster"
    scenario = cfg["scenario"]
    T = cfg["precision"] in SINGLE ? Float32 : Float64 
    if is_raster
        if scenario == "pairwise"
            raster_pairwise(T, cfg)
        elseif scenario == "advanced"
            raster_advanced(T, cfg)
        elseif scenario == "one-to-all"
            raster_one_to_all(T, cfg)
        else
            raster_all_to_one(T, cfg)
        end
    else
        if scenario == "pairwise"
            network_pairwise(T, cfg)
        else
            network_advanced(T, cfg)
        end
    end
end