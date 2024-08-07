"""
    μ(dataset::Dict{String, DataFrame}, firms::Array{String,1}; 
        Δt::Float64 = (1.0/252.0), risk_free_rate::Float64 = 0.0) -> Array{Float64,2}
"""
function μ(dataset::Dict{String, DataFrame}, 
    firms::Array{String,1}; Δt::Float64 = (1.0/252.0), risk_free_rate::Float64 = 0.0)::Array{Float64,2}

    # initialize -
    number_of_firms = length(firms);
    number_of_trading_days = nrow(dataset["AAPL"]);
    growth_matrix = Array{Float64,2}(undef, number_of_trading_days-1, number_of_firms);

    # main loop -
    for i ∈ eachindex(firms) 

        # get the firm data -
        firm_index = firms[i];
        firm_data = dataset[firm_index];

        # compute the log returns -
        for j ∈ 2:number_of_trading_days
            S₁ = firm_data[j-1, :volume_weighted_average_price];
            S₂ = firm_data[j, :volume_weighted_average_price];
            growth_matrix[j-1, i] = (1/Δt)*log(S₂/S₁) - risk_free_rate;
        end
    end

    # return -
    return growth_matrix;
end



"""
    encode(A::Array{Float64,1}, logic::Function) -> Array{Int64,1}

Encode a vector `A` using a logic function `logic` and returns a matrix of integers.

### Arguments
- `A::Array{Float64,2}`: a matrix of size `m x n`.
- `logic::Function`: a function that takes a float and returns an integer.

### Returns
- `B::Array{Int64,2}`: a matrix of size `m x n` such that `B[i,j] = logic(A[i,j])`.
"""
function encode(A::Array{Float64,1}, logic::Function)::Array{Int64,1}

    # initialize -
    m = length(A)
    B = zeros(Int64, m)

    # main loop -
    for i ∈ 1:m
        B[i] = logic(A[i])
    end

    # return -
    return B
end