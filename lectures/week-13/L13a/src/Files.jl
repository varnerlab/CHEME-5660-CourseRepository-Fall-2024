function _jld2(path::String)::Dict{String,Any}
    return load(path);
end

MyPortfolioDataSet() = _jld2(joinpath(_PATH_TO_DATA, "SP500-Daily-OHLC-1-3-2018-to-12-29-2023.jld2"));
MyOutOfSamplePortfolioDataSet() = _jld2(joinpath(_PATH_TO_DATA, "SP500-Daily-OHLC-1-3-2024-to-09-24-2024.jld2"));