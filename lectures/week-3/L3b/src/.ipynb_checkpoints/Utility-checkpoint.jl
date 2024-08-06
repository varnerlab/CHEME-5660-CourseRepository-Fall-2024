function securityterm(duration::String)::Float64

    # initialize -
    number_of_weeks_per_year = 52.0;
    number_of_days_per_year = 365.0;
    value = 0.0;
    numerator = 0.0;
    denominator = 1.0;

    # convert -
    security_term_components = split(duration, "-");
    if (length(security_term_components) != 2)
        throw(ArgumentError("Invalid security term value: $duration"));
    end

    # get the duration -
    unit_of_time = security_term_components[2];
    if (unit_of_time == "Week")
        denominator = number_of_weeks_per_year;
    elseif (unit_of_time == "Day")
        denominator = number_of_days_per_year;
    else
        throw(ArgumentError("Invalid security term value: $duration"));
    end

    # get the term -
    numerator = security_term_components[1] |> String |> x-> parse(Float64,x)
    
    # calculate -
    value = numerator / denominator;

    # return -
    return value;
end