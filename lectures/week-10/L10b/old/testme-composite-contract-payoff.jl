include("Include.jl")

# build a short strangle -
call_contract = build(MyAmericanCallContractModel, (
    K = 100.0,
    sense = 1,
    DTE = 45.0,
    IV = 0.25,
    premium = 1.0
));

put_contract = build(MyAmericanPutContractModel, (
    K = 80.0,
    sense = 1,
    DTE = 45.0,
    IV = 0.25,
    premium = 1.0
));

# build the contract array -
contracts = [call_contract, put_contract];

# build the underlying price array -
S = range(70.0, 110.0, length=100) |> collect;

# compute the payoff -
payoff_array = payoff(contracts, S);
profit_array = profit(contracts, S);
