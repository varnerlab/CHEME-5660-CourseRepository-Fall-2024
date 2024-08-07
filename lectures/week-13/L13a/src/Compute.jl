"""
    encode(A::Array{Float64,1}, logic::Function) -> Array{Int64,1}

Encode a vector `A` using a logic function `logic` and returns a matrix of integers.

### Arguments
- `A::Array{Float64,2}`: a matrix of size `m x n`.
- `logic::Function`: a function that takes a float and returns an integer.

### Returns
- `B::Array{Int64,2}`: a matrix of size `m x n` such that `B[i,j] = logic(A[i,j])`.
"""
function encode(A::Array{Float64,1}, logic::Function)::Array{Int64,1}

    # initialize -
    m = length(A)
    B = zeros(Int64, m)

    # main loop -
    for i ∈ 1:m
        B[i] = logic(A[i])
    end

    # return -
    return B
end