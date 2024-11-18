"""
   function build(model::Type{M}, data::NamedTuple) -> AbstractMarkovModel where {M <: AbstractMarkovModel}

This `build` method constructs a concrete instance of type `M` where `M` is a subtype of `AbstractMarkovModel` type using the data in a [NamedTuple](https://docs.julialang.org/en/v1/base/base/#Core.NamedTuple).

### Arguments
- `model::Type{M}`: The type of model to build. This type must be a subtype of `AbstractMarkovModel`.
- `data::NamedTuple`: The data to use to build the model.

The `data::NamedTuple` argument must contain the following `keys`:
- `states::Array{Int64,1}`: The states of the model.
- `T::Array{Float64,2}`: The transition matrix of the model.
- `E::Array{Float64,2}`: The emission matrix of the model.
"""
function build(model::Type{MyHiddenMarkovModel}, data::NamedTuple)::MyHiddenMarkovModel
    
    # initialize -
    m = model(); # build an empty model, add data to it below
    transition = Dict{Int64, Categorical}();
    emission = Dict{Int64, Categorical}();

    # get stuff from the data NamedTuple -
    states = data.states;
    T = data.T; # this is the transition matrix
    E = data.E; # this is the emission matrix

    # build the transition and emission distributions -
    for s ∈ states
        transition[s] = Categorical(T[s,:]);
        emission[s] = Categorical(E[s,:]);
    end

    # add data to the model -
    m.transition = transition;
    m.emission = emission;
    m.states = states;

    # return -
    return m;
end


"""
   function build(model::Type{M}, data::NamedTuple) -> AbstractMarkovModel where {M <: AbstractMarkovModel}

This `build` method constructs a concrete instance of type `M` where `M` is a subtype of `AbstractMarkovModel` type using the data in a [NamedTuple](https://docs.julialang.org/en/v1/base/base/#Core.NamedTuple).

### Arguments
- `model::Type{M}`: The type of model to build. This type must be a subtype of `AbstractMarkovModel`.
- `data::NamedTuple`: The data to use to build the model.

The `data::NamedTuple` argument must contain the following `keys`:
- `states::Array{Int64,1}`: The states of the model.
- `T::Array{Float64,2}`: The transition matrix of the model.
- `E::Array{Float64,2}`: The emission matrix of the model.
"""
function build(model::Type{MyHiddenMarkovModelWithJumps}, data::NamedTuple)::MyHiddenMarkovModelWithJumps
    
    # initialize -
    m = model(); # build an empty model, add data to it below
    transition = Dict{Int64, Categorical}();
    inverse_transition = Dict{Int64, Categorical}();
    emission = Dict{Int64, Categorical}();
    ϵ = data.ϵ;
    λ = data.λ;

    # get stuff from the data NamedTuple -
    states = data.states;
    T = data.T; # this is the transition matrix
    E = data.E; # this is the emission matrix

    # build the transition and emission distributions -
    for s ∈ states
        transition[s] = Categorical(T[s,:]);
        emission[s] = Categorical(E[s,:]);
    end

    # build the inverse transition matrix -
    for s ∈ states
        F = sum(1 .- T[s,:]);
        d = (1/F)*(1 .- T[s,:]);
        inverse_transition[s] = Categorical(d);
    end

    # add data to the model -
    m.transition = transition;
    m.inverse_transition = inverse_transition;
    m.emission = emission;
    m.states = states;
    m.ϵ = ϵ;
    m.λ = λ;
    m.jump_distribution = Poisson(λ); # jump distribution

    # return -
    return m;
end
# --------------------------------------------------------------------------------------------- #