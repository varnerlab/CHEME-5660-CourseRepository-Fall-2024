# --- PRIVATE FUNCTIONS BELOW HERE ------------------------------------------------------------------------------------ #

# --- PRIVATE FUNCTIONS ABOVE HERE ------------------------------------------------------------------------------------ #

# --- PUBLIC FUNCTIONS BELOW HERE ------------------------------------------------------------------------------------- #
function wealth(simulation::Dict{Int64,Array{Float64,2}}, ω::Array{Float64,1};
    number_of_days::Int64 = 100, total_budget::Float64 = 1000.0)
    
    # initialize -
    number_of_trials = length(simulation);
    number_of_states = length(ω);
    number_of_shares = Array{Float64,1}()
    for i ∈ eachindex(ω)
        ωᵢ = ω[i]
        nᵢ = (ωᵢ*total_budget)/simulation[1][1,i+1]; # initial price
        push!(number_of_shares, nᵢ)
    end

    # main -
    simulated_wealth_array = Array{Float64,2}(undef, number_of_days, number_of_trials);
    for i ∈ 1:number_of_trials
        simulation_array = simulation[i]
        portfolio_performance_array = Array{Float64,2}(undef, number_of_days, length(ω)+1)
        for j ∈ 1:number_of_states
            price_data = simulation_array[:,j+1];
            nⱼ = number_of_shares[j]

            for k ∈ 1:number_of_days
                portfolio_performance_array[k,j] = nⱼ*price_data[k];
            end
        end

        # total -
        for j ∈ 1:number_of_days
            portfolio_performance_array[j,end] = sum(portfolio_performance_array[j,1:end-1])
        end

        # wealth -
        for j ∈ 1:number_of_days
            simulated_wealth_array[j,i] = portfolio_performance_array[j,end];
        end
    end

    return simulated_wealth_array;
end

function allocation(simulation::Dict{Int64,Array{Float64,2}};
    number_of_iterations::Int64 = 100, total_budget::Float64 = 1000.0)::DataFrame
    
    # get the time points, abd the number of states -
    (number_of_rows, number_of_columns) = size(simulation[1]);
    number_of_states = number_of_columns - 1;
    number_of_time_steps = number_of_rows;

    # initialize -
    objective_best = 0.0;
    archive = DataFrame();
    parameters_best = ones(number_of_states);
    α = (1/number_of_states)*ones(number_of_states);

    # compute the initial prices -
    tmp = simulation[1];
    Sₒ = Array{Float64,1}()
    for i ∈ 1:number_of_states
        push!(Sₒ, tmp[1, i+1])
    end

    # main -
    for i ∈ 1:number_of_iterations

        # generate a random allocation -
        ω = Dirichlet(α) |> d->rand(d);   

        # compute the number of shares that have been purchased
        Nₒ = Array{Float64,1}()
        for i ∈ eachindex(ω)
            ωᵢ = ω[i]
            nᵢ = (ωᵢ*total_budget)/Sₒ[i];
            push!(Nₒ,nᵢ)
        end

        simulated_wealth_array = Array{Float64,2}(undef, number_of_time_steps, number_of_trials);
        for i ∈ 1:number_of_trials
    
            simulation_array = simulation[i]
            portfolio_performance_array = Array{Float64,2}(undef, number_of_time_steps, length(ω)+1)
            for j ∈ 1:number_of_states
                price_data = simulation_array[:,j+1];
                nⱼ = Nₒ[j]
    
                for k ∈ 1:number_of_time_steps
                    portfolio_performance_array[k,j] = nⱼ*price_data[k];
                end
            end

            # total -
            for j ∈ 1:number_of_time_steps
                portfolio_performance_array[j,end] = sum(portfolio_performance_array[j,1:end-1])
            end
    
            # wealth -
            for j ∈ 1:number_of_time_steps
                simulated_wealth_array[j,i] = portfolio_performance_array[j,end];
            end
        end

        # compute the future expected wealth and the wealth variance -
        expected_future_weath = mean(simulated_wealth_array[end,:]);
        expected_future_risk = std(simulated_wealth_array[end,:]);
        objective_value = expected_future_weath/expected_future_risk;
        if (objective_value > objective_best)
            objective_best = objective_value
            parameters_best = α;

            # update the archive -
            row_df = (
                iteration = i,
                objective = objective_value,
                ω = ω,
                α = α
            );
            push!(archive,row_df);
            α = rand(0.2:0.01:1.8, number_of_states).*α;
        end
    end

    return archive;
end
# --- PUBLIC FUNCTIONS ABOVE HERE ------------------------------------------------------------------------------------- #