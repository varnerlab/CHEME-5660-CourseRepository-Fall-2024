_𝔼(X::Array{Float64,1}, p::Array{Float64,1}) = sum(X.*p)

𝒟(r̄,t) = exp(r̄*t);

function log_return_matrix(dataset::Dict{String, DataFrame}, 
    firms::Array{String,1}; Δt::Float64 = (1.0/252.0), risk_free_rate::Float64 = 0.0)::Array{Float64,2}

    # initialize -
    number_of_firms = length(firms);
    number_of_trading_days = nrow(dataset["AAPL"]);
    return_matrix = Array{Float64,2}(undef, number_of_trading_days-1, number_of_firms);

    # main loop -
    for i ∈ eachindex(firms) 

        # get the firm data -
        firm_index = firms[i];
        firm_data = dataset[firm_index];

        # compute the log returns -
        for j ∈ 2:number_of_trading_days
            S₁ = firm_data[j-1, :volume_weighted_average_price];
            S₂ = firm_data[j, :volume_weighted_average_price];
            return_matrix[j-1, i] = (1/Δt)*log(S₂/S₁) - risk_free_rate;
        end
    end

    # return -
    return return_matrix;
end

function log_return_matrix(dataset::Dict{String, DataFrame}, 
    firm::String; Δt::Float64 = (1.0/252.0), risk_free_rate::Float64 = 0.0)::Array{Float64,1}

    # initialize -
    number_of_trading_days = nrow(dataset["AAPL"]);
    return_matrix = Array{Float64,1}(undef, number_of_trading_days-1);

    # get the firm data -
    firm_data = dataset[firm];

    # compute the log returns -
    for j ∈ 2:number_of_trading_days
        S₁ = firm_data[j-1, :volume_weighted_average_price];
        S₂ = firm_data[j, :volume_weighted_average_price];
        return_matrix[j-1] = (1/Δt)*log(S₂/S₁) - risk_free_rate;
    end

    # return -
    return return_matrix;
end



"""
    𝔼(model::MyBinomialEquityPriceTree; level::Int = 0) -> Float64
"""
function 𝔼(model::MyBinomialEquityPriceTree; level::Int = 0)::Float64

    # initialize -
    expected_value = 0.0;
    X = Array{Float64,1}();
    p = Array{Float64,1}();

    # get the levels dictionary -
    levels = model.levels;
    nodes_on_this_level = levels[level]
    for i ∈ nodes_on_this_level

        # grab the node -
        node = model.data[i];
        
        # get the data -
        x_value = node.price;
        p_value = node.probability;

        # store the data -
        push!(X,x_value);
        push!(p,p_value);
    end

    # compute -
    expected_value = _𝔼(X,p) # inner product

    # return -
    return expected_value
end

"""
    𝔼(model::MyBinomialEquityPriceTree, levels::Array{Int64,1}; 
        startindex::Int64 = 0) -> Array{Float64,2}

Computes the expectation of the model simulation. Takes a model::MyBinomialEquityPriceTree instance and a vector of
tree levels, i.e., time steps and returns a variance array where the first column is the time and the second column is the expectation.
Each row is a time step.
"""
function 𝔼(model::MyBinomialEquityPriceTree, levels::Array{Int64,1}; 
    startindex::Int64 = 0)::Array{Float64,2}

    # initialize -
    number_of_levels = length(levels);
    expected_value_array = Array{Float64,2}(undef, number_of_levels, 2);

    # loop -
    for i ∈ 0:(number_of_levels-1)

        # get the level -
        level = levels[i+1];

        # get the expected value -
        expected_value = 𝔼(model, level=level);

        # store -
        expected_value_array[i+1,1] = level + startindex;
        expected_value_array[i+1,2] = expected_value;
    end

    # return -
    return expected_value_array;
end

Var(model::MyBinomialEquityPriceTree, levels::Array{Int64,1}; startindex::Int64 = 0) = 𝕍(model, levels, startindex = startindex)

"""
    𝕍(model::MyBinomialEquityPriceTree; level::Int = 0) -> Float64
"""
function 𝕍(model::MyBinomialEquityPriceTree; level::Int = 0)::Float64

    # initialize -
    variance_value = 0.0;
    X = Array{Float64,1}();
    p = Array{Float64,1}();

    # get the levels dictionary -
    levels = model.levels;
    nodes_on_this_level = levels[level]
    for i ∈ nodes_on_this_level
 
        # grab the node -
        node = model.data[i];
         
        # get the data -
        x_value = node.price;
        p_value = node.probability;
 
        # store the data -
        push!(X,x_value);
        push!(p,p_value);
    end

    # update -
    variance_value = (_𝔼(X.^2,p) - (_𝔼(X,p))^2)

    # return -
    return variance_value;
end

"""
    𝕍(model::MyBinomialEquityPriceTree, levels::Array{Int64,1}; startindex::Int64 = 0) -> Array{Float64,2}

Computes the variance of the model simulation. Takes a model::MyBinomialEquityPriceTree instance and a vector of
tree levels, i.e., time steps and returns a variance array where the first column is the time and the second column is the variance.
Each row is a time step.
"""
function 𝕍(model::MyBinomialEquityPriceTree, levels::Array{Int64,1}; startindex::Int64 = 0)::Array{Float64,2}

    # initialize -
    number_of_levels = length(levels);
    variance_value_array = Array{Float64,2}(undef, number_of_levels, 2);

    # loop -
    for i ∈ 0:(number_of_levels - 1)
        level = levels[i+1];
        variance_value = 𝕍(model, level=level);
        variance_value_array[i+1,1] = level + startindex
        variance_value_array[i+1,2] = variance_value;
    end

    # return -
    return variance_value_array;
end