# Internal method for load a CSV file 
function _loadcsvfile(path::String)::DataFrame
    return CSV.read(path, DataFrame);
end

# Load harded coded specific files -
function MyTreasuryBillDataSet()::DataFrame
    return _loadcsvfile(joinpath(_PATH_TO_DATA, "data/US-TBill-Prices-TD-May-Sept-2023.csv"));
end