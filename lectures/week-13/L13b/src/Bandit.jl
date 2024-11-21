function sample(model::ThompsonSamplingModel; 𝒯::Int64 = 0, world::Function = _null)::Dict{Int64, Array{Float64,2}}

    # initialize -
    α = model.α
    β = model.β
    K = model.K
    θ̂_vector = Array{Float64,1}(undef, K)
    time_sample_results_dict = Dict{Int64, Array{Float64,2}}();

    # initialize collection of Beta distributions -
    action_distribution = Array{Beta,1}(undef, K);
    for k ∈ 1:K
        action_distribution[k] = Beta(α[k], β[k]); # initialize uniform
    end

    # main sampling loop -
    for t ∈ 1:𝒯

        # create a new parameter array -
        parameter_array = Array{Float64,2}(undef, K,2);
        fill!(parameter_array,0.0);

        for k ∈ 1:K

            # grab the distribution for action k -
            d = action_distribution[k];

            # generate a sample for this action -
            θ̂_vector[k] = rand(d);

            # store the parameter array -
            αₖ, βₖ = params(d);
            parameter_array[k,1] = αₖ
            parameter_array[k,2] = βₖ

            # store -
            time_sample_results_dict[t] = parameter_array;
        end

        # ok: let's choose an action -
        aₜ = argmax(θ̂_vector);

        # pass that action to the world function, gives back a reward -
        rₜ = world(aₜ);

        # update the parameters -
        # first, get the old parameters -
        old_d = action_distribution[aₜ];
        αₒ,βₒ = params(old_d);

        # update the old values with the new values -
        αₜ = αₒ + rₜ
        βₜ = βₒ + (1-rₜ)

        # build new distribution -
        action_distribution[aₜ] = Beta(αₜ, βₜ);
    end
    
    # return -
    return time_sample_results_dict;
end 

function sample(model::EpsilonSamplingModel;  𝒯::Int64 = 0, world::Function = _null)::Dict{Int64, Array{Float64,2}}

    # initialize -
    α = model.α
    β = model.β
    K = model.K
    ϵ = model.ϵ
    θ̂_vector = Array{Float64,1}(undef, K)
    time_sample_results_dict = Dict{Int64, Array{Float64,2}}();

    # generate random Categorical distribution -
    parray = [1/K for i = 1:K]
    dcat = Categorical(parray);

    # initialize collection of Beta distributions -
    action_distribution = Array{Beta,1}(undef, K);
    for k ∈ 1:K
        action_distribution[k] = Beta(α[k], β[k]); # initialize uniform
    end

    # main sampling loop -
    for t ∈ 1:𝒯
    
        # create a new parameter array -
        parameter_array = Array{Float64,2}(undef, K,2);
        fill!(parameter_array,0.0);
        
        for k ∈ 1:K
            
            # grab the distribution for action k -
            d = action_distribution[k];

            # store the parameter array -
            αₖ, βₖ = params(d);
            parameter_array[k,1] = αₖ
            parameter_array[k,2] = βₖ

            # store -
            time_sample_results_dict[t] = parameter_array;
        end


        aₜ = nothing; # default to 1
        if (rand() ≤ ϵ)
            aₜ = rand(dcat);
        else

            for k ∈ 1:K

                # grab the distribution for action k -
                d = action_distribution[k];
    
                # generate a sample for this action -
                θ̂_vector[k] = rand(d);
            end

            # ok: let's choose an action -
            aₜ = argmax(θ̂_vector);
        end

        # pass that action to the world function, gives back a reward -
        rₜ = world(aₜ);

        # update the parameters -
        # first, get the old parameters -
        old_d = action_distribution[aₜ];
        α,β = params(old_d);

        # update the old values with the new values -
        α = α + rₜ
        β = β + (1-rₜ)

        # build new distribution -
        action_distribution[aₜ] = Beta(α, β);
    end

    # return -
    return time_sample_results_dict;
end

function build_beta_array(parameters::Array{Float64,2})::Array{Beta,1}

    # build an array of beta distributions -
    (NR,_) = size(parameters);
    beta_array = Array{Beta,1}(undef,NR)
    for i ∈ 1:NR
        
        # grab the parameters -
        α = parameters[i,1];
        β = parameters[i,2];

        # build -
        beta_array[i] = Beta(α, β);
    end

    # return -
    return beta_array;
end