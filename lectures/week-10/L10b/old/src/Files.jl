function loadoptionsdata()::DataFrame
    return CSV.read(joinpath(_PATH_TO_DATA, "AMD-options-exp-2023-08-18-monthly-07-18-2023.csv"), DataFrame);
end