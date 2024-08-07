abstract type AbstractMarkovModel end


mutable struct MyObservableMarkovModel <: AbstractMarkovModel
    
    # data -
    states::Array{Int64,1}
    transition::Dict{Int64, Categorical}
    emission::Dict{Int64, Categorical}

    # constructor -
    MyObservableMarkovModel() = new();
end