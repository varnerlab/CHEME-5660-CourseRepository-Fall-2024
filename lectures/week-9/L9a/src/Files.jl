function _loadcsvfile(path::String)::DataFrame
    return CSV.read(path, DataFrame);
end

MyOptionsChainDataSet() = _loadcsvfile(joinpath(_PATH_TO_DATA, "AMD-options-exp-2023-08-18-monthly-07-18-2023.csv"));