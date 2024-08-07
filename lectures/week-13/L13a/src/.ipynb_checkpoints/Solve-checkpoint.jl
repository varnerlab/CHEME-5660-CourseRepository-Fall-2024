function _simulate(m::MyObservableMarkovModel, start::Int64, steps::Int64)::Array{Int64,1}

    # initialize -
    chain = Array{Int64,1}(undef, steps);
    chain[1] = start;

    # main loop -
    for i ∈ 2:steps
        chain[i] = rand(m.transition[chain[i-1]]);
    end

    return chain;
end

(m::MyObservableMarkovModel)(start::Int64, steps::Int64) = _simulate(m, start, steps);   