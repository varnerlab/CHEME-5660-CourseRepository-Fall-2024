_payoff(contract::Union{MyEuropeanCallContractModel, MyAmericanCallContractModel}, S::Float64) = max(0.0, S - contract.K)
_payoff(contract::Union{MyEuropeanPutContractModel,MyAmericanPutContractModel}, S::Float64) = max(0.0, contract.K - S)

function payoff(contracts::Array{T,1}, S::Array{Float64,1})::Array{Float64,2} where T <: AbstractContractModel

    # initialize - 
    number_of_underlying_prices = length(S);
    number_of_contracts = length(contracts);
    payoff_array = Array{Float64,2}(undef, number_of_underlying_prices, number_of_contracts+2);

    # main loop -
    for i ∈ 1:number_of_underlying_prices

        # get the underlying price -
        Sᵢ = S[i];

        # compute the payoff -
        payoff_array[i,1] = Sᵢ;

        # loop over the contracts -
        for j ∈ 1:number_of_contracts

            # get the contract -
            contract = contracts[j];
            sense = contract.sense |> Float64;

            # compute the payoff -
            payoff_array[i,j+1] = (sense)*_payoff(contract, Sᵢ);
        end
    end

    # compute the sum -
    for i ∈ 1:number_of_underlying_prices
        payoff_array[i,end] = sum(payoff_array[i,2:end-1]);
    end

    # return -
    return payoff_array;
end

function profit(contracts::Array{T,1}, S::Array{Float64,1})::Array{Float64,2} where T <: AbstractContractModel

    # initialize - 
    number_of_underlying_prices = length(S);
    number_of_contracts = length(contracts);
    profit_array = Array{Float64,2}(undef, number_of_underlying_prices, number_of_contracts+2);

    # main loop -
    for i ∈ 1:number_of_underlying_prices

        # get the underlying price -
        Sᵢ = S[i];

        # compute the payoff -
        profit_array[i,1] = Sᵢ;

        # loop over the contracts -
        for j ∈ 1:number_of_contracts

            # get the contract -
            contract = contracts[j];
            sense = contract.sense |> Float64;

            copy = nothing;
            if (isnothing(contract.copy))
                copy = 1.0;
            else
                copy = contract.copy |> Float64;
            end
            premium = contract.premium;

            # compute the payoff -
            profit_array[i,j+1] = (copy*sense)*(_payoff(contract, Sᵢ) - premium)
        end
    end

    # compute the sum -
    for i ∈ 1:number_of_underlying_prices
        profit_array[i,end] = sum(profit_array[i,2:end-1]);
    end

    # return -
    return profit_array;    
end