function MyOptionsChainDataSet(;basedate::Date = Date("2023-06-19"))::Dict{Int64, Vector{Dict{String, Any}}}

    # initialize -
    results = Dict{Int64, Vector{Dict{String, Any}}}();

    # load all the files in the data directory -
    list_of_files = readdir(_PATH_TO_DATA, join=true);
    for filename in list_of_files

        # load the data -
        data = load(filename,"data");
        expdate = data[1]["details"]["expiration_date"] |> Date
        DTE = (expdate - basedate) |> x-> Dates.value(x);

        # build inner


        results[DTE] = data;
    end

    # return -
    return(results);
end