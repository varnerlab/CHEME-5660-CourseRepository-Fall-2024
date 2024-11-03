function search(dataset::Dict{Int64, Vector{Dict{String, Any}}}, DTE::Int64, logic::Function)::DataFrame

    # initialize -
    results = DataFrame();

    # iterate over the dataset -
    records = dataset[DTE];
    for record in records

        if (logic(DTE, record) == true)

            # @show record["details"]
            
            # capture data from the record -
            row_df = (
                underlying = record["underlying_asset"]["price"],
                strike = record["details"]["strike_price"] |> x-> convert(Float64, x),
                type = record["details"]["contract_type"],
                bid = record["last_quote"]["bid"] |> x-> convert(Float64, x),
                ask = record["last_quote"]["ask"] |> x-> convert(Float64, x),
                midpoint = record["last_quote"]["midpoint"] |> x-> convert(Float64, x),
                bid_size = record["last_quote"]["bid_size"] |> x-> convert(Int64, x),
                ask_size = record["last_quote"]["ask_size"] |> x-> convert(Int64, x)
            );

            # capture -
            push!(results, row_df);
        end
    end

    return results;
end