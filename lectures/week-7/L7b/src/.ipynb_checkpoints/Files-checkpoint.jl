function _jld2(path::String)::Dict{String,Any}
    return load(path);
end

MyMarketDataSet() = _jld2(joinpath(_PATH_TO_DATA, "SP500-Daily-OHLC-1-3-2018-to-12-01-2023.jld2"));