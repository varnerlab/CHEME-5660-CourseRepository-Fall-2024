# setup paths -
const _ROOT = pwd();
const _PATH_TO_SRC = joinpath(_ROOT, "src");
const _PATH_TO_DATA = joinpath(_ROOT, "data");

# make sure all is up to date -
using Pkg
Pkg.add(path="https://github.com/varnerlab/VLQuantitativeFinancePackage.jl.git")
Pkg.activate("."); Pkg.resolve(); Pkg.instantiate(); Pkg.update();

# load external packages -
using VLQuantitativeFinancePackage
using DataFrames
using CSV
using Dates
using LinearAlgebra
using Statistics
using Plots
using Colors
using StatsPlots
using JLD2
using FileIO
using Distributions
using DataStructures
using PrettyTables

# setup a  color -
blue_color = colorant"rgb(68,152,242)"

# load my codes -
include(joinpath(_PATH_TO_SRC,"Types.jl"));
include(joinpath(_PATH_TO_SRC,"Files.jl"));
include(joinpath(_PATH_TO_SRC,"Compute.jl"));
include(joinpath(_PATH_TO_SRC,"Portfolio.jl"));