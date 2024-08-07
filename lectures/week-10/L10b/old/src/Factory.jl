function _build(modeltype::Type{T}, data::NamedTuple) where T <: AbstractAssetModel
    
    # build an empty model
    model = modeltype();

    # if we have options, add them to the contract model -
    if (isempty(data) == false)
        for key ∈ fieldnames(modeltype)
            
            # check the for the key - if we have it, then grab this value
            value = nothing
            if (haskey(data, key) == true)
                # get the value -
                value = data[key]
            end

            # set -
            setproperty!(model, key, value)
        end
    end
 
    # return -
    return model
end

build(model::Type{MyEuropeanCallContractModel}, data::NamedTuple)::MyEuropeanCallContractModel = _build(model, data)
build(model::Type{MyEuropeanPutContractModel}, data::NamedTuple)::MyEuropeanPutContractModel = _build(model, data)
build(model::Type{MyAmericanPutContractModel}, data::NamedTuple)::MyAmericanPutContractModel = _build(model, data)
build(model::Type{MyAmericanCallContractModel}, data::NamedTuple)::MyAmericanCallContractModel = _build(model, data)