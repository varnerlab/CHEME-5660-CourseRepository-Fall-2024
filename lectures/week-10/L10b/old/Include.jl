# setup paths -
const _ROOT = pwd()
const _PATH_TO_SRC = joinpath(_ROOT, "src");
const _PATH_TO_DATA = joinpath(_ROOT, "data");

# load packages -
using Plots
using Colors
using CSV
using DataFrames

# load my codes -
include(joinpath(_PATH_TO_SRC, "Types.jl"))
include(joinpath(_PATH_TO_SRC, "Factory.jl"))
include(joinpath(_PATH_TO_SRC, "Compute.jl"))
include(joinpath(_PATH_TO_SRC, "Files.jl"))

# load colors -
colors = Dict{Int64,RGB}()
colors[1] = colorant"#EE7733";
colors[2] = colorant"#0077BB";
colors[3] = colorant"#33BBEE";
colors[4] = colorant"#EE3377";
colors[5] = colorant"#CC3311";
colors[6] = colorant"#009988";
colors[7] = colorant"#BBBBBB";