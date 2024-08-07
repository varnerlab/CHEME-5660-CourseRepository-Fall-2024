function _jld2(path::String)::Dict{String,Any}
    return load(path);
end

MyPortfolioDataSet() = _jld2(joinpath(_PATH_TO_DATA, "SP500-Daily-OHLC-1-3-2018-to-03-13-2024.jld2"));