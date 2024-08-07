abstract type AbstractAssetModel end
abstract type AbstractContractModel <: AbstractAssetModel end

mutable struct MyEuropeanCallContractModel <: AbstractContractModel

    # data -
    K::Float64
    sense::Int64
    DTE::Float64
    IV::Float64
    premium::Union{Nothing, Float64}

    # constructor -
    MyEuropeanCallContractModel() = new()
end

mutable struct MyEuropeanPutContractModel <: AbstractContractModel

    # data -
    K::Float64
    sense::Int64
    DTE::Float64
    IV::Float64
    premium::Union{Nothing, Float64}

    # constructor -
    MyEuropeanPutContractModel() = new()
end

mutable struct MyAmericanCallContractModel <: AbstractContractModel

    # data -
    K::Float64
    sense::Union{Nothing, Int64}
    DTE::Union{Nothing,Float64}
    IV::Union{Nothing, Float64}
    premium::Union{Nothing, Float64}
    ticker::Union{Nothing,String}
    copy::Union{Nothing, Int64}

    # constructor -
    MyAmericanCallContractModel() = new()
end

mutable struct MyAmericanPutContractModel <: AbstractContractModel

    # data -
    K::Float64
    sense::Union{Nothing, Int64}
    DTE::Union{Nothing,Float64}
    IV::Union{Nothing, Float64}
    premium::Union{Nothing, Float64}
    ticker::Union{Nothing,String}
    copy::Union{Nothing, Int64}

    # constructor -
    MyAmericanPutContractModel() = new()
end