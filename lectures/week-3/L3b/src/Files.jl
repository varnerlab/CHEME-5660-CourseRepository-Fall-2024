# Internal method for load a CSV file 
function _loadcsvfile(path::String)::DataFrame
    return CSV.read(path, DataFrame);
end

function _jld2(path::String)::Dict{String,Any}
    return load(path);
end

# Load harded coded specific files -
function MyTreasuryNotesAndBondsDataSet()::DataFrame
    return _loadcsvfile(joinpath(_PATH_TO_DATA, "US-TNotesBonds-Prices-TD-May-Sept-2023.csv"));
end